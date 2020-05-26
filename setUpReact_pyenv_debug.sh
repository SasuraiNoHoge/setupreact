#!/bin/sh

function createHtml(){
  touch ./index.html
  echo "<!DOCTYPE html>\n<html lang=\"ja\">\n  <head>\n    <meta charset=\"UTF-8\" />\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />\n    <title>Document</title>\n  </head>\n  <body>\n    <div id=\"app\"></div>\n    <script src=\"./src/index.tsx\"></script>\n  </body>\n</html>" > ./index.html
}

function craeteTsx(){
  mkdir -p src
  touch ./src/index.tsx
  echo "import React from \"react\";\nimport ReactDOM from \"react-dom\";\n\nconst app = document.getElementById(\"app\");\nconst title = \"hello world\";\nconst root = <div> called, {title}</div>;\n\nReactDOM.render(root, app);" > ./src/index.tsx
}

function init(){
  pyenv local 2.7.17 ; yarn init -yarn ; git init ; touch .gitignore ; echo node_modules/ > .gitignore ; yarn add react ;  yarn add --dev typescript ; createHtml ; craeteTsx ; yarn add --dev @types/react ; yarn add react-dom ; yarn add --dev @types/react-dom ; npx tsc --init
}

function writeScript(){
  value=$(sed -n '/"jsx": /=' tsconfig.json) ; row=$((${value}-1)) ; 
  sed -i "" "${row}i\\
  \    \"jsx\": \"react\",\\
  " tsconfig.json ; value=$(sed -n '/"allowJs": true/=' tsconfig.json) ; row=$((${value})) ; sed -i "" "${row}i\\
  \    \"allowJs\": true,\\
  " tsconfig.json ; yarn add --dev parcel ; value=$(sed -n '/"main":/=' package.json) ; sed -i "" "${value}d" package.json ; sed -i "" "${value}i\\
  \  \"main\": \"src\/index.tsx\",\\
  " package.json ; value=$(sed -n '/"license":/=' package.json) ; row=$((1+${value})) ; sed -i "" "${row}i\\
  \  \"scripts\": {\\
  \    \"start\" : \"parcel ./index.html\",\\
  \    \"format\" : \"prettier ./src/index.tsx\"\\
  \  },\\
  " package.json ; value=$(sed -n '/"lib": /=' tsconfig.json) ; row=$((${value})) ; sed -i "" "${row}i\\
  \    \"lib\": [\\
  \      \"DOM\",\\
  \      \"ES2015\"\\
  \    ],\\
  " tsconfig.json ; value=$(sed -n '/"outDir": /=' tsconfig.json) ; row=$((${value})) ; sed -i "" "${row}i\\
  \    \"outDir\": \"./dist\",\\
  " tsconfig.json ; echo dist/ >> .gitignore ; echo .cache/ >> .gitignore
}

function createeslintrc(){
  touch .eslintrc.js

echo "module.exports = {
  env: {
    browser: true,
    es6: true,
  },
  extends: [
    'plugin:react/recommended',
    'airbnb',
  ],
  globals: {
    Atomics: 'readonly',
    SharedArrayBuffer: 'readonly',
  },
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 11,
    sourceType: 'module',
  },
  plugins: [
      "prettier",
    'react',
    '@typescript-eslint',
  ],
  rules: {
      quotes: double,
  },
};
" > .eslintrc.js
}

function format(){
    yarn add --dev prettier ; yarn format ; yarn format --write ; yarn add --dev eslint ; createeslintrc ; yarn add --dev eslint-plugin-react@^7.19.0 @typescript-eslint/eslint-plugin@latest eslint-config-airbnb@latest eslint@^5.16.0 || ^6.8.0 eslint-plugin-import@^2.20.1 eslint-plugin-jsx-a11y@^6.2.3 eslint-plugin-react-hooks@^2.5.0 || ^1.7.0 @typescript-eslint/parser@latest ; value=$(sed -n '/rules: {/=' .eslintrc.js) ; row=$((1+${value})) ; sed -i "" "${row}i\\
    \      quotes: "double",\\
    " .eslintrc.js ; yarn add --dev eslint-plugin-prettier ; value=$(sed -n '/plugins: /=' .eslintrc.js) ; row=$((1+${value})) ; sed -i "" "${row}i\\
    \      \"prettier\",\\
    " .eslintrc.js
}

function vsconfig(){
 mkdir -p .vscode ; touch ./.vscode/launch.json ; echo "{\n \"version\": \"0.1.0\",\n  \"configurations\": [\n    {\n     \"type\": \"browser-preview\",\n      \"request\": \"launch\",\n      \"name\": \"Browser Preview: Launch\",\n      \"url\": \"http://localhost:1234\"\n    }\n ]\n}" > ./.vscode/launch.json ; echo .vscode/ >> ./.gitignore
}

init ; writeScript ; npx tsc ; format ; yarn add --dev typesync ; npx typesync ; pyenv local 3.8.2 ; vsconfig ; yarn start