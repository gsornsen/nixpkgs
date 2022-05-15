{ buildPythonPackage, fetchPypi, lib, isPy27, pytest }:

buildPythonPackage rec {
  pname = "ordered-set";
  version = "4.1.0";
  disabled = isPy27;

  checkInputs = [ pytest ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "694a8e44c87657c59292ede72891eb91d34131f6531463aab3009191c77364a8";
  };

  checkPhase = ''
    py.test test/
  '';

  meta = {
    description = "A MutableSet that remembers its order, so that every entry has an index.";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.MostAwesomeDude ];
  };
}
