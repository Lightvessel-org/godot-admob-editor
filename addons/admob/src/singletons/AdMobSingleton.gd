extends Node

const ANDROID_BANNER_TEST_ID: String = "ca-app-pub-3940256099942544/6300978111"
const ANDROID_INTERSTITIAL_TEST_ID: String = "ca-app-pub-3940256099942544/1033173712"
const ANDROID_REWARDED_VIDEO_TEST_ID: String = "ca-app-pub-3940256099942544/5224354917"
const ANDROID_REWARDED_INTERSTITIAL_TEST_ID: String = "ca-app-pub-3940256099942544/5354046379"
const ANDROID_NATIVE_TEST_ID: String = "ca-app-pub-3940256099942544/2247696110"

const IOS_BANNER_TEST_ID: String = "ca-app-pub-3940256099942544/2934735716"
const IOS_INTERSTITIAL_TEST_ID: String = "ca-app-pub-3940256099942544/4411468910"
const IOS_REWARDED_VIDEO_TEST_ID: String = "ca-app-pub-3940256099942544/1712485313"
const IOS_REWARDED_INTERSTITIAL_TEST_ID: String = "ca-app-pub-3940256099942544/6978759866"
const IOS_NATIVE_TEST_ID: String = "ca-app-pub-3940256099942544/3986624511"

signal initialization_complete(status, adapter_name)

signal consent_form_dismissed()
signal consent_status_changed(consent_status_message)
signal consent_form_load_failure(error_code, error_message)
signal consent_info_update_success(consent_status_message)
signal consent_info_update_failure(error_code, error_message)

signal banner_loaded()
signal banner_failed_to_load(error_code)
signal banner_opened()
signal banner_clicked()
signal banner_closed()
signal banner_recorded_impression()
signal banner_destroyed()

signal interstitial_failed_to_load(error_code)
signal interstitial_loaded()
signal interstitial_failed_to_show(error_code)
signal interstitial_opened()
signal interstitial_clicked()
signal interstitial_closed()
signal interstitial_recorded_impression()

signal rewarded_ad_failed_to_load(ad_unit, error_code)
signal rewarded_ad_loaded(ad_unit)
signal rewarded_ad_failed_to_show(ad_unit, error_code)
signal rewarded_ad_opened(ad_unit)
signal rewarded_ad_clicked(ad_unit)
signal rewarded_ad_closed(ad_unit)
signal rewarded_ad_recorded_impression(ad_unit)
signal rewarded_ad_earned_rewarded(ad_unit, currency, amount)

signal rewarded_interstitial_ad_failed_to_load(error_code)
signal rewarded_interstitial_ad_loaded()
signal rewarded_interstitial_ad_failed_to_show(error_code)
signal rewarded_interstitial_ad_opened()
signal rewarded_interstitial_ad_clicked()
signal rewarded_interstitial_ad_closed()
signal rewarded_interstitial_ad_recorded_impression()
signal rewarded_interstitial_earned_rewarded(currency, amount)

signal native_loaded()
signal native_failed_to_load(error_code)
signal native_opened()
signal native_clicked()
signal native_closed()
signal native_recorded_impression()
signal native_destroyed()


var AdMobSettings = preload("res://addons/admob/src/utils/AdMobSettings.gd").new()
onready var config = AdMobSettings.config
var _plugin : Object

func _ready() -> void:
	if config.general.is_enabled:
		if (Engine.has_singleton("AdMob")):
			_plugin = Engine.get_singleton("AdMob")
			initialize()
			_connect_signals()

func get_is_initialized() -> bool:
	if _plugin:
		return _plugin.get_is_initialized()
	return false

func initialize() -> void:
	if _plugin:
		var is_release : bool = OS.has_feature("release")
		
		var is_debug_on_release : bool = config.debug.is_debug_on_release

		var is_real : bool = false
		var is_test_europe_user_consent : bool = config.debug.is_test_europe_user_consent

		if is_release:
			is_real = true
			is_test_europe_user_consent = false

			if is_debug_on_release:
				is_real = config.debug.is_real
				is_test_europe_user_consent = config.debug.is_test_europe_user_consent
		
		if !is_real:
			_set_ids_to_test()
		
		_plugin.initialize(config.general.is_for_child_directed_treatment, config.general.max_ad_content_rating, is_real, is_test_europe_user_consent)


func _set_ids_to_test() -> void:
	var reconfig: Dictionary = {
		ANDROID_BANNER_TEST_ID: config.banner.unit_ids.Android,
		ANDROID_INTERSTITIAL_TEST_ID: config.interstitial.unit_ids.Android,
		ANDROID_REWARDED_VIDEO_TEST_ID: config.rewarded.unit_ids.Android,
		ANDROID_REWARDED_INTERSTITIAL_TEST_ID: config.rewarded_interstitial.unit_ids.Android,
		ANDROID_NATIVE_TEST_ID: config.native.unit_ids.Android,
		IOS_BANNER_TEST_ID: config.banner.unit_ids.iOS,
		IOS_INTERSTITIAL_TEST_ID: config.interstitial.unit_ids.iOS,
		IOS_REWARDED_VIDEO_TEST_ID: config.rewarded.unit_ids.iOS,
		IOS_REWARDED_INTERSTITIAL_TEST_ID: config.rewarded_interstitial.unit_ids.iOS,
		IOS_NATIVE_TEST_ID: config.native.unit_ids.iOS,
	}
	
	for test_id in reconfig.keys():
		var unit_ids: Dictionary = reconfig[test_id]
		for unit_name in unit_ids.keys():
			unit_ids[unit_name] = test_id



func _connect_signals() -> void:
	_plugin.connect("initialization_complete", self, "_on_AdMob_initialization_complete")

	_plugin.connect("consent_form_dismissed", self, "_on_AdMob_consent_form_dismissed")
	_plugin.connect("consent_status_changed", self, "_on_AdMob_consent_status_changed")
	_plugin.connect("consent_form_load_failure", self, "_on_AdMob_consent_form_load_failure")
	_plugin.connect("consent_info_update_success", self, "_on_AdMob_consent_info_update_success")
	_plugin.connect("consent_info_update_failure", self, "_on_AdMob_consent_info_update_failure")

	_plugin.connect("banner_loaded", self, "_on_AdMob_banner_loaded")
	_plugin.connect("banner_failed_to_load", self, "_on_AdMob_banner_failed_to_load")
	_plugin.connect("banner_opened", self, "_on_AdMob_banner_opened")
	_plugin.connect("banner_clicked", self, "_on_AdMob_banner_clicked")
	_plugin.connect("banner_closed", self, "_on_AdMob_banner_closed")
	_plugin.connect("banner_recorded_impression", self, "_on_AdMob_banner_recorded_impression")
	_plugin.connect("banner_destroyed", self, "_on_AdMob_banner_destroyed")

	_plugin.connect("interstitial_failed_to_load", self, "_on_AdMob_interstitial_failed_to_load")
	_plugin.connect("interstitial_loaded", self, "_on_AdMob_interstitial_loaded")
	_plugin.connect("interstitial_failed_to_show", self, "_on_AdMob_interstitial_failed_to_show")
	_plugin.connect("interstitial_opened", self, "_on_AdMob_interstitial_opened")
	_plugin.connect("interstitial_clicked", self, "_on_AdMob_interstitial_clicked")
	_plugin.connect("interstitial_closed", self, "_on_AdMob_interstitial_closed")
	_plugin.connect("interstitial_recorded_impression", self, "_on_AdMob_interstitial_recorded_impression")

	_plugin.connect("rewarded_ad_failed_to_load", self, "_on_AdMob_rewarded_ad_failed_to_load")
	_plugin.connect("rewarded_ad_loaded", self, "_on_AdMob_rewarded_ad_loaded")
	_plugin.connect("rewarded_ad_failed_to_show", self, "_on_AdMob_rewarded_ad_failed_to_show")
	_plugin.connect("rewarded_ad_opened", self, "_on_AdMob_rewarded_ad_opened")
	_plugin.connect("rewarded_ad_clicked", self, "_on_AdMob_rewarded_ad_clicked")
	_plugin.connect("rewarded_ad_closed", self, "_on_AdMob_rewarded_ad_closed")
	_plugin.connect("rewarded_ad_recorded_impression", self, "_on_AdMob_rewarded_ad_recorded_impression")
	_plugin.connect("rewarded_ad_earned_rewarded", self, "_on_AdMob_rewarded_ad_earned_rewarded")

	_plugin.connect("rewarded_interstitial_ad_failed_to_load", self, "_on_AdMob_rewarded_interstitial_ad_failed_to_load")
	_plugin.connect("rewarded_interstitial_ad_loaded", self, "_on_AdMob_rewarded_interstitial_ad_loaded")
	_plugin.connect("rewarded_interstitial_ad_failed_to_show", self, "_on_AdMob_rewarded_interstitial_ad_failed_to_show")
	_plugin.connect("rewarded_interstitial_ad_opened", self, "_on_AdMob_rewarded_interstitial_ad_opened")
	_plugin.connect("rewarded_interstitial_ad_clicked", self, "_on_AdMob_rewarded_interstitial_ad_clicked")
	_plugin.connect("rewarded_interstitial_ad_closed", self, "_on_AdMob_rewarded_interstitial_ad_closed")
	_plugin.connect("rewarded_interstitial_ad_recorded_impression", self, "_on_AdMob_rewarded_interstitial_ad_recorded_impression")
	_plugin.connect("rewarded_interstitial_earned_rewarded", self, "_on_AdMob_rewarded_interstitial_earned_rewarded")
	
	_plugin.connect("native_loaded", self, "_on_AdMob_native_loaded")
	_plugin.connect("native_failed_to_load", self, "_on_AdMob_native_failed_to_load")
	_plugin.connect("native_opened", self, "_on_AdMob_native_opened")
	_plugin.connect("native_clicked", self, "_on_AdMob_native_clicked")
	_plugin.connect("native_closed", self, "_on_AdMob_native_closed")
	_plugin.connect("native_recorded_impression", self, "_on_AdMob_native_recorded_impression")
	_plugin.connect("native_destroyed", self, "_on_AdMob_native_destroyed")


func _on_AdMob_initialization_complete(status : int, adapter_name : String) -> void:
	emit_signal("initialization_complete", status, adapter_name)

func _on_AdMob_consent_form_dismissed() -> void:
	emit_signal("consent_form_dismissed")
func _on_AdMob_consent_status_changed(consent_status_message : String) -> void:
	emit_signal("consent_status_changed", consent_status_message)
func _on_AdMob_consent_form_load_failure(error_code : int, error_message: String) -> void:
	emit_signal("consent_form_load_failure", error_code, error_message)
func _on_AdMob_consent_info_update_success(consent_status_message : String) -> void:
	emit_signal("consent_info_update_success", consent_status_message)
func _on_AdMob_consent_info_update_failure(error_code : int, error_message : String) -> void:
	emit_signal("consent_info_update_failure", error_code, error_message)

func _on_AdMob_banner_loaded() -> void:
	emit_signal("banner_loaded")
func _on_AdMob_banner_failed_to_load(error_code : int) -> void:
	emit_signal("banner_failed_to_load", error_code)
func _on_AdMob_banner_opened() -> void:
	emit_signal("banner_loaded")
func _on_AdMob_banner_clicked() -> void:
	emit_signal("banner_clicked")
func _on_AdMob_banner_closed() -> void:
	emit_signal("banner_closed")
func _on_AdMob_banner_recorded_impression() -> void:
	emit_signal("banner_recorded_impression")
func _on_AdMob_banner_destroyed() -> void:
	emit_signal("banner_destroyed")

func _on_AdMob_interstitial_failed_to_load(error_code : int) -> void:
	emit_signal("interstitial_failed_to_load", error_code)
func _on_AdMob_interstitial_loaded() -> void:
	emit_signal("interstitial_loaded")
func _on_AdMob_interstitial_failed_to_show(error_code : int) -> void:
	emit_signal("interstitial_failed_to_show", error_code)
func _on_AdMob_interstitial_opened() -> void:
	emit_signal("interstitial_opened")
func _on_AdMob_interstitial_clicked() -> void:
	emit_signal("interstitial_clicked")
func _on_AdMob_interstitial_closed() -> void:
	emit_signal("interstitial_closed")
func _on_AdMob_interstitial_recorded_impression() -> void:
	emit_signal("interstitial_recorded_impression")

func _on_AdMob_rewarded_ad_failed_to_load(raw_ad_unit : String, error_code : int) -> void:
	emit_signal("rewarded_ad_failed_to_load", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]), error_code)
func _on_AdMob_rewarded_ad_loaded(raw_ad_unit : String) -> void:
	emit_signal("rewarded_ad_loaded", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]))
func _on_AdMob_rewarded_ad_failed_to_show(raw_ad_unit : String, error_code : int) -> void:
	emit_signal("rewarded_ad_failed_to_show", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]), error_code)
func _on_AdMob_rewarded_ad_opened(raw_ad_unit : String) -> void:
	emit_signal("rewarded_ad_opened", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]))
func _on_AdMob_rewarded_ad_clicked(raw_ad_unit : String) -> void:
	emit_signal("rewarded_ad_clicked", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]))
func _on_AdMob_rewarded_ad_closed(raw_ad_unit : String) -> void:
	emit_signal("rewarded_ad_closed", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]))
func _on_AdMob_rewarded_ad_recorded_impression(raw_ad_unit : String) -> void:
	emit_signal("rewarded_ad_recorded_impression", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]))
func _on_AdMob_rewarded_ad_earned_rewarded(raw_ad_unit : String, currency : String, amount : int) -> void:
	emit_signal("rewarded_ad_earned_rewarded", _get_ad_unit_from_raw(raw_ad_unit, config.rewarded.unit_ids[OS.get_name()]), currency, amount)

func _get_ad_unit_from_raw(raw_ad_unit : String, ad_units : Dictionary) -> String:
	for key in ad_units.keys():
		if ad_units[key] == raw_ad_unit:
			return key
	return raw_ad_unit

func _on_AdMob_rewarded_interstitial_ad_failed_to_load(error_code : int) -> void:
	emit_signal("rewarded_interstitial_ad_failed_to_load", error_code)
func _on_AdMob_rewarded_interstitial_ad_loaded() -> void:
	emit_signal("rewarded_interstitial_ad_loaded")
func _on_AdMob_rewarded_interstitial_ad_failed_to_show(error_code : int) -> void:
	emit_signal("rewarded_interstitial_ad_failed_to_show", error_code)
func _on_AdMob_rewarded_interstitial_ad_opened() -> void:
	emit_signal("rewarded_interstitial_ad_opened")
func _on_AdMob_rewarded_interstitial_ad_clicked() -> void:
	emit_signal("rewarded_interstitial_ad_clicked")
func _on_AdMob_rewarded_interstitial_ad_closed() -> void:
	emit_signal("rewarded_interstitial_ad_closed")
func _on_AdMob_rewarded_interstitial_ad_recorded_impression() -> void:
	emit_signal("rewarded_interstitial_ad_recorded_impression")
func _on_AdMob_rewarded_interstitial_earned_rewarded(currency : String, amount : int) -> void:
	emit_signal("rewarded_interstitial_earned_rewarded", currency, amount)


func _on_AdMob_native_loaded() -> void:
	emit_signal("native_loaded")
func _on_AdMob_native_failed_to_load(error_code: int) -> void:
	emit_signal("native_failed_to_load", error_code)
func _on_AdMob_native_opened() -> void:
	emit_signal("native_opened")
func _on_AdMob_native_clicked() -> void:
	emit_signal("native_clicked")
func _on_AdMob_native_closed() -> void:
	emit_signal("native_closed")
func _on_AdMob_native_recorded_impression() -> void:
	emit_signal("native_recorded_impression")
func _on_AdMob_native_destroyed() -> void:
	emit_signal("native_destroyed")
