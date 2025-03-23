local M = {}

M.palettes = {
  poimandres = {
    rosewater = "#FCC5E9",
    flamingo = "#5FB3A1",
    pink = "#FAE4FC",
    mauve = "#5DE4C7",
    red = "#D0679D",
    maroon = "#42675A",
    peach = "#FFFAC2",
    yellow = "#FFFAC2",
    green = "#ADD7FF",
    teal = "#91B4D5",
    sky = "#7390AA",
    sapphire = "#A6ACCD",
    blue = "#89DDFF",
    surface2 = "#767C9D",
    subtext1 = "#506477",
    subtext0 = "#303340",
    overlay2 = "#1B1E28",
    surface1 = "#171922",
    text = "#E4F0FB",
    lavender = "#FFFFFF",
    none = "NONE",
  },
  abelfubu = {
    rosewater = "#A8BCC9",
    flamingo = "#B4C9D7",
    pink = "#FAE4FC",
    mauve = "#89DDFF",
    red = "#BDD4E5",
    maroon = "#A4BACA",
    peach = "#8BA0B0",
    yellow = "#FFFAC2",
    green = "#5DE4C7",
    teal = "#97AAB5",
    sky = "#91A3AE",
    sapphire = "#8696A1",
    blue = "#ADD7FF",
    lavender = "#BFD5E4",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e2326",
    mantle = "#181825",
    crust = "#11111b",
  },
  everforest = {
    base = "#1e2326",
    text = "#f3e6ca",
    mauve = "#f5a79f",
    lavender = "#d3c6aa",
    red = "#e67e80",
    peach = "#e69875",
    yellow = "#dbbc7f",
    green = "#a7c080",
    teal = "#83c092",
    blue = "#7fbbb3",
    pink = "#d699b6",
    overlay1 = "#7a8478",
    subtext1 = "#9da9a0",
    subtext0 = "#859289",
    surface1 = "#354249",
  },
  mocha = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#f5a79f",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#f5e0dc",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
  },
  nordic = {
    rosewater = "#C0C8D8",
    flamingo = "#f2cdcd",
    pink = "#B48EAD",
    mauve = "#81A1C1",
    red = "#BF616A",
    maroon = "#eba0ac",
    peach = "#D08770",
    yellow = "#EBCB8B",
    green = "#A3BE8C",
    teal = "#8FBCBB",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#5E81AC",
    lavender = "#b4befe",
    text = "#BBC3D4",
    subtext1 = "#60728A",
    subtext0 = "#4C566A",
    overlay2 = "#434C5E",
    overlay1 = "#3B4252",
    overlay0 = "#2E3440",
    surface2 = "#242933",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e2326",
    mantle = "#181825",
    crust = "#11111b",
  },
}

M.get_palette = function(name)
  return M.palettes[name]
end

return M
