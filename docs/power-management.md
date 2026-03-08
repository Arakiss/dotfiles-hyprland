# Power Management

## Strategy

This machine runs workloads around the clock (AI inference, background builds, long-running processes), so **suspend and hibernate are fully disabled**. The monitors turn off after idle, but the system stays active at all times.

## What's configured

### 1. systemd targets (masked)

All sleep-related targets are masked so nothing — not logind, not a desktop button, not a script — can trigger suspend:

```bash
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
```

To verify:

```bash
systemctl status sleep.target suspend.target hibernate.target
# All should show "masked"
```

To undo (if you ever want suspend back):

```bash
sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target
```

### 2. logind overrides

File: `/etc/systemd/logind.conf.d/no-suspend.conf`

```ini
[Login]
HandleSuspendKey=ignore
HandleHibernateKey=ignore
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
```

This tells systemd-logind to ignore all hardware sleep triggers (power button sleep, lid close, etc.).

Apply after creating the file (reload config without killing sessions):

```bash
sudo systemctl kill -s HUP systemd-logind
```

**WARNING:** Never use `systemctl restart systemd-logind` — it destroys all active graphical sessions (SDDM, Hyprland, etc.).

### 3. Hypridle (screen-only power saving)

File: `config/hypr/hypridle.conf`

- **5 minutes idle** -> lock screen (hyprlock)
- **10 minutes idle** -> turn off monitors (DPMS off)
- **System never sleeps** — CPU, GPU, network, and all processes remain active

The monitors wake instantly on any input (mouse, keyboard).

## Quick setup

Run both commands to apply the full no-suspend config:

```bash
# Mask systemd sleep targets
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target suspend-then-hibernate.target

# Prevent logind from suspending on hardware events
sudo mkdir -p /etc/systemd/logind.conf.d
sudo tee /etc/systemd/logind.conf.d/no-suspend.conf << 'EOF'
[Login]
HandleSuspendKey=ignore
HandleHibernateKey=ignore
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
EOF

sudo systemctl kill -s HUP systemd-logind
```
