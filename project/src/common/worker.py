import threading
import subprocess
from PyQt5.QtCore import QObject, pyqtSignal


class Worker(QObject):
    startSignal = pyqtSignal()
    outSignal = pyqtSignal(str)
    endSignal = pyqtSignal()

    def __init__(self):
        super().__init__()

        self.stop_event = threading.Event()
        self.stop_event.set()

    def run_nb_command(self, cmd, path=".", is_shell=True):
        self.startSignal.emit()
        self.stop_event.clear()
        threading.Thread(
            target=self._execute_command, args=(cmd, path, is_shell), daemon=True
        ).start()

    def run_b_command(self, cmd, path="."):
        self.startSignal.emit()
        self.stop_event.clear()
        proc = subprocess.Popen(
            cmd,
            cwd=path,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            shell=True,
            universal_newlines=True,
        )
        outs = proc.communicate()[0]
        self.stop_event.set()
        self.endSignal.emit()
        return outs

    def cancel_command(self):
        self.stop_event.set()
        self.endSignal.emit()

    def _execute_command(self, cmd, path, is_shell):
        proc = subprocess.Popen(
            cmd,
            cwd=path,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            shell=is_shell,
            universal_newlines=True,
        )

        for line in proc.stdout:
            self.outSignal.emit(line)
            if self.stop_event.isSet():
                proc.kill()
                return
        self.stop_event.set()
        self.endSignal.emit()
