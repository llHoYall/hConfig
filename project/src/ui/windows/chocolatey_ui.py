import os
import sys
import ctypes
from shutil import which
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import (
    QApplication,
    QWidget,
    QVBoxLayout,
    QHBoxLayout,
    QGroupBox,
    QLabel,
    QComboBox,
    QPushButton,
)

sys.path.append(os.path.dirname(os.path.dirname(os.path.dirname(__file__))))
from common.worker import Worker


PROGRAM_LIST = [
    {"primary": "chocolatey", "secondary": []},
    {"primary": "font", "secondary": ["Cascadia Code"]},
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

        self.install_btn.clicked.connect(self.install)
        self.upgrade_btn.clicked.connect(self.upgrade)
        self.uninstall_btn.clicked.connect(self.uninstall)
        self.config_btn.clicked.connect(self.config)

        label = (
            f"Chocolatey (v{self.get_version().strip()})"
            if which("choco") is not None
            else "Chocolatey"
        )

        choco_hlayout = QHBoxLayout()
        choco_hlayout.addWidget(self.primary_cmb)
        choco_hlayout.setStretchFactor(self.primary_cmb, 3)
        choco_hlayout.addWidget(self.secondary_cmb)
        choco_hlayout.setStretchFactor(self.secondary_cmb, 3)
        choco_hlayout.addWidget(self.state_label)
        choco_hlayout.setStretchFactor(self.state_label, 3)
        choco_hlayout.addWidget(self.install_btn)
        choco_hlayout.addWidget(self.upgrade_btn)
        choco_hlayout.addWidget(self.uninstall_btn)
        choco_hlayout.addWidget(self.config_btn)
        choco_group = QGroupBox(label)
        choco_group.setLayout(choco_hlayout)
        choco_vlayout = QVBoxLayout()
        choco_vlayout.addWidget(choco_group)
        self.setLayout(choco_vlayout)

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
        elif condition == "install" or condition == "upgrade" or condition == "uninstall":
            if condition == "install":
                self.state_label.setText("Installing...")
            elif condition == "upgrade":
                self.state_label.setText("Upgrading...")
            elif condition == "uninstall":
                self.state_label.setText("Uninstalling...")
            self.install_btn.setEnabled(False)
            self.upgrade_btn.setEnabled(False)
            self.uninstall_btn.setEnabled(False)
            self.config_btn.setEnabled(False)

    def install(self):
        if self.parent():
            self.parent().log_te.clear()
        if self.primary_cmb.currentText() == "chocolatey":
            cmd = "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
        elif self.primary_cmb.currentText() == "font":
            cmd = "choco install -y cascadiacode"
        path = "./"
        self.worker.run_nb_command(cmd, path)
        self.update_ui("install")

    def upgrade(self):
        if self.parent():
            self.parent().log_te.clear()
        cmd = "choco upgrade -y "
        if self.primary_cmb.currentText() == "font":
            cmd += "cascadiacode"
        else:
            cmd += self.primary_cmb.currentText()
        path = "./"
        self.worker.run_nb_command(cmd, path)
        self.update_ui("upgrade")

    def uninstall(self):
        if self.parent():
            self.parent().log_te.clear()
        if self.primary_cmb.currentText() == "chocolatey":
            cmd = ["powershell", '. "./chocolatey.ps1";', "&Uninstall_Chocolatey"]
            path = os.path.abspath("script/system/package_manager")
            is_shell = False
        elif self.primary_cmb.currentText() == "font":
            cmd = "choco uninstall -y cascadiacode"
            path = "./"
            is_shell = True
        self.worker.run_nb_command(cmd, path, is_shell)
        self.update_ui("uninstall")

    def config(self):
        if self.parent():
            self.parent().log_te.clear()

    def check_installed(self):
        if self.primary_cmb.currentText() == "chocolatey":
            return True if which("choco") is not None else False
        elif self.primary_cmb.currentText() == "font":
            return True if os.path.exists(r"C:\ProgramData\chocolatey\lib\cascadiacode") else False

    def get_version(self):
        if which("choco"):
            return self.worker.run_b_command("choco --version", "./")
        return ""

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
