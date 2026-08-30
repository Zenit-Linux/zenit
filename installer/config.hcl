installer {
  desktop_selector = true

  # Środowiska graficzne dostępne w tej dystrybucji -- każdemu (poza
  # "none" i sentinelem "all", patrz niżej) odpowiada katalog
  # modules/desktop-<id>/ z metapakietem "zenit-desktop-<id>" (patrz
  # zlbpkg/installerconfig.nim w repo zlb, walidowane przez `zlb validate`/
  # `zlb build iso`). GNOME i Plasma mają dziś pełny, realny zestaw
  # pakietów -- reszta (xfce/cosmic/budgie/mate/lxqt/deepin/
  # enlightenment/zde/blue) to na razie PLACEHOLDERY: katalog i metapakiet
  # istnieją (żeby nazwa/konwencja była już zarezerwowana i wybieralna w
  # kreatorze), ale bez pełnego zestawu pakietów środowiska -- patrz
  # komentarz w każdym modules/desktop-<id>/package.list.
  #
  # "all": dodatkowy sentinel (obok jawnie wymienionych wyżej) -- mówi
  # instalatorowi "pozwól użytkownikowi wybrać DOWOLNE środowisko z
  # pełnego, wbudowanego katalogu instalatora" (patrz
  # installerpkg/desktops.nim::KnownDesktops w repo installer), nie tylko
  # z listy poniżej. Utrzymujemy jednocześnie jawną listę (żeby `zlb
  # validate` pilnowało, że KAŻDE z tych konkretnych środowisk ma
  # przygotowany, zwalidowany katalog modułu w tym repo) i "all" (żeby
  # kreator i tak pokazywał pełen wybór, gdyby katalog instalatora
  # urósł o kolejne środowiska, zanim ten plik zdąży się o nich
  # dowiedzieć).
  desktops = [
    "gnome", "plasma",
    "xfce", "cosmic", "budgie", "mate", "lxqt", "deepin", "enlightenment",
    "zde", "blue",
    "all", "none"
  ]
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
