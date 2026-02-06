local M = {}

-- Compiler.nvim keymaps
M.compiler = {
  plugin = true,
  n = {
    -- Open compiler
    ["<F6>"] = {
      "<cmd>CompilerOpen<CR>",
      "Open compiler",
    },
    -- Redo last selected option
    ["<S-F6>"] = {
      "<cmd>CompilerStop<CR><cmd>CompilerRedo<CR>",
      "Redo last compiler option",
    },
    -- Toggle compiler results
    ["<S-F7>"] = {
      "<cmd>CompilerToggleResults<CR>",
      "Toggle compiler results",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    }
  }
}

-- Run current python file
vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:!python3 %<CR>', { noremap = true, silent = true })


M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "Debug python method",
    }
  }
}


return M
