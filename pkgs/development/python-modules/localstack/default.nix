{ lib
, buildPythonPackage
, fetchPypi
, boto3
, click
, cachetools
, localstack-client
, plux
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
  # Remove circular localstack dependency and
  # allow package upgrades that remove Python 3.5 compatibility.
  postPatch = ''
    sed -r -i '/^\s*localstack-ext/d' setup.cfg
    sed -i 's/requests>=2.20.0,<2.26/requests>=2.20.0,<=2.26/' setup.cfg
    sed -i 's/cachetools>=3.1.1,<4.0.0/cachetools>=4.0.0/' setup.cfg
    '';
  propagatedBuildInputs = [ boto3
                            click
                            cachetools
                            localstack-client
                            plux
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
    broken = pythonOlder "3.6";
  };
}
