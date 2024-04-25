-- Check that fzf-lua is installed
local has_fzf, fzf = pcall(require, 'fzf-lua')

if not has_fzf then
	error('fzf-lua is required (https://github.com/ibhagwan/fzf-lua)')
end

local has_plenary, _ = pcall(require, 'plenary')
if not has_plenary then
	error('plenary is required (https://github.com/nvim-lua/plenary.nvim)')
end

local path = require 'fzf-lua.path'
local Path = require "plenary.path"
local cwd = vim.loop.cwd()

local M = {}

local function get_file_path(selected)
	local fullpath = path.entry_to_file(selected[1]).path

	if not path.is_absolute(fullpath) then
		fullpath = path.join({ cwd, fullpath })
	end

	return fullpath
end

function M.yank(selected)
	local p = get_file_path(selected)
	local source = Path:new(p)

	local prompt = vim.fn.input('Copy As: ', p)
	if prompt ~= '' and prompt ~= p then
		local target = Path:new(prompt)
		source:copy({ destination = target })
	end
end

function M.edit()
	local prompt = vim.fn.input('New File Name: ', cwd .. '/')
	if prompt ~= '' then
		vim.cmd('edit ' .. prompt)
	end
end

function M.touch()
	local prompt = vim.fn.input('New File Name: ', cwd .. '/')
	if prompt ~= '' then
		local file = Path:new(prompt)
		file:touch()
	end
end

function M.rename(selected)
	local p = get_file_path(selected)
	local source = Path:new(p)

	local prompt = vim.fn.input('Rename To: ', p)
	if prompt ~= '' and prompt ~= p then
		source:rename({ new_name = prompt })
	end
end

-- TODO: add functionaly to delete all selected
function M.delete(selected)
	local p = get_file_path(selected)
	local source = Path:new(p)

	local confirm = vim.fn.input('Type y to confirm deletion of: ' .. p .. ': ')
	if confirm == 'y' then
		source:rm()
	end
end

return M
