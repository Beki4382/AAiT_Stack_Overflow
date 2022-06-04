
class ErrorMessage {
  String message;
  ErrorMessage({required this.message});

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(
      message: json['message'] as String,
    );
  }
}
