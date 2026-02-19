import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitlabel/app/router.dart';
import 'package:fitlabel/app/theme.dart';
import 'package:fitlabel/config/providers/tenant_config_provider.dart';

class FitLabelApp extends ConsumerWidget {
  const FitLabelApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(routerProvider);
    final configState = ref.watch(tenantConfigNotifierProvider);

    final tenantConfig = configState.valueOrNull;

    return MaterialApp.router(
      title: tenantConfig?.appName ?? 'FitLabel',
      theme: AppTheme.fromConfig(tenantConfig),
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
