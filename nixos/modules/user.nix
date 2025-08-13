{ user, ... }: {
  users.users.${user} = {
    isNormalUser = true;
    description  = user;
    extraGroups  = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "input"
      "users"
    ];
  };
}
