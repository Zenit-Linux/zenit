repo "zenit-own" {
  # Ekosystem własny Zenit (custom/own-repository.json w repo zpm) --
  # narzędzia takie jak zpm, installer, cr, ow. Weryfikowane przez
  # sha256 zamiast podpisu GPG na tym etapie projektu.
  type      = "own"
  url       = "https://github.com/Zenit-Linux"
  trust     = "sha256"
}

repo "debian-base" {
  # Baza pakietów systemowych dla default_backend = "apt" (distro.hcl).
  type      = "apt"
  url       = "https://deb.debian.org/debian"
  gpg_key   = "keys/debian-archive-keyring.asc"
  trust     = "gpg"
}

repo "flathub" {
  type      = "flatpak"
  url       = "https://flathub.org/repo/flathub.flatpakrepo"
  trust     = "gpg"
}
