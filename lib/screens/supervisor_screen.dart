import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/delivery_provider.dart';
import '../widgets/progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:challengefluttergreengo/l10n/app_localizations.dart';
import 'package:flutter/services.dart';

class SupervisorScreen extends StatefulWidget {
  const SupervisorScreen({super.key});

  @override
  State<SupervisorScreen> createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  String _filterStatus = 'all'; // all, pending, completed
  String _searchQuery = '';
  String _sortKey = 'time_desc'; // time_asc, time_desc, status, district

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    // Filtrar por estado
    List filteredDeliveries = List.of(provider.deliveries);
    if (_filterStatus == 'pending') {
      filteredDeliveries = provider.pendingDeliveries;
    } else if (_filterStatus == 'completed') {
      filteredDeliveries = provider.completedDeliveries;
    }

    // Filtrar por búsqueda (cliente/dirección/distrito)
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filteredDeliveries = filteredDeliveries.where((d) {
        return d.clientName.toLowerCase().contains(q) ||
            d.address.toLowerCase().contains(q) ||
            d.district.toLowerCase().contains(q);
      }).toList();
    }

    // Ordenar
    filteredDeliveries.sort((a, b) {
      switch (_sortKey) {
        case 'time_asc':
          return a.orderTime.compareTo(b.orderTime);
        case 'time_desc':
          return b.orderTime.compareTo(a.orderTime);
        case 'status':
          // Pendientes primero
          if (a.delivered == b.delivered) return 0;
          return a.delivered ? 1 : -1;
        case 'district':
          return a.district.toLowerCase().compareTo(b.district.toLowerCase());
        default:
          return 0;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.supervisorTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Dashboard con estadísticas
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primaryContainer,
                  colorScheme.primaryContainer.withOpacity(0.5),
                ],
              ),
            ),
            child: Column(
              children: [
                // Estadísticas principales
                Row(
                  children: [
                    Expanded(
                      child: _buildDashboardCard(
                        context,
                        '📦 ' + AppLocalizations.of(context)!.statTotal,
                        provider.deliveries.length.toString(),
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDashboardCard(
                        context,
                        '⏳ ' + AppLocalizations.of(context)!.statPending,
                        provider.pendingCount.toString(),
                        Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDashboardCard(
                        context,
                        '✅ ' + AppLocalizations.of(context)!.statCompleted,
                        provider.completedCount.toString(),
                        Theme.of(context).colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Barra de progreso
                ProgressBar(progress: provider.progress),
              ],
            ),
          ),
          // Filtros
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(AppLocalizations.of(context)!.filter, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip(AppLocalizations.of(context)!.filterAll, 'all', provider.deliveries.length),
                        const SizedBox(width: 8),
                        _buildFilterChip(AppLocalizations.of(context)!.filterPending, 'pending', provider.pendingCount),
                        const SizedBox(width: 8),
                        _buildFilterChip(AppLocalizations.of(context)!.filterCompleted, 'completed', provider.completedCount),
                        const SizedBox(width: 12),
                        // Buscador
                        SizedBox(
                          width: 220,
                          child: TextField(
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: const Icon(Icons.search),
                              hintText: AppLocalizations.of(context)!.searchHint,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value.trim();
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Ordenamiento
                        DropdownButton<String>(
                          value: _sortKey,
                          underline: const SizedBox.shrink(),
                          items: [
                            DropdownMenuItem(value: 'time_desc', child: Text(AppLocalizations.of(context)!.sortNewest)),
                            DropdownMenuItem(value: 'time_asc', child: Text(AppLocalizations.of(context)!.sortOldest)),
                            DropdownMenuItem(value: 'status', child: Text(AppLocalizations.of(context)!.sortStatus)),
                            DropdownMenuItem(value: 'district', child: Text(AppLocalizations.of(context)!.sortDistrict)),
                          ],
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _sortKey = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Lista de entregas
          Expanded(
            child: filteredDeliveries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: colorScheme.onSurface.withOpacity(0.3),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.emptyCategory,
                          style: TextStyle(
                            color: colorScheme.onSurface.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: filteredDeliveries.length,
                    itemBuilder: (context, index) {
                      final delivery = filteredDeliveries[index];
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: Duration(milliseconds: 200 + (index * 50)),
                        builder: (context, value, child) {
                          return Transform.scale(
                            scale: 0.8 + (0.2 * value),
                            child: Opacity(
                              opacity: value,
                              child: child,
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          elevation: delivery.delivered ? 1 : 3,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: delivery.delivered
                                    ? Theme.of(context).colorScheme.tertiary.withOpacity(0.1)
                                    : Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                delivery.delivered
                                    ? Icons.check_circle
                                    : Icons.pedal_bike,
                                color: delivery.delivered
                                    ? Theme.of(context).colorScheme.tertiary
                                    : Theme.of(context).colorScheme.secondary,
                                size: 28,
                              ),
                            ),
                            title: Text(
                              delivery.clientName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: delivery.delivered
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on, size: 14),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        delivery.address,
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.map, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      delivery.district,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 14),
                                    const SizedBox(width: 4),
                                    Text(
                                      DateFormat('HH:mm')
                                          .format(delivery.orderTime),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                delivery.delivered
                                    ? Chip(
                                        label: Text(
                                          AppLocalizations.of(context)!.chipDelivered,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                                        labelStyle: const TextStyle(color: Colors.white),
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                      )
                                    : Chip(
                                        label: Text(
                                          AppLocalizations.of(context)!.chipOnRoute,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                        backgroundColor: Theme.of(context).colorScheme.secondary,
                                        labelStyle: const TextStyle(color: Colors.white),
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                      ),
                                const SizedBox(width: 8),
                                PopupMenuButton<_SupervisorAction>(
                                  tooltip: AppLocalizations.of(context)!.moreOptions,
                                  onSelected: (action) async {
                                    switch (action) {
                                      case _SupervisorAction.toggle:
                                        HapticFeedback.selectionClick();
                                        await provider.toggleDelivered(delivery.id);
                                        break;
                                      case _SupervisorAction.remove:
                                        final removed = delivery;
                                        HapticFeedback.vibrate();
                                        await provider.removeDelivery(delivery.id);
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
                                      value: _SupervisorAction.toggle,
                                      child: Row(
                                        children: [
                                          Icon(delivery.delivered ? Icons.undo : Icons.check),
                                          const SizedBox(width: 8),
                                          Text(delivery.delivered
                                              ? AppLocalizations.of(context)!.markPending
                                              : AppLocalizations.of(context)!.markDelivered),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuDivider(),
                                    PopupMenuItem(
                                      value: _SupervisorAction.remove,
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
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, int count) {
    final isSelected = _filterStatus == value;
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.black,
              ),
            ),
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _filterStatus = value;
        });
      },
    );
  }
}

enum _SupervisorAction { toggle, remove }
