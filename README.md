# zenith

Source code for Zenith Linux -- kod źródłowy dystrybucji budowanej
przez [zlb](https://github.com/Zenith-Linux/zlb) (Zenith Linux Builder)
przy użyciu [zpm](https://github.com/Zenith-Linux/zpm) (Zenith Package
Manager) jako menedżera pakietów oraz
[installer](https://github.com/Zenith-Linux/installer) (Zenith
Installer) jako graficznego instalatora osadzonego w obrazie live.

## Struktura

```
distro.hcl                          -- manifest główny (nazwa, wersja, arch, backend domyślny, tools{})
keys/default.hcl                    -- zestaw kluczy repo, którym ufa świeży zpm w rootfsie
modules/core/
  package.list                      -- pakiety do zainstalowania (składnia "pkg" / "pkg -> backend")
  scripts/setup.janet                 -- hooki pre-packages / post-packages / post-overlay
overlays/
  branding/                           -- logo, ikony
  home/.bashrc                         -- domyślny .bashrc kont użytkowników
  system/etc/zpm/config.hcl            -- produkcyjna konfiguracja zpm w zainstalowanym systemie
  system/etc/zpm/custom/own-repository.json -- ekosystem własny (zpm, installer, cr, ow)
  system/etc/systemd/system/zenith-session-select.service
  system/usr/local/bin/zenith-session-select -- Live vs. Install wg /proc/cmdline
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
