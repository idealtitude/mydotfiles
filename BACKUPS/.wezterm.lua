-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
config.color_scheme = 'Catppuccin Mocha'
config.font_size = 10

-- Curseur en barre vertical (SteadyBar = fixe, BlinkingBar = clignotant)
config.default_cursor_style = 'SteadyBar'

-- Police de caractères (ex: JetBrains Mono si disponible, fallback automatique)
config.font = wezterm.font_with_fallback({
  'JetBrains Mono',
  'DejaVu Sans Mono',
})

-- Disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.keys = {
  -- 1. Libérer Ctrl+Shift+Flèches pour que Micro puisse s'en servir
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.DisableDefaultAssignment },

  -- 2. Assigner la navigation des panneaux WezTerm à ALT + Flèches
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.ActivatePaneDirection 'Down' },

    -- Diviser l'écran en panneaux (Splits) avec ALT + v ou h
  { key = 'v', mods = 'ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    -- Redimensionner les panneaux avec ALT + CTRL + h/j/k/l (ajustement de 5 cellules)
  { key = 'h', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = 'l', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = 'k', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = 'j', mods = 'ALT|CTRL', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
}

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

-- CORRECTION 1 : Ajuster la taille de la police pour la barre d'onglets (Fancy)
config.window_frame = {
  font_size = 9.0, -- Réduit la police des onglets (adaptez à 8.0 ou 9.5 selon vos préférences)
}

-- CORRECTION 2 : Extraire uniquement le nom du dossier courant pour le titre
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local current_dir = tab.active_pane.current_working_dir
  local title = ""

  if current_dir then
    -- On récupère le chemin sous forme de chaîne (enlève le protocole file://)
    local dir_path = current_dir.file_path
    -- Extrait le texte après le dernier slash (le nom du dossier)
    title = dir_path:match("([^/]+)$") or dir_path

    -- Optionnel : Si vous êtes dans votre dossier "Home", afficher "~" au lieu de votre nom d'utilisateur
    if dir_path == wezterm.home_dir then
      title = "~"
    end
  else
    -- Fallback si le dossier n'est pas détecté (ex: pendant le démarrage)
    title = tab.active_pane.title
  end

  -- On ajoute un petit espace de confort autour du titre
  return " " .. title .. " "
end)

-- Détection de la cloche (bell) : pas de bip sonore
config.audible_bell = "Disabled"

-- Finally, return the configuration to wezterm:
return config
