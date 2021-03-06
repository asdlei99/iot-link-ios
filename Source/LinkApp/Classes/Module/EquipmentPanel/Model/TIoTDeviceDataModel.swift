//
//  TIoTDeviceDataModel.swift
//  LinkApp
//
//  Created by eagleychen on 2020/10/27.
//  Copyright © 2020 Tencent. All rights reserved.
//

import Foundation

@objcMembers
class TIoTDeviceDataModel: TIoTBaseModel {
    let _action = "AppGetDeviceData"
    
    var brightness: TIoTDeviceValueModel?
    var color: TIoTDeviceValueModel?
    var switch_on: TIoTDeviceValueModel?
    var light_switch: TIoTDeviceValueModel?
    var name: TIoTDeviceValueModel?
    
    //TRTC设备的属性
    var audio_call_status: TIoTDeviceValueModel?
    var video_call_status: TIoTDeviceValueModel?
    var userid: TIoTDeviceValueModel?
    
    class func modelContainerPropertyGenericClass() -> [String: AnyObject]? {
        return ["brightness": TIoTDeviceValueModel.classForCoder(),
                "color": TIoTDeviceValueModel.classForCoder(),
                "switch_on": TIoTDeviceValueModel.classForCoder(),
                "light_switch": TIoTDeviceValueModel.classForCoder(),
                "name": TIoTDeviceValueModel.classForCoder(),
                
                "audio_call_status": TIoTDeviceValueModel.classForCoder(),
                "video_call_status": TIoTDeviceValueModel.classForCoder(),
                "userid": TIoTDeviceValueModel.classForCoder()]
    }
    
    class func modelCustomPropertyMapper() -> [String : Any]? {
        return ["switch_on" :"switch"]
    }
}

@objcMembers class TIoTDeviceValueModel: TIoTBaseModel {
    var Value: String?
    var LastUpdate: String?
}
