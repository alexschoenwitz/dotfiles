{
  pkgs,
  lib,
  config,
  ...
}:
let
  p = config.theme.paletteHash;
  skin = {
    k9s = {
      body = {
        fgColor = p.base06;
        bgColor = p.base00;
        logoColor = p.base0D;
      };
      prompt = {
        fgColor = p.base06;
        bgColor = p.base00;
        suggestColor = p.base09;
      };
      info = {
        fgColor = p.base0E;
        sectionColor = p.base06;
      };
      help = {
        fgColor = p.base06;
        bgColor = p.base00;
        keyColor = p.base0E;
        numKeyColor = p.base0D;
        sectionColor = p.base0B;
      };
      dialog = {
        fgColor = p.base06;
        bgColor = p.base00;
        buttonFgColor = p.base06;
        buttonBgColor = p.base0E;
        buttonFocusFgColor = p.base07;
        buttonFocusBgColor = p.base0C;
        labelFgColor = p.base09;
        fieldFgColor = p.base06;
      };
      frame = {
        border = {
          fgColor = p.base01;
          focusColor = p.base06;
        };
        menu = {
          fgColor = p.base06;
          keyColor = p.base0E;
          numKeyColor = p.base0E;
        };
        crumbs = {
          fgColor = p.base06;
          bgColor = p.base03;
          activeColor = p.base0D;
        };
        status = {
          newColor = p.base0C;
          modifyColor = p.base0D;
          addColor = p.base0B;
          errorColor = p.base08;
          highlightColor = p.base09;
          killColor = p.base03;
          completedColor = p.base03;
        };
        title = {
          fgColor = p.base06;
          bgColor = p.base00;
          highlightColor = p.base09;
          counterColor = p.base0D;
          filterColor = p.base0E;
        };
      };
      views = {
        charts = {
          bgColor = "default";
          defaultDialColors = [
            p.base0D
            p.base08
          ];
          defaultChartColors = [
            p.base0D
            p.base08
          ];
        };
        table = {
          fgColor = p.base06;
          bgColor = p.base00;
          cursorFgColor = p.base01;
          cursorBgColor = p.base06;
          header = {
            fgColor = p.base06;
            bgColor = p.base00;
            sorterColor = p.base01;
          };
        };
        xray = {
          fgColor = p.base06;
          bgColor = p.base00;
          cursorColor = p.base06;
          graphicColor = p.base0D;
          showIcons = false;
        };
        yaml = {
          keyColor = p.base0E;
          colonColor = p.base0D;
          valueColor = p.base06;
        };
        logs = {
          fgColor = p.base06;
          bgColor = p.base00;
          indicator = {
            fgColor = p.base06;
            bgColor = p.base00;
          };
        };
      };
    };
  };
in
{
  options.tools.kubernetes.enable = lib.mkEnableOption "Kubernetes tools" // {
    default = true;
  };

  config = lib.mkIf config.tools.kubernetes.enable {
    home.packages = with pkgs; [
      kubectl
      istioctl
      skaffold
      kind
    ];

    programs.k9s = {
      enable = true;

      settings.k9s.ui.skin = "theme";

      aliases.aliases = {
        dp = "deployments";
        sec = "v1/secrets";
        jo = "jobs";
        cr = "clusterroles";
        crb = "clusterrolebindings";
        ro = "roles";
        rb = "rolebindings";
        np = "networkpolicies";
      };

      skins.theme = skin;
    };
  };
}
