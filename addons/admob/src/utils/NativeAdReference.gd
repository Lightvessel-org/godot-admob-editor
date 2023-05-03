extends Control
class_name NativeAdReference

export (bool) var show_immediately: bool = true
export (String) var ad_id_name: String = "standard"


func _ready() -> void:
	MobileAds.connect("initialization_complete", self, "_on_AdMob_initialization_complete")


func _on_AdMob_initialization_complete(status : int, adapter_name : String) -> void:
	if status == MobileAds.AdMobSettings.INITIALIZATION_STATUS.READY && show_immediately:
		_load_ad()


func _load_ad() -> void:
		MobileAds.load_native(ad_id_name, self)
		MobileAds.connect("native_loaded", self, "_on_AdMob_native_loaded")


func enable_ad() -> void:
	if MobileAds.get_is_initialized():
		_load_ad()


func _on_AdMob_native_loaded() -> void:
	if show_immediately:
		MobileAds.show_native()
	MobileAds.disconnect("native_loaded", self, "_on_AdMob_native_loaded")
