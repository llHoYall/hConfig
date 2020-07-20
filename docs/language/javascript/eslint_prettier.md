# ESLint and Prettier

## Installation

> $ npm install eslint prettier eslint-config-prettier eslint-plugin-prettier

## Settings

### ESLint

```js
// .eslintrc.js
module.exports = {
  env: {
    browser: true,
    es2020: true
  },
  extends: [
    "eslint:recommended",
    "plugin:prettier/recommended"
  ]
};
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
  "eslint.enable": true,
  "[javascript]": {
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.fixAll": true
    }
  },
  "[typescript]": {
    "editor.formatOnSave": true,
  }
}
```

## Reference

* [ESLint Rules](https://eslint.org/docs/rules/)
