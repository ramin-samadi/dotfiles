pactl list sinks short
42      alsa_output.pci-0000_01_00.1.hdmi-stereo        PipeWire        s32le 2ch 48000Hz       SUSPENDED
43      alsa_output.pci-0000_00_1b.0.analog-stereo      PipeWire        s32le 2ch 48000Hz       SUSPENDED
1231    alsa_output.usb-Razer_Razer_Nommo_Chroma-02.analog-stereo       PipeWire        s16le 2ch 48000Hz       SUSPENDED

pactl set-default-sink 1231
