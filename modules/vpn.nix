{ ... }:
{
  # NordVPN tunnel, shared by every machine
  services.openvpn.servers = {
    nordVPN = {
      config = ''
        config /home/nakedsnake/Documents/GitHub/OpenVPN/us5839.nordvpn.com.udp.ovpn
        auth-user-pass /etc/openvpn/nordvpn.cred
      '';
      autoStart = true; # start on boot
      updateResolvConf = true; # update DNS, if needed
    };
  };
}
