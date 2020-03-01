import sys
from PyQt5.QtWidgets import QApplication, QWidget


class Mac(QWidget):
    def __init__(self, parent=None):
        super().__init__(parent)

        self.init_ui()

    def init_ui(self):
        pass


if __name__ == "__main__":
    APP = QApplication(sys.argv)
    ex = Mac()
    ex.setWindowTitle("HoYa's Configurator - Mac")
    ex.show()
    sys.exit(APP.exec_())
