M = {}
M.load_plugins = function()
    -- Lazy plugin manager
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    -- plugins
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    require("lazy").setup({
        {
            "christoomey/vim-tmux-navigator",
            lazy = false,
        },
        {
            "sainnhe/sonokai",
            config = function()
                vim.cmd([[
	          let g:sonokai_style = 'shusia'
		  let g:sonokai_better_performance = 1
                  colorscheme sonokai
		  ]])
            end,
            lazy = false,
        },
        {
            "nvim-lualine/lualine.nvim",
            dependencies = {
                "sainnhe/sonokai",
            },
            config = function()
                require("lualine").setup({
                    options = {
                        theme = "sonokai",
                    },
                })
            end,
        },
        {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
                require("which-key").setup({})
            end,
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            version = "*",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
                "MunifTanjim/nui.nvim",
            },
            config = function()
                require("neo-tree").setup()
            end,
        },
        {
            "phaazon/hop.nvim",
            config = function()
                require("hop").setup()
            end,
        },
    })
end

return M
