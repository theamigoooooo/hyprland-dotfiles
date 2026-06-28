return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    -- Read pywal colors
    local colors = nil
    local cache_file = os.getenv("HOME") .. "/.cache/wal/colors.json"
    local f = io.open(cache_file, "r")
    if f then
      local content = f:read("*a")
      f:close()
      local ok, decoded = pcall(vim.fn.json_decode, content)
      if ok then
        colors = decoded
      end
    end

    local overrides = {}
    if colors then
      overrides = {
        -- Overriding the base mocha palette with Pywal colors
        base = colors.special.background,
        mantle = colors.special.background,
        crust = colors.special.background,
        text = colors.special.foreground,
        subtext1 = colors.colors.color7,
        subtext0 = colors.colors.color6,
        overlay2 = colors.colors.color5,
        overlay1 = colors.colors.color8,
        overlay0 = colors.colors.color8,
        surface2 = colors.colors.color8,
        surface1 = colors.colors.color0,
        surface0 = colors.colors.color0,
        
        red = colors.colors.color1,
        green = colors.colors.color2,
        yellow = colors.colors.color3,
        blue = colors.colors.color4,
        pink = colors.colors.color5,
        teal = colors.colors.color6,
        
        rosewater = colors.colors.color6,
        flamingo = colors.colors.color5,
        lavender = colors.colors.color5,
        maroon = colors.colors.color1,
        peach = colors.colors.color3,
        sky = colors.colors.color4,
        sapphire = colors.colors.color4,
        mauve = colors.colors.color5,
      }
    end

    require('catppuccin').setup {
      flavour = 'mocha', -- fallback if pywal fails
      transparent_background = true, -- <--- Make background transparent
      color_overrides = {
        mocha = overrides,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        nvimtree = true,
      },
    }

    vim.cmd.colorscheme("catppuccin")

    -- Optional: for floating windows transparency
    vim.cmd [[
        hi Normal guibg=NONE ctermbg=NONE
        hi NormalFloat guibg=NONE ctermbg=NONE
        hi FloatBorder guibg=NONE ctermbg=NONE
    ]]
  end,
}
