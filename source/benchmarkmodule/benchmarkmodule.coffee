benchmarkmodule = {name: "benchmarkmodule"}

#region modulesFromTheEnvironment
cfg = null
ble = null
uiState = null
#endregion

#region HTMLElements
totalPackageNumber = null
totalBytes = null
totalAssumedConnectionInterval = null

benchmarkTable = null
#endregion

#region internalProperties
intervalID = 0

isBenchmarking = false

totalPackagesReceived = 0
totalReadBytes = 0
allReadBytes = []
totalTimeMS = 0

runIndex = 0

currentPackagesReceived = 0
currentReadBytes = []

lastTimestampMS = 0
#endregion

#region printLogFunctions
##############################################################################
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["benchmarkmodule"]?  then console.log "[benchmarkmodule]: " + arg
    return
print = (arg) -> console.log(arg)
#endregion
##############################################################################
benchmarkmodule.initialize = () ->
    log "benchmarkmodule.initialize"
    cfg = allModules.configmodule
    ble = allModules.blemodule
    uiState = allModules.uistatemodule

    totalPackageNumber = document.getElementById("total-package-number")
    totalBytes = document.getElementById("total-bytes")
    totalAssumedConnectionInterval = document.getElementById("total-assumed-connection-interval")
    benchmarkTable = document.getElementById("benchmark-table")
    
    lastTimestampMS = performance.now()
    startTimeframing()
    return

#region internalFunctions
checkTimeframe = ->
    log "checkTimeframe"

    timeMS = performance.now()
    deltaMS = timeMS - lastTimestampMS
    
    printCurrentStatsWithElapsedTime(deltaMS)
    handleBenchmarksWithElapsedTime(deltaMS)    

    resetCurrentStats()
    lastTimestampMS = timeMS

handleBenchmarksWithElapsedTime = (elapsedTimeMS) ->
    return unless isBenchmarking
    log "handleBenchmarks"
    # Here we do leave out the first frame which is not representative
    # as the the first is not a complete run
    if totalTimeMS
        if runIndex == 0 then totalTimeMS = 0    
        addCurrentDataToStats(elapsedTimeMS)
    totalTimeMS += elapsedTimeMS
    return

addCurrentDataToStats = (elapsedTimeMS)->
    log "addCurrentDataToTotalStats"
    
    totalPackagesReceived += currentPackagesReceived
    allReadBytes = allReadBytes.concat(currentReadBytes)
    totalReadBytes += currentReadBytes.length

    totalSeconds = (totalTimeMS + elapsedTimeMS) / 1000
    elapsedSeconds = elapsedTimeMS / 1000

    averagePackagesReceivedPerSecond = totalPackagesReceived / totalSeconds
    averageReadBytesPerSecond = totalReadBytes / totalSeconds
    averagePackageInterval = 1 / averagePackagesReceivedPerSecond
    averagePackageIntervalMS = averagePackageInterval * 1000

    ##write into average stats block    
    totalPackageNumber.textContent = averagePackagesReceivedPerSecond.toFixed(3)
    totalBytes.textContent = averageReadBytesPerSecond.toFixed(3)
    totalAssumedConnectionInterval.textContent = averagePackageIntervalMS.toFixed(3)

    currentPackagesReceivedPerSecond = currentPackagesReceived / elapsedSeconds
    currentReadBytesPerSecond = currentReadBytes.length / elapsedSeconds

    ##add line to table
    tableRow = createNewTableRow(runIndex, currentPackagesReceivedPerSecond, currentReadBytesPerSecond)
    currentTableBody = benchmarkTable.getElementsByTagName("tbody")[0]
    currentTableBody.prepend(tableRow)
    
    runIndex++
    return

handleData = (event) ->
    return unless isBenchmarking
    value = event.target.value;
    i = 0
    currentPackagesReceived++
    while (i < value.byteLength)
        currentReadBytes.push(value.getUint8(i))
        i++
    return

startTimeframing = ->
    log "startTimeframing"
    intervalID = setInterval(checkTimeframe, cfg.timeframeSizeMS);
    return

stopTimeframing = ->
    log "startTimeframing"
    return unless intervalID
    clearInterval(intervalID)
    return

resetCurrentStats = ->
    log "resetCurrentStats"
    currentPackagesReceived = 0
    currentReadBytes = []
    return

createNewTableRow = (index, packagesPerSecond, bytesPerSecond) ->
    log "createNewTableRow"
    tableRow = document.createElement("tr")
    html = "<td>" + index + "</td>"
    html += "<td class='packages-per-second'>" + packagesPerSecond.toFixed(3) + "</td>"
    html += "<td class='bytes-per-second'>" + bytesPerSecond.toFixed(3) + "</td>"
    tableRow.innerHTML = html
    return tableRow

resetTotalStats = ->
    log "resetTotalStats"
    totalPackagesReceived = 0
    totalReadBytes = 0
    allReadBytes = []
    totalTimeMS = 0

    runIndex = 0

    #reset average stats block
    totalPackageNumber.textContent = "-" 
    totalBytes.textContent = "-" 
    totalAssumedConnectionInterval.textContent = "-" 

    ##reset Table
    newTableBody = document.createElement("tbody")
    oldTableBody = benchmarkTable.getElementsByTagName("tbody")[0]
    benchmarkTable.replaceChild(newTableBody, oldTableBody)
    return

printCurrentStatsWithElapsedTime = (elapsedTime) ->
    message = " - \n"
    message += " elapsedTime: " + elapsedTime + "ms\n"
    message += " packagesReceived: " + currentPackagesReceived + "\n"
    message += " readBytes: " + currentReadBytes.length + "\n - "
    log message
    return
#endregion

#region exposedFunctions
benchmarkmodule.start = ->
    log "benchmarkmodule.start"
    
    resetTotalStats()
    resetCurrentStats()

    isBenchmarking = true
    uiState.setBenchmarking()

    await ble.startData()
    ble.onData(handleData)
    return

benchmarkmodule.stop = ->
    log "benchmarkmodule.stop"

    isBenchmarking = false
    uiState.setConnected()

    await ble.stopData()
    return


#endregion

module.exports = benchmarkmodule