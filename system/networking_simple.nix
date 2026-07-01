{ ... }:

{
  networking = {
    wireless = {
      iwd = {
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
    };
  };
}
