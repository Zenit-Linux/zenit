distro {
  name     = "Zenit Linux Devcontainer"
  codename = "devcontainer"
  version  = "0.1.0"

  base            = "self"
  default_backend = "apt"

  # Tylko x86_64 -- devcontainery uruchamiane są lokalnie na maszynach
  # deweloperskich, gdzie aarch64 to margines (Apple Silicon owszem, ale
  # przez emulację/rosetta w podmanie na macOS i tak zwykle celuje w
  # x86_64 albo natywne aarch64 buduje się na żądanie, nie w CI).
  arch = ["x86_64"]
}

modules {
  include = ["devcontainer"]
}

# Ten manifest NIE ma bloku `iso {}` -- devcontainer to obraz WYŁĄCZNIE
# OCI (patrz modules/devcontainer/package.list: celowo brak jądra/
# bootloadera/instalatora), `zlb build iso --manifest=devcontainer.hcl`
# musi się nie powieść, nie cicho zbudować bezużyteczne ISO.

oci {
  registry   = "ghcr.io/zenit-linux"
  repository = "zenit-linux-devcontainer"
  tag        = "${version}"
  output     = "zenit-linux-devcontainer-${version}-${arch}-oci"
}

keys {
  gpg_key      = "keys/zenit-release.asc"
  gpg_key_id   = ""
  zpm_key_list = "keys/default.hcl"
}

workflow {
  provider    = "github"
  triggers    = ["push", "schedule"]
  matrix_arch = ["x86_64"]
}

tools {
  auto_fetch    = true
  zpm_url       = "https://github.com/Zenit-Linux/zpm/releases/download/v0.1/zpm"
}

# Brak bloku `toolset {}` -- devcontainer to obraz aplikacyjny nad
# istniejącym jądrem hosta (patrz komentarz w modules/devcontainer/
# package.list), wybór GNU-vs-Zenit coreutils nie ma tu zastosowania;
# `zlb` domyślnie przyjmuje profil "gnu" i tak, ale moduły toolset-*/
# nie są w `modules.include`, więc `withToolset`/`resolveIncludeModsWithToolset`
# jest tu no-opem z definicji (brak katalogów toolset-*/ w tym profilu
# nie jest błędem -- patrz zlbpkg/rootfs.nim::resolveIncludeModsWithToolset).
