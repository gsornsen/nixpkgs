{ lib
, buildPythonPackage
, fetchPypi
, boto3
, click
, cachetools
, psutil
, python-dotenv
, pyyaml
, rich
, requests
, semver
, stevedore
, tailer
}:

buildPythonPackage rec {
  pname = "localstack";
  version = "0.14.2.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "c815e992b2dd4468474b93adda710ca2895dece09b7d789dac1aeefc81114a0c";
  };

  doCheck = false;
  propagatedBuildInputs = [ boto3
                            click
                            cachetools
                            psutil
                            python-dotenv
                            pyyaml
                            rich
                            requests
                            semver
                            stevedore
                            tailer
                          ];

  meta = with lib; {
    description = "A fully functional local AWS cloud stack";
    homepage = "https://github.com/localstack/localstack";
    license = licenses.asl20;
  };
}
