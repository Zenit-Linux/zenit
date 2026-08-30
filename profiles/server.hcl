distro {
  name     = "Zenit Linux Server"
  codename = "testing"
  version  = "0.1.0"

  base            = "self"
  default_backend = "apt"

  arch = ["x86_64", "aarch64"]
}

modules {
  include = ["server"]
}

# Ten sam mechanizm wyboru toolsetu co distro.hcl -- serwer to typowe
# miejsce, gdzie ktoś faktycznie chce "wolny od GNU" (mniejsza podstawa
# ataku/audytu), stąd domyślny profil TUTAJ to "zenit", w przeciwieństwie
# do edycji desktopowej (distro.hcl), gdzie domyślny jest "gnu" dla
# najszerszej kompatybilności. Obie wartości są nadal nadpisywalne przez
# `zlb build rootfs --toolset=<gnu|zenit>` niezależnie od tego, co tu
# zapisano jako domyślne.
toolset {
  profile        = "zenit"
  allow_override = true
  gnu_module     = "toolset-gnu"
  zenit_module   = "toolset-zenit"
}

iso {
  bootloader  = "grub"
  boot_mode   = "hybrid"
  compression = "xz"
  output      = "zenit-linux-server-${version}-${arch}.iso"
}

oci {
  registry   = "ghcr.io/zenit-linux"
  repository = "zenit-linux-server"
  tag        = "${version}"
  output     = "zenit-linux-server-${version}-${arch}-oci"
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
