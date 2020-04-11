import sys
import os
import ctypes
from shutil import which
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QApplication, QWidget, QHBoxLayout, QLabel, QComboBox, QPushButton

sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from common.worker import Worker
from common import defines


class Font(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.worker = Worker()
        self.worker.startSignal.connect(self.worker_start)
        self.worker.outSignal.connect(self.log)
        self.worker.endSignal.connect(self.worker_end)

        self.state_label = QLabel()
        self.font_combo = QComboBox()
        self.install_btn = QPushButton("Install")
        self.upgrade_btn = QPushButton("Upgrade")
        self.uninstall_btn = QPushButton("Uninstall")
        self.config_btn = QPushButton("Config")

        self.init_ui()
        self.refresh_ui()
        # self.enable_ui(which("choco") != None)

    def init_ui(self):
        label = QLabel("Fonts: ")
        label.setFixedWidth(defines.SIZE_LABEL)

        self.state_label.setAlignment(Qt.AlignLeft | Qt.AlignVCenter)

        self.font_combo = QComboBox()
        self.font_combo.addItem("Cascadia Code")
        self.font_combo.currentTextChanged.connect(self.refresh_ui)

        self.install_btn.clicked.connect(self.install)
        self.upgrade_btn.clicked.connect(self.upgrade)
        self.config_btn.setEnabled(False)
        self.uninstall_btn.clicked.connect(self.uninstall)

        font_hlayout = QHBoxLayout()
        font_hlayout.addWidget(label)
        font_hlayout.addWidget(self.state_label)
        font_hlayout.setStretchFactor(self.state_label, 2)
        font_hlayout.addWidget(self.font_combo)
        font_hlayout.setStretchFactor(self.font_combo, 1)
        font_hlayout.addWidget(self.install_btn)
        font_hlayout.setStretchFactor(self.install_btn, 1)
        font_hlayout.addWidget(self.upgrade_btn)
        font_hlayout.setStretchFactor(self.upgrade_btn, 1)
        font_hlayout.addWidget(self.uninstall_btn)
        font_hlayout.setStretchFactor(self.uninstall_btn, 1)
        font_hlayout.addWidget(self.config_btn)
        font_hlayout.setStretchFactor(self.config_btn, 1)

        self.setLayout(font_hlayout)

    def refresh_ui(self):
        if not ctypes.windll.shell32.IsUserAnAdmin():
            self.disable_ui()
            self.state_label.setText("Run as Administrator")
        elif which("choco") == None:
            self.disable_ui()
            self.state_label.setText("Need Chocolatey")
        else:
            self.enable_ui(self.check())
            self.state_label.setText("Installed" if self.check() else "Not Installed")

    def install(self):
        if self.parent():
            self.parent().log_te.clear()
        self.worker.run_nb_command(
            "choco install -y cascadiacode", "./",
        )
        self.refresh_ui()

    def upgrade(self):
        if self.parent():
            self.parent().log_te.clear()
        self.worker.run_nb_command("choco upgrade -y cascadiacode", "./")
        self.refresh_ui()

    def uninstall(self):
        if self.parent():
            self.parent().log_te.clear()
        self.worker.run_nb_command(
            "choco uninstall -y cascadiacode", "./",
        )
        self.refresh_ui()

    def check(self):
        font_list = [f.lower() for f in os.listdir(r"C:\Windows\Fonts")]
        font_name = (self.font_combo.currentText().split(" ")[0] + ".ttf").lower()
        return True if font_name in font_list else False

    def log(self, msg):
        msg = msg.strip()
        if msg != "":
            if self.parent():
                self.parent().log_te.append(msg)
            else:
                print(msg)

    def enable_ui(self, opt):
        self.install_btn.setDisabled(opt)
        self.upgrade_btn.setEnabled(opt)
        self.uninstall_btn.setEnabled(opt)

    def disable_ui(self):
        self.install_btn.setDisabled(True)
        self.upgrade_btn.setDisabled(True)
        self.uninstall_btn.setDisabled(True)
        self.config_btn.setDisabled(True)

    def worker_start(self):
        self.enable_ui(False)

    def worker_end(self):
        self.enable_ui(True)


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = Font()
    ex.setWindowTitle("HoYa's Configurator - Font")
    ex.show()
    sys.exit(APP.exec_())
