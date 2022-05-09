{ lib
, buildPythonPackage
, fetchPypi
, stevedore
}:

buildPythonPackage rec {
  pname = "plux";
  version = "1.3.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "49f8d0f372c80f315f1d36e897bfcd914b867ba7aaf701ed5931a6d873ae28d3";
  };

  doCheck = false;
  propagatedBuildInputs = [ stevedore ];

  meta = with lib; {
    description = "A dynamic code loading framework for building pluggable Python distributions";
    homepage = "https://github.com/localstack/plux";
    license = licenses.asl20;
  };
}
