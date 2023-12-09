require('rose-pine').setup({
    disable_background = true,
    variant = "moon",
    disable_float_background = true
})

require("solarized-osaka").setup({
    -- disable italic for functions
    styles = {
        functions = {}
    },
    transparent = true,
    terminal_colors = true,
    hide_interactive_statusline = true,
    sidebars = { "qf", "vista_kind", "terminal", "packer" },
    -- Change the "hint" color to the "orange" color, and make the "error" color bright red
    on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff0000"
    end
})

function ColorMyPencils(color)
    color = color or "solarized-osaka"
    vim.cmd.colorscheme(color)
end

ColorMyPencils('solarized-osaka')
