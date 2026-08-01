# fpp-scripts

**Status: Deprecated.** This repository — the FPP-sanctioned Script Repository — is deprecated,
and the in-app "Script Repository Browser" that browsed and installed from it has been removed
as of FPP 10.

**Scripts themselves aren't going away.** FPP still fully supports uploading, editing, and running
your own scripts via the **Scripts** tab in File Manager. What's deprecated is only this
repository and its in-app browser/installer. Scripts were contributed here over the years but
were often never revisited or updated for later FPP versions — generally unloved — and in the
meantime, almost everything they offered has been absorbed into FPP itself as FPP
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

| Category | Script | Suggested Replacement |
|---|---|---|
| Control | [Send_Email_Script.sh](Control/Send_Email_Script.sh) | FPP now has outbound email support (Settings → Email: SMTP server/port/login/from/to) and a built-in "send test email" action. However, there is currently no built-in FPP Command to send a *custom* subject/message from a playlist, schedule, or event — that still needs a script (now much simpler, since it can just call `mail` using the FPP-managed configuration). |
| Control | [StaticOff.sh](Control/StaticOff.sh) | FPP Command: **Overlay Model → Clear** |
| Control | [StaticOn.sh](Control/StaticOn.sh) | FPP Command: **Overlay Model → Fill** |
| Control | [UserCallbackHook.sh](Control/UserCallbackHook.sh) | **FPPD_STARTED** / **FPPD_STOPPED** Command Presets *(FPP does still call this script, if present, but it must be provided manually, FPP doesn't ship it.)* |
| GPIO | [GPIO-Off.sh](GPIO/GPIO-Off.sh) | FPP Command: **GPIO → Set Output** |
| GPIO | [GPIO-On.sh](GPIO/GPIO-On.sh) | FPP Command: **GPIO → Set Output** |
| GPIO | [LongShort-ButtonPressed.sh](GPIO/LongShort-ButtonPressed.sh) | GPIO Input configuration page from FPP 10 |
| GPIO | [LongShort-ButtonReleased.sh](GPIO/LongShort-ButtonReleased.sh) | GPIO Input configuration page from FPP 10 |
| Media | [DisplayStaticImage.sh](Media/DisplayStaticImage.sh) | No replacement provided. |
| Media | [SqueezeLiteStart.sh](Media/SqueezeLiteStart.sh) | No replacement provided. |
| Media | [SqueezeLiteStop.sh](Media/SqueezeLiteStop.sh) | No replacement provided. |
| PixelOverlay | [PixelOverlay-Clock.php](PixelOverlay/PixelOverlay-Clock.php) | [FPP-Simple-Countdown](https://github.com/FalconChristmas/fpp-Simple-Countdown) plugin |
| PixelOverlay | [PixelOverlay-Countdown.php](PixelOverlay/PixelOverlay-Countdown.php) | [FPP-Simple-Countdown](https://github.com/FalconChristmas/fpp-Simple-Countdown) plugin |
| PixelOverlay | [PixelOverlay-CountdownToShow.sh](PixelOverlay/PixelOverlay-CountdownToShow.sh) | [FPP-Simple-Countdown](https://github.com/FalconChristmas/fpp-Simple-Countdown) plugin |
| PixelOverlay | [PixelOverlay-NaughtyNice.php](PixelOverlay/PixelOverlay-NaughtyNice.php) | [fpp-VideoCapture](https://github.com/FalconChristmas/fpp-VideoCapture) plugin combined with FPP Commands |
| PixelOverlay | [PixelOverlay-ScrollingText.php](PixelOverlay/PixelOverlay-ScrollingText.php) | FPP Command: **Overlay Model → Effect** (scrolling text effect) |
| System | [add_fpp_src_samba.sh](System/add_fpp_src_samba.sh) | No replacement provided. |
| System | [DisableOnboardWifi-Pi3.sh](System/DisableOnboardWifi-Pi3.sh) | **No longer relevant.** |
| System | [EnableOnboardWifi-Pi3.sh](System/EnableOnboardWifi-Pi3.sh) | **No longer relevant.** |
| System | [Reboot.sh](System/Reboot.sh) | FPP Command: **Reboot**, from FPP 10 |
| System | [Shutdown.sh](System/Shutdown.sh) | FPP Command: **Shutdown**, from FPP 10 |

## Everything else in this repository

Every other script in this repository's `index.csv` already had a `max_rfs_ver` below the current
FPP release before this deprecation happened — meaning FPP's old Script Repository Browser had
already stopped offering them as installable, functioning scripts in earlier FPP versions (they
were shown only in the "Incompatible Scripts" section, if at all). Nothing changed for those
scripts as part of removing the browser; they are simply historical.

## Useful Links

- [www.falconplayer.com](https://www.falconplayer.com)
