local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  vim.notify('Failed to require "neotest"...')
	return
end

neotest.setup({
  adapters = {
    require("neotest-python")({
      dap = { justMyCode = false, console = "integratedTerminal" },
    }),
    require("neotest-plenary"),
  },
})
