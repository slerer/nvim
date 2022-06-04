local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
	return
end

gitlinker.setup({
	opts = {
		callbacks = {
			["https://github.pie.apple.com/DSI-SW/ADCamera"] = require("gitlinker.hosts").get_github_type_url,
		},
		-- remote = 'github', -- force the use of a specific remote
		-- adds current line nr in the url for normal mode
		add_current_line_on_normal_mode = true,
		-- callback for what to do with the url
		action_callback = require("gitlinker.actions").open_in_browser,
    -- action_callback = require"gitlinker.actions".copy_to_clipboard,
		-- print the url after performing the action
		print_url = true,
		-- mapping to call url generation
		mappings = "<leader>gy",
	},
})
