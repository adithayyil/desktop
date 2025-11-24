{ pkgs, ... }:

let
  pythonWithPackages = pkgs.python3.withPackages (ps: with ps; [
    pyqt5
    tkinter
  ]);
in
pkgs.symlinkJoin {
  name = "davinci-resolve-with-python";
  paths = [ pkgs.davinci-resolve ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/davinci-resolve \
      --prefix PYTHONPATH : "${pythonWithPackages}/${pythonWithPackages.sitePackages}"
  '';
}
