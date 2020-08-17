import 'package:lunacon_app/models/jobsite.dart';
import 'network.dart';

List<JobSite> _myJSList = [];

Future<List<JobSite>> getJSList() async {
  if (_myJSList.length < 1) {
    _myJSList = await fetchJobSites();
    return _myJSList;
  }
  return _myJSList;
}

JobSite getJS(int aJSid) {
  JobSite requestedJS;
  _myJSList.forEach(
    (element) {
      if (element.id == aJSid) {
        requestedJS = element;
      }
    },
  );
  return requestedJS;
}

String getJobSiteName(int aJSid) {
  for (int i = 0; i < _myJSList.length; i++) {
    if (_myJSList[i].id == aJSid) {
      return _myJSList[i].name;
    }
  }
  return '';
}
