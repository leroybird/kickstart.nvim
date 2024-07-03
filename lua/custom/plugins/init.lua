-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'github/copilot.vim',
  'kevinhwang91/promise-async',
  'kevinhwang91/nvim-ufo',
  {
    'kiyoon/jupynium.nvim',
    build = 'pip3 install --user .',
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),

    config = function()
      local cmp = require 'cmp'
      local compare = cmp.config.compare
      local jup = require 'jupynium'

      jup.setup {
        python_host = vim.g.python3_host_prog or 'python3',

        default_notebook_URL = 'localhost:8888/nbclassic',

        -- Write jupyter command but without "notebook"
        -- When you call :JupyniumStartAndAttachToServer and no notebook is open,
        -- then Jupynium will open the server for you using this command. (only when notebook_URL is localhost)
        jupyter_command = 'jupyter',
        --- For Conda, maybe use base environment
        --- then you can `conda install -n base nb_conda_kernels` to switch environment in Jupyter Notebook
        -- jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },

        -- Used when notebook is launched by using jupyter_command.
        -- If nil or "", it will open at the git directory of the current buffer,
        -- but still navigate to the directory of the current buffer. (e.g. localhost:8888/nbclassic/tree/path/to/buffer)
        notebook_dir = nil,

        -- Used to remember the last session (password etc.).
        -- e.g. '~/.mozilla/firefox/profiles.ini'
        -- or '~/snap/firefox/common/.mozilla/firefox/profiles.ini'
        firefox_profiles_ini_path = nil,
        -- nil means the profile with Default=1
        -- or set to something like 'default-release'
        firefox_profile_name = nil,

        -- Open the Jupynium server if it is not already running
        -- which means that it will open the Selenium browser when you open this file.
        -- Related command :JupyniumStartAndAttachToServer
        auto_start_server = {
          enable = false,
          file_pattern = { '*.ju.*' },
        },
        auto_attach_to_server = {
          enable = false,
          file_pattern = { '*.ju.*', '*.md' },
        },
        jupynium_file_pattern = { '*.py' },

        auto_start_sync = {
          enable = false,
          file_pattern = { '*.ju.*', '*.md' },
        },

        -- Automatically keep filename.ipynb copy of filename.ju.py
        -- by downloading from the Jupyter Notebook server.
        -- WARNING: this will overwrite the file without asking
        -- Related command :JupyniumDownloadIpynb
        auto_download_ipynb = true,

        -- Automatically close tab that is in sync when you close buffer in vim.
        auto_close_tab = true,

        -- Always scroll to the current cell.
        -- Related command :JupyniumScrollToCell
        autoscroll = {
          enable = true,
          mode = 'always', -- "always" or "invisible"
          cell = {
            top_margin_percent = 20,
          },
        },

        scroll = {
          page = { step = 0.5 },
          cell = {
            top_margin_percent = 20,
          },
        },

        use_default_keybindings = true,
        textobjects = {
          use_default_keybindings = true,
        },

        syntax_highlight = {
          enable = true,
        },

        -- Dim all cells except the current one
        -- Related command :JupyniumShortsightedToggle
        shortsighted = false,

        -- Configure floating window options
        -- Related command :JupyniumKernelHover
        kernel_hover = {
          floating_win_opts = {
            max_width = 84,
            border = 'none',
          },
        },

        notify = {
          ignore = {
            -- "download_ipynb",
            -- "error_download_ipynb",
            -- "attach_and_init",
            -- "error_close_main_page",
            -- "notebook_closed",
          },
        },
      }

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
