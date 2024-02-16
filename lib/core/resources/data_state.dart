// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? data;
  final DioException? exception;

  const DataState({
    this.data,
    this.exception,
  });
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailure<T> extends DataState<T> {
  const DataFailure(DioException exception) : super(exception: exception);
}
