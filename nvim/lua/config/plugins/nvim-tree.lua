return {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    vim.keymap.set('n', '<leader>t', ':NvimTreeToggle<CR>', { desc = "Toggle File Explorer" })
    require('nvim-tree').setup {
      view = {
        side = 'right',
        width = 30,
      },
      actions = {
        open_file = { quit_on_open = true }
      }
    }
  end
}
