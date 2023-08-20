import 'package:plateron/core/error/failures.dart';

class DataResponse<TContent> {
  final bool isSuccessful;

  final TContent? content;

  /// Gets the failure object.
  final Failure? failure;

  /// Initializes a new instance of [DataResponse] class that is successful and returns the [content] object.
  const DataResponse.success(this.content)
      : isSuccessful = true,
        failure = null;

  /// Initializes a new instance of [DataResponse] class that is failed and returns the [failure] object.
  const DataResponse.failure(this.failure)
      : isSuccessful = false,
        content = null;

  @override
  bool operator ==(dynamic o) {
    return identical(this, o) ||
        (o is DataResponse<TContent> && o.isSuccessful == isSuccessful && o.content == content && o.failure == failure);
  }

  @override
  int get hashCode => isSuccessful.hashCode ^ content.hashCode ^ failure.hashCode;

  @override
  String toString() {
    return 'DataResponse<${TContent.runtimeType}>(isSuccessful: $isSuccessful, content: $content, failure: $failure)';
  }
}
