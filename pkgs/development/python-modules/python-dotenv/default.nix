{ lib
, buildPythonPackage
, click
, fetchPypi
, ipython
, mock
, pytestCheckHook
, pythonOlder
, sh
}:

buildPythonPackage rec {
  pname = "python-dotenv";
  version = "0.20.0";
  disabled = pythonOlder "3.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "b7e3b04a59693c42c36f9ab1cc2acc46fa5df8c78e178fc33a8d4cd05c8d498f";
  };

  propagatedBuildInputs = [ click ];

  checkInputs = [
    ipython
    mock
    pytestCheckHook
    sh
  ];

  disabledTests = [
    "cli"
  ];

  pythonImportsCheck = [ "dotenv" ];

  meta = with lib; {
    description = "Add .env support to your django/flask apps in development and deployments";
    homepage = "https://github.com/theskumar/python-dotenv";
    license = licenses.bsdOriginal;
    maintainers = with maintainers; [ earvstedt ];
  };
}
