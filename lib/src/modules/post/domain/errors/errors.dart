abstract class IPostException {
  final String message;
  final StackTrace? stackTrace;

  const IPostException(this.message, [this.stackTrace]);
}

class ArgumentsException extends IPostException {
  const ArgumentsException(super.message, [super.stackTrace]);
}

class DatasourcePostException extends IPostException {
  const DatasourcePostException(super.message, [super.stackTrace]);
}
