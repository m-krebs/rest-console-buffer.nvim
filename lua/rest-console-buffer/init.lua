local This = require("rest-console-buffer")

local M = {}

function M.setup()
	vim.api.nvim_create_user_command("RestBuffer", function()
		This.init.create_temp_buffer()
	end, { desc = "Creates new temporary Buffer with .rest extension" })
end

function M.create_temp_buffer()
	local default_text = [=[
# host
https://httpbin.org

# curl options
--silent
--include

GET /json
  ]=]

	local lines = {}
	for line in default_text:gmatch("([^\r\n]*)\r?\n") do
		table.insert(lines, line)
	end

	local temp_file = vim.fn.tempname() .. ".rest"

	vim.fn.writefile(lines, temp_file)

	vim.cmd("edit " .. temp_file)

	vim.cmd('autocmd BufDelete <buffer> call delete("' .. temp_file .. '", "rf")')
end

return M
