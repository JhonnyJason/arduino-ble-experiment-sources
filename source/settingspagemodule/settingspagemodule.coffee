settingspagemodule = {name: "settingspagemodule"}
##############################################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["settingspagemodule"]?  then console.log "[settingspagemodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

settingspage = null
backFromSettingsButton = null

##############################################################################
settingspagemodule.initialize = () ->
    log "settingspagemodule.initialize"
    settingspage = document.getElementById("settingspage")
    backFromSettingsButton = document.getElementById("back-from-settings-button")
    backFromSettingsButton.addEventListener("click", backFromSettingsButtonClicked)
    return
    
backFromSettingsButtonClicked = ->
    log "backFromSettingsButtonClicked"
    settingspagemodule.turnDown()
    return

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