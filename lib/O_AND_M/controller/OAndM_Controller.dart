import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_pmis_app/O_AND_M/o&m_datasource/oAndM_dashboard_datasource.dart';
import 'package:ev_pmis_app/O_AND_M/o&m_model/oAndM_dashboard_model.dart';

class OAndMController {
  int targetTime = 0;
  bool isCitySelected = false;
  bool dateRangeSelected = false;
  // List<double> mttrData = [];
  List<double> chargersMttrData = [];
  List<double> electricalMttrData = [];
  List<OAndMDashboardModel> oAndMModel = [];
  List<String> depotList = [];
  List<String> chargerAvailabilityList = [];
  List<int> chargerFaults = [];
  List<int> electricalFaults = [];
  int totalChargers = 0;
  int totalFaultOccured = 0;
  int totalFaultResolved = 0;
  int totalFaultPending = 0;
  int totalAverageMttr = 0;
  int totalChargerAvailability = 0;
  int totalBuses = 0;
  double totalMttrForConclusion = 0;
  late OAndMDashboardDatasource oAndMDashboardDatasource;

  Future<void> getTimeLossData(
      List<String> depotList, int totalChargers) async {
    chargerAvailabilityList.clear();
    chargersMttrData.clear();
    // mttrData.clear();
    totalMttrForConclusion = 0;
    for (int i = 0; i < depotList.length; i++) {
      //Fetch Breakdown Data
      DocumentSnapshot breakdownSnap = await FirebaseFirestore.instance
          .collection("BreakDownData")
          .doc(depotList[i])
          .get();

      if (breakdownSnap.exists) {
        Map<String, dynamic> breakdownData =
            breakdownSnap.data() as Map<String, dynamic>;
        List<dynamic> breakdownMapData = breakdownData['data'];

        double totalChargerMttr = 0.0;
        double totalElectricalMttr = 0.0;
        for (int j = 0; j < breakdownMapData.length; j++) {
          if (breakdownMapData[j]['faultRelated'] == "Chargers" &&
              breakdownMapData[j]['Attribute to'] == "TPC") {
            totalChargerMttr = totalChargerMttr +
                double.parse(breakdownMapData[j]["MTTR"].toString());
          } else if (breakdownMapData[j]['faultRelated'] == "Electrical" &&
              breakdownMapData[j]['Attribute to'] == "TPC") {
            totalElectricalMttr = totalElectricalMttr +
                double.parse(breakdownMapData[j]["MTTR"].toString());
          }
        }
        // mttrData.add(totalChargerMttr);
        chargersMttrData.add(totalChargerMttr);
        electricalMttrData.add(totalElectricalMttr);
        totalMttrForConclusion = totalMttrForConclusion + totalChargerMttr;
      } else {
        chargersMttrData.add(0.0);
        electricalMttrData.add(0.0);
        // mttrData.add(0.0);
      }
    }
    calculateAvailability(chargersMttrData, targetTime, totalChargers);
  }

  List<String> calculateAvailability(
      List<double> totalMttr, int targetTime, int totalNumChargers) {
    for (int i = 0; i < totalMttr.length; i++) {
      double availability = (((targetTime * totalNumChargers) - totalMttr[i]) /
              (targetTime * totalNumChargers)) *
          100;
      chargerAvailabilityList.add(
        availability.toStringAsFixed(
          2,
        ),
      );
    }
    print("chargerAvailabilityList - $chargerAvailabilityList");
    return chargerAvailabilityList;
  }
}
