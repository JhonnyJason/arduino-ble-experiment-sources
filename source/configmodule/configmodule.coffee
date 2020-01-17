configmodule = {name: "configmodule", uimodule: false}

#region logPrintFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["configmodule"]?  then console.log "[configmodule]: " + arg
    return
#endregion
########################################################
configmodule.initialize = () ->
    log "configmodule.initialize"
    return    

#region arduinoDefinitions
# BLECharacteristic resultcharacteristic("19B10002-E8F2-537E-4F6C-D104768A1214",BLERead | BLENotify, SIZEARRAY, true);
# //BLEFloatCharacteristic accxcharacteristic("19B10002-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic accycharacteristic("19B10003-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic acczcharacteristic("19B10004-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic gyrxcharacteristic("19B10005-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic gyrycharacteristic("19B10006-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic gyrzcharacteristic("19B10007-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic magxcharacteristic("19B10008-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic magycharacteristic("19B10009-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEFloatCharacteristic magzcharacteristic("19B100010-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEIntCharacteristic adc0characteristic("19B100011-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# //BLEIntCharacteristic adc1characteristic("19B100012-E8F2-537E-4F6C-D104768A1214", BLERead | BLENotify);
# BLEByteCharacteristic statuscharacteristic("19B10020-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite | BLENotify);
# //BLEDescriptor acclabel(acccharacteristic.uuid(),"Accelerometer");
#endregion

#region exposedProperties
configmodule.deviceOptions =
    acceptAllDevices: true
    # filters: [
    #     services: ['19b10002-e8f2-537e-4f6c-d104768a1214']
    #     # name: 'Ardidino1234'
    # ]
#endregion

export default configmodule
