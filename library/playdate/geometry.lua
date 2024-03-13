---@meta

---The `playdate.geometry` library allows you to store and manipulate points, sizes, rectangles, line segments, 2D vectors, polygons, and affine transforms.
---
---All new geometry objects are created with a `new()` function using syntax like:
---
---> Example of creating a new rect
---```lua
---r = playdate.geometry.rect.new(x, y, width, height)
---```
---
---They can be output to the Simulator console:
---
---> Example of printing a rect to the console
---```lua
---print('rect', r)
---```
---
---And tested for equality:
---
---> Example of testing two rects for equality
---```lua
---b = r1 == r2
---```
---
---Fields on most geometry objects can be set directly:
---
---> Example of directly setting a rect’s x coordinate
---```lua
---r.x = 42.0
---```
---
---Functions for drawing `playdate.geometry` objects to screen are available in `playdate.graphics`.
---@see playdate.graphics
playdate.geometry = {}

---You can directly read or write the `width` and `height` values of a size.
playdate.geometry.size = {}

---Returns a `playdate.geometry.size`.
---@param width number
---@param height number
---@return playdate.geometry.Size size
---@see playdate.geometry.Size
function playdate.geometry.size.new(width, height) end

---You can directly read or write the `width` and `height` values of a size.
---@class playdate.geometry.Size
---@field public width number
---@field public height number
local Size = {}

---Returns a new copy of the size.
---@return playdate.geometry.Size copy
function Size:copy() end

---Returns the values `width`, `height`.
---@return number width, number height
function Size:unpack() end

---`playdate.geometry.point` implements a two-dimensional point.
---
---You can directly read or write the `x` and `y` values of a `point`.
---
playdate.geometry.point = {}

---`playdate.geometry.point` implements a two-dimensional point.
---
---You can directly read or write the `x` and `y` values of a `point`.
---
---@class playdate.geometry.Point
---@field public x number The x component of the point.
---@field public y number The y component of the point.
---@operator add(playdate.geometry.Vector2D): playdate.geometry.Point
---@operator sub(playdate.geometry.Point): playdate.geometry.Vector2D
local Point = {}

---Returns a new `playdate.geometry.point`.
---@param x number
---@param y number
---@return playdate.geometry.Point
---@see playdate.geometry.Point
function playdate.geometry.point.new(x, y) end

---Returns a new copy of the point.
---@return playdate.geometry.Point copy
function Point:copy() end

---Returns the values `x`, `y`.
---@return number x, number y
function Point:unpack() end

---Modifies the point, offsetting its values by `dx`, `dy`.
---@param dx number
---@param dy number
function Point:offset(dx, dy) end

---Returns a new point object, the given point offset by `dx`, `dy`.
---@param dx number
---@param dy number
---@return playdate.geometry.Point
function Point:offsetBy(dx, dy) end

---Returns the square of the distance to point `p`.
---@param p playdate.geometry.Point
---@return number
function Point:squaredDistanceToPoint(p) end

---Returns the distance to point `p`.
---@param p playdate.geometry.Point
---@return number
function Point:distanceToPoint(p) end

---playdate.geometry.rect implements a rectangle.
---
---You can directly read or write `x`, `y`, `width`, or `height` values to a rect.
---
---The values of `top`, `bottom`, `right`, `left`, `origin`, and `size` are read-only.
---
playdate.geometry.rect = {}

---playdate.geometry.rect implements a rectangle.
---
---You can directly read or write `x`, `y`, `width`, or `height` values to a rect.
---
---The values of `top`, `bottom`, `right`, `left`, `origin`, and `size` are read-only.
---
---@class playdate.geometry.Rect
---@field public x number
---@field public y number
---@field public width number
---@field public height number
---@field public top number The y position of the top of the rectangle.
---@field public bottom number The y position of the bottom of the rectangle.
---@field public right number The x position of the right side of the rectangle.
---@field public left number The x position of the left side of the rectangle.
---@field public origin playdate.geometry.Point The origin of the rectangle as a `playdate.geometry.point`.
---@field public size playdate.geometry.Size The size of the rectangle as a `playdate.geometry.size`.
local Rect = {}

---Returns a new `playdate.geometry.rect`.
---@param x number
---@param y number
---@param width number
---@param height number
---@return playdate.geometry.Rect
function playdate.geometry.rect.new(x, y, width, height) end

---playdate.geometry.vector2D implements a two-dimensional vector.
---
---You can directly read or write dx, or dy values to a vector2D.
---
playdate.geometry.vector2D = {}

---playdate.geometry.vector2D implements a two-dimensional vector.
---
---You can directly read or write dx, or dy values to a vector2D.
---
---@class playdate.geometry.Vector2D
---@field public dx number The x component of the vector.
---@field public dy number The y component of the vector.
local Vector2D = {}

---Returns a new `playdate geometry.vector2D`.
---@param x number
---@param y number
---@return playdate.geometry.Vector2D
function playdate.geometry.vector2D.new(x, y) end

---Returns a new `playdate.geometry.vector2D`. Angles should be specified in degrees. Zero degrees represents the top of the circle.
---@param length number
---@param angle number
---@return playdate.geometry.Vector2D
function playdate.geometry.vector2D.fromPolar(length, angle) end