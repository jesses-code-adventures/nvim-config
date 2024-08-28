return {
    "ThePrimeagen/harpoon",
    name = "harpoon",
    cmd = "Harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", lazy=false},
    keys={
        {"<leader>a", function() Harpoon:list():add() end, desc="append file to harpoon list"},
        {"<C-b>", function() Harpoon.ui:toggle_quick_menu(Harpoon:list()) end, desc="harpoon toggle menu"},
        {"<C-j>", function() Harpoon:list():select(1) end, desc="harpoon select first buffer"},
        {"<C-k>", function() Harpoon:list():select(2) end, desc="harpoon select second buffer"},
        {"<C-m>", function() Harpoon:list():select(3) end, desc="harpoon select third buffer"},
        -- {"<C-,>", function() Harpoon:list():select(4) end, desc="harpoon select fourth buffer"},
        {"<C-x>", function() Harpoon:list():clear() end, desc="close harpoon"}
    },
    config=function()
        Harpoon = require("harpoon"):setup()
    end
}
