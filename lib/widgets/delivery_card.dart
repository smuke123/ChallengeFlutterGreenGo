import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/delivery.dart';
import '../providers/delivery_provider.dart';
import 'package:intl/intl.dart';
import 'package:challengefluttergreengo/l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class DeliveryCard extends StatefulWidget {
  final Delivery delivery;
  const DeliveryCard({super.key, required this.delivery});

  @override
  State<DeliveryCard> createState() => _DeliveryCardState();
}

class _DeliveryCardState extends State<DeliveryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryProvider>(context, listen: false);
    final colorScheme = Theme.of(context).colorScheme;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        elevation: widget.delivery.delivered ? 1 : 4,
        color: widget.delivery.delivered
            ? Colors.green.withOpacity(0.1)
            : colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: widget.delivery.delivered
                ? Colors.green.withOpacity(0.3)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTapDown: (_) {
            if (!widget.delivery.delivered) {
              _controller.forward();
            }
          },
          onTapUp: (_) {
            if (!widget.delivery.delivered) {
              _controller.reverse();
            }
          },
          onTapCancel: () {
            if (!widget.delivery.delivered) {
              _controller.reverse();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Ícono animado
                Hero(
                  tag: 'delivery_${widget.delivery.id}',
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.delivery.delivered
                          ? Colors.green.withOpacity(0.2)
                          : Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.delivery.delivered
                          ? Icons.check_circle
                          : Icons.pedal_bike,
                      color: widget.delivery.delivered
                          ? Colors.green
                          : Colors.orange,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Información
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.delivery.clientName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: widget.delivery.delivered
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 14,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.delivery.address,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.map,
                            size: 14,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.delivery.district,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('HH:mm').format(widget.delivery.orderTime),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Acciones: entregar/toggle + menú contextual
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!widget.delivery.delivered)
                      Material(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () async {
                            HapticFeedback.selectionClick();
                            await provider.markAsDelivered(widget.delivery.id);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: [
                                      const Icon(Icons.check_circle, color: Colors.white),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(AppLocalizations.of(context)!
                                            .snackDelivered(widget.delivery.clientName)),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 24,
                        ),
                      ),
                    const SizedBox(width: 8),
                    PopupMenuButton<_DeliveryAction>(
                      tooltip: AppLocalizations.of(context)!.moreOptions,
                      onSelected: (action) async {
                        switch (action) {
                          case _DeliveryAction.toggle:
                            HapticFeedback.selectionClick();
                            await provider.toggleDelivered(widget.delivery.id);
                            break;
                          case _DeliveryAction.remove:
                            final removed = widget.delivery;
                            HapticFeedback.vibrate();
                            await provider.removeDelivery(widget.delivery.id);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!.snackRemoved),
                                  behavior: SnackBarBehavior.floating,
                                  action: SnackBarAction(
                                    label: AppLocalizations.of(context)!.undo,
                                    onPressed: () async {
                                      await provider.addDelivery(removed);
                                    },
                                  ),
                                ),
                              );
                            }
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: _DeliveryAction.toggle,
                          child: Row(
                            children: [
                              Icon(widget.delivery.delivered ? Icons.undo : Icons.check),
                              const SizedBox(width: 8),
                              Text(widget.delivery.delivered
                                  ? AppLocalizations.of(context)!.markPending
                                  : AppLocalizations.of(context)!.markDelivered),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        PopupMenuItem(
                          value: _DeliveryAction.remove,
                          child: Row(
                            children: [
                              const Icon(Icons.delete_outline),
                              const SizedBox(width: 8),
                              Text(AppLocalizations.of(context)!.remove),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _DeliveryAction { toggle, remove }
