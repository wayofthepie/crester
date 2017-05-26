with import <nixpkgs> {};

let
  orcania = stdenv.mkDerivation {
    name = "orcania";
    buildInputs =[ pkgs.jansson ];
    src = fetchFromGitHub {
      owner = "babelouest";
      repo = "orcania";
      rev = "f5a437f44bdc3297d56d0d663b9fabfb7deef18d";
      sha256 = "0nwgzglziad7zn1h6i5wzmqvmbl4j16s67c1lbbn4j33jj68p9lm";
    };
    preBuild = ''
      mkdir -p $out/lib
      mkdir -p $out/include
      sed -i "s:PREFIX=\/usr\/local:PREFIX=$out:" src/Makefile
      sed -i '/\/sbin\/ldconfig/d' src/Makefile
      sed -i 's/\$(OUTPUT)\.\$(VERSION)/\$(OUTPUT)/' src/Makefile
      sed -i '/ln/d' src/Makefile
      cat src/Makefile
    '';
  };

  yder = stdenv.mkDerivation {
    name = "yder";
    buildInputs = [ orcania pkgs.jansson  ];
    src = fetchFromGitHub {
      owner = "babelouest";
      repo = "yder";
      rev = "9965444012be16822a2055dacd987c8a914a26fd";
      sha256 = "1ia68xxz2c7164p0jcd8pzf64h2aw39l3i7rsf82qllmzlj9ig5g";
    };
    preBuild = ''
      mkdir -p $out/lib
      mkdir -p $out/include
      sed -i "s:PREFIX=\/usr\/local:PREFIX=$out:" src/Makefile
      sed -i '/\/sbin\/ldconfig/d' src/Makefile
      sed -i 's/\$(OUTPUT)\.\$(VERSION)/\$(OUTPUT)/' src/Makefile
      sed -i '/ln/d' src/Makefile
      sed -i '/cp\slibyder.so/d' src/Makefile
    '';
  };

  ulfius = stdenv.mkDerivation {
    name = "ulfius";
    buildInputs = [
      yder
      orcania
      pkgs.libmicrohttpd
      pkgs.jansson
      pkgs.curl
      pkgs.gnutls
    ];
    src = fetchFromGitHub {
      owner = "babelouest";
      repo = "ulfius";
      rev = "13dc8daec231c447bff067195fda47db9bde8b4c";
      sha256 = "0gxlq2sxjxjgiwkdh9fk2kwp5a7sncqzx98qv4yb6z8c7lss6jqd";
    };
    preBuild = ''
      mkdir -p $out/lib
      mkdir -p $out/include
      sed -i "s:PREFIX=\/usr\/local:PREFIX=$out:" src/Makefile
      sed -i '/ldconfig/d' src/Makefile
      sed -i 's/\$(OUTPUT)\.\$(VERSION)/\$(OUTPUT)/' src/Makefile
      sed -i '/ln/d' src/Makefile
      sed -i '/cp\slibyder.so/d' src/Makefile
      cat src/Makefile
    '';
  };

  crester = callPackage ./crester.nix { ulfius = ulfius; };

in stdenv.mkDerivation rec {
  name = "crester-${version}";
  version = "0.0.1";
  buildInputs =[crester ];
}
