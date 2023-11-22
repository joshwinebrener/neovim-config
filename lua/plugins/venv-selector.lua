return {
  "linux-cultist/venv-selector.nvim",
  opts = {
    changed_venv_hooks = {
      function(venv_path, python_path)
        require("dap-python").setup(python_path)
      end,
    },
  },
  keys = {
    { "<leader>vv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Retrieve VirtualEnv cache" },
  },
}
