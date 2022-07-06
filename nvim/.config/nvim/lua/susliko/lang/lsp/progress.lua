local fidget_ok, fidget = pcall(require, "fidget")
if not fidget_ok then
  return
end

fidget.setup({
  text = {
    spinner = "moon",
  },
  timer = {
    spinner_rate = 130,
  },
  window = {
    blend = 0
  }
})
