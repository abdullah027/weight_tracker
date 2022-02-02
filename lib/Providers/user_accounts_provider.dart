import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/Models/account_model.dart';
import 'package:weight_tracker/Services/cloud_firestore.dart';

class AccountProvider extends ChangeNotifier {
  Account? _account;
  List<Account> _accounts = [];

  Account? get account => _account;

  List<Account> get accounts {
    return _accounts;
  }

  void setAccount(Account? account) {
    _account = account;
    notifyListeners();
  }

  void restUserProvider() {
    _account = null;
    notifyListeners();
  }

  void addAccounts({String? dateCreated, weight, uid, fullName, email}) {
    DatabaseService(uid)
        .addAccountData(
            fullName: fullName,
            email: email,
            weight: weight,
            dateCreated: dateCreated)
        .then((value) {
      _accounts.add(
        Account(
          fullName: fullName,
          email: email,
          weight: weight,
        ),
      );
      notifyListeners();
    });

    print(_accounts.length);
  }

  void fetchAccountsList(List data) {
    _accounts = [];
    List _users = [];
    for (var element in data) {
      _accounts.add(Account.fromDocument(element));
    }
    for (int i = 0; i < _accounts.length; i++) {
      for (int j = i + 1; j < _accounts.length; j++) {
        if (DateTime.parse(_accounts[i].dateCreated.toString())
            .isBefore(DateTime.parse(_accounts[j].dateCreated.toString()))) {
          var temp = _accounts[i];
          _accounts[i] = _accounts[j];
          _accounts[j] = temp;
        }
      }
    }
    notifyListeners();
  }

}
