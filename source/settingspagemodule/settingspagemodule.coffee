settingspagemodule = {name: "settingspagemodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["settingspagemodule"]?  then console.log "[settingspagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
cfg = null
addDeviceOptionIndex = -1

############################################################
#region HTMLElements
########################################################################
settingspage = null
backFromSettingsButton = null

########################################################################
deviceSelect = null
deviceNameInput = null
deviceServiceInput = null
deviceCharacteristicInput = null
runTimeInput = null
#endregion

############################################################
settingspagemodule.initialize = () ->
    log "settingspagemodule.initialize"
    cfg = allModules.configmodule

    ########################################################################
    #region chacheUIElements
    settingspage = document.getElementById("settingspage")
    backFromSettingsButton = document.getElementById("back-from-settings-button")

    deviceSelect = document.getElementById("settings-device-select")
    deviceNameInput = document.getElementById("settings-device-name-input")
    deviceServiceInput = document.getElementById("settings-device-service-input")
    deviceCharacteristicInput = document.getElementById("settings-device-characteristic-input")
    runTimeInput = document.getElementById("settings-run-time-input")
    #endregion

    ########################################################################
    #region attachEventListeners
    backFromSettingsButton.addEventListener("click", backFromSettingsButtonClicked)
    deviceSelect.addEventListener("change", deviceSelectChanged)
    deviceNameInput.addEventListener("change", deviceNameInputChanged)
    deviceServiceInput.addEventListener("change", deviceServiceInputChanged)
    deviceCharacteristicInput.addEventListener("change", deviceCharacteristicInputChanged)
    runTimeInput.addEventListener("change", runTimeInputChanged)
    #endregion

    runTimeInput.value = cfg.timeframeSizeMS
    initializeDeviceSelect()
    return

############################################################
initializeDeviceSelect = ->
    log "initializeDeviceSelect"
    optionsHTML = getDeviceSelectOptionsHTML()
    deviceSelect.innerHTML = optionsHTML
    displayFieldsForCurrentDevice()
    return

############################################################
createAndSelectDevice = ->
    log "createAndSelectDevice"
    device = cfg.createDevice()
    chooseDevice(device)
    return

chooseDevice = (device) ->
    log "setUITODevice"
    cfg.selectDevice(device)
    initializeDeviceSelect()
    return

displayFieldsForCurrentDevice = ->
    log "displayFieldsForCurrentDevice"
    deviceNameInput.value = cfg.currentDevice.name
    deviceServiceInput.value = cfg.currentDevice.dataService
    deviceCharacteristicInput.value = cfg.currentDevice.dataCharacteristic
    return

getDeviceSelectOptionsHTML = ->
    log "createDeviceSelectOptions"
    html = ""
    for device,index in cfg.allDevices
        selected = device == cfg.currentDevice
        html += getOptionHTML(device.name, index, selected)
    
    addDeviceOptionIndex = cfg.allDevices.length
    html += getOptionHTML("add device", addDeviceOptionIndex, false)

    return html

getOptionHTML = (name, index, selected) ->
    log "getOptionHTML"
    html = '<option value="'
    html += index + '" '
    if selected then html += "selected>"
    else html += ">"
    html += name
    html += "</option>"
    return html

############################################################
#region eventListeners
backFromSettingsButtonClicked = ->
    log "backFromSettingsButtonClicked"
    settingspagemodule.turnDown()
    return

########################################################################
#region settingsEdits
deviceSelectChanged = ->
    log "deviceSelectChanged"
    value = JSON.parse(deviceSelect.value)
    if value == addDeviceOptionIndex then createAndSelectDevice()
    else chooseDevice(cfg.allDevices[value])
    return

deviceNameInputChanged = ->
    log "deviceNameInputChanged"
    value = deviceNameInput.value
    cfg.currentDevice.name = value
    initializeDeviceSelect()
    cfg.updateStorage()
    return

deviceServiceInputChanged = ->
    log "deviceServiceInputChanged"
    value = deviceServiceInput.value
    cfg.currentDevice.dataService = value
    cfg.updateStorage()
    return

deviceCharacteristicInputChanged = ->
    log "deviceCharacteristicInputChanged"
    value = deviceCharacteristicInput.value
    cfg.currentDevice.dataCharacteristic = value
    cfg.updateStorage()
    return

runTimeInputChanged = ->
    log "runTimeInputChanged"
    value = JSON.parse(runTimeInput.value)
    cfg.setBenchmarkRunTime(value)
    return

#endregion

#endregion

############################################################
#region exposedFunctions
settingspagemodule.turnDown = ->
    log "settingspagemodule.turnDown"
    settingspage.classList.remove("active")
    return

settingspagemodule.turnUp = ->
    log "settingspagemodule.turnUp"
    settingspage.classList.add("active")
    return

#endregion

module.exports = settingspagemodule