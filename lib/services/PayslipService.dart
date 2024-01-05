import 'dart:convert';

import 'package:bitbytes/services/BaseService.dart';

class PayslipService extends BaseService {

  Future<List> getList(userId) async{
    var response = await get('/payrollItem/getPayslip?user_id=$userId');
    return response['data'];
  }

  Future<Map<String,dynamic>> fetchPayslip(userId, payslipId) async{
    var response = await get('/payrollItem/getPayslip?user_id=$userId&id=$payslipId');
    return response['data'][0];
  }
}