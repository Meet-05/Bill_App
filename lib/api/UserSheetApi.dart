import 'package:gsheets/gsheets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bill_app/constant.dart';

class UserSheetApi {
  static final transactionSpreadSheetid = dotenv.env['SID'];
  static final productSheetId = dotenv.env['SID2'];

  static const _credentials = 's';
  static final _gsheets = GSheets(_credentials);
  static Worksheet _transactionsheet;
  static Worksheet _productSheet;

  static Future init() async {
    final transactionSpreadsheet =
        await _gsheets.spreadsheet(transactionSpreadSheetid);
    final productSheet = await _gsheets.spreadsheet(productSheetId);
    _transactionsheet =
        await _getWorkSheet(transactionSpreadsheet, title: 'Shop');
    _productSheet = await _getWorkSheet(productSheet, title: 'Inventory');
    print('initialized');
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {String title}) async {
    return spreadsheet.worksheetByTitle(title);
  }

  static insertData(List<Map<String, dynamic>> data, sheet sheetType) async {
    if (sheetType == sheet.product) {
      await _productSheet.values.map.appendRows(data);
    } else {
      await _transactionsheet.values.map.appendRows(data);
    }
  }
}
