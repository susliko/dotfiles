local M = {}

M.trim_path_vowels = function(_, path)
  local sep = require('telescope.utils').get_separator()
  local filename = require('telescope.utils').path_tail(path)
  local filepath = string.gsub(path, sep .. filename, '')
  if (filepath == filename) then
    return filename
  else
    local short_filepath = string.gsub(filepath, '[AEYUIOaeyuio]', '')
    return string.format('%s/%s', short_filepath, filename)
  end
end

return M
