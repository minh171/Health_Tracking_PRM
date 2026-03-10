import '../../interface/repository/ihome_repository.dart';
import '../../interface/service/ihome_service.dart';

class HomeService implements IHomeService {
  final IHomeRepository _homeRepo;
  HomeService(this._homeRepo);
}