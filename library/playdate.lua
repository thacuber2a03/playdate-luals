---@meta

---@alias playdate.Button
---| '"a"'
---| '"b"'
---| '"up"'
---| '"down"'
---| '"left"'
---| '"right"'

---Version 2.5.0.
---
---Official reference: https://sdk.play.date
---@class _playdate
---@field public kButtonA     playdate.Button
---@field public kButtonB     playdate.Button
---@field public kButtonUp    playdate.Button
---@field public kButtonDown  playdate.Button
---@field public kButtonLeft  playdate.Button
---@field public kButtonRight playdate.Button
---@field public isSimulator number? This variable—not a function, so don’t invoke with ()—it is set to 1 when running inside of the Simulator and is `nil` otherwise.
playdate = {}

---Returns two values, the current API version of the Playdate runtime and the minimum API version supported by the runtime.
---@return number curAPI, number minAPI
---@nodiscard
function playdate.apiVersion() end

---This table contains the values in the current game’s pdxinfo file, keyed by variable name. To retrieve the version number of the game, for example, you would use `playdate.metadata.version`.
---
---Changing values in this table at runtime has no effect.
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
---@type fun()
playdate.gameWillTerminate = nil

---Called before the device goes to low-power sleep mode because of a low battery.
---
---> **Alert**
---> If your game saves its state, `playdate.gameWillTerminate()` and `playdate.deviceWillSleep()` are good opportunities to do it.
---
---@type fun()
playdate.deviceWillSleep = nil

---If your game is running on the Playdate when the device is locked, this function will be called. Implementing this function allows your game to take special action when the Playdate is locked, e.g., saving state.
---@type fun()
playdate.deviceWillLock = nil

---If your game is running on the Playdate when the device is unlocked, this function will be called.
---@type fun()
playdate.deviceDidUnlock = nil

---Called before the system pauses the game. (In the current version of Playdate OS, this only happens when the device’s Menu button is pushed.) Implementing these functions allows your game to take special action when it is paused, e.g., updating the menu image.
---@type fun()
playdate.gameWillPause = nil

---Called before the system resumes the game.
---@type fun()
playdate.gameWillResume = nil

---Returns true if `button` is currently being pressed.
---
---Button should be one of the constants:
---
---* `playdate.kButtonA`
---* `playdate.kButtonB`
---* `playdate.kButtonUp`
---* `playdate.kButtonDown`
---* `playdate.kButtonLeft`
---* `playdate.kButtonRight`
---
---Or one of the strings "a", "b", "up", "down", "left", "right".
---
---@param button playdate.Button
---@return boolean pressed
---@see playdate.buttonJustPressed
---@nodiscard
function playdate.buttonIsPressed(button) end

---Returns true for just one update cycle if button was pressed. `buttonJustPressed` will not return true again until the button is released and pressed again. This is useful for, say, a player "jump" action, so the jump action is taken only once and not on every single update.
---
---`button` should be one of the constants listed in `playdate.buttonIsPressed()`
---
---@param button playdate.Button
---@return boolean justPressed
---@see playdate.buttonIsPressed
---@nodiscard
function playdate.buttonJustPressed(button) end

---Returns a table holding booleans with the following keys:
---* `charging`: The battery is actively being charged
---* `USB`: There is a powered USB cable connected
---* `screws`: There is 5V being applied to the corner screws (via the dock, for example)
---
---@return { charging: boolean, USB: boolean, screws: boolean }
---@nodiscard
function playdate.getPowerStatus() end

---Simulator-only functionality.
playdate.simulator = {}

---
---Writes an image to a PNG file at the path specified. Only available on the Simulator.
---
---> **Note**:
---> path represents a path on your development computer, not the Playdate filesystem. It’s recommended you prefix your path with ~/ to ensure you are writing to a writeable directory, for example, ~/myImageFile.png. Please include the .png file extension in your path name. Any directories in your path must already exist on your development computer in order for the file to be written.
---
---@param image playdate.graphics.Image
---@param path string
function playdate.simulator.writeToFile(image, path) end

---Quits the Playdate Simulator app.
function playdate.simulator.exit() end

---Returns the contents of the URL `url` as a string.
---@param url string
---@return string contents
---@nodiscard
function playdate.simulator.getURL(url) end

---Clears the simulator console.
function playdate.clearConsole() end

---Sets the color of the `playdate.debugDraw()` overlay image. Values are in the range 0-1.
---@param r number
---@param g number
---@param b number
---@param a number
---@see playdate.debugDraw
function playdate.setDebugDrawColor(r, g, b, a) end

---Lets you act on keyboard keypresses when running in the Simulator ONLY. These can be useful for adding debugging functions that can be enabled via your keyboard.
---
---> **Note**:
---> It is possible test a game on Playdate hardware and trap computer keyboard keypresses if you are using the Simulator’s Control Device with Simulator option.
---
---`key` is a string containing the character pressed or released on the keyboard. Note that:
---
---* The key in question needs to have a textual representation or these functions will not be called. For instance, alphanumeric keys will call these functions; keyboard directional arrows will not.
---* If the keypress in question is already in use by the Simulator for another purpose (say, to control the d-pad or A/B buttons), these functions will not be called.
---* If key is an alphabetic character, the value will always be lowercase, even if the user deliberately typed an uppercase character.
---
---@type fun(key: string)
playdate.keyPressed = nil

---Lets you act on keyboard key releases when running in the Simulator ONLY. These can be useful for adding debugging functions that can be enabled via your keyboard.
---
---@type fun(key: string)
playdate.keyReleased = nil

---Called immediately after `playdate.update()`, any drawing performed during this callback is overlaid on the display in 50% transparent red (or another color selected with `playdate.setDebugDrawColor()`).
---
---White pixels are drawn in the debug draw color. Black pixels are transparent.
---
---@see playdate.update
---@see playdate.setDebugDrawColor
---@type fun()
playdate.debugDraw = nil