return {
  "Pocco81/auto-save.nvim",
  opts = {
    debounce_delay = 500,
    execution_message = {
      message = function() -- message to print on save
        return ""
      end,
    },
  },
}
