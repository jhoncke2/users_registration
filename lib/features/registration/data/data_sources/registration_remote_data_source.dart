import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:registro_usuarios/features/registration/data/models/user_model.dart';
import 'package:registro_usuarios/features/registration/error/exceptions.dart';

abstract class RegistrationRemoteDataSource{
  Future<void> register(UserModel user);
}

class RegistrationRemoteDataSourceImpl implements RegistrationRemoteDataSource{
  static const API_URL = 'https://plm.com.co/test/users';

  @override
  Future<void> register(UserModel user)async{
    final Map<String, String> headers = {'Content-Type':'application/x-www-form-urlencoded'};
    final Map<String, String> fields = user.toServiceJson();
    final Map<String, dynamic> fileInfo = {
      'field_name':'photo',
      'file':user.photo
    };
    http.MultipartRequest multiPRequest = await _generateMultiPartRequest(API_URL, headers, fields, fileInfo);
    await _sendMultiPartRequest(multiPRequest);
  }

  Future<http.MultipartRequest> _generateMultiPartRequest(String requestUrl, Map<String, String> headers, Map<String, String> fields, Map<String, dynamic> fileInfo)async{
    final http.MultipartRequest request = _generateBasicMultiPartRequest(requestUrl, headers, fields);
    _addFileToMultiPartRequest(fileInfo, request);
    return request;
  }

  Future<http.Response> _sendMultiPartRequest(http.MultipartRequest request)async{
    try{
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      if(response.statusCode != 200)
        throw Exception();
      return response;
    }on Exception{
      throw ServerException();
    }
  }

  http.MultipartRequest _generateBasicMultiPartRequest(String requestUrl, Map<String, String> headers, Map<String, String> fields){
    var request = http.MultipartRequest(
      'POST', 
      Uri.parse(requestUrl)
    );
    request.headers.addAll(headers);
    request.fields.addAll(fields);
    return request;
  }

  void _addFileToMultiPartRequest(Map<String, dynamic> fileInfo, http.MultipartRequest request){
    final File file = fileInfo['file'];
    request.files.add(http.MultipartFile(
      fileInfo['field_name'],
      file.readAsBytes().asStream(),
      file.lengthSync(),
      filename: file.path.split('/').last
    ));
  }
}