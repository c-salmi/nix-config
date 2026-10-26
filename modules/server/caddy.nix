{
  # Reverse proxy and static file server. Sites add their own
  # services.caddy.virtualHosts; a domain name as the key gets automatic HTTPS.
  flake.modules.nixos.caddy = {
    services.caddy.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 443 ];
  };
}
