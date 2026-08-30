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

# Wybór między klasycznym GNU coreutils/util-linux/... (modules/toolset-gnu/,
# backend apt) a własnymi, minimalnymi narzędziami Zenit (modules/toolset-zenit/,
# backend own, patrz zenit-base/tools/) -- "wolny od GNU, ale z narzędziami
# od Zenit". Domyślnie "gnu" (najszersza kompatybilność ze skryptami/
# dokumentacją zakładającą GNU coreutils); `zlb build rootfs --toolset=zenit`
# nadpisuje to dla pojedynczego builda. Ten moduł jest dokładany do
# `modules.include` AUTOMATYCZNIE przez zlb (patrz
# zlbpkg/rootfs.nim::resolveIncludeModsWithToolset w repo zlb) -- nie
# trzeba (i nie należy) wymieniać "toolset-gnu"/"toolset-zenit" ręcznie
# w `modules.include` powyżej.
toolset {
  profile        = "gnu"
  allow_override = true
  gnu_module     = "toolset-gnu"
  zenit_module   = "toolset-zenit"
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

# Brak bloku tools { } (v0.4, usunięte) -- zlb sam wie, skąd pobrać
# najnowsze zpm (stały alias GitHuba w kodzie zlb, zawsze "latest").
# Instalator jest zwykłym pakietem: `package "installer" { backend = "own" }`
# w modules/core/package.list, instalowanym przez `zpm install installer`
# w ramach normalnej instalacji pakietów modułu -- nie ma już żadnej
# osobnej konfiguracji do tego w tym pliku.
