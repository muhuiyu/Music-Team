class AppError implements Exception {
  String cause;
  AppError(this.cause);

  static const missingUserId = 'missingUserId';
}
