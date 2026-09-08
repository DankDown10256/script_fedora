#!/usr/bin/env bash
set -euo pipefail

SYSTEMD_DISABLE=(
  NetworkManager-wait-online.service
  fwupd.service
  passim.service
  avahi-daemon.service
  avahi-daemon.socket
  ModemManager.service
  systemd-homed.service
  systemd-homed-activate.service
  sssd-kcm.service
  sssd-kcm.socket
  virtqemud.service
)

for u in "${SYSTEMD_DISABLE[@]}"; do
  if systemctl list-unit-files "$u" &>/dev/null; then
    sudo systemctl disable --now "$u" || true
  fi
done

sudo systemctl mask NetworkManager-wait-online.service fwupd.service passim.service ModemManager.service systemd-homed.service systemd-homed-activate.service sssd-kcm.service

PKGS=(
  abrt abrt-addon-ccpp abrt-addon-kerneloops abrt-addon-pstoreoops abrt-addon-vmcore abrt-addon-xorg
  abrt-cli abrt-dbus abrt-libs abrt-plugin-bodhi abrt-tui mcelog sos
  anaconda-core anaconda-install-env-deps anaconda-live anaconda-tui anaconda-webui livesys-scripts
  open-vm-tools open-vm-tools-desktop virtualbox-guest-additions qemu-guest-agent
  cups cups-browsed cups-client cups-filters cups-filters-driverless cups-ipptool
  hplip hplip-common hplip-libs
  sane-airscan sane-backends sane-backends-drivers-cameras sane-backends-drivers-scanners sane-backends-libs
  simple-scan
  gnome-boxes gnome-weather gnome-maps gnome-contacts gnome-connections gnome-tour gnome-user-docs
  yelp yelp-libs yelp-xsl
  gnome-initial-setup
  totem-pl-parser evince-djvu
)

sudo dnf remove -y "${PKGS[@]}"
sudo dnf autoremove -y
sudo dnf clean packages
