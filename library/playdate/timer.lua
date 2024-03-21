---@meta

---`playdate.timer` provides a time-based timer useful for handling animation timings, countdowns, or performing tasks after a delay. For a frame-based timer see `playdate.frameTimer`.
---
---> **Alert**:
---> You must import `CoreLibs/timer` to use these functions. It is also critical to call `playdate.timer.updateTimers()` in your `playdate.update()` function to ensure that all timers are updated every frame.
---
---@see playdate.FrameTimer
playdate.timer = {}

---@class playdate.Timer
---`playdate.timer` provides a time-based timer useful for handling animation timings, countdowns, or performing tasks after a delay. For a frame-based timer see `playdate.frameTimer`.
---
---> **Alert**:
---> You must import `CoreLibs/timer` to use these functions. It is also critical to call `playdate.timer.updateTimers()` in your `playdate.update()` function to ensure that all timers are updated every frame.
---
---@see playdate.FrameTimer
local Timer = {}

---@alias playdate.timer.TimerFinishCallback fun(timer: playdate.Timer|unknown, ...)

---This should be called from the main `playdate.update()` loop to drive the timers.
function playdate.timer.updateTimers() end

---Returns a new `playdate.timer` that will run for `duration` milliseconds. callback is a function closure that will be called when the timer is complete.
---
---Accepts a variable number of arguments that will be passed to the callback function when it is called. If arguments are not provided, the timer itself will be passed to the callback instead.
---
---By default, timers start upon instantiation. To modify the behavior of a timer, see common timer methods and properties.
---@param duration integer
---@param callback playdate.timer.TimerFinishCallback
---@param ... any
---@return playdate.Timer
---@nodiscard
function playdate.timer.new(duration, callback, ...) end

---A frame-based timer useful for handling frame-precise animation timings. For a time-based timer see `playdate.timer` or `playdate.graphics.animation.loop`.
---
---> **Alert**:
---> You must import CoreLibs/frameTimer to use these functions. It is also to critical to call playdate.frameTimer.updateTimers() in your playdate.update() function to ensure that all timers are updated every frame. 
---
---@see playdate.Timer
---@see playdate.graphics.animation.loop
playdate.frameTimer = {}

---@class playdate.FrameTimer
---A frame-based timer useful for handling frame-precise animation timings. For a time-based timer see `playdate.timer` or `playdate.graphics.animation.loop`.
---
---> **Alert**:
---> You must import CoreLibs/frameTimer to use these functions. It is also to critical to call playdate.frameTimer.updateTimers() in your playdate.update() function to ensure that all timers are updated every frame. 
---
---@see playdate.Timer
---@see playdate.graphics.animation.loop
local FrameTimer = {}

---This should be called from the main playdate.update() loop to drive the timers.
function playdate.frameTimer.updateTimers() end

---Returns a new playdate.frameTimer that will run for `duration` frames. `callback` is a function closure that will be called when the timer is complete.
---
---Accepts a variable number of arguments that will be passed to the callback function when it is called. If arguments are not provided, the timer itself will be passed to the callback instead.
---
---By default, frame timers start upon instantiation. To modify the behavior of a frame timer, see common frame timer methods and properties.
---
---@param duration integer
---@param callback playdate.timer.TimerFinishCallback
---@param ... any
---@return playdate.FrameTimer
---@nodiscard
function playdate.frameTimer.new(duration, callback, ...) end