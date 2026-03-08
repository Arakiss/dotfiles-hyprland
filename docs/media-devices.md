# Media Devices (Camera & Microphone)

## Hardware

- **Camera:** Logitech StreamCam (046d:0893) — USB 3.0, /dev/video0
- **Microphone:** Blue Microphones Yeti (046d:0ab7) — USB 2.0, /dev/video1 is metadata-only (no capture formats)
- **Audio interface:** Generic USB Audio (DAC/speakers)

## PipeWire / WirePlumber

The Blue Mic must be the default audio source:

```bash
# Check current default
wpctl inspect @DEFAULT_SOURCE@

# If it's wrong (e.g., StreamCam mic), fix it:
wpctl set-default 61  # Blue Microphones node ID
```

WirePlumber remembers the default across sessions, but may reset it if USB devices are replugged.

## Google Chrome flags

File: `~/.config/chrome-flags.conf`

```
--ozone-platform-hint=auto
--enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer
--enable-wayland-ime
--disable-features=VaapiVideoEncodeAcceleration,VaapiVideoDecodeLinuxGL
--disable-gpu-compositing
--use-gl=angle
--use-angle=gl
```

### Why these flags matter

| Flag                                      | Purpose                                                   |
| ----------------------------------------- | --------------------------------------------------------- |
| `UseOzonePlatform`                        | Native Wayland support (not XWayland)                     |
| `WebRTCPipeWireCapturer`                  | WebRTC audio capture via PipeWire                         |
| `VaapiVideoEncodeAcceleration` (disabled) | NVIDIA VAAPI encoding causes white camera in Google Meet  |
| `VaapiVideoDecodeLinuxGL` (disabled)      | Same issue with decode path                               |
| `--disable-gpu-compositing`               | Prevents GPU compositing bugs with video frames on NVIDIA |
| `--use-gl=angle --use-angle=gl`           | Uses ANGLE GL backend, avoids NVIDIA GL quirks            |

**Do NOT add `PipeWireCameraSupport`** — it routes camera through PipeWire Camera portal which returns blank frames. Chrome's direct V4L2 access works correctly.

## Known issues

### Camera shows white in Google Meet but works elsewhere

- **Cause:** NVIDIA hardware video encoding (VAAPI) corrupts WebRTC video frames
- **Fix:** The `--disable-features` and `--disable-gpu-compositing` flags above

### Blue Microphone I/O error (no audio captured)

- **Cause:** USB isochronous endpoint corrupted after failed suspend/hibernate or logind restart
- **Fix:** Physically unplug and replug the Blue Mic USB cable. Software resets (`usbreset`, `authorized 0/1`) do not fix this.

### Default mic switches to StreamCam after replug

- **Cause:** WirePlumber re-enumerates and picks the last device
- **Fix:** `wpctl set-default 61` (Blue Mic node ID)

## Quick diagnostics

```bash
# Camera test (should produce a visible image)
ffmpeg -f v4l2 -i /dev/video0 -frames:v 1 -update 1 /tmp/cam-test.jpg -y

# Mic test (file should be >1000 bytes)
pw-record --target=61 /tmp/mic-test.wav &
sleep 2 && kill $!
wc -c /tmp/mic-test.wav

# Check mic audio levels (mean_volume should not be -inf)
ffmpeg -i /tmp/mic-test.wav -af volumedetect -f null /dev/null

# Check default audio source
wpctl inspect @DEFAULT_SOURCE@

# List all sources
wpctl status
```

## Deploy SDDM theme after changes

```bash
sudo ~/.dotfiles/bin/deploy-sddm-theme
```
