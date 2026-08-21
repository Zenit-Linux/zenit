core {
  db_path                = "/var/lib/zpm/zpm.db"
  parallel_updates       = true
  confirm_before_install = true
}

backends {
  enabled         = ["own", "flatpak", "apt", "snap", "brew", "cargo", "pip", "npm"]
  preferred_order = ["own", "flatpak", "apt", "snap", "brew", "cargo", "pip", "npm"]
}

building {
  cache_dir       = "/var/cache/zpm/building"
  default_backend = "apt"
}

custom {
  repository_path = "/etc/zpm/custom/own-repository.json"
  install_dir     = "/usr/local/bin"
}
