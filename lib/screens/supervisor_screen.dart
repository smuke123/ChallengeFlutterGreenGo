import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/delivery_provider.dart';
import '../widgets/progress_bar.dart';
import 'package:intl/intl.dart';

class SupervisorScreen extends StatefulWidget {
  const SupervisorScreen({super.key});

  @override
  State<SupervisorScreen> createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  String _filterStatus = 'all'; // all, pending, completed

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    // Filtrar entregas
    List filteredDeliveries = provider.deliveries;
    if (_filterStatus == 'pending') {
      filteredDeliveries = provider.pendingDeliveries;
    } else if (_filterStatus == 'completed') {
      filteredDeliveries = provider.completedDeliveries;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '👨‍💼 Panel del Supervisor',
          style: TextStyle(fontWeight: FontWeight.bold),
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
                        '📦 Total',
                        provider.deliveries.length.toString(),
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDashboardCard(
                        context,
                        '⏳ Pendientes',
                        provider.pendingCount.toString(),
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDashboardCard(
                        context,
                        '✅ Completadas',
                        provider.completedCount.toString(),
                        Colors.green,
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
                const Text(
                  'Filtrar:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Todas', 'all', provider.deliveries.length),
                        const SizedBox(width: 8),
                        _buildFilterChip('Pendientes', 'pending', provider.pendingCount),
                        const SizedBox(width: 8),
                        _buildFilterChip('Completadas', 'completed', provider.completedCount),
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
                          'No hay entregas en esta categoría',
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
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                delivery.delivered
                                    ? Icons.check_circle
                                    : Icons.pedal_bike,
                                color: delivery.delivered
                                    ? Colors.green
                                    : Colors.orange,
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
                            trailing: delivery.delivered
                                ? const Chip(
                                    label: Text(
                                      'Entregado',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    backgroundColor: Colors.green,
                                    labelStyle: TextStyle(color: Colors.white),
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                  )
                                : const Chip(
                                    label: Text(
                                      'En ruta',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                    backgroundColor: Colors.orange,
                                    labelStyle: TextStyle(color: Colors.white),
                                    padding: EdgeInsets.symmetric(horizontal: 8),
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
