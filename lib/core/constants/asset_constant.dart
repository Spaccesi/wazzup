enum AssetType {
  image,
  // animation,
}

enum AssetConstant {
  googleLogo(
    type: AssetType.image,
    path: 'assets/images/google.png',
  ),
  ;

  final AssetType type;
  final String path;

  const AssetConstant({
    required this.path,
    required this.type,
  });
}
