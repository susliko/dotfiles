local tla_ok, tla = pcall(require, "tla")
if not tla_ok then
	return
end

tla.setup()
