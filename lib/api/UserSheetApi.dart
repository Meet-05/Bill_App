import 'package:gsheets/gsheets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserSheetApi {
  static final spreadSheetid = dotenv.env['SID'];

  static const _credentials = 's';
  static final _gsheets = GSheets(_credentials);
  static Worksheet _userSheet;

  static Future init() async {
    final spreadsheet = await _gsheets.spreadsheet(spreadSheetid);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'Shop');
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {String title}) async {
    return spreadsheet.worksheetByTitle(title);
  }

  static insertData(List<Map<String, dynamic>> data) async {
    await _userSheet.values.map.appendRows(data);
  }
}
