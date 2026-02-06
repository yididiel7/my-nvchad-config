require("nvim-dap-virtual-text").setup({
  enabled = true, -- enable this plugin (the default)
  enabled_commands = true, -- enable virtual text for commands
  highlight_changed_variables = true, -- highlight changed variable names
  highlight_new_as_changed = false, -- highlight new variables as changed (off by default)
  show_stop_reason = true, -- show stop reason when stopped for exceptions
  commented = false, -- add comments for variable names
  virt_text_pos = 'eol', -- position of virtual text, see |virtual-text|
  all_frames = false, -- show virtual text for all frames not just current. Will yield poor performance! Use with large projects only if you have a decent machine
  virt_lines = false, -- show virtual lines for all frames (will change display), eol will be overriden
  all_references = true, -- show virtual text for variable references
  all_references_highlight = true, -- highlight all references for the variable under the cursor
})
