{
  description = ''Large number of cryptographic hashes for Nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-sph-master.flake = false;
  inputs.src-sph-master.owner = "aidansteele";
  inputs.src-sph-master.ref   = "refs/heads/master";
  inputs.src-sph-master.repo  = "sph";
  inputs.src-sph-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-sph-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-sph-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}