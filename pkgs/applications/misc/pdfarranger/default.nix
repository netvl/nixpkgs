{ stdenv, fetchFromGitHub, lib
, wrapGAppsHook, intltool
, python3Packages, gtk3, poppler_gi
}:

python3Packages.buildPythonApplication rec {
  pname = "pdfarranger";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "jeromerobert";
    repo = pname;
    rev = version;
    sha256 = "0n4jw0dsqw929a34ff077kz8w89vkjkqf8dy4c356zh6gf23cdxr";
  };

  nativeBuildInputs = [
    wrapGAppsHook intltool
  ] ++ (with python3Packages; [
    setuptools distutils_extra
  ]);

  buildInputs = [
    gtk3 poppler_gi
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
    pikepdf
    setuptools
  ];

  # incompatible with wrapGAppsHook
  strictDeps = false;

  doCheck = false; # no tests

  meta = with lib; {
    inherit (src.meta) homepage;
    description = "Merge or split pdf documents and rotate, crop and rearrange their pages using an interactive and intuitive graphical interface";
    platforms = platforms.linux;
    maintainers = with maintainers; [ symphorien ];
    license = licenses.gpl3;
  };
}
