Fix-firmware-i915

Fix error "Possible missing firmware /lib/firmware/i915 " on Debian, SysLinuxOS and others Linux distro.
All warnings displayed are related to missing firmware for the following Intel microarchitectures:
Sky Lake, Broxton, Kaby Lake, Commet Lake, Ice Lake, Elkhart Lake, Tiger Lake, Gemini Lake, Alder Lake,Arc Alchemist.

Download and use:

git clone https://github.com/fconidi/fix-firmware-i915.git
cd fix-firmware-i915/
chmod +x fixi915.sh
./fixi915.sh
