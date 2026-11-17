{ config, ... }:

let
  hm = config.flake.modules.homeManager;
in
{
  # Screen recording: gpu-screen-recorder (NVENC) behind a start/stop toggle, plus
  # wf-recorder + slurp for quick area recordings from a terminal.
  flake.modules.nixos.recording = {
    programs.gpu-screen-recorder.enable = true; # capability wrapper for KMS capture
    home-manager.sharedModules = [ hm.recording ];
  };

  flake.modules.homeManager.recording = { pkgs, ... }: {
    home.packages = [
      pkgs.wf-recorder
      pkgs.slurp
      pkgs.ffmpeg # trim, compress or convert recordings
      (pkgs.writeShellApplication {
        name = "screenrecord-toggle";
        runtimeInputs = with pkgs; [ procps libnotify coreutils ];
        text = ''
          # First call: pick a screen/window (remembered next time) and record to ~/Videos.
          # Second call: stop; gpu-screen-recorder finalises the file on SIGINT.
          # Tracked by PID file: the process name is cut to 15 chars, so pkill -x can't match it.
          pidfile="''${XDG_RUNTIME_DIR:-/tmp}/screenrecord.pid"
          if [ -f "$pidfile" ] && kill -INT "$(cat "$pidfile")" 2>/dev/null; then
            rm -f "$pidfile"
            notify-send -t 3000 "Screen recording" "Stopped, saved to ~/Videos"
            exit 0
          fi
          dir="$HOME/Videos"
          mkdir -p "$dir"
          out="$dir/recording-$(date +%Y-%m-%d_%H-%M-%S).mp4"
          notify-send -t 2000 "Screen recording" "Started"
          gpu-screen-recorder -w portal -restore-portal-session yes -f 60 -o "$out" &
          echo $! > "$pidfile"
          wait || true
          # Remove the PID file only if it is still ours (a stop may already have removed it).
          [ "$(cat "$pidfile" 2>/dev/null)" = "$!" ] && rm -f "$pidfile" || true
        '';
      })
    ];
  };
}
