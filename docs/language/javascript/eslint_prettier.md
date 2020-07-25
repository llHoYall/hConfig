# ESLint and Prettier

## Installation

> $ npm install eslint prettier babel-eslint eslint-config-prettier eslint-plugin-prettier

## Settings

### ESLint

```json
// .eslintrc
{
  "parser": "babel-eslint",
  "parserOptions": {
    "ecmaFeatures": {
      "jsx": true
    },
    "ecmaVersion": 2020
  },
  "env": {
    "browser": true,
    "es2020": true
  },
  "plugins": [
    "prettier"
  ],
  "extends": [
    "eslint:recommended",
    "plugin:prettier/recommended"
  ],
  "rules": {}
}
```

### Prettier

```json
// .prettierrc
{
  "endOfLine": "auto"
}
```

## Run

### ESLint

> $ eslint \<path>

### Prettier

> $ npx prettier \<path/**/*> -- write

## Intergate with VSCode

### VSCode Settings

```json
// .vscode/settings.json
{
  "editor.formatOnSave": true,
  "eslint.enable": true,
  "[javascript]": {
    "editor.codeActionsOnSave": {
      "source.fixAll": true
    }
  }
}
```

## Reference

* [ESLint Rules](https://eslint.org/docs/rules)
* [Prettier Options](https://prettier.io/docs/en/options.html)
