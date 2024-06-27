---@meta

---A set of easing functions to aid with animation timing.
---
---> **Warning**:
---> You must import `CoreLibs/easing` to use these functions.
---
--- - `t` is elapsed time
--- - `b` is the beginning value
--- - `c` is the change (or end value - start value)
--- - `d` is the duration
--- - `a` - amplitude
--- - `p` - period parameter
--- - `s` - amount of "overshoot"
---
---See playdate.graphics.animator, playdate.timer, or playdate.frameTimer for use-cases.
---
---> **Info**:
---> [This page](https://easings.net) does a great job illustrating the shape of each easing function. (A mouseover will show an animation.)
---
---@see playdate.graphics.Animator
---@see playdate.Timer
---@see playdate.FrameTimer
playdate.easingFunctions = {}

---@alias playdate.EasingFunctionWithAmplitudeAndPeriod fun(t: number, b: number, c: number, d: number, a: number, p: number): number
---@alias playdate.EasingFunctionWithOvershoot fun(t: number, b: number, c: number, d: number, s: number): number
---@alias playdate.NormalEasingFunction fun(t: number, b: number, c: number, d: number): number
---@alias playdate.EasingFunction playdate.NormalEasingFunction | playdate.EasingFunctionWithOvershoot | playdate.EasingFunctionWithAmplitudeAndPeriod

function playdate.easingFunctions.linear(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inQuad(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outQuad(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutQuad(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInQuad(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inCubic(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outCubic(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutCubic(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInCubic(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inQuart(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outQuart(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutQuart(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInQuart(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inQuint(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outQuint(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutQuint(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInQuint(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inSine(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outSine(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutSine(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInSine(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inExpo(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outExpo(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutExpo(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInExpo(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inCirc(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outCirc(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutCirc(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInCirc(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inElastic(t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function playdate.easingFunctions.outElastic(t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function playdate.easingFunctions.inOutElastic(t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function playdate.easingFunctions.outInElastic(t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function playdate.easingFunctions.inBack(t, b, c, d, s) end ---@type playdate.EasingFunctionWithOvershoot
function playdate.easingFunctions.outBack(t, b, c, d, s) end ---@type playdate.EasingFunctionWithOvershoot
function playdate.easingFunctions.inOutBack(t, b, c, d, s) end ---@type playdate.EasingFunctionWithOvershoot
function playdate.easingFunctions.outInBack(t, b, c, d, s) end ---@type playdate.EasingFunctionWithOvershoot
function playdate.easingFunctions.outBounce(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inBounce(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.inOutBounce(t, b, c, d) end ---@type playdate.NormalEasingFunction
function playdate.easingFunctions.outInBounce(t, b, c, d) end ---@type playdate.NormalEasingFunction
