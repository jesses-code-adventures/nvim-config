require('rose-pine').setup({
    disable_background = true,
    variant="moon",
    disable_float_background = true
})

require('poimandres').setup({
    disable_background = true;
    disable_float_background = true;
})

-- require('nightly').setup({
--     transparent = true,
--     styles = {
--         comments = { italic = true },
--         functions = { italic= false },

--         keywords = { italic = false },
--         variables = { italic = false },
--     },
-- })

function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

ColorMyPencils('rose-pine')
