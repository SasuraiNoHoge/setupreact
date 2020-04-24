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
    yarn init -yarn ; git init ; touch .gitignore ; echo node_modules/ > .gitignore ; yarn add react ;  yarn add --dev typescript ; createHtml ; craeteTsx ; yarn add --dev @types/react ; yarn add react-dom ; yarn add --dev @types/react-dom ; npx tsc --init
}

function writeScript(){
  value=$(sed -n '/"jsx": /=' tsconfig.json) ; row=$((${value}-1)) ; 
  sed -i "" "${row}i\\
  \    \"jsx\": \"react\",\\
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
  " tsconfig.json ; echo dist/ >> .gitignore ; echo .cache/ >> .gitignore
}

function format(){
    yarn add --dev prettier ; yarn format ; yarn format --write ; npx eslint --init ; value=$(sed -n '/rules: {/=' .eslintrc.js) ; row=$((1+${value})) ; sed -i "" "${row}i\\
    \      quotes: "double",\\
    " .eslintrc.js ; yarn add --dev eslint-plugin-prettier ; value=$(sed -n '/plugins: /=' .eslintrc.js) ; row=$((1+${value})) ; sed -i "" "${row}i\\
    \      \"prettier\",\\
    " .eslintrc.js
}

init ; writeScript ; npx tsc ; format ; yarn start