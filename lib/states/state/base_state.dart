class ApiResponse<T> {
  ApiResponse.init(this.message) : status = Status.INIT;

  ApiResponse.loading(this.message) : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;
  Status? status;
  T? data;
  String? message;
  String? error;

  @override
  String toString() {
    return 'Status : $status \n Message : $message \n Data : $data';
  }
}

enum Status { LOADING, COMPLETED, ERROR, INIT }
