# react + typescriptの環境構築を1コマンドで
Mac+VSCode+yarn環境のみですがreact.js + typescript + parcel + prettierの環境構築を  
1コマンドで完了するシェルスクリプトを書きました．
## はっぽんさんの動画を参考にして構築しています[https://www.youtube.com/watch?v=vrNWUL635A0](https://www.youtube.com/watch?v=vrNWUL635A0)
### 導入の注意
prettierはVSCodeのプラグインと連携しているので，  
VSCodeでPrettierを動かすにはに```Prettier-Code formatter```を  
インストールしてください．  
また，VSCodeの```settings.json```ファイルに  
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
