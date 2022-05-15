{ lib
, buildPythonPackage
, fetchPypi
, boto
, botocore
, cbor2
, deepdiff
, dill
, dnslib
, dnspython
, localstack
, plux
, pyaes
, tabulate
}:

buildPythonPackage rec {
  pname = "localstack-ext";
  version = "0.14.2.23";

  src = fetchPypi {
    inherit pname version;
    sha256 = "b9d7c86690b09ce7f3e6584d8e5e93f207f4e8a8d6af90691fc2a1b3538d2995";
  };

  doCheck = false;
  # Remove circular localstack dependency and
  # allow package upgrades that remove Python 3.5 compatibility
  # dill is a hidden dependency -- I had to download the tarball and inspect
  # setup.cfg
  postPatch = ''
    sed -r -i '/^\s*localstack-ext/d' setup.cfg
    sed -i 's/requests>=2.20.0,<2.26/requests>=2.20.0,<=2.26/' setup.cfg
    sed -i 's/dill==0.3.2/dill==0.3.4/' setup.cfg
    '';
  propagatedBuildInputs = [ boto
                            botocore
                            cbor2
                            deepdiff
                            dill
                            dnslib
                            dnspython
                            localstack
                            plux
                            pyaes
                            tabulate
                          ];

  meta = with lib; {
    description = "A fully functional local AWS cloud stack";
    homepage = "https://github.com/localstack/localstack";
    license = licenses.asl20;
    broken = pythonOlder "3.6";
  };
}
