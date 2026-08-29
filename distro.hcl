distro {
  name     = "Zenit Linux"
  codename = "testing"
  version  = "0.1.0"

  # "self" -- Zenit Linux bootstrapuje się z poprzednio zbudowanego
  # ziarna Zenit (out/cache/seeds/), nie z obcej dystrybucji.
  base = "self"

  # Domyślny backend zpm dla pakietów bez jawnego "-> backend" w
  # modules/*/package.list. Przy base = "self" domyślnie jest to "apt"
  # (patrz zlbpkg/manifest.nim::backendForBase w repo zlb) -- Zenit w
  # tej fazie projektu korzysta z bazy pakietów Debiana dla pakietów
  # systemowych, a z ekosystemu własnego ("own") dla narzędzi Zenit.
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
  output      = "zenit-linux-${version}-${arch}.iso"
}

oci {
  registry   = "ghcr.io/zenit-linux"
  repository = "zenit-linux"
  tag        = "${version}"
  output     = "zenit-linux-${version}-${arch}-oci"
}

keys {
  gpg_key      = "keys/zenit-release.asc"
  gpg_key_id   = ""
  zpm_key_list = "keys/default.hcl"
}

workflow {
  provider    = "github"
  triggers    = ["push", "tag"]
  matrix_arch = ["x86_64", "aarch64"]
}
