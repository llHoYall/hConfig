import sys
import os
import PyQt5
from PyQt5.QtCore import QSettings
from PyQt5.QtGui import QIcon, QKeySequence
from PyQt5.QtWidgets import QApplication, QMainWindow, QWidget, QShortcut, QVBoxLayout, QTabWidget

from ui.windows_ui import Windows
from ui.mac_ui import Mac
from ui.linux_ui import Linux


MAJOR_VERSION = 0
MINOR_VERSION = 1
PATCH_VERSION = 3


class HCongfig(QMainWindow):
    def __init__(self):
        super().__init__()

        self.tabs = QTabWidget()

        self.shortcut_set()
        self.init_ui()

    def init_ui(self):
        # Main Layout
        self.tabs.addTab(Windows(self.tabs), "Windows")
        self.tabs.addTab(Mac(self.tabs), "Mac")
        self.tabs.addTab(Linux(self.tabs), "Linux")

        vlayout = QVBoxLayout()
        vlayout.addWidget(self.tabs)

        central_widget = QWidget()
        central_widget.setLayout(vlayout)
        self.setCentralWidget(central_widget)

        # Main UI
        self.setWindowIcon(QIcon("../resource/logo.ico"))
        self.setWindowTitle(
            "HoYa's Configurator v{}.{}.{}".format(MAJOR_VERSION, MINOR_VERSION, PATCH_VERSION)
        )
        self.show()

    # Utility ##################################################################
    def select_tab1(self):
        QTabWidget.setCurrentIndex(self.tabs, 0)

    def select_tab2(self):
        QTabWidget.setCurrentIndex(self.tabs, 1)

    def select_tab3(self):
        QTabWidget.setCurrentIndex(self.tabs, 2)

    def shortcut_set(self):
        self.shortcut_tab1 = QShortcut(QKeySequence("Ctrl+1"), self)
        self.shortcut_tab1.activated.connect(self.select_tab1)

        self.shortcut_tab2 = QShortcut(QKeySequence("Ctrl+2"), self)
        self.shortcut_tab2.activated.connect(self.select_tab2)

        self.shortcut_tab3 = QShortcut(QKeySequence("Ctrl+3"), self)
        self.shortcut_tab3.activated.connect(self.select_tab3)

        self.shortcut_tab3 = QShortcut(QKeySequence("Ctrl+Q"), self)
        self.shortcut_tab3.activated.connect(PyQt5.QtWidgets.qApp.quit)


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = HCongfig()
    sys.exit(APP.exec_())
