return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ty = {
          mason = false,
          cmd = { "uv", "run", "--no-sync", "ty", "server" },
        },
      },
    },
  },
}
