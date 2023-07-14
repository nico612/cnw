class UtilsString {
  static fixedHttpStart(String url) {
    if (url == "") return "";
    if (!url.startsWith('http')) return 'https:$url';
    if (url.startsWith('http:')) return url.replaceAll('http:', 'https:');
    return url;
  }
}
