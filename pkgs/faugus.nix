final: prev: {
  faugus-launcher = prev.python3Packages.buildPythonApplication (finalAttrs: {
    pname = "faugus-launcher";
    version = "1.22.6";
    pyproject = false;

    src = prev.fetchFromGitHub {
      owner = "Faugus";
      repo = "faugus-launcher";
      tag = finalAttrs.version;
      hash = "sha256-hN0DU7MFlG8+TVQ2pWRRIVIDlmmHE54Dv/PqFAwwECs=";
    };

    nativeBuildInputs = [
      prev.gobject-introspection
      prev.meson
      prev.ninja
      prev.wrapGAppsHook3
    ];

    buildInputs = [
      prev.libayatana-appindicator
    ];

    dependencies = with prev.python3Packages; [
      pillow
      psutil
      pygame
      pygobject3
      requests
      vdf
    ];

    postPatch = ''
      substituteInPlace faugus-launcher \
        --replace-fail "/usr/bin/python3" "${prev.python3Packages.python.interpreter}"

      substituteInPlace faugus/path_manager.py \
        --replace-fail "PathManager.user_data('faugus-launcher/umu-run')" "'${prev.lib.getExe prev.umu-launcher}'" \
        --replace-fail "Path(\"/usr/lib/extensions/vulkan/lsfgvk/lib/liblsfg-vk.so\")" "Path(\"${prev.lsfg-vk}/lib/liblsfg-vk.so\")" \
        --replace-fail "Path(\"/usr/lib/liblsfg-vk.so\")" "Path(\"${prev.lsfg-vk}/lib/liblsfg-vk.so\")"
    '';

    dontWrapGApps = true;

    preFixup = ''
      makeWrapperArgs+=(
        "''${gappsWrapperArgs[@]}"
        --suffix PYTHONPATH : "$out/${prev.python3Packages.python.sitePackages}:$PYTHONPATH"
        --suffix PATH : "${
          prev.lib.makeBinPath [
            prev.icoextract
            prev.imagemagick
            prev.libcanberra-gtk3
            prev.umu-launcher
            prev.vulkan-tools
            prev.xdg-utils
          ]
        }"
      )
      wrapProgram $out/bin/faugus-launcher ''${makeWrapperArgs[@]}
    '';

    meta = {
      description = "Simple and lightweight app for running Windows games using UMU-Launcher";
      homepage = "https://github.com/Faugus/faugus-launcher";
      changelog = "https://github.com/Faugus/faugus-launcher/releases/tag/${finalAttrs.version}";
      license = prev.lib.licenses.mit;
      maintainers = with prev.lib.maintainers; [ RoGreat ];
      mainProgram = "faugus-launcher";
      platforms = prev.lib.platforms.linux;
    };
  });
}
