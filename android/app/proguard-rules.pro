# android/app/proguard-rules.pro
# Reglas ProGuard para la aplicación

# Mantener clases de Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Mantener clases de ExoPlayer
-keep class com.google.android.exoplayer.** { *; }

# Mantener clases del visor de PDF
-keep class com.github.barteksc.pdfviewer.** { *; }

# Mantener anotaciones importantes
-keep class androidx.annotation.Keep
-keep @androidx.annotation.Keep class * {*;}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <methods>;
}
-keepclasseswithmembers class * {
    @androidx.annotation.Keep <fields>;
}

# Reglas específicas para Kotlin
-keep class kotlin.** { *; }
-keep class kotlin.Metadata { *; }
-keepclassmembers class **$WhenMappings {
    <fields>;
}
