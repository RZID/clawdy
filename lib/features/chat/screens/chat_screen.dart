import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/colors.dart';
import '../../../core/controllers/app_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final controller = context.watch<AppController>();
    final messages = controller.messages;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // Very light grey canvas background
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
                color: Color(0xFFE5E7EB),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFF9CA3AF),
                size: 20,
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
          preferredSize: const Size.fromHeight(42),
          child: Column(
            children: [
              Container(
                color: AppColors.cardBorder,
                height: 0.5,
              ),
              // Sub-header bar: Thesis Research Notes
              Container(
                color: Colors.white,
                height: 41,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.menu_book_outlined,
                      color: AppColors.textSecondary,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Thesis Research Notes',
                      style: textTheme.labelLarge?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: AppColors.cardBorder,
                height: 0.5,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat history stream
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  
                  // Display date stamp if it's the first message or if it's a new day
                  final showDate = index == 0 || messages[index - 1].timestamp != msg.timestamp;

                  return Column(
                    children: [
                      if (showDate) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24.0, top: 8.0),
                          child: Text(
                            msg.timestamp.toUpperCase(),
                            style: textTheme.labelLarge?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textHint,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ],
                      if (msg.sender == 'user') ...[
                        _buildUserBubble(context, msg.content),
                      ] else if (msg.isAnalysisCard) ...[
                        _buildAnalysisCard(context),
                      ] else ...[
                        _buildAssistantBubble(context, msg.content),
                      ],
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
            ),

            // Bottom Input bar
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.cardBorder, width: 0.5),
                ),
              ),
              child: Row(
                children: [
                  // Attachment button
                  IconButton(
                    icon: const Icon(Icons.attach_file, color: AppColors.textSecondary, size: 24),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  // Text field
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.inputBackground,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: TextField(
                        controller: _textController,
                        onSubmitted: (val) {
                          _handleSend();
                        },
                        decoration: InputDecoration(
                          hintText: 'Query database or add notes...',
                          hintStyle: textTheme.bodyMedium?.copyWith(
                            color: AppColors.textHint,
                            fontSize: 14,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        style: textTheme.bodyLarge?.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Send button
                  GestureDetector(
                    onTap: _handleSend,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSend() {
    final text = _textController.text;
    if (text.trim().isNotEmpty) {
      context.read<AppController>().sendMessage(text);
      _textController.clear();
      _scrollToBottom();
    }
  }

  Widget _buildUserBubble(BuildContext context, String content) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: const BoxDecoration(
              color: AppColors.userBubble,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(1),
              ),
            ),
            child: Text(
              content,
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.userBubbleText,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'You',
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssistantBubble(BuildContext context, String content) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.cardBorder, width: 1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(1),
              ),
            ),
            child: Text(
              content,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 14,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Clawdy Researcher',
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.82,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.cardBorder, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header of Analysis card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Custom split circle icon
                      Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4F46E5),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 10,
                            height: 20,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Analysis Complete',
                        style: textTheme.labelLarge?.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                
                // Content of Analysis card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Here is the concise structural differentiation between the two methodologies:',
                        style: textTheme.bodyLarge?.copyWith(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Bullet points with rich text styling
                      _buildRichBulletPoint(
                        context: context,
                        header: 'Core Objective',
                        text: 'Phenomenology seeks to describe the ',
                        italicPart1: 'essence of a lived experience',
                        textAfter1: ' from the subject\'s perspective, whereas Grounded Theory aims to generate a ',
                        italicPart2: 'novel, explanatory framework',
                        textAfter2: ' directly from collected data.',
                      ),
                      const SizedBox(height: 16),
                      
                      _buildRichBulletPoint(
                        context: context,
                        header: 'Analytical Process',
                        text: 'Phenomenology relies on bracketing researcher bias and thematic extraction; Grounded Theory utilizes iterative ',
                        italicPart1: '\'constant comparison\'',
                        textAfter1: ' and theoretical sampling until data saturation occurs.',
                      ),
                      const SizedBox(height: 16),
                      
                      _buildRichBulletPoint(
                        context: context,
                        header: 'Output',
                        text: 'The former yields a rich, descriptive narrative of ',
                        italicPart1: '\'what it is like\'',
                        textAfter1: ', while the latter produces a structural model or theory explaining a social process.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Clawdy Researcher',
            style: textTheme.bodyMedium?.copyWith(
              fontSize: 11,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRichBulletPoint({
    required BuildContext context,
    required String header,
    required String text,
    required String italicPart1,
    required String textAfter1,
    String? italicPart2,
    String? textAfter2,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$header: ',
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          TextSpan(
            text: text,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 13,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          TextSpan(
            text: italicPart1,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          TextSpan(
            text: textAfter1,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 13,
              color: AppColors.textPrimary,
              height: 1.4,
            ),
          ),
          if (italicPart2 != null) ...[
            TextSpan(
              text: italicPart2,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ],
          if (textAfter2 != null) ...[
            TextSpan(
              text: textAfter2,
              style: textTheme.bodyLarge?.copyWith(
                fontSize: 13,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
