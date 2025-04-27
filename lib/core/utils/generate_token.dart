String generateAuthToken() {
  // Token sencillo: una combinación random de números/tiempo
  final now = DateTime.now().millisecondsSinceEpoch;
  return 'auth_token_$now';
}
