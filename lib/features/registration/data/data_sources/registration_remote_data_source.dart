import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:registro_usuarios/features/registration/data/models/user_model.dart';

abstract class RegistrationRemoteDataSource{
  Future<void> register(UserModel user);
}

class RegistrationRemoteDataSourceImpl implements RegistrationRemoteDataSource{
  static const API_URL = 'https://plm.com.co/test/userss';

  @override
  Future<void> register(UserModel user)async{
    final Map<String, String> headers = {'Content-Type':'application/x-www-form-urlencoded'};
    final Map<String, String> fields = user.toServiceJson();
    final Map<String, dynamic> fileInfo = {
      'field_name':'photo',
      'file':user.photo
    };
    return await _generateMultiPartRequest(API_URL, headers, fields, fileInfo);
  }

  Future<http.MultipartRequest> _generateMultiPartRequest(String requestUrl, Map<String, String> headers, Map<String, String> fields, Map<String, dynamic> fileInfo)async{
    final http.MultipartRequest request = _generateBasicMultiPartRequest(requestUrl, headers, fields);
    _addFileToMultiPartRequest(fileInfo, request);
    return request;
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