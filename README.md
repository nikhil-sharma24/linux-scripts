# 🐧 Linux Post-Install Setup Guide (Dual Boot + Performance)

> One-stop setup for Ubuntu after fresh install (performance + dev ready)

---

<details>
<summary>🧠 1. Dual Boot Time Fix (Windows ↔ Ubuntu)</summary>

### Option A (Recommended: Ubuntu uses local time)
```bash
timedatectl set-local-rtc 1 --adjust-system-clock
timedatectl
```

### Option B (Windows uses UTC)
```cmd
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation" /v RealTimeIsUniversal /t REG_DWORD /d 1
```

</details>

---

<details>
<summary>🔋 2. TLP Battery Optimization</summary>

### Install & Enable
```bash
sudo apt install tlp tlp-rdw
sudo systemctl enable tlp
sudo systemctl start tlp
```

### Check Status
```bash
tlp-stat -s
```

### Optional Config
```bash
sudo nano /etc/tlp.conf
```

```ini
CPU_SCALING_GOVERNOR_ON_BAT=powersave
CPU_ENERGY_PERF_POLICY_ON_BAT=power
```

</details>

---

<details>
<summary>⚡ 3. ZRAM Setup</summary>

### Install
```bash
sudo apt install zram-tools
```

### Configure
```bash
sudo nano /etc/default/zramswap
```

```ini
ALGO=zstd
PERCENT=100
```

### Apply
```bash
sudo systemctl restart zramswap
```

### Verify
```bash
swapon --show
```

</details>

---

<details>
<summary>⚡ 4. ZSWAP (Optional)</summary>

### Enable via GRUB
```bash
sudo nano /etc/default/grub
```

```ini
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1 zswap.compressor=zstd"
```

```bash
sudo update-grub
```

</details>

---

<details>
<summary>💻 5. Force Git to Use SSH</summary>

```bash
git config --global url."git@github.com:".insteadOf "https://github.com/"
ssh -T git@github.com
```

</details>

---

<details>
<summary>📋 6. Clipboard from Terminal</summary>

### Install
```bash
sudo apt install xclip
```

### Usage
```bash
cat file.txt | xclip -selection clipboard
echo "text" | xclip -selection clipboard
```

</details>

---

<details>
<summary>🧩 7. VS Code Settings Transfer</summary>

### Paths
```bash
~/.config/Code/User/settings.json
~/.config/Code/User/keybindings.json
```

### Restore
```bash
mkdir -p ~/.config/Code/User
cp settings.json ~/.config/Code/User/
cp keybindings.json ~/.config/Code/User/
```

</details>

---

<details>
<summary>🧱 8. GRUB Customization</summary>

```bash
sudo nano /etc/default/grub
sudo update-grub
```

</details>

---

<details>
<summary>🧠 9. Swap + ZRAM Strategy</summary>

- ZRAM → 100% RAM (priority 100)  
- Disk swap → fallback (priority -1)

```bash
swapon --show
```

</details>

---

<details>
<summary>🧪 10. Fix Stuck Terminal</summary>

```bash
killall gnome-terminal-server
ps aux | grep terminal
```

</details>

---

<details>
<summary>🧰 11. Essential Packages</summary>

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget htop neovim xclip build-essential tlp zram-tools
```

</details>

---

<details>
<summary> 12.Remove Snap </summary>

```bash
	sudo rm -rf /var/cache/snapd/
	sudo apt autoremove --purge snapd gnome-software-plugin-snap
	rm -fr ~/snap
	sudo apt-mark hold snapd
```

</details>

---

<details>
<summary> 13. Bash History Scrolling </summary>

```bash
	echo 'TAB: menu-complete
"\e[A": history-search-backward
"\e[B": history-search-forward
' >> input.md
```

</details>

---

## ✅ Final Recommended Setup

- TLP enabled  
- ZRAM (100%, zstd)  
- ZSWAP optional  
- Git via SSH  
- Clipboard via xclip  
- VSCode configs restored  
- Dual boot time fixed  

---
