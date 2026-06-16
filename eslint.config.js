import tsPlugin from "@typescript-eslint/eslint-plugin";
import tsParser from "@typescript-eslint/parser";

export default [
  {
    files: ["**/*.ts"],
    languageOptions: {
      parser: tsParser,
    },
    plugins: {
      "@typescript-eslint": tsPlugin,
    },
    rules: {
      "@typescript-eslint/typedef": [
        "error",
        {
          "variableDeclaration": true,
          "parameter": true,
          "propertyDeclaration": true,
          "memberVariableDeclaration": true,
          "arrayDestructuring": true,
          "objectDestructuring": true
        }
      ]
    }
  }
];