with import <nixpkgs> {};

let
  orcania = stdenv.mkDerivation {
    name = "orcania";
    buildInputs =[ jansson ];
    src = fetchFromGitHub {
      owner = "babelouest";
      repo = "orcania";
      rev = "f5a437f44bdc3297d56d0d663b9fabfb7deef18d";
      sha256 = "0nwgzglziad7zn1h6i5wzmqvmbl4j16s67c1lbbn4j33jj68p9lm";
    };
    installPhase = ''
      mkdir -p $out/lib
      mkdir -p $out/include
      sed -i "s:PREFIX=\/usr\/local:PREFIX=$out:" src/Makefile
      sed -i '/\/sbin\/ldconfig/d' src/Makefile
      cat src/Makefile
      make install
    '';
  };

  yder = stdenv.mkDerivation {
    name = "yder";
    buildInputs =[ jansson orcania ];
    src = fetchFromGitHub {
      owner = "babelouest";
      repo = "yder";
      rev = "9965444012be16822a2055dacd987c8a914a26fd";
      sha256 = "1ia68xxz2c7164p0jcd8pzf64h2aw39l3i7rsf82qllmzlj9ig5g";
    };
    installPhase = ''
      mkdir -p $out/lib
      mkdir -p $out/include
      sed -i "s:PREFIX=\/usr\/local:PREFIX=$out:" src/Makefile
      sed -i '/\/sbin\/ldconfig/d' src/Makefile
      cat src/Makefile
      make install
    '';
  };

  ulfius = stdenv.mkDerivation {
    name = "ulfius";
    buildInputs =[ yder libmicrohttpd ];
    src = fetchFromGitHub {
      owner = "babelouest";
      repo = "ulfius";
      rev = "13dc8daec231c447bff067195fda47db9bde8b4c";
      sha256 = "0gxlq2sxjxjgiwkdh9fk2kwp5a7sncqzx98qv4yb6z8c7lss6jqd";
    };
  };

  crester = callPackage ./crester.nix { ulfius = ulfius; };

in stdenv.mkDerivation rec {
  name = "crester-${version}";
  version = "0.0.1";
  buildInputs =[crester ];
}
