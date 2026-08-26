(def rootfs (os/getenv "ZLB_ROOTFS"))
(def arch (os/getenv "ZLB_ARCH"))
(def distro-name (os/getenv "ZLB_DISTRO_NAME"))
(def distro-version (os/getenv "ZLB_VERSION"))
(def stage (os/getenv "ZLB_STAGE"))

(defn chroot-sh [cmd]
  (print "[setup.janet] chroot " rootfs " -- " cmd)
  (os/execute ["chroot" rootfs "/bin/sh" "-c" cmd] :p))

(defn stage= [s] (= stage s))

(when (stage= "post-packages")
  (print "[setup.janet] (" arch ") system bazowy zainstalowany, konfiguruję etap post-packages")
  # Włącz podstawowe usługi systemowe.
  (chroot-sh "systemctl enable NetworkManager || true")
  (chroot-sh "systemctl enable systemd-timesyncd || true"))

(when (stage= "post-overlay")
  (print "[setup.janet] (" arch ") overlays nałożone, finalizuję obraz " distro-name " " distro-version)

  # Wpięcie wyboru sesji live/installer (patrz overlays/system) jako
  # jednostki systemd uruchamianej przed graficznym menedżerem logowania
  # -- odróżnia sesję "Try/Live" od "Install" (installer=1 w /proc/cmdline,
  # patrz zlbpkg/iso.nim w repo zlb oraz installerpkg/liveenv.nim w repo
  # installer).
  (chroot-sh "systemctl enable zenit-session-select.service || true")

  # /etc/os-release spójny z distro.hcl, zamiast placeholdera z bazy apt.
  (def os-release
    (string
      "NAME=\"" distro-name "\"\n"
      "VERSION=\"" distro-version "\"\n"
      "ID=zenit\n"
      "ID_LIKE=debian\n"
      "PRETTY_NAME=\"" distro-name " " distro-version "\"\n"
      "HOME_URL=\"https://zenit-linux.org/\"\n"))
  (spit (string rootfs "/etc/os-release") os-release)

  (print "[setup.janet] gotowe."))
