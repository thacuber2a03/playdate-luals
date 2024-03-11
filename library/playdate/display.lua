---@meta

---The `playdate.display` module contains functions pertaining to Playdate’s screen. Functions related to drawing can be found in `playdate.graphics`.
---@see playdate.graphics
---@class playdate.display
playdate.display = {}

---Sets the desired refresh rate in frames per second. The default is 30 fps, which is a recommended figure that balances animation smoothness with performance and power considerations. Maximum is 50 fps.
---
---If `rate` is 0, `playdate.update()` is called as soon as possible. Since the display refreshes line-by-line, and unchanged lines aren’t sent to the display, the update cycle will be faster than 30 times a second but at an indeterminate rate. `playdate.getCurrentTimeMilliseconds()` should then be used as a steady time base.
---
---> Equivalent to playdate->display->setRefreshRate() in the C API.
---
---@param rate number
function playdate.display.setRefreshRate(rate) end

---Returns the width of the Playdate display, taking the current display scale into account; e.g., if the scale is 2, the values returned will be based off of a 200 x 120-pixel screen rather than the native 400 x 240. (See `playdate.display.setScale()`.)
---
---> Equivalent to `playdate->display->getWidth()` in the C API.
---
---@return number width The width of the display.
---@see playdate.display.setScale
function playdate.display.getWidth() end

---Returns the height of the Playdate display, taking the current display scale into account; e.g., if the scale is 2, the values returned will be based off of a 200 x 120-pixel screen rather than the native 400 x 240. (See `playdate.display.setScale()`.)
---
---> Equivalent to `playdate->display->getHeight()` in the C API.
---
---@return number height The height of the display.
---@see playdate.display.setScale
function playdate.display.getHeight() end

---Sets the display scale factor. Valid values for scale are 1, 2, 4, and 8.
---
---The top-left corner of the frame buffer is scaled up to fill the display; e.g., if the scale is set to 4, the pixels in rectangle [0,100] x [0,60] are drawn on the screen as 4 x 4 squares.
---
---> Equivalent to playdate->display->setScale() in the C API.
---
---@param scale 1 | 2 | 4 | 8 # The scale factor.
function playdate.display.setScale(scale) end