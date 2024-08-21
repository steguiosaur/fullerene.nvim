local config = require("fullerene.config")
local editor_highlights = require("fullerene.groups.editor")
local syntax_highlights = require("fullerene.groups.syntax")
local terminal = require("fullerene.terminal")

local M = {}

local integrations_highlights = {
    alpha = require("fullerene.groups.integrations.alpha"),
    cmp = require("fullerene.groups.integrations.cmp"),
    flash = require("fullerene.groups.integrations.flash"),
    gitsigns = require("fullerene.groups.integrations.gitsigns"),
    hop = require("fullerene.groups.integrations.hop"),
    indent_blankline = require("fullerene.groups.integrations.indent_blankline"),
    lazy = require("fullerene.groups.integrations.lazy"),
    lsp = require("fullerene.groups.integrations.lsp"),
    markdown = require("fullerene.groups.integrations.markdown"),
    mason = require("fullerene.groups.integrations.mason"),
    mini = require("fullerene.groups.integrations.mini"),
    navic = require("fullerene.groups.integrations.navic"),
    neo_tree = require("fullerene.groups.integrations.neo_tree"),
    neorg = require("fullerene.groups.integrations.neorg"),
    noice = require("fullerene.groups.integrations.noice"),
    notify = require("fullerene.groups.integrations.notify"),
    rainbow_delimiters = require("fullerene.groups.integrations.rainbow_delimiters"),
    telescope = require("fullerene.groups.integrations.telescope"),
    treesitter = require("fullerene.groups.integrations.treesitter"),
    illuminate = require("fullerene.groups.integrations.illuminate"),
}
local integrations = {}

for integration, enabled in pairs(config.integrations) do
    if enabled then
        local highlights = integrations_highlights[integration]
        table.insert(integrations, { enabled = true, highlights = highlights })
    end
end

local function load_highlights(highlights)
    for group_name, group_settings in pairs(highlights) do
        vim.api.nvim_set_hl(0, group_name, group_settings)
    end
end

function M.setup()
    load_highlights(editor_highlights)
    load_highlights(syntax_highlights)
    for _, plugin in ipairs(integrations) do
        if plugin.enabled then
            load_highlights(plugin.highlights)
        end
    end

    load_highlights(config.highlight_overrides)

    if config.terminal_colors then
        terminal.setup()
    end
end

return M
