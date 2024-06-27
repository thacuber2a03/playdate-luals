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

local e = playdate.easingFunctions
function e.linear      (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inQuad      (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outQuad     (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutQuad   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInQuad   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inCubic     (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outCubic    (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutCubic  (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInCubic  (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inQuart     (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outQuart    (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutQuart  (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInQuart  (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inQuint     (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outQuint    (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutQuint  (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInQuint  (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inSine      (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outSine     (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutSine   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInSine   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inExpo      (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outExpo     (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutExpo   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInExpo   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inCirc      (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outCirc     (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutCirc   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInCirc   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inElastic   (t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function e.outElastic  (t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function e.inOutElastic(t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function e.outInElastic(t, b, c, d, a, p) end ---@type playdate.EasingFunctionWithAmplitudeAndPeriod
function e.inBack      (t, b, c, d, s)    end ---@type playdate.EasingFunctionWithOvershoot
function e.outBack     (t, b, c, d, s)    end ---@type playdate.EasingFunctionWithOvershoot
function e.inOutBack   (t, b, c, d, s)    end ---@type playdate.EasingFunctionWithOvershoot
function e.outInBack   (t, b, c, d, s)    end ---@type playdate.EasingFunctionWithOvershoot
function e.outBounce   (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inBounce    (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.inOutBounce (t, b, c, d)       end ---@type playdate.NormalEasingFunction
function e.outInBounce (t, b, c, d)       end ---@type playdate.NormalEasingFunction
