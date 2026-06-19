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
          General = {
            AddressRandomization = "network";
          };
        };
      };
    };
    interfaces.enp2s0.ipv4.addresses = [{
      address = "192.168.100.1";
      prefixLength = 24;
    }];
    dhcpcd.extraConfig = ''
      nohostname
      nohook hostname
      nooption host_name
      noipv4ll
    '';
    firewall.extraCommands = ''
      iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
      iptables -A FORWARD -i enp2s0 -o wlan0 -j ACCEPT
      iptables -A FORWARD -i wlan0 -o enp2s0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    '';
  };
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
}
