import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/controllers/app_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.watch<AppController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          'Account',
          style: textTheme.labelLarge?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const SizedBox(height: 16),
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=facearea&facepad=2&w=256&h=256&q=80',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              controller.userEmail.isNotEmpty ? controller.userEmail : 'Researcher',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),
          _buildTile(context, Icons.person_outline, 'Name', 'Researcher'),
          const Divider(),
          _buildTile(context, Icons.email_outlined, 'Email', controller.userEmail.isNotEmpty ? controller.userEmail : 'Not set'),
          const Divider(),
          _buildTile(context, Icons.school_outlined, 'Institution', 'Not set'),
          const Divider(),
          _buildTile(context, Icons.work_outline, 'Department', 'Not set'),
          const Divider(),
          const SizedBox(height: 24),
          Text(
            'PROFILE',
            style: textTheme.labelLarge?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          _buildTile(context, Icons.book_outlined, 'Research Interests', 'Tap to edit'),
          const Divider(),
          _buildTile(context, Icons.language_outlined, 'ORCID', 'Tap to add'),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildTile(BuildContext context, IconData icon, String title, String subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textHint)),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Edit $title coming soon.')),
        );
      },
    );
  }
}