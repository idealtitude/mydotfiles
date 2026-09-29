-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 9.5

-- Curseur en barre vertical (SteadyBar = fixe, BlinkingBar = clignotant)
config.default_cursor_style = 'SteadyBar'

-- Police de caractères (ex: JetBrains Mono si disponible, fallback automatique)
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',
  'DejaVu Sans Mono',
})

-- Fenêtre et ergonomie
config.enable_scroll_bar = false               -- Masque la barre de défilement (inutile au clavier)
config.scrollback_lines = 10000                 -- Augmente le tampon d'historique du terminal
config.check_for_updates = false              -- Évite les pings de mise à jour inutiles au démarrage

-- Performance et rendu
config.front_end = "WebGpu"                    -- Rendu GPU fluide (bascule automatique sur OpenGL si indisponible)
config.max_fps = 30                          -- Fréquence d'affichage pour une fluidité optimale

-- Gestion de la barre d'onglets
config.hide_tab_bar_if_only_one_tab = false     -- Affiche toujours la barre d'onglets
config.use_fancy_tab_bar = true                 -- Onglets arrondis modernes

-- Détection de la cloche (bell) : pas de bip sonore
config.audible_bell = "Disabled"

-- Finally, return the configuration to wezterm:
return config
