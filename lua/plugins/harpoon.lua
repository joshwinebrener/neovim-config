return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()

    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file [1]" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file [2]" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file [3]" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file [4]" })
    vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon file [5]" })

    -- Use telescope cuz it rocks
    local harpoon = require('harpoon')
    harpoon:setup({})

    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    vim.keymap.set(
      "n",
      "<leader>ha",
      function() harpoon:list():append() end,
      { desc = "[H]arpoon [A]ppend" }
    )
    vim.keymap.set(
      "n",
      "<leader>hc",
      function() harpoon:list():clear() end,
      { desc = "[H]arpoon [C]lear" }
    )
    vim.keymap.set(
      "n",
      "<leader>hh",
      function() toggle_telescope(harpoon:list()) end,
      { desc = "[H]arpoon menu" }
    )
  end
}
