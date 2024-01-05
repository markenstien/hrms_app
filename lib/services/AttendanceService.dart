import 'package:bitbytes/services/BaseService.dart';

class AttendanceService extends BaseService{

  Future<List> getList(userId) async{
    var response = await get('/attendance/getList?userId=$userId');
    return response['data'];
  }

  Future<Map<String,dynamic>> getStatus(userId) async {
    var response = await get('/attendance/getStatus?userId=$userId');
    if(response['success'] == true) {
      return {
        'lastLog' : response['data']['lastLog'],
        'currentStatus' : response['data']['timelogAction']
      };
    } else {
      return {};
    }
  }
}