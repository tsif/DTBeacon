DTBeacon
========

iBeacons are transmitters that can notify nearby iOS 7 devices of their presence.

More here: http://support.apple.com/kb/HT6048

This beacon singleton class posts an NSNotification for state changes (entering/exiting a region/ proximity etc.)
and can be used by multiple objects simultaneously.

You can add DTBeacon .h/.m to you projects, and check out DTViewController for example usage.
