{
  programs.git = {
    enable = true;
    userName = "yehorovye";
    userEmail = "yehorovye@envs.net";

    signing = {
      key = "C3AA71F6B53557FD";
      signByDefault = true;
    };

    extraConfig = {
      tag.gpgSign = true;

      credential.helper =
        "store"; # or "store", or "libsecret" depending on preference
    };
  };
}

