# quidditch

## TODO

- NETWORKING!
  - Attempt to connect to devin's phone
  - Update to use real IP addresses via GUI (since phone and computer are on different networks)
- Update README with tools being used (asprite, godot, beepbox)

## Installing

### Android

Make a file at `/etc/udev/rules.d/51-android.rules` with the following contents:

```
SUBSYSTEM=="usb", ATTR{idVendor}=="****", ATTR{idProduct}=="****", MODE="0660", 
GROUP="plugdev", SYMLINK+="android%n"
```

- adb kill-server
- sudo adb start-server
- adb devices

- Install with `adb install foo.apk`

