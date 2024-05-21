import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ev_pmis_app/O_AND_M/o&m_model/chargerAvailability_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../style.dart';

class ChargerAvailabilityDataSource extends DataGridSource {
  String cityName;
  String depoName;
  String userId;
  String selectedDate;
  bool toShowTimeloss;
  int targetTime;
  Map<String, dynamic> mttrData;
  BuildContext mainContext;

  List data = [];
  ChargerAvailabilityDataSource(
      this._dailyproject,
      this.mainContext,
      this.cityName,
      this.depoName,
      this.selectedDate,
      this.userId,
      this.toShowTimeloss,
      this.mttrData,
      this.targetTime) {
    buildDataGridRows();
    setDropDownValue();
  }

  void buildDataGridRows() {
    dataGridRows = _dailyproject
        .map<DataGridRow>((dataGridRow) => dataGridRow.dataGridRow())
        .toList();
  }

  @override
  List<ChargerAvailabilityModel> _dailyproject = [];
  List<String?> charTransDropDownValue = [];
  final dropdownController = TextEditingController();
  List<String> chargersTranformersList = [
    'Charger No. 1',
    'Charger No. 2',
    'Charger No. 3',
    'Charger No. 4',
    'Charger No. 5',
    'Charger No. 6',
    'Charger No. 7',
    'Charger No. 8',
    'Charger No. 9',
    'Charger No. 10',
    'Charger No. 11',
    'Charger No. 12',
    'Charger No. 13',
    'Charger No. 14',
    'Charger No. 15',
    'Charger No. 16',
    'Charger No. 17',
    'Charger No. 18',
    'Charger No. 19',
    'Charger No. 20',
    'Charger No. 21',
    'Charger No. 22',
    'Charger No. 23',
    'Charger No. 24',
    'Charger No. 25',
    'Charger No. 26',
    'Charger No. 27',
    'Charger No. 28',
    'Charger No. 29',
    'Charger No. 30',
    'Charger No. 31',
    'Charger No. 32',
    'Charger No. 33',
    'Charger No. 34',
    'Charger No. 35',
    'Charger No. 36',
    'Charger No. 37',
    'Charger No. 38',
    'Charger No. 39',
    'Charger No. 40',
  ];

  void setDropDownValue() {
    charTransDropDownValue =
        List<String?>.generate(dataGridRows.length, (index) => null);
  }

  List<DataGridRow> dataGridRows = [];
  final _dateFormatter = DateFormat.yMd();

  /// [DataGridCell] on [onSubmitCell] method.
  dynamic newCellValue;

  /// Help to control the editable text in [TextField] widget.
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final int dataRowIndex = dataGridRows.indexOf(row);
    if (charTransDropDownValue.length - 1 < dataRowIndex) {
      charTransDropDownValue.add(null);
    }
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      void removeRowAtIndex(int index) {
        _dailyproject.removeAt(index);
        buildDataGridRows();
        notifyListeners();
      }

      return dataGridCell.columnName == 'Delete'
          ? IconButton(
              padding: const EdgeInsets.all(0.0),
              onPressed: () async {
                removeRowAtIndex(dataRowIndex);
                dataGridRows.remove(row);
                notifyListeners();
              },
              icon: Icon(
                Icons.delete,
                color: red,
              ),
            )
          : dataGridCell.columnName == 'TimeLoss'
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: Text(
                    toShowTimeloss
                        ? mttrData[row.getCells()[3].value.toString()]
                            .toString()
                        : dataGridCell.value.toString(),
                    textAlign: TextAlign.center,
                    style: tablefonttext,
                  ),
                )
              : dataGridCell.columnName == 'Availability'
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        toShowTimeloss
                            ? calculateAvailability(targetTime,
                                mttrData[row.getCells()[3].value.toString()])
                            : dataGridCell.value.toString(),
                        textAlign: TextAlign.center,
                        style: tablefonttext,
                      ),
                    )
                  : dataGridCell.columnName == "ChargerNo"
                      ? customDropdown(dataRowIndex, "ChargerNo",
                          dataGridCell.value.toString())
                      : Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          child: Text(
                            dataGridCell.value.toString(),
                            textAlign: TextAlign.center,
                            style: tablefonttext,
                          ),
                        );
    }).toList());
  }

  Widget customDropdown(int dataRowIndex, String columnName, String hintValue) {
    return Container(
      height: 30.0,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isDense: true,
          isExpanded: true,
          dropdownStyleData: DropdownStyleData(
            scrollbarTheme: ScrollbarThemeData(
              thumbVisibility: const MaterialStatePropertyAll(
                true,
              ),
              interactive: true,
              thumbColor: MaterialStatePropertyAll(
                blue,
              ),
            ),
            maxHeight: 300,
          ),
          dropdownSearchData: columnName == 'ChargerNo'
              ? DropdownSearchData(
                  searchController: dropdownController,
                  searchInnerWidget: Container(
                    margin:
                        const EdgeInsets.only(left: 5.0, top: 5.0, right: 5.0),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Search...",
                          contentPadding: const EdgeInsets.only(left: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            borderSide: BorderSide(
                              color: blue,
                            ),
                          )),
                      controller: dropdownController,
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value.toString().toLowerCase().contains(
                          searchValue.toLowerCase(),
                        );
                  },
                  searchInnerWidgetHeight: 30,
                )
              : null,
          hint: Text(
            hintValue,
            style: TextStyle(color: blue),
          ),
          style: TextStyle(
            color: blue,
          ),
          value: columnName == 'ChargerNo'
              ? charTransDropDownValue[dataRowIndex]
              : null,
          items: List.generate(
              columnName == 'ChargerNo' ? chargersTranformersList.length : 2,
              (index) {
            return DropdownMenuItem(
              value: columnName == 'ChargerNo'
                  ? chargersTranformersList[index]
                  : null,
              child: Text(
                chargersTranformersList[index],
              ),
            );
          }),
          onChanged: (value) {
            switch (columnName) {
              case 'ChargerNo':
                charTransDropDownValue[dataRowIndex] = value.toString();
                _dailyproject[dataRowIndex].chargerNo = value.toString();
                break;
            }
            buildDataGridRows();
            notifyListeners();
          },
        ),
      ),
    );
  }

  String calculateAvailability(int targetTime, double timeLoss) {
    double availability = ((targetTime - timeLoss) / targetTime) * 100;

    return '${availability.toStringAsFixed(2)}%';
  }

  void updateDatagridSource() {
    notifyListeners();
  }

  void updateDataGrid({required RowColumnIndex rowColumnIndex}) {
    notifyDataSourceListeners(rowColumnIndex: rowColumnIndex);
  }

  @override
  void onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == 'Sr.No.') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'Sr.No.', value: newCellValue);
      _dailyproject[dataRowIndex].srNo = newCellValue;
    } else if (column.columnName == 'Location') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'Location', value: newCellValue);
      _dailyproject[dataRowIndex].location = newCellValue;
    } else if (column.columnName == 'Depot name') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'Depot name', value: newCellValue);
      _dailyproject[dataRowIndex].depotName = newCellValue;
    } else if (column.columnName == 'ChargerNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'ChargerNo', value: newCellValue);
      _dailyproject[dataRowIndex].chargerNo = newCellValue;
    } else if (column.columnName == 'ChargerSrNo') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'ChargerSrNo', value: newCellValue);
      _dailyproject[dataRowIndex].chargerSrNo = newCellValue;
    } else if (column.columnName == 'ChargerMake') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'ChargerMake', value: newCellValue);
      _dailyproject[dataRowIndex].chargerMake = newCellValue;
    } else if (column.columnName == 'TargetTime') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'TargetTime', value: newCellValue);
      _dailyproject[dataRowIndex].targetTime = newCellValue;
    } else if (column.columnName == 'TimeLoss') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<int>(columnName: 'TimeLoss', value: newCellValue);
      _dailyproject[dataRowIndex].timeLoss = newCellValue;
    } else if (column.columnName == 'Availability') {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<double>(
              columnName: 'Availability',
              value: double.parse(newCellValue.toString()));
      _dailyproject[dataRowIndex].availability = newCellValue;
    } else {
      dataGridRows[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
          DataGridCell<dynamic>(columnName: 'Remarks', value: newCellValue);
      _dailyproject[dataRowIndex].remarks = newCellValue;
    }
  }

  @override
  bool canSubmitCell(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    // Return false, to retain in edit mode.
    return true; // or super.canSubmitCell(dataGridRow, rowColumnIndex, column);
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';

    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = '';

    final bool isNumericType = (column.columnName == 'Sr.No.' ||
        column.columnName == 'Availability' ||
        column.columnName == 'Sr.No.' ||
        column.columnName == 'TimeLoss' ||
        column.columnName == 'TargetTime');

    final bool isDateTimeType = column.columnName == 'StartDate' ||
        column.columnName == 'EndDate' ||
        column.columnName == 'ActualStart' ||
        column.columnName == 'ActualEnd';
    // Holds regular expression pattern based on the column type.
    final RegExp regExp =
        _getRegExp(isNumericType, isDateTimeType, column.columnName);

    return Container(
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        style: tablefonttext,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        autocorrect: false,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(left: 5, right: 5),
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(regExp),
        ],
        keyboardType: isNumericType
            ? TextInputType.number
            : isDateTimeType
                ? TextInputType.datetime
                : TextInputType.text,
        onTapOutside: (event) {
          newCellValue = editingController.text;
        },
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else if (isDateTimeType) {
              newCellValue = value;
            } else {
              newCellValue = value;
            }
          }
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }

  RegExp _getRegExp(
      bool isNumericKeyBoard, bool isDateTimeBoard, String columnName) {
    return isNumericKeyBoard
        ? RegExp('[0-9]')
        : isDateTimeBoard
            ? RegExp('[0-9/]')
            : RegExp('[a-zA-Z0-9.@!#^&*(){+-}%|<>?_=+,/ )]');
  }
}
