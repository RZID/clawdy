import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/controllers/app_controller.dart';

class ChatSearchDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Search messages...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 14);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, size: 20),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, size: 20),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildMatches(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildMatches(context);
  }

  Widget _buildMatches(BuildContext context) {
    final messages = context.read<AppController>().messages;
    final filtered = query.isEmpty
        ? messages
        : messages.where((m) => m.content.toLowerCase().contains(query.toLowerCase())).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Text(
          query.isEmpty ? 'Type to search messages' : 'No matches found',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final msg = filtered[index];
        return ListTile(
          leading: Icon(
            msg.sender == 'user' ? Icons.person : Icons.smart_toy_outlined,
            color: AppColors.textSecondary,
            size: 20,
          ),
          title: Text(
            msg.content.isNotEmpty ? msg.content : 'Analysis card',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
          subtitle: Text(
            msg.timestamp,
            style: const TextStyle(fontSize: 11, color: AppColors.textHint),
          ),
          onTap: () => close(context, query),
        );
      },
    );
  }
}