import sys
import os
import ctypes
from shutil import which
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QApplication, QWidget, QHBoxLayout, QLabel, QPushButton

sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from common.worker import Worker
from common import defines


class Chocolatey(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.worker = Worker()
        self.worker.startSignal.connect(self.worker_start)
        self.worker.outSignal.connect(self.log)
        self.worker.endSignal.connect(self.worker_end)

        self.label = QLabel()
        self.state_label = QLabel()
        self.install_btn = QPushButton("Install")
        self.upgrade_btn = QPushButton("Upgrade")
        self.uninstall_btn = QPushButton("Uninstall")
        self.config_btn = QPushButton("Config")

        self.init_ui()
        self.refresh_ui()

    def init_ui(self):
        self.label.setFixedWidth(defines.SIZE_LABEL)

        self.state_label.setAlignment(Qt.AlignLeft | Qt.AlignVCenter)

        self.install_btn.clicked.connect(self.install)
        self.upgrade_btn.clicked.connect(self.upgrade)
        self.uninstall_btn.clicked.connect(self.uninstall)

        choco_hlayout = QHBoxLayout()
        choco_hlayout.addWidget(self.label)
        choco_hlayout.addWidget(self.state_label)
        choco_hlayout.setStretchFactor(self.state_label, 3)
        choco_hlayout.addWidget(self.install_btn)
        choco_hlayout.setStretchFactor(self.install_btn, 1)
        choco_hlayout.addWidget(self.upgrade_btn)
        choco_hlayout.setStretchFactor(self.upgrade_btn, 1)
        choco_hlayout.addWidget(self.uninstall_btn)
        choco_hlayout.setStretchFactor(self.uninstall_btn, 1)
        choco_hlayout.addWidget(self.config_btn)
        choco_hlayout.setStretchFactor(self.config_btn, 1)

        self.setLayout(choco_hlayout)

    def refresh_ui(self):
        self.refresh_label()
        if not ctypes.windll.shell32.IsUserAnAdmin():
            self.disable_ui()
            self.state_label.setText("Run as Administrator")
        else:
            self.enable_ui()
            self.state_label.setText("Installed" if self.check() else "Not Installed")

    def install(self):
        if self.parent():
            self.parent().log_te.clear()
        self.worker.run_b_command(
            "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
            "./",
        )
        self.refresh_ui()

    def upgrade(self):
        if self.parent():
            self.parent().log_te.clear()
        self.worker.run_nb_command("choco upgrade -y chocolatey", "./")
        self.refresh_ui()

    def uninstall(self):
        if self.parent():
            self.parent().log_te.clear()
        script_path = os.path.abspath("script/system/package_manager")
        self.worker.run_nb_command(
            ["powershell", '. "./chocolatey.ps1";', "&Uninstall_Chocolatey"],
            script_path,
            is_shell=False,
        )
        self.refresh_ui()

    def check(self):
        return True if which("choco") is not None else False

    def get_version(self):
        if self.check():
            return self.worker.run_b_command("choco --version", "./",)
        return None

    def refresh_label(self):
        label = "Chocolatey (v"
        label += self.get_version().strip()
        label += "): "
        self.label.setText(label)

    def log(self, msg):
        msg = msg.strip()
        if msg != "":
            if self.parent():
                self.parent().log_te.append(msg)
            else:
                print(msg)

    def enable_ui(self):
        if self.check():
            self.install_btn.setEnabled(False)
            self.upgrade_btn.setEnabled(True)
            self.uninstall_btn.setEnabled(True)
        else:
            self.install_btn.setEnabled(True)
            self.upgrade_btn.setEnabled(False)
            self.uninstall_btn.setEnabled(False)
        self.config_btn.setEnabled(False)

    def disable_ui(self):
        self.install_btn.setDisabled(True)
        self.upgrade_btn.setDisabled(True)
        self.uninstall_btn.setDisabled(True)
        self.config_btn.setDisabled(True)

    def worker_start(self):
        self.disable_ui()

    def worker_end(self):
        self.enable_ui()


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = Chocolatey()
    ex.setWindowTitle("HoYa's Configurator - Chocolatey")
    ex.show()
    sys.exit(APP.exec_())
