import sys
import os
import ctypes
import winreg
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QLabel, QTextEdit

sys.path.append(os.path.dirname(os.path.dirname(__file__)))
from ui.windows.chocolatey_ui import ChocolateyUI


class Windows(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.log_te = QTextEdit()

        self.init_ui()

    def init_ui(self):
        # System Information
        version_info = QLabel()
        version = self.get_system_information()
        version = "System Version Information: {} ({}-{})".format(
            version[0], version[1], version[2]
        )
        if self.check_system_privilege():
            version += " [admin]"
        version_info.setText(version)

        # Logging
        self.log_te.setReadOnly(True)

        # Layout
        win_vlayout = QVBoxLayout()
        win_vlayout.addWidget(version_info)
        win_vlayout.addWidget(ChocolateyUI(self))
        win_vlayout.addWidget(self.log_te)

        self.setLayout(win_vlayout)

    def get_system_information(self):
        key = r"SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        with winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, key) as key:
            product_name = winreg.QueryValueEx(key, r"ProductName")[0]
            release_id = winreg.QueryValueEx(key, r"ReleaseID")[0]
            current_build = winreg.QueryValueEx(key, r"CurrentBuild")[0]
        return (product_name, release_id, current_build)

    def check_system_privilege(self):
        return ctypes.windll.shell32.IsUserAnAdmin() != 0


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = Windows()
    ex.setWindowTitle("HoYa's Configurator - Windows")
    ex.show()
    sys.exit(APP.exec_())
