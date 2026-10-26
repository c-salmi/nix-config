{
  flake.modules.nixos.ssh-hardened = {
    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
      };
    };
    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEvhrITlQDWcH2bQEaGSLJoxMBrLozRlDbwChdWrxb+ chadi@nixos"
    ];
    users.users.chadi.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEvhrITlQDWcH2bQEaGSLJoxMBrLozRlDbwChdWrxb+ chadi@nixos"
    ];
    # chadi has no password on servers, so wheel sudo must not ask for one.
    security.sudo.wheelNeedsPassword = false;
  };
}
