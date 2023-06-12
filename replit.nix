{ pkgs }: {
	deps = [
		pkgs.mkinitcpio-nfs-utils
  pkgs.toybox
  pkgs.clang_12
		pkgs.ccls
		pkgs.gdb
		pkgs.gnumake
	];
}