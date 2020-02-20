configmodule = {name: "configmodule", uimodule: false}
############################################################
#region logPrintFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["configmodule"]?  then console.log "[configmodule]: " + arg
    return
#endregion

#############################################################
#region readLocalStorage
#############################################################
benchmarkRunTime = localStorage.getItem("benchmarkRunTime")
if !benchmarkRunTime then benchmarkRunTime = 10000
else benchmarkRunTime = JSON.parse(benchmarkRunTime)

#############################################################
currentDevice = localStorage.getItem("currentDevice")
if !currentDevice then currentDevice = 
    name: 'Ardidino1234#'
    dataService: "19b10001-e8f2-537e-4f6c-d104768a1214"
    dataCharacteristic: "19b10002-e8f2-537e-4f6c-d104768a1214"
else currentDevice = JSON.parse(currentDevice)

#############################################################
allDevices = localStorage.getItem("allDevices")
if !allDevices then allDevices = [currentDevice]
else allDevices = JSON.parse(allDevices)

currentDeviceIndex = localStorage.getItem("currentDeviceIndex")
if !currentDeviceIndex then currentDeviceIndex = 0
else currentDeviceIndex = JSON.parse(currentDeviceIndex)

currentDevice = allDevices[currentDeviceIndex]
#############################################################
#region printStuff
console.log "benchmarkRunTime: " + benchmarkRunTime
console.log "benchmarkRunTime type: " + typeof benchmarkRunTime
console.log "currentDevice: " + JSON.stringify(currentDevice, null, 4)
console.log "allDevices: " + JSON.stringify(allDevices, null, 4)
#endregion

#endregion

benchmark = null

#############################################################
configmodule.initialize = () ->
    log "configmodule.initialize"
    benchmark = allModules.benchmarkmodule
    return


getDeviceIndex = (device) ->
    log "getDeviceIndex"
    for item,index in allDevices
        if item == device then return index
    log "error! we did not find the device!"
    return 0
############################################################
#region exposedProperties
configmodule.currentDevice = currentDevice
configmodule.allDevices = allDevices

############################################################
configmodule.timeframeSizeMS = benchmarkRunTime

############################################################
#region bleProperties
configmodule.dataService = currentDevice.dataService
configmodule.dataCharacteristic = currentDevice.dataCharacteristic
configmodule.deviceOptions =
    # acceptAllDevices: true #only use this when we donot provide filters!
    filters: [
        services: [currentDevice.dataService]
        name: currentDevice.name
    ]
    optionalServices: [configmodule.dataService]
#endregion

#endregion

############################################################
configmodule.updateStorage = ->
    log "configmodule.updateStorage"
    localStorage.setItem("currentDevice", JSON.stringify(currentDevice))
    currentDeviceIndex = getDeviceIndex(currentDevice)
    localStorage.setItem("currentDeviceIndex", "" + currentDeviceIndex)
    localStorage.setItem("allDevices", JSON.stringify(allDevices))
    localStorage.setItem("benchmarkRunTime", "" + benchmarkRunTime)
    return

configmodule.selectDevice = (device) ->
    log "configmodule.selectDevice"
    currentDevice = device
    currentDeviceIndex = getDeviceIndex(device)
    localStorage.setItem("currentDeviceIndex", "" + currentDeviceIndex)
    localStorage.setItem("currentDevice", JSON.stringify(currentDevice))

    ############################################################
    #region passChanges
    configmodule.currentDevice = currentDevice
    configmodule.dataService = currentDevice.dataService
    configmodule.dataCharacteristic = currentDevice.dataCharacteristic
    configmodule.deviceOptions =
        # acceptAllDevices: true #only use this when we donot provide filters!
        filters: [
            services: [currentDevice.dataService]
            name: currentDevice.name
        ]
        optionalServices: [configmodule.dataService]
    #endregion
    return

configmodule.createDevice = ->
    log "configmodule.createDevice"
    device = 
        name: "new device"
        dataService: currentDevice.dataCharacteristic
        dataCharacteristic: currentDevice.dataCharacteristic        
    allDevices.push(device)
    localStorage.setItem("allDevices", JSON.stringify(allDevices))
    return device

configmodule.setBenchmarkRunTime = (runTime) ->
    log "configmodule.setBenchmarkRunTime"
    benchmarkRunTime = runTime
    localStorage.setItem("benchmarkRunTime", "" + benchmarkRunTime)
    
    ############################################################
    configmodule.timeframeSizeMS = benchmarkRunTime
    benchmark.resetTimeFraming()
    return

export default configmodule

#############################################################
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
