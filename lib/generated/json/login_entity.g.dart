import 'package:demoorder/generated/json/base/json_convert_content.dart';
import 'package:demoorder/generated/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
  final LoginEntity loginEntity = LoginEntity();
  final int? responseCode = jsonConvert.convert<int>(json['ResponseCode']);
  if (responseCode != null) {
    loginEntity.responseCode = responseCode;
  }
  final String? responseMsg = jsonConvert.convert<String>(json['ResponseMsg']);
  if (responseMsg != null) {
    loginEntity.responseMsg = responseMsg;
  }
  final String? result = jsonConvert.convert<String>(json['Result']);
  if (result != null) {
    loginEntity.result = result;
  }
  final String? serverTime = jsonConvert.convert<String>(json['ServerTime']);
  if (serverTime != null) {
    loginEntity.serverTime = serverTime;
  }
  return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['ResponseCode'] = entity.responseCode;
  data['ResponseMsg'] = entity.responseMsg;
  data['Result'] = entity.result;
  data['ServerTime'] = entity.serverTime;
  return data;
}

extension LoginEntityExtension on LoginEntity {
  LoginEntity copyWith({
    int? responseCode,
    String? responseMsg,
    String? result,
    String? serverTime,
  }) {
    return LoginEntity()
      ..responseCode = responseCode ?? this.responseCode
      ..responseMsg = responseMsg ?? this.responseMsg
      ..result = result ?? this.result
      ..serverTime = serverTime ?? this.serverTime;
  }
}