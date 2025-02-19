{pkgs, ...}: {
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      # autodetected themes:
      # adwaita, adwaita-dark, adwaita-highcontrast, adwaita-hightcontrastinverse, breeze, bb10bright, bb10dark, cde, cleanlooks, gtk2, motfi, plastique
      #theme package
      package = pkgs.qt6Packages.qt6gtk2;
    };
  };
}
