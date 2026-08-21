distro {
  name     = "Zenith Linux"
  codename = "nova"
  version  = "0.1.0"

  # "self" -- Zenith Linux bootstrapuje się z poprzednio zbudowanego
  # ziarna Zenith (out/cache/seeds/), nie z obcej dystrybucji.
  base = "self"

  # Domyślny backend zpm dla pakietów bez jawnego "-> backend" w
  # modules/*/package.list. Przy base = "self" domyślnie jest to "apt"
  # (patrz zlbpkg/manifest.nim::backendForBase w repo zlb) -- Zenith w
  # tej fazie projektu korzysta z bazy pakietów Debiana dla pakietów
  # systemowych, a z ekosystemu własnego ("own") dla narzędzi Zenith.
  default_backend = "apt"

  arch = ["x86_64", "aarch64"]
}

modules {
  include = ["core"]
}

iso {
  bootloader  = "grub"
  boot_mode   = "hybrid"
  compression = "xz"
  output      = "zenith-linux-${version}-${arch}.iso"
}

oci {
  registry   = "ghcr.io/zenith-linux"
  repository = "zenith-linux"
  tag        = "${version}"
  output     = "zenith-linux-${version}-${arch}-oci"
}

keys {
  gpg_key      = "keys/zenith-release.asc"
  gpg_key_id   = ""
  zpm_key_list = "keys/default.hcl"
}

workflow {
  provider    = "github"
  triggers    = ["push", "tag"]
  matrix_arch = ["x86_64", "aarch64"]
}

tools {
  # Pobierane automatycznie na starcie `zlb build ...` (patrz
  # zlbpkg/tools.nim w repo zlb) zamiast zakładać, że runner CI ma je
  # już zainstalowane.
  auto_fetch    = true
  zpm_url       = "https://github.com/Zenith-Linux/zpm/releases/download/v0.1/zpm"
  installer_url = "https://github.com/Zenith-Linux/installer/releases/download/v0.1/installer"
}
