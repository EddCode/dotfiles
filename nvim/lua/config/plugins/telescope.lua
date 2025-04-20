return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
     'nvim-lua/plenary.nvim',
     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<C-f>', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope buffers' })
    end
}
