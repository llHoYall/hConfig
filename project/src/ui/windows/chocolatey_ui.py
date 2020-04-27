import os
import sys
import ctypes
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
from common.worker import Worker


PROGRAM_LIST = [
    {"primary": "Chocolatey", "secondary": []},
    {"primary": "Git", "secondary": ["Global", "HoYa"]},
    {"primary": "Google Chrome", "secondary": []},
    {"primary": "Firefox", "secondary": []},
    {"primary": "Font", "secondary": ["Cascadia Code"]},
]


class ChocolateyUI(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.state = "INIT"

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
            self.state = "DISABLED"
            self.state_label.setText("Run as Administrator")
            self.install_btn.setEnabled(False)
            self.upgrade_btn.setEnabled(False)
            self.uninstall_btn.setEnabled(False)
            self.config_btn.setEnabled(False)
        elif self.state == "INIT" and condition == "start":
            self.state == "INIT"
            if self.check_installed():
                self.state == "INSTALLED"
                self.state_label.setText("Installed")
                self.install_btn.setEnabled(False)
                self.upgrade_btn.setEnabled(True)
                self.uninstall_btn.setEnabled(True)
                self.config_btn.setEnabled(True)
            else:
                self.state == "NOT_INSTALLED"
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
            cmd = "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
        elif self.primary_cmb.currentText().lower() == "font":
            cmd = "choco install -y cascadiacode"
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
            cmd = ["powershell", '. "./chocolatey.ps1";', "&Chocolatey_Uninstall"]
            path = os.path.abspath("script/system/package_manager")
            is_shell = False
        elif self.primary_cmb.currentText().lower() == "font":
            cmd = "choco uninstall -y cascadiacode"
            path = "./"
        else:
            program = self.primary_cmb.currentText().strip().lower().replace(" ", "")
            cmd = f"choco uninstall -y {program}"
        self.worker.run_nb_command(cmd, path, is_shell)
        self.update_ui("uninstall")

    def config(self):
        if self.parent():
            self.parent().log_te.clear()
        is_shell = True
        if self.primary_cmb.currentText().lower() == "git":
            if self.secondary_cmb.currentText().lower() == "global":
                cmd = ["powershell", '. "./git.ps1";', "&Git_Config_Global"]
                path = os.path.abspath("script/tool/git")
            elif self.secondary_cmb.currentText().lower() == "hoya":
                cmd = ["powershell", '. "script/tool/git/git.ps1";', "&Git_Config_Local_HoYa"]
                path = self.path_le.text()
            is_shell = False
        self.worker.run_b_command(cmd, path, is_shell)
        self.update_ui("config")

    def check_installed(self):
        if self.primary_cmb.currentText() == "chocolatey":
            return True if which("choco") is not None else False
        elif self.primary_cmb.currentText() == "font":
            return True if os.path.exists(r"C:\ProgramData\chocolatey\lib\cascadiacode") else False
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
        msg = msg.strip()
        if msg != "":
            if self.parent():
                self.parent().log_te.append(msg)
            else:
                print(msg)

    def worker_end(self):
        self.update_ui("start")


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = ChocolateyUI()
    ex.setWindowTitle("HoYa's Configurator - Chocolatey")
    ex.show()
    sys.exit(APP.exec_())
