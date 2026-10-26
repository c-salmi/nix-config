{ inputs, ... }:

{
  # Personal website, built by the personal_website flake and served by Caddy.
  # Update to the latest commit with: nix flake update personal-website
  flake.modules.nixos.website = { pkgs, ... }:
    let
      site = inputs.personal-website.packages.${pkgs.stdenv.hostPlatform.system}.default;
    in
    {
      # Domain names as keys get automatic HTTPS from Let's Encrypt.
      services.caddy.virtualHosts."www.chadisalmi.com".extraConfig = ''
        redir https://chadisalmi.com{uri} permanent
      '';
      services.caddy.virtualHosts."chadisalmi.com".extraConfig = ''
        root * ${site}
        encode zstd gzip
        try_files {path} {path}.html
        file_server

        @static path *.css *.js *.jpg *.jpeg *.png *.gif *.ico *.svg *.webp *.woff *.woff2
        header @static Cache-Control "public, max-age=604800"
      '';
    };
}
