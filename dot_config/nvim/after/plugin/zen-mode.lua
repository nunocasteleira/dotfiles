local zen = require("zen-mode")

zen.setup({
	twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
	gitsigns = { enabled = false }, -- disables git signs_defined

	-- this will change the font size on kitty when in zen mode
	-- to make this work, you need to set the following kitty options:
	-- - allow_remote_control socket-only
	-- - listen_on unix:/tmp/kitty
	plugins = {
        kitty = {
            enabled = true,
            font = "+6",
        },
    },
})
