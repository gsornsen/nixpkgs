{ lib
, buildPythonPackage
, fetchPypi
, flit-core
, pythonOlder
, isPy3k
, python
, typing
}:

let
  testDir = "src";

in buildPythonPackage rec {
  pname = "typing_extensions";
  version = "4.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "f1c24655a0da0d1b67f07e17a5e6b2a105894e6824b92096378bb3668ef02376";
  };

  checkInputs = lib.optional (pythonOlder "3.5") typing;

  # Error for Python3.6: ImportError: cannot import name 'ann_module'
  # See https://github.com/python/typing/pull/280
  doCheck = pythonOlder "3.6";
  propagatedBuildInputs = [ flit-core ];

  format = "pyproject";

  checkPhase = ''
    cd ${testDir}
    ${python.interpreter} -m unittest discover
  '';

  meta = with lib; {
    description = "Backported and Experimental Type Hints for Python 3.5+";
    homepage = "https://github.com/python/typing";
    license = licenses.psfl;
    maintainers = with maintainers; [ pmiddend ];
  };
}
