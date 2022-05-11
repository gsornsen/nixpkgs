{ lib
, buildPythonPackage
, fetchPypi
, boto3
}:

buildPythonPackage rec {
  pname = "localstack-client";
  version = "1.35";

  src = fetchPypi {
    inherit pname version;
    sha256 = "f42a8cb0b16bab56e447058f06b4d583814d03be9687e8c7dac6cf35b7c2210b";
  };

  doCheck = false;
  propagatedBuildInputs = [ boto3 ];

  meta = with lib; {
    description = "A lightweight Python client for LocalStack";
    homepage = "https://github.com/localstack/localstack-python-client";
    license = licenses.asl20;
  };
}
