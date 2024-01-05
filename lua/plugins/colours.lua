return ({
    "craftzdog/solarized-osaka.nvim",
    name="solarized-osaka",
    lazy=false,
    priority=1000,
    opts={
        styles = {
            functions = {}
        },
        transparent = true,
        terminal_colors = true,
        hide_interactive_statusline = true,
        sidebars = { "qf", "vista_kind", "terminal"},
        on_colors = function(colors)
            colors.hint = colors.orange
            colors.error = "#ff0000"
        end
    },
    config=function()
        vim.cmd.colorscheme("solarized-osaka")
    end
})
