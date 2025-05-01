local options = {

  base46 = {
    theme = "onedark", -- default theme
    hl_add = {},
    hl_override = {},
    integrations = {},
    changed_themes = {},
    transparency = false,
    theme_toggle = {},
  },

  ui = {
    cmp = {
      icons_left = false, -- only for non-atom styles!
      lspkind_text = true,
      style = "default", -- default/flat_light/flat_dark/atom/atom_colored
      format_colors = {
        tailwind = false, -- will work for css lsp too
        icon = "󱓻",
      },
    },

    telescope = { enabled = false, style = "borderless" }, -- borderless / bordered

    statusline = {
      enabled = true,
      theme = "default", -- default/vscode/vscode_colored/minimal
      -- default/round/block/arrow separators work only for default statusline theme
      -- round and block will work for minimal theme only
      separator_style = "default",
      order = nil,
      modules = nil,
    },

    -- lazyload it when there are 1+ buffers
    tabufline = {
      enabled = true,
      lazyload = false,
      order = { "treeOffset", "buffers", "tabs" },
      modules = nil,
    },
  },

  nvdash = {
    enabled = false,
    load_on_startup = false,
    header = {
      [[=================     ===============     ===============   ========  ========]],
      [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
      [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
      [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
      [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
      [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
      [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
      [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
      [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
      [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
      [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
      [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
      [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
      [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
      [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
      [[||.=='    _-'                                                     `' |  /==.||]],
      [[=='    _-'                        N E O V I M                         \/   `==]],
      [[\   _-'                                                                `-_   /]],
      [[ `''                                                                      ``' ]],
    },

    buttons = {
      { txt = "  Find File", keys = "<leader><leader>", cmd = "lua LazyVim.pick()()" },
      { txt = "  Recent Files", keys = "fr", cmd = 'lua LazyVim.pick("oldfiles")()' },
      { txt = "󰈭  Find Word", keys = "fw", cmd = 'lua LazyVim.pick("live_grep")()' },
      { txt = "  Restore Session", keys = "s", cmd = 'lua require("persistence").load()' },
      { txt = "  Quit", keys = "q", cmd = "qa" },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

      {
        txt = function()
          local stats = require("lazy").stats()
          local ms = math.floor(stats.startuptime) .. " ms"
          return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        end,
        hl = "NvDashFooter",
        no_gap = true,
      },

      { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
    },
  },

  term = {
    enabled = false,
    winopts = { number = false, relativenumber = false },
    sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },

  lsp = { signature = false },

  cheatsheet = {
    enabled = false,
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  mason = { pkgs = {} },

  colorify = {
    enabled = true,
    mode = "virtual", -- fg, bg, virtual
    virt_text = "󱓻 ",
    highlight = { hex = true, lspvars = true },
  },
}

local status, chadrc = pcall(require, "chadrc")
return vim.tbl_deep_extend("force", options, status and chadrc or {})
