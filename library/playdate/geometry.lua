---@meta

---The `playdate.geometry` library allows you to store and manipulate points, sizes, rectangles, line segments, 2D vectors, polygons, and affine transforms.
---
---All new geometry objects are created with a `new()` function using syntax like:
---
---#### Example of creating a new rect
---```lua
---r = playdate.geometry.rect.new(x, y, width, height)
---```
---
---They can be output to the Simulator console:
---
---#### Example of printing a rect to the console
---```lua
---print('rect', r)
---```
---
---And tested for equality:
---
---#### Example of testing two rects for equality
---```lua
---b = r1 == r2
---```
---
---Fields on most geometry objects can be set directly:
---
---#### Example of directly setting a rect’s x coordinate
---```lua
---r.x = 42.0
---```
---
---Functions for drawing `playdate.geometry` objects to screen are available in `playdate.graphics`.
---@see playdate.graphics
playdate.geometry = {}

---Affine transforms can be used to modify the coordinates of points, rects (as axis aligned bounding boxes (AABBs)), line segments, and polygons. The underlying matrix is of the form:
---> The matrix of an affine transform
---```
---[m11 m12 tx]
---[m21 m22 ty]
---[ 0   0  1 ]
---```
---
---You can directly read and write the `m11`, `m12`, `m21`, `m22`, `tx` and `ty` values of an `affineTransform`.
---
playdate.geometry.affineTransform = {}

---Affine transforms can be used to modify the coordinates of points, rects (as axis aligned bounding boxes (AABBs)), line segments, and polygons. The underlying matrix is of the form:
---> The matrix of an affine transform
---```
---[m11 m12 tx]
---[m21 m22 ty]
---[ 0   0  1 ]
---```
---
---You can directly read and write the `m11`, `m12`, `m21`, `m22`, `tx` and `ty` values of an `affineTransform`.
---
---@class playdate.geometry.AffineTransform
---@operator mul(playdate.geometry.AffineTransform): playdate.geometry.AffineTransform
---@operator mul(playdate.geometry.Vector2D): playdate.geometry.Vector2D
---@operator mul(playdate.geometry.Point): playdate.geometry.Point
local AffineTransform = {}

---Returns a new `playdate.geometry.affineTransform`. Use `new()` instead to get a new copy of the identity transform.
---@param m11 number
---@param m12 number
---@param m21 number
---@param m22 number
---@param tx number
---@param ty number
---@return playdate.geometry.AffineTransform transform
function playdate.geometry.affineTransform.new(m11, m12, m21, m22, tx, ty) end

---Returns a new `playdate.geometry.affineTransform` that is the identity transform.
---@return playdate.geometry.AffineTransform transform
function playdate.geometry.affineTransform.new() end

---Returns a new copy of the affine transform.
---@return playdate.geometry.AffineTransform copy
function AffineTransform:copy() end

---Mutates the caller so that it is an affine transformation matrix constructed by inverting itself.
---
---Inversion is generally used to provide reverse transformation of points within transformed objects. Given the coordinates (x, y), which have been transformed by a given matrix to new coordinates (x’, y’), transforming the coordinates (x’, y’) by the inverse matrix produces the original coordinates (x, y).
---
function AffineTransform:invert() end

---Mutates the caller, changing it to an identity transformation matrix.
function AffineTransform:reset() end

---Mutates the the caller. The affine transform `af` is concatenated to the caller.
---
---Concatenation combines two affine transformation matrices by multiplying them together. You might perform several concatenations in order to create a single affine transform that contains the cumulative effects of several transformations.
---
---Note that matrix operations are not commutative — the order in which you concatenate matrices is important. That is, the result of multiplying matrix t1 by matrix t2 does not necessarily equal the result of multiplying matrix t2 by matrix t1.
---
---@param af playdate.geometry.AffineTransform
function AffineTransform:concat(af) end

---Mutates the caller by applying a translate transformation.
---@param dx number Translation offset of the x values.
---@param dy number Translation offset of the y values.
function AffineTransform:translate(dx, dy) end

---Returns a copy of the calling affine transform with a translate transformation appended.
---@param dx number Translation offset of the x values.
---@param dy number Translation offset of the y values.
---@return playdate.geometry.AffineTransform translated
function AffineTransform:translatedBy(dx, dy) end

---Mutates the caller by applying a scaling transformation.
---@param sx number Scale factor for the x values.
---@param sy number? Scale factor for the y values. If omitted, defaults to `sx`.
function AffineTransform:scale(sx, sy) end

---Returns a copy of the calling affine transform with a scaling transformation appended.
---@param sx number Scale factor for the x values.
---@param sy number? Scale factor for the y values. If omitted, defaults to `sx`.
---@return playdate.geometry.AffineTransform scaled
function AffineTransform:scaledBy(sx, sy) end

---Mutates the caller by applying a rotation transformation. If the optional `x` and `y` arguments are given, the transform rotates around (x,y) instead of (0,0).
---@param angle number Value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation.
---@param x number?
---@param y number?
function AffineTransform:rotate(angle, x, y) end

---Mutates the caller by applying a rotation transformation.
---@param angle number Value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation.
---@param point playdate.geometry.Point If supplied, the transform is rotated around that point.
function AffineTransform:rotate(angle, point) end

---Returns a copy of the calling affine transform with a rotate transformation appended. If the optional `x` and `y` arguments are given, the transform rotates around (x,y) instead of (0,0).
---@param angle number Value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation.
---@param x number?
---@param y number?
function AffineTransform:rotatedBy(angle, x, y) end

---Returns a copy of the calling affine transform with a rotate transformation appended.
---@param angle number Value, in degrees, by which to rotate the affine transform. A positive value specifies clockwise rotation and a negative value specifies counterclockwise rotation.
---@param point playdate.geometry.Point If supplied, the transform is rotated around that point.
function AffineTransform:rotatedBy(angle, point) end

---Mutates the caller, appending a skew transformation. Values are in degrees.
---@param sx number Angle by which to skew the x values.
---@param sy number Angle by which to skew the y values.
function AffineTransform:skew(sx, sy) end

---Returns the given transform with a skew transformation appended. Values are in degrees.
---@param sx number Angle by which to skew the x values.
---@param sy number Angle by which to skew the y values.
---@return playdate.geometry.AffineTransform skewed
function AffineTransform:skewedBy(sx, sy) end

---Modifies the point `p` by applying the affine transform.
---@param p playdate.geometry.Point
---@see playdate.geometry.Point
function AffineTransform:transformPoint(p) end

---Returns a copy of point `p` with the affine transformation applied.
---@param p playdate.geometry.Point
---@return playdate.geometry.Point transformed
---@see playdate.geometry.Point
function AffineTransform:transformedPoint(p) end

---Returns two values calculated by applying the affine transform to the point (x, y).
---@param x number
---@param y number
---@return number transformedX, number transformedY
function AffineTransform:transformXY(x, y) end

---Modifies the line segment `ls` by applying the affine transform.
---@param ls playdate.geometry.LineSegment
---@see playdate.geometry.LineSegment
function AffineTransform:transformLineSegment(ls) end

---Returns a copy of line segment `ls` with the affine transformation applied.
---@param ls playdate.geometry.LineSegment
---@return playdate.geometry.LineSegment transformed
---@see playdate.geometry.LineSegment
function AffineTransform:transformedLineSegment(ls) end

---Modifies the axis aligned bounding box r (a rect) by applying the affine transform.
---@param r playdate.geometry.Rect
---@see playdate.geometry.Rect
function AffineTransform:transformAABB(r) end

---Returns a copy of rect `r` with the affine transformation applied.
---@param r playdate.geometry.Rect
---@return playdate.geometry.Rect transformed
---@see playdate.geometry.Rect
function AffineTransform:transformedAABB(r) end

---Modifies the polygon `p` by applying the affine transform.
---@param p playdate.geometry.Polygon
---@see playdate.geometry.Polygon
function AffineTransform:transformPolygon(p) end

---Returns a copy of polygon `p` with the affine transformation applied.
---@param p playdate.geometry.Polygon
---@return playdate.geometry.Polygon transformed
---@see playdate.geometry.Polygon
function AffineTransform:transformedPolygon(p) end

---@class playdate.geometry.LineSegment
local LineSegment = {}

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

---@class playdate.geometry.Polygon
local Polygon = {}

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
---@operator unm:playdate.geometry.Vector2D
---@operator add(playdate.geometry.Vector2D): playdate.geometry.Vector2D
---@operator sub(playdate.geometry.Vector2D): playdate.geometry.Vector2D
---@operator mul(number): playdate.geometry.Vector2D
---@operator mul(playdate.geometry.Vector2D): number
---@operator mul(playdate.geometry.AffineTransform): playdate.geometry.Vector2D
---@operator div(number): playdate.geometry.Vector2D
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

---Returns a new copy of the vector2D.
---@return playdate.geometry.Vector2D copy
function Vector2D:copy() end

---Returns the values `dx`, `dy`.
---@return number dx, number dy
function Vector2D:unpack() end

---Modifies the caller by adding vector `v`.
---@param v playdate.geometry.Vector2D
function Vector2D:addVector(v) end

---Modifies the caller, scaling it by amount `s`.
---@param s number
function Vector2D:scale(s) end

---Returns the given vector, scaled by `s`.
---@param s number
---@return playdate.geometry.Vector2D scaled
function Vector2D:scaledBy(s) end

---Modifies the caller by normalizing it so that its length is 1. If the vector is (0,0), the vector is unchanged.
function Vector2D:normalize() end

---Returns a new vector by normalizing the given vector.
---@return playdate.geometry.Vector2D norm
function Vector2D:normalized() end

---Returns the dot product of the caller and `v`.
---@param v playdate.geometry.Vector2D
---@return number dot
function Vector2D:dotProduct(v) end

---Returns the magnitude of the caller.
---@return number mag
function Vector2D:magnitude() end

---Returns the square of the magnitude of the caller.
---@return number magSq
function Vector2D:magnitudeSquared() end

---Modifies the caller by projecting it along the vector `v`.
---@param v playdate.geometry.Vector2D
function Vector2D:projectAlong(v) end

---Returns a new vector created by projecting the given vector along the vector v.
---@param v playdate.geometry.Vector2D
---@return playdate.geometry.Vector2D proj
function Vector2D:projectedAlong(v) end

---Returns the angle between the caller and the vector `v`.
---@param v playdate.geometry.Vector2D
---@return number angle
function Vector2D:angleBetween(v) end

---Returns a vector that is the left normal of the caller.
function Vector2D:leftNormal() end

---Returns a vector that is the right normal of the caller.
function Vector2D:rightNormal() end