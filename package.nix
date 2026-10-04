{
  pkgs,
  lib,
  stdenv,
  alejandra,
  sd,
}:
stdenv.mkDerivation rec {
  pname = "arkenfox-nix";
  version = "144.0";

  src = pkgs.fetchFromGitHub {
    owner = "arkenfox";
    repo = "user.js";
    rev = version;
    hash = "sha256-oo3/j53+vDh0Y+uCMPFUGEc4bDr7uD4CzagEuQX5PM8=";
  };

  nativeBuildInputs = [
    alejandra
    sd
  ];

  dontConfigure = true;

  buildPhase = let
    multilineStart = ''\/\*'';
    matchAny = ''[\s\S]'';
    multilineEnd = ''\*\/'';
  in ''
    runHook preBuild

    echo "{" > /build/user.nix

    # Remove single-line comments
    sd -p '//\s+.*$' "" $src/user.js | \
    # Remove multi-line comments
    sd -A '${multilineStart}${matchAny}*?${multilineEnd}' "" | \
    # Remove _user.js.parrot lines
    sd '^.*user.js.parrot.*$' "" | \
    # Finally do the actual conversion
    sd '^\s*user_pref\((".*?"),\s*(.*)\);\s*$' '$1 = $2;' \
    >> /build/user.nix

    echo "}" >> /build/user.nix

    alejandra /build/user.nix

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    cp /build/user.nix $out

    runHook postInstall
  '';
}
