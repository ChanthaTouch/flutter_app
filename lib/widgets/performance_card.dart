import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  final double percentage;
  final String statusText;
  final Color? backgroundColor;
  final double? fontSize;

  const PerformanceCard({
    super.key,
    required this.percentage,
    required this.statusText,
    this.backgroundColor = const Color(0xFFFF7F27), // default orange
    this.fontSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isGood = percentage >= 90;
    final bool isNear = percentage >= 70 && percentage < 90;
    final bool isLow = percentage < 70;

    // Optional: auto-adjust text/icon color based on performance
    final Color textColor = isLow ? Colors.white : Colors.white;

    String displayStatus = statusText;
    if (statusText.isEmpty) {
      if (isGood) displayStatus = 'Achieved';
      else if (isNear) displayStatus = 'Near Target';
      else displayStatus = 'Under Target';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Your Performance: ${percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isGood
                    ? Icons.emoji_events
                    : isLow
                        ? Icons.warning_amber_rounded
                        : Icons.trending_up,
                color: textColor,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                displayStatus,
                style: TextStyle(
                  fontSize: fontSize != null ? fontSize! - 2 : 16,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}