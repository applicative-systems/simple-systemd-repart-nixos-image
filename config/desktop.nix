{
  pkgs,
  ...
}:
{
  # very minimal X server setup
  services.xserver.enable = true;
  services.xserver.windowManager.jwm.enable = true;
  services.displayManager.defaultSession = "jwm";

  # run xserver automatically after autologin
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.greetd}/bin/agreety --cmd /bin/sh";
      initial_session = {
        user = "root";
        command = "startx";
      };
    };
  };
  services.xserver.displayManager.startx = {
    enable = true;
    generateScript = true;
    extraCommands = ''
      cp ${./jwmrc.xml} $HOME/.jwmrc
      xrdb $HOME/.Xresources
    '';
  };

}
