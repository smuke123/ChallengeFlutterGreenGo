import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/delivery_provider.dart';
import '../widgets/delivery_card.dart';
import '../widgets/progress_bar.dart';
import 'package:challengefluttergreengo/l10n/app_localizations.dart';

class DeliveryListScreen extends StatefulWidget {
  const DeliveryListScreen({super.key});

  @override
  State<DeliveryListScreen> createState() => _DeliveryListScreenState();
}

class _DeliveryListScreenState extends State<DeliveryListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.deliveriesTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).appBarTheme.foregroundColor ?? colorScheme.onPrimary,
          indicatorWeight: 3,
          tabs: [
            Tab(
              icon: Badge(
                label: Text('${provider.pendingCount}'),
                child: const Icon(Icons.pending_actions),
              ),
              text: AppLocalizations.of(context)!.tabPending,
            ),
            Tab(
              icon: Badge(
                label: Text('${provider.completedCount}'),
                child: const Icon(Icons.check_circle),
              ),
              text: AppLocalizations.of(context)!.tabCompleted,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Barra de progreso
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withOpacity(0.3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatCard(
                      context,
                      AppLocalizations.of(context)!.statTotal,
                      provider.deliveries.length.toString(),
                      Icons.inventory_2,
                      colorScheme.primary,
                    ),
                    _buildStatCard(
                      context,
                      AppLocalizations.of(context)!.statPending,
                      provider.pendingCount.toString(),
                      Icons.hourglass_empty,
                      colorScheme.secondary,
                    ),
                    _buildStatCard(
                      context,
                      AppLocalizations.of(context)!.statCompleted,
                      provider.completedCount.toString(),
                      Icons.check_circle,
                      colorScheme.tertiary,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ProgressBar(progress: provider.progress),
              ],
            ),
          ),
          // Lista de entregas
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Pendientes
                _buildDeliveryList(
                  provider.pendingDeliveries,
              AppLocalizations.of(context)!.emptyPending,
                ),
                // Completadas
                _buildDeliveryList(
                  provider.completedDeliveries,
              AppLocalizations.of(context)!.emptyCompleted,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: provider.pendingCount > 0
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                _showResetDialog(context, provider);
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.reset),
            ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryList(List deliveries, String emptyMessage) {
    if (deliveries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 80,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: deliveries.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 300 + (index * 100)),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: child,
              ),
            );
          },
          child: DeliveryCard(delivery: deliveries[index]),
        );
      },
    );
  }

  void _showResetDialog(BuildContext context, DeliveryProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.resetDialogTitle),
        content: Text(AppLocalizations.of(context)!.resetDialogContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              provider.resetDeliveries();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppLocalizations.of(context)!.snackReset),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.reset),
          ),
        ],
      ),
    );
  }
}
