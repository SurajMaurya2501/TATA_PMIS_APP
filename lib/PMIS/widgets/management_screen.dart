String managementRole = 'O&M';

List<String> managementScreen = [
  '/daiy_management',
  '/monthly_management',
  "/breakdown",
  '/charger',
  "/oAndMDashboard"
];

List managementImagedata = [
  'assets/overview_image/daily_progress.png',
  'assets/overview_image/monthly.png',
  'assets/overview_image/safety.png',
  'assets/overview_image/closure_report.png',
  'assets/overview_image/daily_progress.png',
];

List<String> managementDescription = [
  'Daily Progress Report',
  'Monthly Project Monitoring',
  'Breakdown Data',
  'Charger Availability Status',
  "O & M Dashboard",
];

List<String> breakdownClnName = [
  'Sr.No.',
  'Location',
  'Depot name',
  'Equipment Name',
  'Chargers affected',
  'Fault Type',
  'Attribute to',
  'Fault Occurrance',
  'Fault Resolving',
  'AgencyName',
  'Fault Resolve by',
  'Status',
  'MTTR',
  'faultRelated',
  'Remarks',
  'Delete'
];

List<String> breakdownTableClnName = [
  'Sr.No.',
  'Location',
  'Depot name',
  'Equipment Name',
  'Chargers affected',
  'Fault Type',
  'Attribute to',
  'Fault Occurrance',
  'Fault Resolving',
  'AgencyName',
  'Fault Resolve by',
  'Status',
  'MTTR',
  'Fault Related To(Charger/Electrical infra)',
  'Remarks',
  'Delete'
];

List<String> chargerAvailabilityClnName = [
  'Sr.No.',
  'Location',
  'Depot name',
  'ChargerNo',
  'ChargerSrNo',
  'ChargerMake',
  'TargetTime',
  'TimeLoss',
  'Availability',
  'Remarks',
  'Delete'
];

List<String> oAndMDashboardTableClnName = [
  'Sr.No.',
  'Location',
  'Depot name',
  'No. of Chargers',
  'No. of Buses',
  'Charger Availablity',
  'Faults Occuring in Chargers',
  'Faults Occuring in Electrical Infra',
  'Total No. of Faults Resolved',
  'Total No. of Faults Pending with OEM',
  'Mttr in Chargers',
  'Mttr in Electrical infra'
];

List<String> oAndMDashboardClnName = [
  'Sr.No.',
  'Location',
  'Depotname',
  'chargers',
  'buses',
  'chargerAvailability',
  'chargerFaults',
  'electricalFaults',
  'totalFaultsResolved',
  'totalFaultsPending',
  'chargerMttr',
  'electricalMttr'
];
