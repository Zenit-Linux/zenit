installer {
  desktop_selector = true

  # Środowiska graficzne dostępne w tej dystrybucji -- każde musi mieć
  # odpowiadający wpis w modules/package.list (dowolny backend).
  desktops = ["gnome", "none"]
  default_desktop = "gnome"

  default_locale = "en_US.UTF-8"
  locales         = ["en_US.UTF-8", "pl_PL.UTF-8"]

  allow_manual_partitioning = true
}

branding {
  # Pliki istnieją w overlays/branding/ (patrz ten katalog w repo).
  icon   = "icon-no-bg.png"
  banner = "banner.png"
}
