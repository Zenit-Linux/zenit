# zenit

Source code for Zenit Linux -- kod źródłowy dystrybucji budowanej
przez [zlb](https://github.com/Zenit-Linux/zlb) (Zenit Linux Builder)
przy użyciu [zpm](https://github.com/Zenit-Linux/zpm) (Zenit Package
Manager) jako menedżera pakietów oraz
[installer](https://github.com/Zenit-Linux/installer) (Zenit
Installer) jako graficznego instalatora osadzonego w obrazie live.

## Struktura

```
distro.hcl                          -- manifest główny (nazwa, wersja, arch, backend domyślny, tools{})
keys/default.hcl                    -- zestaw kluczy repo, którym ufa świeży zpm w rootfsie
modules/core/
  package.list                      -- pakiety do zainstalowania (format HCL, blok `package "nazwa" { ... }`
                                        z polami backend/variant/description -- patrz zlb/docs)
  scripts/setup.janet                 -- hooki pre-packages / post-packages / post-overlay
installer/
  config.hcl                          -- konfiguracja Zenit Installer (PLACEHOLDER, patrz zlb/src/zlbpkg/installerconfig.nim)
overlays/
  branding/                           -- logo, ikony
  home/.bashrc                         -- domyślny .bashrc kont użytkowników
  system/etc/zpm/config.hcl            -- produkcyjna konfiguracja zpm w zainstalowanym systemie
  system/etc/zpm/custom/own-repository.json -- ekosystem własny (zpm, installer, cr, ow)
  system/etc/systemd/system/zenit-session-select.service
  system/usr/local/bin/zenit-session-select -- Live vs. Install wg /proc/cmdline
.github/workflows/
  setup.yml            -- walidacja distro.hcl / keys / package.list na każdy push/PR
  test.yml               -- szybki smoke-test (rootfs x86_64) na każdy PR
  build-standard.yml       -- rootfs jako tarball
  build-iso.yml              -- bootowalne ISO (Try/Live + Install w GRUB-ie)
  build-oci.yml                -- obraz OCI
  menu.yml                       -- ręczne menu wyboru buildu (workflow_dispatch)
```

## Budowanie lokalnie

```bash
zlb build rootfs --arch x86_64
zlb build iso    --arch x86_64
zlb build oci    --arch x86_64
```

`zlb` na starcie każdej z powyższych komend sam pobiera `zpm` i
`installer` (blok `tools {}` w `distro.hcl`) -- nie trzeba niczego
instalować ręcznie poza samym `zlb`.
