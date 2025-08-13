{
  # Disable PulseAudio — PipeWire will handle audio
  services.pulseaudio.enable = false;

  # Allow real‑time scheduling for better audio performance
  security.rtkit.enable = true;

  # Enable PipeWire with ALSA and PulseAudio compatibility
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
