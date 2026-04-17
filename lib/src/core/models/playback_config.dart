import 'package:flutter/foundation.dart';

/// Configuration for video playback behavior.
///
/// All fields have sensible defaults suitable for feed-style video playback.
/// This is an immutable value object — use [copyWith] to derive variations.
@immutable
class PlaybackConfig {
  /// Creates a new [PlaybackConfig] with the given settings.
  ///
  /// - [volume] must be between 0.0 and 1.0 (inclusive).
  /// - [speed] must be between 0.5 and 2.0 (inclusive).
  const PlaybackConfig({
    this.loop = true,
    this.mute = false,
    this.volume = 1.0,
    this.speed = 1.0,
    this.syncLifecycleNotifierWithStateNotifier = true,
  })  : assert(volume >= 0.0 && volume <= 1.0, 'volume must be 0.0–1.0'),
        assert(speed >= 0.5 && speed <= 2.0, 'speed must be 0.5–2.0');

  /// Whether the video should loop when it reaches the end.
  final bool loop;

  /// Whether audio output is muted.
  ///
  /// When true, audio is silenced regardless of [volume].
  final bool mute;

  /// Audio volume level from 0.0 (silent) to 1.0 (full).
  final double volume;

  /// Playback speed multiplier from 0.5 (half speed) to 2.0 (double speed).
  final double speed;

  /// Whether [VideoPool] should synchronize its `lifecycleNotifier` with the
  /// adapter `stateNotifier`.
  ///
  /// When true (default), the pool waits for the adapter to report a
  /// visually-playing state before updating UI lifecycle state to `playing`.
  /// This avoids black/placeholder frames on some platforms.
  ///
  /// When false, the pool marks entries as `playing` immediately after calling
  /// `play()` to avoid UI flicker during resume/background/foreground cycles.
  final bool syncLifecycleNotifierWithStateNotifier;

  /// Creates a copy of this [PlaybackConfig] with the given fields replaced.
  PlaybackConfig copyWith({
    bool? loop,
    bool? mute,
    double? volume,
    double? speed,
    bool? syncLifecycleNotifierWithStateNotifier,
  }) {
    return PlaybackConfig(
      loop: loop ?? this.loop,
      mute: mute ?? this.mute,
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
      syncLifecycleNotifierWithStateNotifier:
          syncLifecycleNotifierWithStateNotifier ??
              this.syncLifecycleNotifierWithStateNotifier,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PlaybackConfig &&
        other.loop == loop &&
        other.mute == mute &&
        other.volume == volume &&
        other.speed == speed &&
        other.syncLifecycleNotifierWithStateNotifier ==
            syncLifecycleNotifierWithStateNotifier;
  }

  @override
  int get hashCode => Object.hash(
        loop,
        mute,
        volume,
        speed,
        syncLifecycleNotifierWithStateNotifier,
      );

  @override
  String toString() =>
      'PlaybackConfig(loop: $loop, mute: $mute, volume: $volume, speed: $speed, '
      'syncLifecycleNotifierWithStateNotifier: $syncLifecycleNotifierWithStateNotifier)';
}
