{ lib
, buildPythonPackage
, fetchFromGitHub
, click
, ordered-set
, clevercsv
, jsonpickle
, numpy
, pytestCheckHook
, pyyaml
}:

buildPythonPackage rec {
  pname = "deepdiff";
  version = "v5.8.1";
  format = "setuptools";

  # pypi source does not contain all fixtures required for tests
  src = fetchFromGitHub {
    owner = "seperman";
    repo = "deepdiff";
    rev = version;
    sha256 = "1iygxms8r9pf3avc9bz1i599ipg1rw695wfjq974xdjavgc8i0v6";
  };

  postPatch = ''
    substituteInPlace tests/test_command.py \
      --replace '/tmp/' "$TMPDIR/"
  '';

  propagatedBuildInputs = [
    click
    ordered-set
  ];

  pythonImportsCheck = [
    "deepdiff"
  ];

  checkInputs = [
    clevercsv
    jsonpickle
    numpy
    pytestCheckHook
    pyyaml
  ];

  meta = with lib; {
    description = "Deep Difference and Search of any Python object/data";
    homepage = "https://github.com/seperman/deepdiff";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
