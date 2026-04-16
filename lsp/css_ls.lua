return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css' },
  root_markers = {
    '.git',
    'package.json'
  },
  settings = {
    validate = true,
    lint = {
      unknownAtRules = 'ignore'
    }
  }
}
