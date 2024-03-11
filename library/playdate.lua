---@meta

---Version 2.4.1
---Official reference: https://sdk.play.date
---@class playdate
playdate = {}

---Returns two values, the current API version of the Playdate runtime and the minimum API version supported by the runtime.
---@return number curAPI, number minAPI
function playdate.apiVersion() end

---The `playdate.metadata` table contains the values in the current game’s pdxinfo file, keyed by variable name. To retrieve the version number of the game, for example, you would use `playdate.metadata.version`.
---
---Changing values in this table at run time has no effect.
---
---@type table<string, string>
playdate.metadata = {}

---Implement this callback and Playdate OS will call it once per frame. This is the place to put the main update-and-draw code for your game. Playdate will attempt to call this function by default 30 times per second; that value can be changed by calling `playdate.display.setRefreshRate()`.
---@see playdate.display.setRefreshRate
---@type fun()
playdate.update = nil

---Suspends callbacks to `playdate.update()` for the specified number of milliseconds.
---
---> **Note**
---> `playdate.wait()` is ideal for pausing game execution to, for example, show a message to the player. Because `.update()` will not be called, the screen will freeze during `.wait()`. Audio will continue to play. Animation during this wait period is possible, but you will need to explicitly call `playdate.display.flush()` once per frame.
---
---> **Warning**
---> While timers should pause during `playdate.wait()` (assuming `playdate.timer.updateTimers()` and `playdate.frameTimer.updateTimers()` are invoked during `playdate.update()`), animators will not pause during `playdate.wait()`. Be sure to account for this in your code.
---@param milliseconds integer
---@see playdate.update
function playdate.wait(milliseconds) end

---Stops per-frame callbacks to `playdate.update()`. Useful in conjunction with `playdate.display.flush()` if your program only does things in response to button presses.
function playdate.stop() end

---Resumes per-frame callbacks to `playdate.update()`
function playdate.start() end

---Called when the player chooses to exit the game via the System Menu or Menu button.
---@alias playdate.gameWillTerminate fun()

---Called before the device goes to low-power sleep mode because of a low battery.
---
---> **Alert**
---> If your game saves its state, `playdate.gameWillTerminate()` and `playdate.deviceWillSleep()` are good opportunities to do it.
---
---@alias playdate.deviceWillSleep fun()

---If your game is running on the Playdate when the device is locked, this function will be called. Implementing this function allows your game to take special action when the Playdate is locked, e.g., saving state.
---@alias playdate.deviceWillLock fun()

---If your game is running on the Playdate when the device is unlocked, this function will be called.
---@alias playdate.deviceDidUnlock fun()

---Called before the system pauses the game. (In the current version of Playdate OS, this only happens when the device’s Menu button is pushed.) Implementing these functions allows your game to take special action when it is paused, e.g., updating the menu image.
---@alias playdate.gameWillPause fun()

---Called before the system resumes the game.
---@alias playdate.gameWillResume fun()