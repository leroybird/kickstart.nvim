-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'kiyoon/jupynium.nvim',
    build = 'pip3 install --user .',
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
    config = function()
      local cmp = require 'cmp'
      local compare = cmp.config.compare

      cmp.setup {
        sources = {
          { name = 'jupynium', priority = 900 }, -- consider higher priority than LSP
          { name = 'nvim_lsp', priority = 100 },
          -- ...
        },
        sorting = {
          priority_weight = 1.0,
          comparators = {
            compare.score, -- Jupyter kernel completion shows prior to LSP
            compare.recently_used,
            compare.locality,
            -- ...
          },
        },
      }

      vim.keymap.set('n', '<leader>js', '<cmd>JupyniumStartSync<CR>')
      vim.keymap.set('n', '<leader>jr', '<cmd>JupyniumKernelRestart<CR>')
      vim.keymap.set('n', '<leader>ji', '<cmd>JupyniumKernelInterrupt<CR>')
      vim.keymap.set('n', '<leader>ja', '<cmd>JupyniumAttachToServer<CR>')
      vim.keymap.set('n', '<leader>x', '<cmd>JupyniumExecuteSelectedCells<CR>')

      vim.keymap.set('n', '<leader>jc', '<cmd>JupyniumClearSelectedCellsOutputs<CR>')
      vim.keymap.set('n', '<leader>jk', '<cmd>JupyniumKernelHover<cr>')
      vim.keymap.set('n', '<leader>jg', '<cmd>JupyniumScrollToCell<cr>')
      vim.keymap.set('n', '<leader>jj', '<cmd>JupyniumStartAndAttachToServer<cr>')
      vim.keymap.set('n', '<leader>jo', '<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>')
    end,
  },
  'rcarriga/nvim-notify', -- optional
  'stevearc/dressing.nvim', -- optional, UI for :JupyniumKernelSelect
}
