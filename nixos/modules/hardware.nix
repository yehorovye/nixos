{
  services.xserver.videoDrivers = [ "nvidia" ];
  services.dbus.enable = true;
  services.pcscd.enable = true;

  hardware.nvidia = {
    open = true;
  };
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
}
