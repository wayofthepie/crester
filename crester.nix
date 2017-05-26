{stdenv, ulfius}:
stdenv.mkDerivation rec {
  name = "crester-0.0.1";

  src = ./.;

  buildInputs = [ ulfius ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    mkdir -p $out/include
    INSTALL=$out/bin make install
  '';

  meta = {
    description = "crester";
    homepage = "";
    license = "MIT";
  };
}
