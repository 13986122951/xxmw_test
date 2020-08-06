class TextUtils {
  /**
   * 判断是否空字符串
   */
  static bool isEmpty(String string) {
    if (string == null || string.length == 0) {
      return true;
    }
    return false;
  }
}
