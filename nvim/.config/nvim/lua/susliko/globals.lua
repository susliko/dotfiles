function _G.dump(...)
    if ... then
      local objects = vim.tbl_map(vim.inspect, {...})
      print(unpack(objects))
    else
      print('nil')
    end
    return ...
end

if pcall(require, "plenary") then
  RELOAD = require("plenary.reload").reload_module

  R = function(name)
    RELOAD(name)
    return require(name)
  end
end
