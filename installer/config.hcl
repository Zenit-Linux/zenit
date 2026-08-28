installer {
  desktop_selector = true

  # Środowiska graficzne dostępne w tej dystrybucji -- każdemu (poza
  # "none") odpowiada katalog modules/desktop-<id>/ z metapakietem
  # "zenit-desktop-<id>" (patrz zlbpkg/installerconfig.nim w repo zlb,
  # walidowane przez `zlb validate`/`zlb build iso`).
  desktops = ["gnome", "plasma", "none"]
  default_desktop = "gnome"

  default_locale = "en_US.UTF-8"
  locales         = ["en_US.UTF-8", "pl_PL.UTF-8", "de_DE.UTF-8", "fr_FR.UTF-8",
                      "es_ES.UTF-8", "it_IT.UTF-8", "uk_UA.UTF-8"]

  allow_manual_partitioning = true

  # Nazwa produktu pokazywana w kreatorze (patrz InstallerConfig.title w
  # zlb i RunnerConfig.title w installer) -- puste = użyj distro.name.
  title = "Zenit Linux Installer"
}

branding {
  # Pliki istnieją w overlays/branding/ (patrz ten katalog w repo).
  icon   = "icon-no-bg.png"
  banner = "banner.png"
}
