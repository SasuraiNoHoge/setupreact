# react + typescript の環境構築を 1 コマンドで

Mac+VSCode+yarn 環境のみですが  
react.js + typescript + parcel + prettier の環境構築を  
1 コマンドで完了するシェルスクリプトを書きました．

## はっぽんさんの動画を参考にして構築しています

## [https://www.youtube.com/watch?v=vrNWUL635A0](https://www.youtube.com/watch?v=vrNWUL635A0)

### 導入の注意

prettier は VSCode のプラグインと連携しているので，  
VSCode で Prettier を動かすにはに`Prettier-Code formatter`を  
インストールしてください．  
また，VSCode の`settings.json`ファイルに

```Javascript
  "editor.codeActionsOnSave": {
    "source.fixAll": true,
    "source.organizeImports": true
  }
```

を追記してください

## How to

```Bash
 cmod 755 ./setUpReact.sh
 ./setUpReact.sh
```

### 追記

pyenv を使っている方は`setUpReact_pyenv.sh`ファイルをご利用ください  
`setUpReact_pyenv_debug.sh`で，[Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)と[Browser Preview](https://marketplace.visualstudio.com/items?itemName=auchenberg.vscode-browser-preview)に対応しました

![デモ](https://github.com/SasuraiNoHoge/setupreact/blob/master/outputreact.gif)
