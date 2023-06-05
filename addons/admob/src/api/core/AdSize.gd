# MIT License

# Copyright (c) 2023 Poing Studios

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

class_name AdSize
extends MobileSingletonPlugin


const FULL_WIDTH := -1
const PLUGIN_NAME := "PoingGodotAdMobAdSize"

static var _plugin : Object

static var BANNER := new(320, 50)
static var FULL_BANNER := new(468, 60)
static var LARGE_BANNER := new(320, 100)
static var LEADERBOARD := new(728, 90)
static var MEDIUM_RECTANGLE := new(300, 250)
static var WIDE_SKYSCRAPER := new(160, 600)

var width : int
var height : int

static func _static_init() -> void:
	_plugin = _get_plugin(PLUGIN_NAME)


func _init(width : int, height : int):
	self.width = width
	self.height = height

static func get_smart_banner_ad_size() -> AdSize:
	if _plugin:
		var ad_size_dictionary : Dictionary = _plugin.getSmartBannerAdSize()
		return _create(ad_size_dictionary)
	return AdSize.new(0, 0)

static func get_current_orientation_anchored_adaptive_banner_ad_size(width : int) -> AdSize:
	if _plugin:
		var ad_size_dictionary : Dictionary = _plugin.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width)
		return _create(ad_size_dictionary)
	return AdSize.new(0, 0)

static func get_portrait_anchored_adaptive_banner_ad_size(width : int) -> AdSize:
	if _plugin:
		var ad_size_dictionary : Dictionary = _plugin.getPortraitAnchoredAdaptiveBannerAdSize(width)
		return _create(ad_size_dictionary)
	return AdSize.new(0, 0)

static func get_landscape_anchored_adaptive_banner_ad_size(width : int) -> AdSize:
	if _plugin:
		var ad_size_dictionary : Dictionary = _plugin.getLandscapeAnchoredAdaptiveBannerAdSize(width)
		return _create(ad_size_dictionary)
	return AdSize.new(0, 0)


static func _create(ad_size_dictionary : Dictionary) -> AdSize:
	var width = ad_size_dictionary["width"]
	var height = ad_size_dictionary["height"]
	return AdSize.new(width, height)
