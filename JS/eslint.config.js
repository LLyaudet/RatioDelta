// eslint.config.js
import stylistic from "@stylistic/eslint-plugin";

export default [
  {
    plugins: {
      "@stylistic": stylistic,
    },
    rules: {
      "@stylistic/brace-style": ["error", "stroustrup"],
      "@stylistic/comma-dangle": ["error", "always-multiline"],
      "@stylistic/comma-spacing": [
        "error", {"before": false, "after": true}
      ],
      "@stylistic/indent": ["error", 2],
      "@stylistic/space-before-blocks": ["error", "never"],
    }
  }
];

