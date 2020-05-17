import os
import sys
import ctypes
from glob import glob
from shutil import which
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont
from PyQt5.QtWidgets import (
    QApplication,
    QWidget,
    QVBoxLayout,
    QHBoxLayout,
    QGroupBox,
    QFileDialog,
    QLabel,
    QLineEdit,
    QComboBox,
    QPushButton,
)

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
from common import util
from common.worker import Worker


PROGRAM_LIST = [
    {"primary": "Chocolatey", "secondary": []},
    {"primary": "Git", "secondary": ["Global", "HoYa"]},
    {"primary": "Google Chrome", "secondary": []},
    {"primary": "Firefox", "secondary": []},
    {"primary": "Font", "secondary": ["Cascadia Code"]},
    {"primary": "Powershell", "secondary": ["core", "preview", "old"]},
    {"primary": "VSCode", "secondary": []},
    {"primary": "Windows Terminal", "secondary": ["HoYa", "WDC"]},
]


class ChocolateyUI(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        self._state = "INIT"

        self.worker = Worker()
        self.worker.outSignal.connect(self.log)
        self.worker.endSignal.connect(self.worker_end)

        self.primary_cmb = QComboBox()
        self.secondary_cmb = QComboBox()
        self.state_label = QLabel()

        self.path_le = QLineEdit("C:\\")
        self.path_btn = QPushButton("Select Path")

        self.install_btn = QPushButton("Install")
        self.upgrade_btn = QPushButton("Upgrade")
        self.uninstall_btn = QPushButton("Uninstall")
        self.config_btn = QPushButton("Config")

        self.init_ui()
        self.update_ui("start")

    def init_ui(self):
        self.primary_cmb.addItems([item["primary"] for item in PROGRAM_LIST])
        self.primary_cmb.currentTextChanged.connect(self.set_secondary)

        self.state_label.setAlignment(Qt.AlignLeft | Qt.AlignVCenter)

        self.path_btn.clicked.connect(self.select_path)

        font = QFont()
        font.setBold(True)
        self.install_btn.setFont(font)
        self.install_btn.clicked.connect(self.install)
        self.upgrade_btn.setFont(font)
        self.upgrade_btn.clicked.connect(self.upgrade)
        self.uninstall_btn.setFont(font)
        self.uninstall_btn.clicked.connect(self.uninstall)
        self.config_btn.setFont(font)
        self.config_btn.clicked.connect(self.config)

        label = (
            f"Chocolatey (v{self.get_version().strip()})"
            if which("choco") is not None
            else "Chocolatey"
        )

        choco_hlayout1 = QHBoxLayout()
        choco_hlayout1.addWidget(self.primary_cmb)
        choco_hlayout1.setStretchFactor(self.primary_cmb, 15)
        choco_hlayout1.addWidget(self.secondary_cmb)
        choco_hlayout1.setStretchFactor(self.secondary_cmb, 15)
        choco_hlayout1.addWidget(self.state_label)
        choco_hlayout1.setStretchFactor(self.state_label, 10)
        choco_hlayout2 = QHBoxLayout()
        choco_hlayout2.addWidget(self.path_le)
        choco_hlayout2.setStretchFactor(self.path_le, 3)
        choco_hlayout2.addWidget(self.path_btn)
        choco_hlayout2.setStretchFactor(self.path_btn, 1)
        choco_hlayout3 = QHBoxLayout()
        choco_hlayout3.addWidget(self.install_btn)
        choco_hlayout3.addWidget(self.upgrade_btn)
        choco_hlayout3.addWidget(self.uninstall_btn)
        choco_hlayout3.addWidget(self.config_btn)
        choco_vlayout1 = QVBoxLayout()
        choco_vlayout1.addLayout(choco_hlayout1)
        choco_vlayout1.addLayout(choco_hlayout2)
        choco_vlayout1.addLayout(choco_hlayout3)
        choco_group = QGroupBox(label)
        choco_group.setLayout(choco_vlayout1)
        choco_layout = QVBoxLayout()
        choco_layout.addWidget(choco_group)
        self.setLayout(choco_layout)

    def update_ui(self, condition):
        if not ctypes.windll.shell32.IsUserAnAdmin():
            self._state = "DISABLED"
            self.state_label.setText("Run as Administrator")
            self.install_btn.setEnabled(False)
            self.upgrade_btn.setEnabled(False)
            self.uninstall_btn.setEnabled(False)
            self.config_btn.setEnabled(False)
        elif self._state == "INIT" or condition == "start":
            if self.check_installed():
                self._state = "INSTALLED"
                self.state_label.setText("Installed")
                self.install_btn.setEnabled(False)
                self.upgrade_btn.setEnabled(True)
                self.uninstall_btn.setEnabled(True)
                self.config_btn.setEnabled(True)
            else:
                self._state = "NOT_INSTALLED"
                self.state_label.setText("Not Installed")
                self.install_btn.setEnabled(True)
                self.upgrade_btn.setEnabled(False)
                self.uninstall_btn.setEnabled(False)
                self.config_btn.setEnabled(False)
        elif (
            condition == "install"
            or condition == "upgrade"
            or condition == "uninstall"
            or condition == "config"
        ):
            if condition == "install":
                self.state_label.setText("Installing...")
            elif condition == "upgrade":
                self.state_label.setText("Upgrading...")
            elif condition == "uninstall":
                self.state_label.setText("Uninstalling...")
            elif condition == "config":
                self.state_label.setText("Configuring...")
            self.install_btn.setEnabled(False)
            self.upgrade_btn.setEnabled(False)
            self.uninstall_btn.setEnabled(False)
            self.config_btn.setEnabled(False)

    def install(self):
        if self.parent():
            self.parent().log_te.clear()
        if self.primary_cmb.currentText().lower() == "chocolatey":
            cmd = "powershell Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
        elif self.primary_cmb.currentText().lower() == "font":
            cmd = "choco install -y cascadiacode"
        elif self.primary_cmb.currentText().lower() == "powershell":
            cmd = "choco install -y powershell-"
            cmd += self.secondary_cmb.currentText().lower()
        elif self.primary_cmb.currentText().lower() == "windows terminal":
            cmd = "choco install -y microsoft-windows-terminal"
        else:
            program = self.primary_cmb.currentText().strip().lower().replace(" ", "")
            cmd = f"choco install -y {program}"
        self.worker.run_nb_command(cmd)
        self.update_ui("install")

    def upgrade(self):
        if self.parent():
            self.parent().log_te.clear()
        cmd = "choco upgrade -y "
        if self.primary_cmb.currentText().lower() == "font":
            cmd += "cascadiacode"
        elif self.primary_cmb.currentText().lower() == "powershell":
            cmd += "powershell-"
            cmd += self.secondary_cmb.currentText().lower()
        elif self.primary_cmb.currentText().lower() == "windows terminal":
            cmd += "microsoft-windows-terminal"
        else:
            program = self.primary_cmb.currentText().strip().lower().replace(" ", "")
            cmd += program
        self.worker.run_nb_command(cmd)
        self.update_ui("upgrade")

    def uninstall(self):
        if self.parent():
            self.parent().log_te.clear()
        is_shell = True
        if self.primary_cmb.currentText().lower() == "chocolatey":
            script = util.resource_path("script/system/package_manager/chocolatey.ps1")
            cmd = 'powershell -command "&{' + f". {script}; Chocolatey_Uninstall" + '}"'
            is_shell = False
        elif self.primary_cmb.currentText().lower() == "font":
            cmd = "choco uninstall -y cascadiacode"
        elif self.primary_cmb.currentText().lower() == "powershell":
            cmd = "choco uninstall -y powershell-"
            cmd += self.secondary_cmb.currentText().lower()
        elif self.primary_cmb.currentText().lower() == "windows terminal":
            cmd = "choco uninstall -y microsoft-windows-terminal"
        else:
            program = self.primary_cmb.currentText().strip().lower().replace(" ", "")
            cmd = f"choco uninstall -y {program}"
        self.worker.run_nb_command(cmd, is_shell=is_shell)
        self.update_ui("uninstall")

    def config(self):
        path = "."
        if self.primary_cmb.currentText().lower() == "git":
            script = util.resource_path("script/tool/git/git.ps1")
            if self.secondary_cmb.currentText().lower() == "global":
                cmd = 'powershell -command "&{' + f". {script}; Git_Config_Global" + '}"'
            elif self.secondary_cmb.currentText().lower() == "hoya":
                cmd = 'powershell -command "&{' + f". {script}; Git_Config_Local_HoYa" + '}"'
                path = self.path_le.text()
        elif self.primary_cmb.currentText().lower() == "powershell":
            script = util.resource_path("script/shell/powershell/powershell.ps1")
            if self.secondary_cmb.currentText().lower() == "old":
                cmd = 'powershell -command "&{' + f". {script}; Powershell_Config" + '}"'
            else:
                cmd = 'pwsh -command "&{' + f". {script}; Powershell_Config" + '}"'
        elif self.primary_cmb.currentText().lower() == "windows terminal":
            script = util.resource_path("script/terminal/windows_terminal/windows_terminal.ps1")
            if self.secondary_cmb.currentText().lower() == "hoya":
                cmd = 'powershell -command "&{' + f". {script}; WindowsTerminal_Config_HoYa" + '}"'
            elif self.secondary_cmb.currentText().lower() == "wdc":
                cmd = 'powershell -command "&{' + f". {script}; WindowsTerminal_Config_WDC" + '}"'
        elif self.primary_cmb.currentText().lower() == "vscode":
            script = util.resource_path("script/tool/vscode/vscode.ps1")
            cmd = 'powershell -command "&{' + f". {script}; VSCode_Config" + '}"'
        else:
            if self.parent() and self.parent().parent():
                self.parent().parent().parent().parent().parent().statusBar().showMessage(
                    "Nothing to configure"
                )
            return
        if self.parent():
            self.parent().log_te.clear()
        self.worker.run_nb_command(cmd, path)
        self.update_ui("config")

    def check_installed(self):
        if self.primary_cmb.currentText().lower() == "chocolatey":
            return True if which("choco") is not None else False
        elif self.primary_cmb.currentText().lower() == "font":
            return True if os.path.exists(r"C:\ProgramData\chocolatey\lib\cascadiacode") else False
        elif self.primary_cmb.currentText().lower() == "powershell":
            if glob("C:/ProgramData/chocolatey/lib/powershell*"):
                return True
            else:
                return False
        elif self.primary_cmb.currentText().lower() == "windows terminal":
            path = rf"C:\ProgramData\chocolatey\lib\microsoft-windows-terminal"
            return True if os.path.exists(path) else False
        else:
            program = self.primary_cmb.currentText().strip().lower().replace(" ", "")
            path = rf"C:\ProgramData\chocolatey\lib\{program}"
            return True if os.path.exists(path) else False

    def get_version(self):
        if which("choco"):
            return self.worker.run_b_command("choco --version")
        return ""

    def select_path(self):
        open_path = self.path_le.text() if self.path_le.text() else "C:\\"
        fname = QFileDialog.getExistingDirectory(self, "Select Path", open_path)
        if fname:
            self.path_le.setText(fname)

    def set_secondary(self):
        self.secondary_cmb.clear()
        self.secondary_cmb.addItems(PROGRAM_LIST[self.primary_cmb.currentIndex()]["secondary"])
        self.update_ui("start")

    def log(self, msg):
        msg = msg.rstrip()
        if msg != "":
            if self.parent():
                self.parent().log_te.append(msg)
            else:
                print(msg)

    def worker_end(self):
        self.update_ui("start")
        if self.parent() and self.parent().parent():
            self.parent().parent().parent().parent().parent().statusBar().showMessage("Done")


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = ChocolateyUI()
    ex.setWindowTitle("HoYa's Configurator - Chocolatey")
    ex.show()
    sys.exit(APP.exec_())
