import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/controllers/app_controller.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.read<AppController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 36,
              height: 36,
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
        ),
        title: Text(
          'Clawdy',
          style: textTheme.labelLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textPrimary, size: 22),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.cardBorder,
            height: 0.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              // Main serif header
              Text(
                'Good morning,\nResearcher.',
                style: textTheme.displayMedium,
              ),
              const SizedBox(height: 32),

              // Quick Actions section
              Text(
                'QUICK ACTIONS',
                style: textTheme.labelLarge?.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textSecondary,
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 16),
              // Horizontal row of quick actions
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      context: context,
                      title: 'New\nThesis',
                      isBlue: true,
                      icon: Icons.add,
                      onTap: () {
                        controller.navigateToTab(0);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      context: context,
                      title: 'PDF\nAnalysis',
                      isBlue: false,
                      icon: Icons.picture_as_pdf_outlined,
                      onTap: () {
                        controller.navigateToTab(0);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      context: context,
                      title: 'Citation\nCheck',
                      isBlue: false,
                      icon: Icons.find_in_page_outlined,
                      onTap: () {
                        controller.navigateToTab(0);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),

              // Recent Research section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'RECENT RESEARCH',
                    style: textTheme.labelLarge?.copyWith(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textSecondary,
                      letterSpacing: 0.8,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'VIEW ALL',
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // List of items
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.cardBorder, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  children: [
                    _buildResearchItem(
                      title: 'Quantum Supremacy Models & Algorithmic B',
                      time: '2h ago',
                      icon: Icons.description_outlined,
                      onTap: () => controller.navigateToTab(0),
                    ),
                    const Divider(height: 1),
                    _buildResearchItem(
                      title: 'LLM Hallucination Rates in Clinical Trials',
                      time: 'Yesterday',
                      icon: Icons.article_outlined,
                      onTap: () => controller.navigateToTab(0),
                    ),
                    const Divider(height: 1),
                    _buildResearchItem(
                      title: 'Neuromorphic Computing Pathways: A Meta-',
                      time: 'Oct 12',
                      icon: Icons.article_outlined,
                      onTap: () => controller.navigateToTab(0),
                    ),
                    const Divider(height: 1),
                    _buildResearchItem(
                      title: 'Dataset: Urban Climate Variance',
                      time: 'Oct 10',
                      icon: Icons.folder_open_outlined,
                      onTap: () => controller.navigateToTab(0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required BuildContext context,
    required String title,
    required bool isBlue,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isBlue ? AppColors.primary : Colors.white,
          border: isBlue ? null : Border.all(color: AppColors.cardBorder, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon at top left
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isBlue ? Colors.white.withValues(alpha: 0.15) : Colors.white,
                shape: BoxShape.circle,
                border: isBlue ? null : Border.all(color: AppColors.cardBorder, width: 1),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: isBlue ? Colors.white : AppColors.textPrimary,
                  size: 18,
                ),
              ),
            ),
            // Text at bottom left
            Text(
              title,
              style: textTheme.labelLarge?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: isBlue ? Colors.white : AppColors.textPrimary,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResearchItem({
    required String title,
    required String time,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
