{stdenv, ulfius}:
stdenv.mkDerivation rec {
  name = "crester-0.0.1";

  src = ./.;

  buildInputs = [ ulfius ];

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/include
    prefix=$out make install
  '';

  meta = {
    description = "crester";
    homepage = "";
    license = "MIT";
  };
}
