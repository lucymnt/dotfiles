final: prev: {
  ryubing = prev.buildFHSEnv {
    name = "ryujinx";
    targetPkgs = pkgs: with pkgs; [
      stdenv.cc.cc.lib
      icu
      libice
      libsm
      libx11
      libxext
      libxi
      libxrandr
      libxcursor
      libgdiplus
      openal
      libsoundio
      vulkan-loader
      gtk3
      libGL
      SDL2
      ffmpeg
      fontconfig
      freetype
      pulseaudio
      udev
      openssl
      curl
    ];
    runScript = "${
      prev.buildDotnetModule {
        pname = "ryubing-canary";
        version = "1.3.294-canary";
        src = prev.fetchurl {
          url = "https://git.ryujinx.app/Ryubing/Canary/releases/download/1.3.294/ryujinx-canary-1.3.294-linux_x64.tar.gz";
          hash = "sha256-JHIhSslXjy5dvVYvu9mhoKTEfmSbjQPts/25CtIMKlo=";
        };
        unpackPhase = ''
          mkdir -p source
          tar -xf $src -C source
        '';
        configurePhase = "true";
        buildPhase = "true";
        installPhase = ''
          mkdir -p $out/lib/ryubing
          cp -r source/publish/* $out/lib/ryubing/
        '';
        nugetDeps = null;
        doCheck = false;
      }
    }/lib/ryubing/Ryujinx";
    extraInstallCommands = let
      ryubingSrc = prev.fetchFromGitLab {
        domain = "git.ryujinx.app";
        owner = "Ryubing";
        repo = "Ryujinx";
        tag = "1.3.3";
        hash = "sha256-LhQaXxmj5HIgfmrsDN8GhhVXlXHpDO2Q8JtNLaCq0mk=";
      };
    in ''
      mkdir -p $out/share/{applications,icons/hicolor/scalable/apps,mime/packages}
      install -D ${ryubingSrc}/distribution/linux/Ryujinx.desktop $out/share/applications/Ryujinx.desktop
      install -D ${ryubingSrc}/distribution/misc/Logo.svg $out/share/icons/hicolor/scalable/apps/Ryujinx.svg
      install -D ${ryubingSrc}/distribution/linux/mime/Ryujinx.xml $out/share/mime/packages/Ryujinx.xml
      sed -i 's|Exec=Ryujinx.sh|Exec=ryujinx|' $out/share/applications/Ryujinx.desktop
    '';
  };
}
