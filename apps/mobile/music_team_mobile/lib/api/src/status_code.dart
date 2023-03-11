enum StatusCode {
  ok,
  badRequest,
  unauthorized,
  notFound,
  internalServalError,
}

extension StatusCodeExtension on StatusCode {
  int get code {
    switch (this) {
      case StatusCode.ok:
        return 200;
      case StatusCode.badRequest:
        return 400;
      case StatusCode.unauthorized:
        return 401;
      case StatusCode.notFound:
        return 404;
      case StatusCode.internalServalError:
        return 500;
    }
  }
}
