.\.venv\Scripts\activate
pyinstaller --clean -w -F --uac-admin --specpath=spec -n=hConfig -i="..\resource\logo.ico" src\main.py
deactivate
