package com.example.ontrace_flutter_plugin

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.View
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.annotation.RequiresApi
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.SideEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalView
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import com.qoobiss.ontracesdk.LibraryEntryPoint
import com.qoobiss.ontracesdk.environment.OntraceCompletionResult
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

/** OntraceFlutterPlugin */
class OntraceFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
	companion object {
		lateinit var channel: MethodChannel
	}

	private var activity: Activity? = null

	override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
		channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ontrace_flutter_plugin")
		channel.setMethodCallHandler(this)
	}

	override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
		val arguments = call.arguments
		println("we have some parameters ${arguments}")

		if (call.method == "startAndroidActivity") {
			if (activity != null) {

				val intent = Intent(activity, OntraceActivity::class.java).apply {
					val parameters = call.arguments as? Map<String, String>
					val apiKey = parameters?.get("apiKey")
					if (apiKey != null) {
						putExtra("apiKey", apiKey)
					}
				}
				activity?.startActivity(intent)
				result.success(true)
			} else {
				result.error("ACTIVITY_ERROR", "Activity is null", null)
			}
		} else {
			result.notImplemented()
		}
	}

	override fun onAttachedToActivity(binding: ActivityPluginBinding) {
		activity = binding.activity
	}

	override fun onDetachedFromActivity() {
		activity = null
	}

	override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
		activity = binding.activity
	}

	override fun onDetachedFromActivityForConfigChanges() {
		activity = null
	}

	override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
		channel.setMethodCallHandler(null)
	}
}

class OntraceActivity : ComponentActivity() {

	@RequiresApi(Build.VERSION_CODES.R)
	@SuppressLint("WrongConstant")
	override fun onCreate(savedInstanceState: Bundle?) {
		super.onCreate(savedInstanceState)

		WindowCompat.setDecorFitsSystemWindows(window, false)
		WindowInsetsControllerCompat(window, window.decorView).apply {
			//TODO: Call requires API level 30 (current min is 21): `android.view.WindowInsets.Type#statusBars`
			hide(android.view.WindowInsets.Type.statusBars())
			systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
		}

		window.decorView.systemUiVisibility = (
				View.SYSTEM_UI_FLAG_FULLSCREEN
						or View.SYSTEM_UI_FLAG_LAYOUT_STABLE
				)
		actionBar?.hide()

		val extras = intent.extras
		val apiKey = extras?.getString("apiKey") ?: ""

		setContent {
			EntryPoint(apiKey = apiKey)
		}
	}

	@Composable
	fun EntryPoint(apiKey: String) {
		val view = LocalView.current
		SideEffect {
			val window = (view.context as ComponentActivity).window
			window.statusBarColor = Color(0xFF6200EA).toArgb()
			WindowInsetsControllerCompat(window, view).isAppearanceLightStatusBars =
				false
		}

		Column(
			modifier = Modifier
				.fillMaxSize(),
			verticalArrangement = Arrangement.Center,
			horizontalAlignment = Alignment.CenterHorizontally
		) {
			LibraryEntryPoint(apiKey = apiKey,
				onMessage = {
					sendOnMessageToFlutter(it)
				}, onComplete = {
					sendOnCompleteToFlutter(it)
				})
		}
	}

	private fun sendOnMessageToFlutter(text: String) {
		OntraceFlutterPlugin.channel.invokeMethod("receiveOnMessage", text)
	}

	private fun sendOnCompleteToFlutter(result: OntraceCompletionResult) {
		try {
			val jsonResult = Json.encodeToString(result)
			println(jsonResult)
			OntraceFlutterPlugin.channel.invokeMethod("receiveOnComplete", jsonResult)
			finish()
		} catch (e: Exception) {
			println("Serialization error: ${e.message}")
		}

	}
}