import '../../data/contactData.dart';

enum MainStatus {  loading, success, error }

class MainState {
  final List<ContactData> list;
  final MainStatus status;
  final bool isLoading;

  MainState(
      {this.status = MainStatus.loading,
      this.list = const [],
      this.isLoading = true});
}
