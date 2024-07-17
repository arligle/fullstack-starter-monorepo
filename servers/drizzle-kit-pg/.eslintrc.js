/** @type {import("eslint").Linter.Config} */
module.exports = {
  root: true,
  extends: [],
  parser: "@typescript-eslint/parser",
  parserOptions: {
    project: "./tsconfig.json",
    tsconfigRootDir: __dirname,
  },
};
