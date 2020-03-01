import sys
import os
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
        self.install_btn = QPushButton("Install")
        self.upgrade_btn = QPushButton("Upgrade")

        self.init_ui()
        self.refresh_label()

    def init_ui(self):
        self.label.setFixedWidth(defines.SIZE_LABEL)

        state_label = QLabel("Installed" if self.check() else "Not Installed")
        state_label.setAlignment(Qt.AlignLeft | Qt.AlignVCenter)

        self.install_btn.clicked.connect(self.install)
        self.upgrade_btn.clicked.connect(self.upgrade)
        config_btn = QPushButton("Config")
        config_btn.setEnabled(False)

        choco_hlayout = QHBoxLayout()
        choco_hlayout.addWidget(self.label)
        choco_hlayout.addWidget(state_label)
        choco_hlayout.setStretchFactor(state_label, 3)
        choco_hlayout.addWidget(self.install_btn)
        choco_hlayout.setStretchFactor(self.install_btn, 1)
        choco_hlayout.addWidget(self.upgrade_btn)
        choco_hlayout.setStretchFactor(self.upgrade_btn, 1)
        choco_hlayout.addWidget(config_btn)
        choco_hlayout.setStretchFactor(config_btn, 1)

        self.setLayout(choco_hlayout)

    def install(self):
        if not self.check():
            if self.parent():
                self.parent().log_te.clear()
            self.worker.run_b_command(
                "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))",
                "./",
            )
            self.refresh_label()

    def upgrade(self):
        if self.check():
            if self.parent():
                self.parent().log_te.clear()
            self.worker.run_nb_command("choco upgrade -y chocolatey", "./")
            self.refresh_label()

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

    def enable_ui(self, opt):
        self.install_btn.setEnabled(opt)
        self.upgrade_btn.setEnabled(opt)

    def worker_start(self):
        print("start")
        self.enable_ui(False)

    def worker_end(self):
        print("end")
        self.enable_ui(True)


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = Chocolatey()
    ex.setWindowTitle("HoYa's Configurator - Chocolatey")
    ex.show()
    sys.exit(APP.exec_())
