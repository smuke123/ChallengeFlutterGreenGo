import 'package:flutter/material.dart';
import 'package:challengefluttergreengo/l10n/app_localizations.dart';

class ProgressBar extends StatefulWidget {
  final double progress;
  const ProgressBar({super.key, required this.progress});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _lastProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: widget.progress).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
    _lastProgress = widget.progress;
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: _lastProgress,
        end: widget.progress,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0.0);
      _lastProgress = widget.progress;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final percentage = (_animation.value * 100).toInt();
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 20,
                      color: _getProgressColor(context, percentage),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context)!.progressTitle,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getProgressColor(context, percentage).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$percentage%',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: _getProgressColor(context, percentage),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final barWidth = constraints.maxWidth;
                return Stack(
                  children: [
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 16,
                      width: barWidth * _animation.value,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getProgressColor(context, percentage),
                            _getProgressColor(context, percentage).withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: _getProgressColor(context, percentage).withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    if (percentage == 100)
                      Positioned.fill(
                        child: Center(
                          child: TweenAnimationBuilder<double>(
                            tween: Tween(begin: 0.8, end: 1.2),
                            duration: const Duration(milliseconds: 500),
                            builder: (context, scale, child) {
                              return Transform.scale(
                                scale: scale,
                                child: const Icon(
                                  Icons.celebration,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              _getProgressMessage(percentage),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        );
      },
    );
  }

  Color _getProgressColor(BuildContext context, int percentage) {
    if (percentage == 0) {
      return Theme.of(context).colorScheme.outline;
    } else if (percentage < 30) {
      return Theme.of(context).colorScheme.error;
    } else if (percentage < 60) {
      return Theme.of(context).colorScheme.secondary;
    } else if (percentage < 100) {
      return Theme.of(context).colorScheme.primary;
    } else {
      return Theme.of(context).colorScheme.tertiary;
    }
  }

  String _getProgressMessage(int percentage) {
    if (percentage == 0) {
      return '¡Comienza tu jornada de entregas! 🚴';
    } else if (percentage < 30) {
      return '¡Buen inicio! Sigue adelante 💪';
    } else if (percentage < 60) {
      return '¡Vas por buen camino! 🎯';
    } else if (percentage < 100) {
      return '¡Casi terminas! Ya falta poco 🔥';
    } else {
      return '¡Todas las entregas completadas! 🎉';
    }
  }
}

