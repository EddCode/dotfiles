return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gf<CR>", ":diffget //2", { desc = "Git status" })
      vim.keymap.set("n", "<leader>gh<CR>", ":diffget //3", { desc = "Git status" })
      vim.keymap.set("n", "<leader>gd<CR>", ":Gvdiffsplit", { desc = "Git status" })
      vim.keymap.set("n", "<leader>gm<CR>", ":Gvdiffsplit!", { desc = "Git status" })
      vim.keymap.set("n", "<leader>gu<CR>", ":diffupdate", { desc = "Git status" })


      vim.keymap.set("n", "<leader>G", ":G<CR>", { desc = "Git status" })
      vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
      vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
      vim.keymap.set("n", "<leader>gl", ":Git pull", { desc = "Git pull" })
    end,
  },
  { "lewis6991/gitsigns.nvim" },
}
