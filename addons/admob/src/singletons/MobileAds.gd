extends "res://addons/admob/src/singletons/AdMobSingleton.gd" 

signal banner_shown(is_shown)
signal native_shown(is_shown)

var _native_control: Control


func _ready() -> void:
	# warning-ignore:return_value_discarded
	get_tree().connect("screen_resized", self, "_on_get_tree_resized")


func load_banner(ad_unit_name : String = "standard") -> void:
	_load_ad(ad_unit_name, config.banner, "load_banner", [config.banner.position, config.banner.size, config.banner.show_instantly, config.banner.respect_safe_area])

func load_interstitial(ad_unit_name : String = "standard") -> void:
	_load_ad(ad_unit_name, config.interstitial, "load_interstitial")

func load_rewarded(ad_unit_name : String = "standard") -> void:
	_load_ad(ad_unit_name, config.rewarded, "load_rewarded")

func load_rewarded_interstitial(ad_unit_name : String = "standard") -> void:
	_load_ad(ad_unit_name, config.rewarded_interstitial, "load_rewarded_interstitial")

func load_native(ad_unit_name: String = "standard", control_to_replace: Control = null) -> void:
	if control_to_replace != null:
		_native_control = control_to_replace
	if _native_control == null:
		_native_control = Control.new()
		var visible_rect: Rect2 = get_viewport().get_visible_rect()
		_native_control.rect_size = Vector2(visible_rect.size.x, visible_rect.size.y * 0.1)
		_native_control.rect_position = Vector2(0.0, visible_rect.size.y - _native_control.rect_size.y)
	
	var difference: Vector2 = OS.window_size - get_viewport().size
	var scale_virt_2_view: Vector2 = get_viewport().size / get_viewport().get_visible_rect().size
	
	var size: Vector2 = _native_control.rect_size * scale_virt_2_view
	var position: Vector2 = _native_control.rect_position * scale_virt_2_view + difference / 2.0
	
	_load_ad(ad_unit_name, config.native, "load_native", [[size.x, size.y], [position.x, position.y]])

func _load_ad(ad_unit_name: String, dict: Dictionary, method: String, varargs: Array = []) -> void:
	if _plugin && _is_valid_ad_unit_name(dict.unit_ids, ad_unit_name):
		_plugin.callv(method, [dict.unit_ids[OS.get_name()][ad_unit_name]] + varargs)

func _is_valid_ad_unit_name(ids : Dictionary, ad_unit_name : String) -> bool:
	return ids[OS.get_name()].has(ad_unit_name)

func destroy_banner() -> void:
	if _plugin:
		_plugin.destroy_banner()
		emit_signal("banner_shown", false)

func show_banner() -> void:
	if _plugin:
		_plugin.show_banner()
		emit_signal("banner_shown", true)
		
func hide_banner() -> void:
	if _plugin:
		_plugin.hide_banner()
		emit_signal("banner_shown", false)

func show_interstitial() -> void:
	if _plugin:
		_plugin.show_interstitial()

func show_rewarded(ad_unit_name : String = "standard") -> void:
	if _plugin && _is_valid_ad_unit_name(config.rewarded.unit_ids, ad_unit_name):
		_plugin.show_rewarded(config.rewarded.unit_ids[OS.get_name()][ad_unit_name])

func show_rewarded_interstitial() -> void:
	if _plugin:
		_plugin.show_rewarded_interstitial()

func get_native_dimensions() -> Rect2:
	if _native_control != null:
		return Rect2(_native_control.rect_global_position, _native_control.rect_size)
	return Rect2()

func destroy_native() -> void:
	if _plugin:
		_plugin.destroy_native()
		emit_signal("native_shown", false)

func _on_AdMob_native_destroyed() -> void:
	if !_native_control.is_inside_tree():
		_native_control.queue_free()
	_native_control = null
	._on_AdMob_native_destroyed()

func show_native() -> void:
	if _plugin:
		_plugin.show_native()
		emit_signal("native_shown", true)

func hide_native() -> void:
	if _plugin:
		_plugin.hide_native()
		emit_signal("native_shown", false)

func request_user_consent() -> void:
	if _plugin:
		_plugin.request_user_consent()

func reset_consent_state(will_request_user_consent := false) -> void:
	if _plugin:
		_plugin.reset_consent_state()

func get_banner_width() -> int:
	if _plugin:
		return _plugin.get_banner_width()
	return 0

func get_banner_width_in_pixels() -> int:
	if _plugin:
		return _plugin.get_banner_width_in_pixels()
	return 0
	
func get_banner_height() -> int:
	if _plugin:
		return _plugin.get_banner_height()
	return 0
	
func get_banner_height_in_pixels() -> int:
	if _plugin:
		return _plugin.get_banner_height_in_pixels()
	return 0
	
func get_is_banner_loaded() -> bool:
	if _plugin:
		return _plugin.get_is_banner_loaded()
	return false

func get_is_interstitial_loaded() -> bool:
	if _plugin:
		return _plugin.get_is_interstitial_loaded()
	return false

func get_is_rewarded_loaded(ad_unit_name : String = "standard") -> bool:
	if _plugin && _is_valid_ad_unit_name(config.rewarded.unit_ids, ad_unit_name):
		return _plugin.get_is_rewarded_loaded(config.rewarded.unit_ids[OS.get_name()][ad_unit_name])
	return false

func get_is_rewarded_interstitial_loaded() -> bool:
	if _plugin:
		return _plugin.get_is_rewarded_interstitial_loaded()
	return false

func get_is_native_loaded() -> bool:
	if _plugin:
		return _plugin.get_is_native_loaded()
	return false

func _on_get_tree_resized() -> void:
	if _plugin:
		if get_is_banner_loaded() and config.banner.size == "SMART_BANNER":
			load_banner()
		if get_is_interstitial_loaded(): #verify if interstitial and rewarded is loaded because the only reason to load again now is to resize
			load_interstitial()
		for key in config.rewarded.unit_ids[OS.get_name()].keys():
			if get_is_rewarded_loaded(key):
				load_rewarded(key)
		if get_is_rewarded_interstitial_loaded():
			load_rewarded_interstitial()
		
		if get_is_native_loaded():
			load_native("standard", _native_control)
