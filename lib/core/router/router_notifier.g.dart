// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Listens to auth-like state changes and notifies [GoRouter] to re-evaluate
/// redirect guards. Implements [Listenable] so it can be passed directly as
/// [GoRouter.refreshListenable].

@ProviderFor(RouterNotifier)
final routerProvider = RouterNotifierProvider._();

/// Listens to auth-like state changes and notifies [GoRouter] to re-evaluate
/// redirect guards. Implements [Listenable] so it can be passed directly as
/// [GoRouter.refreshListenable].
final class RouterNotifierProvider
    extends $NotifierProvider<RouterNotifier, void> {
  /// Listens to auth-like state changes and notifies [GoRouter] to re-evaluate
  /// redirect guards. Implements [Listenable] so it can be passed directly as
  /// [GoRouter.refreshListenable].
  RouterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerNotifierHash();

  @$internal
  @override
  RouterNotifier create() => RouterNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$routerNotifierHash() => r'f74843353be23eecf960104139126502bd7970e3';

/// Listens to auth-like state changes and notifies [GoRouter] to re-evaluate
/// redirect guards. Implements [Listenable] so it can be passed directly as
/// [GoRouter.refreshListenable].

abstract class _$RouterNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
