final: prev: {
  spotify = prev.spotify.overrideAttrs (old: rec {
    version = "1.2.86.502.g8cd7fb22";
    rev = "94";
    src = final.fetchurl {
      url = "https://api.snapcraft.io/api/v1/snaps/download/pOBIoZ2LrCB3rDohMxoYGnbN14EHOgD7_94.snap";
      hash = "sha256-XhwyaObck6viIvDRXEztlSLja5fsfw5HgHUUQzMehLI=";
      name = "spotify-${version}-${rev}.snap";
    };
  });
}

