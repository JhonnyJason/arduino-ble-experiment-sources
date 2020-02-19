bannermodule = {name: "bannermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["bannermodule"]?  then console.log "[bannermodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion

############################################################
settingsIcon = null

############################################################
settingspage = null

############################################################
bannermodule.initialize = () ->
    log "bannermodule.initialize"
    settingspage = allModules.settingspagemodule
    settingsIcon = document.getElementById("settings-icon")
    settingsIcon.addEventListener("click", settingsIconClicked)
    return

############################################################
settingsIconClicked = ->
    log "settingsIconClicked"
    settingspage.turnUp()
    return    

module.exports = bannermodule