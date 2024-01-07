import 'dart:convert';

import 'package:bitbytes/assets/helpers.dart';
import 'package:flutter/material.dart';

class PayslipView extends StatefulWidget {
  const PayslipView({this.userData, this.payslipData});

  final userData;
  final payslipData;

  @override
  State<PayslipView> createState() => _PayslipViewState();
}

class _PayslipViewState extends State<PayslipView> {
  List bonusList = [];
  List deductionList = [];


  var totalEarning = 0.0;
  var totalDeduction = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var bonusListString = getPayslipData('bonus_notes');
    var deductionString  = getPayslipData('deduction_notes');

    print(widget.payslipData);

    if(bonusListString.isNotEmpty) {
      var bonusListExtracted = jsonDecode(bonusListString);
      var total = 0.0;
      for(var i = 0 ; i < bonusListExtracted.length; i++) {
        total += double.parse(bonusListExtracted[i]['amount']);
      }
      total += double.parse(getPayslipData('reg_amount_total'));
      setState(() {
        bonusList = bonusListExtracted;
        totalEarning = total;
      });
    }

    if(deductionString.isNotEmpty) {
      var deductionExtracted = jsonDecode(deductionString);
      var total = 0.0;
      for(var i = 0 ; i < deductionExtracted.length; i++) {
        total += double.parse(deductionExtracted[i]['amount']);
      }
      setState(() {
        deductionList = deductionExtracted;
        totalDeduction = total;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payslip View'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 150,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text('Take Home pay', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),),
                      SizedBox(height: 12,),
                      Text(getPayslipData('take_home_pay'), style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)
                    ],
                  ),
                )
              ),

              divider(),
              
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Earning', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),),
                    ListTile(
                      leading: Text('REG WRK HRS (${minutesToHours(getPayslipData('reg_hours_total'), '')})',  style: particulars(),),
                      trailing: Text(getPayslipData('reg_amount_total'), style: particulars(),),
                    ),
                    ListView.builder(
                        itemCount: bonusList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, position) {
                          var item = bonusList[position];
                          return ListTile(
                            leading: Text('${item['code']}|${item['name']}',  style: particulars(),),
                            trailing: Text(item['amount'], style: particulars(),),
                          );
                        }),
                    ListTile(
                      leading: Text('Total',  style: subTitle(),),
                      trailing: Text("$totalEarning", style: subTitle(),),
                    ),

                  ],
                ),
              ),
              divider(),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Deductions', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),),
                    ListTile(
                      leading: Text('Total',  style: subTitle(),),
                      trailing: Text("$totalDeduction", style: subTitle(),),
                    ),
                  ],
                ),
              ),
              divider(),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('General', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300),),
                    ListTile(
                      leading: Text('Name', style: particulars(),),
                      trailing: Text("${getUserData('firstname')} ${getUserData('lastname')}", style: particulars(),),
                      dense: true,
                    ),
                    ListTile(
                      leading: Text('Department/Position', style: particulars(),),
                      trailing: Text("${getUserData('department_name')}/${getUserData('position_name')}", style: particulars(),),
                      dense: true,
                    ),

                    ListTile(
                      leading: Text('Rate/Day', style: particulars(),),
                      trailing: Text("${getUserData('salary_per_day')}", style: particulars(),),
                      dense: true,
                    ),

                    ListTile(
                      leading: Text('Dept/Position', style: particulars(),),
                      trailing: Text("${getUserData('department_name')}/${getUserData('position_name')}", style: particulars(),),
                      dense: true,
                    ),

                    ListTile(
                      leading: Text('Pay Period', style: particulars(),),
                      trailing: Text("${getPayslipData('start_date')} to ${getPayslipData('end_date')}", style: particulars(),),
                      dense: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle particulars() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300
    );
  }

  TextStyle subTitle() {
    return TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600
    );
  }

  String getUserData(key) {
    return widget.userData[key];
  }

  String getPayslipData(key) {
    return widget.payslipData[key];
  }

  Widget divider() {
    return Padding(padding: EdgeInsets.all(20),
    child: SizedBox(
      width: double.infinity,
      height: 5.0,
      child:  DecoratedBox(
        decoration:  BoxDecoration(
            color: Colors.red
        ),
      ),
    ),);
  }

}
