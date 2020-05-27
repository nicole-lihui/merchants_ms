import 'package:azlistview/azlistview.dart';

// part 'bank_model.g.dart';

class BankModel extends ISuspensionBean{

  int id;
  String bankName;
  String firstLetter;

  BankModel(this.id, this.bankName, this.firstLetter);

  // BankModel.forJsonMap(Map<String, dynamic> map) => _$BankModelFromJson(map);
  BankModel.fromJsonMap(Map<String, dynamic> map):
        id = map['id'],
        bankName = map['bankName'],
        firstLetter = map['firstLetter'];

  // Map<String, dynamic> toJson() => _$BankModelToJson(this);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['bankName'] = bankName;
    data['firstLetter'] = firstLetter;
    return data;
  }


  @override
  String getSuspensionTag() {
    return firstLetter;
  }
}
