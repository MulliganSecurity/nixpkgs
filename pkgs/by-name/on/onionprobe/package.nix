{
  fetchFromGitLab,
  python312Packages,
  python312,
  python3,
  tor,
  lib,
}:

python312Packages.buildPythonPackage rec {
  pname = "onionprobe";
  version = "1.2.1";
  doCheck = false;
  src = fetchFromGitLab {
    domain = "gitlab.torproject.org";
    owner = "tpo";
    repo = "onion-services/onionprobe";
    rev = "c2f67faf7007c8eea6ed6ce4d228431849779c23";
    sha256 = "sha256-tRmdQKDC8NrTbcbpaZWwFs/LnDQmOWw3JBEmwu9oFcw=";
  };
  format = "pyproject";
  dontCheckRuntimeDeps = true;
  buildInputs = [ tor ];
  propagatedBuildInputs = [
    (python312.withPackages (
      ps: with ps; [
        cryptography
        setuptools
        requests
        stem
        prometheus-client
        pyyaml
        pysocks
      ]
    ))
  ];

  meta = {
    maintainers = with lib.maintainers; [ MulliganSecurity ];
    mainProgram = "onionprobe";
    license = lib.licenses.mit;
    homepage = "https://gitlab.torproject.org/tpo/onion-services/onionprobe";
    description = "Monitor and debug onion service connectivity";
    longDescription = ''
      Analyzes and helps monitoring uptime and availability for hidden services.
    '';
  };

}
