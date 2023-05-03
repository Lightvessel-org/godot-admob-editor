extends Control

onready var EnableBanner : Button = $"%EnableBanner"
onready var DisableBanner : Button = $"%DisableBanner"
onready var ShowBanner : Button = $"%ShowBanner"
onready var HideBanner : Button = $"%HideBanner"

onready var Interstitial : Button = $"%Interstitial"
onready var Rewarded : Button = $"%Rewarded"
onready var RewardedInterstitial : Button = $"%RewardedInterstitial"

onready var EnableNative: Button = $"%EnableNative"
onready var DisableNative: Button = $"%DisableNative"
onready var ShowNative: Button = $"%ShowNative"
onready var HideNative: Button = $"%HideNative"

onready var RequestUserConsent : Button = $"%RequestUserConsent"
onready var ResetConsentState : Button = $"%ResetConsentState"

onready var Advice : RichTextLabel = $"%Advice"

onready var BannerPosition : CheckBox = $Background/TabContainer/Banner/VBoxContainer/Position
onready var RespectSafeArea : CheckBox = $Background/TabContainer/Banner/VBoxContainer/RespectSafeArea
onready var BannerSizes : ItemList = $Background/TabContainer/Banner/VBoxContainer/BannerSizes

func _add_text_Advice_Node(text_value : String) -> void:
	Advice.bbcode_text += text_value + "\n"

func _ready() -> void:
	BannerPosition.pressed = MobileAds.AdMobSettings.config.banner.position
	RespectSafeArea.pressed = MobileAds.AdMobSettings.config.banner.respect_safe_area

	OS.center_window()
	for banner_size in MobileAds.AdMobSettings.BANNER_SIZE:
		BannerSizes.add_item(banner_size)
	if OS.get_name() == "Android" or OS.get_name() == "iOS":
		# warning-ignore:return_value_discarded
		MobileAds.connect("consent_form_dismissed", self, "_on_MobileAds_consent_form_dismissed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("consent_form_load_failure", self, "_on_MobileAds_consent_form_load_failure")
		# warning-ignore:return_value_discarded
		MobileAds.connect("consent_info_update_failure", self, "_on_MobileAds_consent_info_update_failure")
		# warning-ignore:return_value_discarded
		MobileAds.connect("consent_info_update_success", self, "_on_MobileAds_consent_info_update_success")
		# warning-ignore:return_value_discarded
		MobileAds.connect("consent_status_changed", self, "_on_MobileAds_consent_status_changed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("banner_loaded", self, "_on_MobileAds_banner_loaded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("banner_destroyed", self, "_on_MobileAds_banner_destroyed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("banner_clicked", self, "_on_MobileAds_banner_clicked")
		# warning-ignore:return_value_discarded
		MobileAds.connect("banner_closed", self, "_on_MobileAds_banner_closed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("banner_failed_to_load", self, "_on_MobileAds_banner_failed_to_load")
		# warning-ignore:return_value_discarded
		MobileAds.connect("banner_recorded_impression", self, "_on_MobileAds_banner_recorded_impression")
		# warning-ignore:return_value_discarded
		MobileAds.connect("interstitial_loaded", self, "_on_MobileAds_interstitial_loaded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("interstitial_closed", self, "_on_MobileAds_interstitial_closed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("interstitial_clicked", self, "_on_MobileAds_interstitial_clicked")
		# warning-ignore:return_value_discarded
		MobileAds.connect("interstitial_failed_to_load", self, "_on_MobileAds_interstitial_failed_to_load")
		# warning-ignore:return_value_discarded
		MobileAds.connect("interstitial_failed_to_show", self, "_on_MobileAds_interstitial_failed_to_show")
		# warning-ignore:return_value_discarded
		MobileAds.connect("interstitial_opened", self, "_on_MobileAds_interstitial_opened")
		# warning-ignore:return_value_discarded
		MobileAds.connect("interstitial_recorded_impression", self, "_on_MobileAds_interstitial_recorded_impression")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_loaded", self, "_on_MobileAds_rewarded_ad_loaded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_closed", self, "_on_MobileAds_rewarded_ad_closed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_clicked", self, "_on_MobileAds_rewarded_ad_clicked")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_failed_to_load", self, "_on_MobileAds_rewarded_ad_failed_to_load")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_failed_to_show", self, "_on_MobileAds_rewarded_ad_failed_to_show")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_opened", self, "_on_MobileAds_rewarded_ad_opened")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_recorded_impression", self, "_on_MobileAds_rewarded_ad_recorded_impression")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_ad_earned_rewarded", self, "_on_MobileAds_rewarded_ad_earned_rewarded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_ad_loaded", self, "_on_MobileAds_rewarded_interstitial_ad_loaded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_ad_closed", self, "_on_MobileAds_rewarded_interstitial_ad_closed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_ad_clicked", self, "_on_MobileAds_rewarded_interstitial_ad_clicked")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_ad_failed_to_load", self, "_on_MobileAds_rewarded_interstitial_ad_failed_to_load")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_ad_failed_to_show", self, "_on_MobileAds_rewarded_interstitial_ad_failed_to_show")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_ad_opened", self, "_on_MobileAds_rewarded_interstitial_ad_opened")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_ad_recorded_impression", self, "_on_MobileAds_rewarded_interstitial_ad_recorded_impression")
		# warning-ignore:return_value_discarded
		MobileAds.connect("rewarded_interstitial_earned_rewarded", self, "_on_MobileAds_rewarded_interstitial_earned_rewarded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("native_loaded", self, "_on_MobileAds_native_loaded")
		# warning-ignore:return_value_discarded
		MobileAds.connect("native_destroyed", self, "_on_MobileAds_native_destroyed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("native_opened", self, "_on_MobileAds_native_opened")
		# warning-ignore:return_value_discarded
		MobileAds.connect("native_closed", self, "_on_MobileAds_native_closed")
		# warning-ignore:return_value_discarded
		MobileAds.connect("native_clicked", self, "_on_MobileAds_native_clicked")
		# warning-ignore:return_value_discarded
		MobileAds.connect("native_failed_to_load", self, "_on_MobileAds_native_failed_to_load")
		# warning-ignore:return_value_discarded
		MobileAds.connect("native_recorded_impression", self, "_on_MobileAds_native_recorded_impression")
		# warning-ignore:return_value_discarded
		MobileAds.connect("initialization_complete", self, "_on_MobileAds_initialization_complete")
	else:
		_add_text_Advice_Node("AdMob only works on Android or iOS devices!")

func _on_MobileAds_rewarded_interstitial_ad_clicked():
	_add_text_Advice_Node("Rewarded Interstitial clicked")
func _on_MobileAds_rewarded_interstitial_ad_failed_to_load(error_code):
	_add_text_Advice_Node("Rewarded Interstitial failed to load, error_code = " + str(error_code))
func _on_MobileAds_rewarded_interstitial_ad_failed_to_show(error_code):
	_add_text_Advice_Node("Rewarded Interstitial failed to show, error_code = " + str(error_code))
func _on_MobileAds_rewarded_interstitial_ad_opened():
	_add_text_Advice_Node("Rewarded Interstitial opened")
func _on_MobileAds_rewarded_interstitial_ad_recorded_impression():
	_add_text_Advice_Node("Rewarded Interstitial recorded impression")

func _on_MobileAds_rewarded_ad_clicked():
	_add_text_Advice_Node("Rewarded clicked")
func _on_MobileAds_rewarded_ad_failed_to_load(error_code):
	_add_text_Advice_Node("Rewarded failed to load, error_code = " + str(error_code))
func _on_MobileAds_rewarded_ad_failed_to_show(error_code):
	_add_text_Advice_Node("Rewarded failed to show, error_code = " + str(error_code))
func _on_MobileAds_rewarded_ad_opened():
	_add_text_Advice_Node("Rewarded opened")
func _on_MobileAds_rewarded_ad_recorded_impression():
	_add_text_Advice_Node("Rewarded recorded impression")


func _on_MobileAds_interstitial_clicked():
	_add_text_Advice_Node("Interstitial clicked")
func _on_MobileAds_interstitial_failed_to_load(error_code):
	_add_text_Advice_Node("Interstitial failed to load, error_code = " + str(error_code))
func _on_MobileAds_interstitial_failed_to_show(error_code):
	_add_text_Advice_Node("Interstitial failed to show, error_code = " + str(error_code))
func _on_MobileAds_interstitial_opened():
	_add_text_Advice_Node("Interstitial opened")
func _on_MobileAds_interstitial_recorded_impression():
	_add_text_Advice_Node("Interstitial recorded impression")

func _on_MobileAds_banner_clicked():
	_add_text_Advice_Node("Banner clicked")
func _on_MobileAds_banner_closed():
	_add_text_Advice_Node("Banner closed")
func _on_MobileAds_banner_failed_to_load(error_code):
	_add_text_Advice_Node("Banner failed to load, error_code = " + str(error_code))
func _on_MobileAds_banner_recorded_impression():
	_add_text_Advice_Node("Banner recorded impression")

func _on_MobileAds_native_opened():
	_add_text_Advice_Node("Native opened")
func _on_MobileAds_native_closed():
	_add_text_Advice_Node("Native closed")
func _on_MobileAds_native_clicked():
	_add_text_Advice_Node("Native clicked")
func _on_MobileAds_native_failed_to_load(error_code):
	_add_text_Advice_Node("Native failed to load, error_code = " + str(error_code))
func _on_MobileAds_native_recorded_impression():
	_add_text_Advice_Node("Native recorded impression")

func _on_MobileAds_initialization_complete(status : int, adapter_name : String) -> void:
	if status == MobileAds.AdMobSettings.INITIALIZATION_STATUS.READY:
		MobileAds.load_interstitial()
		MobileAds.load_rewarded()
		MobileAds.load_rewarded_interstitial()
		_add_text_Advice_Node("AdMob initialized on GDScript! With parameters:")
		_add_text_Advice_Node(JSON.print(MobileAds.config, "\t"))
		_add_text_Advice_Node("instance_id: " + str(get_instance_id()))
		EnableBanner.disabled = false
		BannerPosition.disabled = false
		RequestUserConsent.disabled = false
		ResetConsentState.disabled = false
		EnableNative.disabled = false
	else:
		_add_text_Advice_Node("AdMob not initialized, check your configuration")
	_add_text_Advice_Node("---------------------------------------------------")

func _on_MobileAds_interstitial_loaded() -> void:
	Interstitial.disabled = false
	_add_text_Advice_Node("Interstitial loaded")

func _on_MobileAds_interstitial_closed() -> void:
	MobileAds.load_interstitial()
	_add_text_Advice_Node("Interstitial closed")

func _on_Interstitial_pressed() -> void:
	MobileAds.show_interstitial()
	Interstitial.disabled = true

func reset_banner_buttons() -> void:
	DisableBanner.disabled = true
	EnableBanner.disabled = false
	ShowBanner.disabled = true
	HideBanner.disabled = true

func _on_MobileAds_banner_destroyed() -> void:
	reset_banner_buttons()
	_add_text_Advice_Node("Banner destroyed")

func _on_MobileAds_banner_loaded() -> void:
	DisableBanner.disabled = false
	EnableBanner.disabled = true
	ShowBanner.disabled = false
	HideBanner.disabled = false
	_add_text_Advice_Node("Banner loaded")
	_add_text_Advice_Node("Banner width: " + str(MobileAds.get_banner_width()))
	_add_text_Advice_Node("Banner height: " + str(MobileAds.get_banner_height()))
	_add_text_Advice_Node("Banner width in pixels: " + str(MobileAds.get_banner_width_in_pixels()))
	_add_text_Advice_Node("Banner height in pixels: " + str(MobileAds.get_banner_height_in_pixels()))

func _on_EnableBanner_pressed() -> void:
	EnableBanner.disabled = true
	MobileAds.load_banner()

func _on_DisableBanner_pressed() -> void:
	DisableBanner.disabled = true
	EnableBanner.disabled = false
	MobileAds.destroy_banner()

func _on_Rewarded_pressed() -> void:
	MobileAds.show_rewarded()
	Rewarded.disabled = true

func _on_RewardedInterstitial_pressed() -> void:
	MobileAds.show_rewarded_interstitial()
	RewardedInterstitial.disabled = true

func _on_MobileAds_rewarded_ad_loaded(ad_unit : String) -> void:
	Rewarded.disabled = false
	_add_text_Advice_Node("Rewarded ad loaded")
	
func _on_MobileAds_rewarded_ad_closed(ad_unit : String) -> void:
	MobileAds.load_rewarded()
	_add_text_Advice_Node("Rewarded ad closed")

func _on_MobileAds_rewarded_ad_earned_rewarded(ad_unit : String, currency : String, amount : int) -> void:
	Advice.bbcode_text += "EARNED " + currency + " with amount: " + str(amount) + " with id: " + ad_unit + "\n"

func _on_MobileAds_rewarded_interstitial_ad_loaded() -> void:
	RewardedInterstitial.disabled = false
	_add_text_Advice_Node("Rewarded Interstitial ad loaded")

func _on_MobileAds_rewarded_interstitial_ad_closed() -> void:
	MobileAds.load_rewarded_interstitial()
	_add_text_Advice_Node("Rewarded Interstitial ad closed")

func _on_MobileAds_rewarded_interstitial_earned_rewarded(currency : String, amount : int) -> void:
	Advice.bbcode_text += "EARNED " + currency + " with amount: " + str(amount) + "\n"


func reset_native_buttons():
	DisableNative.disabled = true
	EnableNative.disabled = false
	ShowNative.disabled = true
	HideNative.disabled = true

func _on_MobileAds_native_destroyed():
	reset_native_buttons()
	_add_text_Advice_Node("Native destroyed")

func _on_MobileAds_native_loaded():
	DisableNative.disabled = false
	EnableNative.disabled = true
	ShowNative.disabled = false
	HideNative.disabled = false
	_add_text_Advice_Node("Native loaded")
	if MobileAds._native_control != null:
		_add_text_Advice_Node("Native position: " + str(MobileAds._native_control.rect_position))
		_add_text_Advice_Node("Native size: " + str(MobileAds._native_control.rect_size))


func _on_MobileAds_consent_form_dismissed() -> void:
	_add_text_Advice_Node("Request Consent from European Users Form dismissed")

func _on_MobileAds_consent_form_load_failure(error_code, error_message) -> void:
	_add_text_Advice_Node("Request Consent from European Users load_failure: " + error_message)
	_add_text_Advice_Node("---------------------------------------------------")

func _on_MobileAds_consent_info_update_failure(_error_code : int, error_message : String) -> void:
	_add_text_Advice_Node("Request Consent from European Users update failure: " + error_message)
	_add_text_Advice_Node("---------------------------------------------------")

func _on_MobileAds_consent_info_update_success(status_message : String) -> void:
	_add_text_Advice_Node("Consent info update success: " + status_message)

func _on_MobileAds_consent_status_changed(status_message : String) -> void:
	_add_text_Advice_Node("Consent status changed: " + status_message)

func _on_BannerSizes_item_selected(index : int) -> void:
	if MobileAds.get_is_initialized():
		var item_text : String = BannerSizes.get_item_text(index)
		MobileAds.config.banner.size = item_text
		_add_text_Advice_Node("Banner Size changed:" + item_text)
		if MobileAds.get_is_banner_loaded():
			MobileAds.load_banner()

func _on_ResetConsentState_pressed() -> void:
	MobileAds.reset_consent_state(true)

func _on_RequestUserConsent_pressed() -> void:
	MobileAds.request_user_consent()


func _on_Position_pressed() -> void:
	MobileAds.config.banner.position = BannerPosition.pressed
	if MobileAds.get_is_banner_loaded():
		MobileAds.load_banner()

func _on_RespectSafeArea_pressed():
	MobileAds.config.banner.respect_safe_area = RespectSafeArea.pressed
	if MobileAds.get_is_banner_loaded():
		MobileAds.load_banner()

func _on_IsInitialized_pressed() -> void:
	_add_text_Advice_Node("Is initialized: " + str(MobileAds.get_is_initialized()))


func _on_IsBannerLoaded_pressed() -> void:
	_add_text_Advice_Node("Is Banner loaded: " + str(MobileAds.get_is_banner_loaded()))


func _on_IsInterstitialLoaded_pressed() -> void:
	_add_text_Advice_Node("Is Interstitial loaded: " + str(MobileAds.get_is_interstitial_loaded()))


func _on_IsRewardedLoaded_pressed() -> void:
	_add_text_Advice_Node("Is Rewarded loaded: " + str(MobileAds.get_is_rewarded_loaded()))


func _on_IsRewardedInterstitialLoaded_pressed() -> void:
	_add_text_Advice_Node("Is RewardedInterstitial loaded: " + str(MobileAds.get_is_rewarded_interstitial_loaded()))


func _on_IsNativeLoaded_pressed() -> void:
	_add_text_Advice_Node("Is Native loaded: " + str(MobileAds.get_is_native_loaded()))


func _on_ShowBanner_pressed() -> void:
	MobileAds.show_banner()

func _on_HideBanner_pressed() -> void:
	MobileAds.hide_banner()


func _on_EnableNative_pressed() -> void:
	EnableNative.disabled = true
	MobileAds.load_native("standard", $"%NativeReference")
	
	var visible_rect_size: Vector2 = MobileAds._native_control.get_viewport_rect().size
	
	var size: Vector2 = MobileAds._native_control.rect_size / visible_rect_size
	var pos: Vector2 = MobileAds._native_control.rect_position / visible_rect_size
	_add_text_Advice_Node("Visible rect is " + str(visible_rect_size))
	_add_text_Advice_Node("Loading Native with sizes: x %s - y %s - w %s - h %s" % [pos.x, pos.y, size.x, size.y])


func _on_DisableNative_pressed() -> void:
	DisableNative.disabled = true
	EnableNative.disabled = false
	MobileAds.destroy_native()


func _on_ShowNative_pressed() -> void:
	MobileAds.show_native()


func _on_HideNative_pressed() -> void:
	MobileAds.hide_native()
