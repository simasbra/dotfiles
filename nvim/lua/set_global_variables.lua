vim.g.have_nerd_font = true

if package.config:sub(1, 1) == "/" then
	vim.g.is_unix = true
else
	vim.g.is_unix = false
end
