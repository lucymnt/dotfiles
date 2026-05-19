final: prev: {
  eden = prev.eden.overrideAttrs (old: {
    version = "0.2.0";
    src = prev.fetchFromGitea {
      domain = "git.eden-emu.dev";
      owner = "eden-emu";
      repo = "eden";
      tag = "v0.2.0";
      hash = "sha256-Q/tJP6AHAtW9AXn9G+8dF4oTlKDfNHN4cuTKXtYq0T8=";
    };
    patches = [];
    buildInputs = old.buildInputs ++ [ prev.qt6.qtcharts ];
    preConfigure = (old.preConfigure or "") + ''
      httplibSrc=$(mktemp -d)
      cp -r ${prev.fetchFromGitHub {
        owner = "yhirose";
        repo = "cpp-httplib";
        rev = "v0.37.0";
        hash = "sha256-I7mfT4Eb5sXUURReq3nzQRUhI4sMx4wQpdJBw+vOA/s=";
      }}/. $httplibSrc
      chmod -R u+w $httplibSrc
      cmakeFlags+=("-DCPM_httplib_SOURCE=$httplibSrc")
    '';
  });
}
