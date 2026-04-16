return {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },

  filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

  root_markers = { ".git", "compile_commands.json", "compile_flags.txt" },

  capabilities = {
    offsetEncoding = { "utf-16" },
  },

  settings = {
    clangd = {},
  },
}
