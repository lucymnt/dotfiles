{ ... }:

{
  networking.wireless.enable = false;
  networking.networkmanager.enable = false;

  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
      Network = {
        EnableIPv6 = true;
      };
    };
  };
}
