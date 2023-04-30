enum RoleType {
  admin,
  pic,
  dokter,
}

extension RoleTypeEnumExtension on RoleType {
  String get value {
    switch (this) {
      case RoleType.admin:
        return 'ADMIN';
      case RoleType.pic:
        return 'PIC';
      case RoleType.dokter:
        return 'DOKTER';
      default:
        return '';
    }
  }
}
