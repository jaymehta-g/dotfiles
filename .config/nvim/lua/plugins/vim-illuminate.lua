-- Remove keymaps that would conflict with custom bufferline maps
return {
  "RRethy/vim-illuminate",
  keys = {
    { "]]", false },
    { "[[", false },
  },
}
