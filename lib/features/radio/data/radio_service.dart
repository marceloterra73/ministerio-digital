import '../../../core/constants/app_constants.dart';

class RadioService {
  Future<String> getStreamUrl() async {
    return AppConstants.radioStreamUrl;
  }

  Future<String> getStationName() async {
    return 'Ministério Digital Rádio';
  }

  Future<String> getStationDescription() async {
    return 'Louvor, pregação e adoração 24 horas.';
  }
}
