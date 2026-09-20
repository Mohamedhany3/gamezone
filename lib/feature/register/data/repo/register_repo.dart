import 'package:dio/dio.dart';

import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/api_error_handler.dart';
import '../../../../core/networking/api_result.dart';
import '../models/register_request_model.dart';

class RegisterRepo {
  final Dio _dio;

  RegisterRepo(this._dio);

  Future<ApiResult<dynamic>> register(
    RegisterRequestModel registerModel,
  ) async {
    try {
      final response = await _dio.post(
        ApiConstants.registerEndpoint,
        data: registerModel.toJson(),
      );

      return Success(response.data);
    } on DioException catch (e) {
      return Error(ApiErrorHandler.handle(e).message);
    }
  }
}
