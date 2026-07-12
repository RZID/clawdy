class ResearchModel {
  final String title;
  final List<String> authors;
  final String publishedDate;
  final String doi;
  final String url;

  ResearchModel({
    required this.title,
    required this.authors,
    required this.publishedDate,
    required this.doi,
    required this.url,
  });

  factory ResearchModel.fromJson(Map<String, dynamic> json) {
    final titleList = (json['title'] as List?)?.cast<String>() ?? [];
    final authorList = (json['author'] as List?)?.cast<Map<String, dynamic>>() ?? [];
    final authors = authorList
        .map((a) {
          final given = a['given'] as String? ?? '';
          final family = a['family'] as String? ?? '';
          final full = '$given $family'.trim();
          return full.isEmpty ? null : full;
        })
        .whereType<String>()
        .toList();

    final created = json['created'] as Map<String, dynamic>?;
    final dateTime = created?['date-time'] as String? ?? '';

    return ResearchModel(
      title: titleList.isNotEmpty ? titleList.first : '',
      authors: authors,
      publishedDate: dateTime,
      doi: json['DOI'] as String? ?? '',
      url: json['URL'] as String? ?? '',
    );
  }
}
