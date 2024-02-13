// userState.dart
class UserState {
  static int? currentUserId; // 사용자 ID를 저장할 변수

  static void setCurrentUserId(int id) {
    currentUserId = id; // 사용자 ID 설정
  }

  static int? getCurrentUserId() {
    return currentUserId; // 저장된 사용자 ID 반환
  }
}
