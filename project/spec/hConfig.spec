# -*- mode: python ; coding: utf-8 -*-

block_cipher = None


a = Analysis(['../src/main.py'],
             pathex=['spec'],
             binaries=[],
             datas=[
                ('../resource/logo.ico', './resource'),
                ('../script/system/package_manager/chocolatey.ps1', './script/system/package_manager'),
                ('../script/shell/powershell/*.ps1', './script/shell/powershell'),
                ('../script/terminal/windows_terminal/*', './script/terminal/windows_terminal'),
                ('../script/tool/git/git.ps1', './script/tool/git')
             ],
             hiddenimports=[],
             hookspath=[],
             runtime_hooks=[],
             excludes=[],
             win_no_prefer_redirects=False,
             win_private_assemblies=False,
             cipher=block_cipher,
             noarchive=False)
pyz = PYZ(a.pure, a.zipped_data,
             cipher=block_cipher)
exe = EXE(pyz,
          a.scripts,
          a.binaries,
          a.zipfiles,
          a.datas,
          [],
          name='hConfig',
          debug=False,
          bootloader_ignore_signals=False,
          strip=False,
          upx=True,
          upx_exclude=[],
          runtime_tmpdir=None,
          console=False , uac_admin=True, icon='../resource/logo.ico')
