# fpp-scripts

**Status: Deprecated.** This repository — the FPP-sanctioned Script Repository — is deprecated,
and the in-app "Script Repository Browser" that browsed and installed from it has been removed
as of FPP 10.

**Scripts themselves aren't going away.** FPP still fully supports uploading, editing, and running
your own scripts via the **Scripts** tab in File Manager. What's deprecated is only this
repository and its in-app browser/installer. Scripts were contributed here over the years but
were often never revisited or updated for later FPP versions — generally unloved — and in the
meantime, almost everything they offered has been absorbed into FPP itself as native FPP
Commands, Overlay Model actions, or better-maintained plugins, so keeping a separate script
catalog no longer made sense.

This repository is kept around for historical reference and for the handful of scripts that
still don't have a built-in equivalent. If you're running FPP 10 or later and want one of the
scripts below, download it manually from the appropriate folder in this repo and install it via
the **Scripts** tab in FPP's **File Manager** page.

Only scripts that were still downloadable via the Script Repository Browser in FPP 8/9 are
included in the migration table below — scripts that had already fallen out of the browser's
compatibility window before FPP 8/9 are historical and not part of this migration guide.

## Recommended migration table

| Script | Category | Status in FPP 10 |
|---|---|---|
| [GPIO-On.sh](GPIO/GPIO-On.sh) | GPIO | Replaced — existing FPP Command: **GPIO → Set Output** |
| [GPIO-Off.sh](GPIO/GPIO-Off.sh) | GPIO | Replaced — existing FPP Command: **GPIO → Set Output** |
| [LongShort-ButtonPressed.sh](GPIO/LongShort-ButtonPressed.sh) | GPIO | Replaced — long/short press detection is now built into the GPIO Input configuration page directly |
| [LongShort-ButtonReleased.sh](GPIO/LongShort-ButtonReleased.sh) | GPIO | Replaced — long/short press detection is now built into the GPIO Input configuration page directly |
| [StaticOn.sh](Control/StaticOn.sh) | Control | Replaced — existing FPP Command: **Overlay Model → Fill** |
| [StaticOff.sh](Control/StaticOff.sh) | Control | Replaced — existing FPP Command: **Overlay Model → Clear** |
| [PixelOverlay-ScrollingText.php](PixelOverlay/PixelOverlay-ScrollingText.php) | PixelOverlay | Replaced — existing FPP Command: **Overlay Model → Effect** (scrolling text effect) |
| [PixelOverlay-Clock.php](PixelOverlay/PixelOverlay-Clock.php) | PixelOverlay | Replaced — official [FPP-Simple-Countdown](https://github.com/FalconChristmas/fpp-Simple-Countdown) plugin |
| [PixelOverlay-Countdown.php](PixelOverlay/PixelOverlay-Countdown.php) | PixelOverlay | Replaced — official [FPP-Simple-Countdown](https://github.com/FalconChristmas/fpp-Simple-Countdown) plugin |
| [PixelOverlay-CountdownToShow.sh](PixelOverlay/PixelOverlay-CountdownToShow.sh) | PixelOverlay | Replaced — official [FPP-Simple-Countdown](https://github.com/FalconChristmas/fpp-Simple-Countdown) plugin |
| [PixelOverlay-NaughtyNice.php](PixelOverlay/PixelOverlay-NaughtyNice.php) | PixelOverlay | Replaced — official [fpp-VideoCapture](https://github.com/FalconChristmas/fpp-VideoCapture) plugin combined with existing FPP Commands |
| [Reboot.sh](System/Reboot.sh) | System | Replaced — native **Reboot** FPP Command, added directly to FPP core |
| [Shutdown.sh](System/Shutdown.sh) | System | Replaced — native **Shutdown** FPP Command, added directly to FPP core |
| [UserCallbackHook.sh](Control/UserCallbackHook.sh) | Control | **Still fully supported.** FPP core still calls this hook script (if present) at `boot`, `preStart`, `postStart`, `preStop`, and `postStop`. Not part of this deprecation — keep using it if you rely on it. |
| [Send_Email_Script.sh](Control/Send_Email_Script.sh) | Control | **Partially replaced.** FPP now has native outbound email support (Settings → Email: SMTP server/port/login/from/to) and a built-in "send test email" action, so you no longer need to hand-configure `mail`/`msmtp` yourself. However, there is currently no built-in FPP Command to send a *custom* subject/message from a playlist, schedule, or event — that still needs a script (now much simpler, since it can just call `mail` using the FPP-managed configuration) or a small plugin exposing it as a proper Command. Nobody has built that plugin yet — if this matters to you, contributions welcome. |
| [SqueezeLiteStart.sh](Media/SqueezeLiteStart.sh) | Media | **Deprecated.** No FPP-core or official-plugin replacement exists. If you rely on SqueezeLite integration, a community plugin would be the way to bring this functionality back. |
| [SqueezeLiteStop.sh](Media/SqueezeLiteStop.sh) | Media | **Deprecated.** No FPP-core or official-plugin replacement exists. If you rely on SqueezeLite integration, a community plugin would be the way to bring this functionality back. |
| [DisplayStaticImage.sh](Media/DisplayStaticImage.sh) | Media | **Deprecated.** No replacement provided. |
| [DisableOnboardWifi-Pi3.sh](System/DisableOnboardWifi-Pi3.sh) | System | **No longer relevant.** |
| [EnableOnboardWifi-Pi3.sh](System/EnableOnboardWifi-Pi3.sh) | System | **No longer relevant.** |
| [add_fpp_src_samba.sh](System/add_fpp_src_samba.sh) | System | **Deprecated.** No replacement provided. |

## Everything else in this repository

Every other script in this repository's `index.csv` already had a `max_rfs_ver` below the current
FPP release before this deprecation happened — meaning FPP's old Script Repository Browser had
already stopped offering them as installable, functioning scripts in earlier FPP versions (they
were shown only in the "Incompatible Scripts" section, if at all). Nothing changed for those
scripts as part of removing the browser; they are simply historical.

## Useful Links

- [www.falconplayer.com](https://www.falconplayer.com)
