debugmodule = {name: "debugmodule", uimodule: false}

#####################################################
debugmodule.initialize = () ->
    # console.log "debugmodule.initialize - nothing to do"
    return

debugmodule.modulesToDebug = 
    unbreaker: true
    # bannermodule: true
    # benchmarkmodule: true
    # blemodule: true
    # configmodule: true
    # settingspagemodule: true
    # uicommandsmodule: true

export default debugmodule
