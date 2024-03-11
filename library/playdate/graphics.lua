---@meta

---The `playdate.graphics` module contains functions related to displaying information on the device screen.
---
---## Conventions
---* The Playdate coordinate system has its origin point (0, 0) at the upper left. The x-axis increases to the right, and the y-axis increases downward.
---* (0, 0) represents the upper-left corner of the first pixel onscreen. The center of that pixel is (0.5, 0.5).
---* In the Playdate SDK, angle values should always be provided in degrees, and angle values returned will be in degrees. Not radians. (This is in contrast to Lua’s built-in math libraries, which use radians.)
---
---@class playdate.graphics
---@field public kColorClear playdate.graphics.Color
---@field public kColorBlack playdate.graphics.Color
---@field public kColorWhite playdate.graphics.Color
---@field public kColorXOR   playdate.graphics.Color
playdate.graphics = {}

---Draws the rect at (`x`, `y`) of the given `width` and `height`.
---@param x number
---@param y number
---@param width number
---@param height number
function playdate.graphics.fillRect(x, y, width, height) end

---Draws the filled rectangle `r`.
---@param r playdate.geometry.Rect
---@see playdate.geometry.Rect
function playdate.graphics.fillRect(r) end

---@enum playdate.graphics.Color

---Sets and gets the current drawing color for primitives.
---
---`color` should be one of the constants:
---* playdate.graphics.kColorBlack
---* playdate.graphics.kColorWhite
---* playdate.graphics.kColorClear
---* playdate.graphics.kColorXOR
---
---This color applies to drawing primitive shapes such as lines and rectangles, not bitmap images.
---
---> **Alert**:
---> setColor() and setPattern() / setDitherPattern() are mutually exclusive. Setting a color will overwrite a pattern, and vice versa. 
---@param color playdate.graphics.Color
function playdate.graphics.setColor(color) end

---@enum playdate.graphics.image.DitherType

---PNG and GIF images in the source folder are compiled into a Playdate-specific format by pdc, and can be loaded into Lua with `playdate.graphics.image.new(path)`. Playdate images are 1 bit per pixel, with an optional alpha channel.
---@class playdate.graphics.image
---@field public kDitherTypeFloidSteinberg playdate.graphics.image.DitherType
---@field public kDitherTypeBurkes         playdate.graphics.image.DitherType
---@field public kDitherTypeAtkinson       playdate.graphics.image.DitherType
playdate.graphics.image = {}

---@class playdate.graphics.Image
local Image = {} 

---@class playdate.graphics.Tilemap
local Tilemap = {}

---Creates a new blank image of the given width and height. The image can be drawn on using `playdate.graphics.pushContext()` or `playdate.graphics.lockFocus()`. The optional bgcolor argument is one of the color constants as used in playdate.graphics.setColor()`, defaulting to `kColorClear`.
---@param width number
---@param height number
---@param bgColor playdate.graphics.Color?
---@return playdate.graphics.Image
---@see playdate.graphics.setColor
function playdate.graphics.image.new(width, height, bgColor) end

---Returns a `playdate.graphics.image` object from the data at `path`. If there is no file at `path`, the function returns nil and a second value describing the error.
---@param path string
---@return playdate.graphics.Image? image, string error
function playdate.graphics.image.new(path) end

---Sets the pattern used for drawing to a dithered pattern. If the current drawing color is white, the pattern is white pixels on a transparent background and (due to a bug) the alpha value is inverted: 1.0 is transparent and 0 is opaque. Otherwise, the pattern is black pixels on a transparent background and alpha 0 is transparent while 1.0 is opaque.
---
---The optional ditherType argument is a dither type as used in playdate.graphics.image:blurredImage(), and should be an ordered dither type; i.e., line, screen, or Bayer.
---
---> **Alert**:
---> The error-diffusing dither types Floyd-Steinberg (`kDitherTypeFloydSteinberg`), Burkes (`kDitherTypeBurkes`), and Atkinson (`kDitherTypeAtkinson`) are allowed but produce very unpredictable results here. 
---
---@param alpha number
---@param ditherType playdate.graphics.image.DitherType?
function playdate.graphics.setDitherPattern(alpha, ditherType) end

---Sprites are graphic objects that can be used to represent moving entities in your games, like the player, or the enemies that chase after your player. Sprites animate efficiently, and offer collision detection and a host of other built-in functionality. (If you want to create an environment for your sprites to move around in, consider using tilemaps or drawing a background image.)
---To have access to all the sprite functionality described below, be sure to import "CoreLibs/sprites" at the top of your source file.
---
---The simplest way to create a sprite is using sprite.new(image):
---
---> Creating a standalone sprite
---```lua
---import "CoreLibs/sprites"
---
---local image = playdate.graphics.image.new("coin")
---local sprite = playdate.graphics.sprite.new(image)
---sprite:moveTo(100, 100)
---sprite:add()
---```
---
---If you want to use an object-oriented approach, you can also subclass sprites and create instance of those subclasses.
---
---> Creating a sprite subclass
---```lua
---import "CoreLibs/sprites"
---
---class('MySprite').extends(playdate.graphics.sprite)
---
---local sprite = MySprite()
---local image = playdate.graphics.image.new("coin")
---sprite:setImage(image)
---sprite:moveTo(100, 100)
---sprite:add()
---```
---
---Or with a custom initializer:
---
---> Creating a sprite subclass with a custom initializer
---```lua
---import "CoreLibs/sprites"
---
---class('MySprite').extends(playdate.graphics.sprite)
---
---local image = playdate.graphics.image.new("coin")
---
---function MySprite:init(x, y)
---MySprite.super.init(self) -- this is critical
---    self:setImage(image)
---    self:moveTo(x, y)
---end
---
---local sprite = MySprite(100, 100)
---sprite:add()
---```
---
---@see playdate.graphics.image
---@see class
---@class playdate.graphics.sprite : playdate.Class
playdate.graphics.sprite = {}

---@see playdate.graphics.sprite
---@class playdate.graphics.Sprite
local Sprite = {}

---This class method (note the "." syntax rather than ":") returns a new sprite object. A previously-loaded image or tilemap object can be optionally passed-in.
---
---> **Alert**:
---> To see your sprite onscreen, you will need to call :add() on your sprite to add it to the display list. 
---
---@return playdate.graphics.Sprite
---@overload fun(image: playdate.graphics.Image): playdate.graphics.Sprite
---@overload fun(tilemap: playdate.graphics.Tilemap): playdate.graphics.Sprite
function playdate.graphics.sprite.new() end

--- This class method (note the "." syntax rather than ":") calls the `update()` function on every sprite in the global sprite list and redraws all of the dirty rects.
---> **Alert**:
---> You will generally want to call playdate.graphics.sprite.update() once in your playdate.update() method, to ensure that your sprites are updated and drawn during every frame. Failure to do so may mean your sprites will not appear onscreen.
---
---> **Warning**:
---> Be careful not confuse sprite.update() with sprite:update(): the former updates all sprites; the latter updates just the sprite being invoked.
---
function playdate.graphics.sprite.update() end

---Called by `playdate.graphics.sprite.update()` (note the syntactic difference between the period and the colon) before sprites are drawn. Implementing `:update()` gives you the opportunity to perform some code upon every frame.
---> **Note**:
---> The update method will only be called on sprites that have had `add()` called on them, and have their updates enabled.
---
---> **Warning**
---> Be careful not confuse sprite:update() with sprite.update(): the latter updates all sprites; the former updates just the sprite being invoked.
---
function Sprite:update() end

---Adds the given sprite to the display list, so that it is drawn in the current scene.
---@param self playdate.graphics.Sprite
function Sprite:add() end

---Sets the sprite’s drawing center as a fraction (ranging from 0.0 to 1.0) of the height and width. Default is 0.5, 0.5 (the center of the sprite). This means that when you call `:moveTo(x, y)`, the center of your sprite will be positioned at x, y. If you want x and y to represent the upper left corner of your sprite, specify the center as 0, 0.
---@param x number The x percentage of the center.
---@param y number The y percentage of the center.
function Sprite:setCenter(x, y) end

---`setBounds()` positions and sizes the sprite, used for drawing and for calculating dirty rects. upper-left-x and upper-left-y are relative to the overall display coordinate system. (If an image is attached to the sprite, the size will be defined by that image, and not by the width and height parameters passed in to `setBounds()`.)
---> **Note**:
---> In `setBounds()`, x and y always correspond to the upper left corner of the sprite, regardless of how a sprite’s center is defined. This makes it different from sprite:moveTo(), where x and y honor the sprite’s defined center (by default, at a point 50% along the sprite’s width and height.) 
---@param upperLeftX number
---@param upperLeftY number
---@param width number
---@param height number
function Sprite:setBounds(upperLeftX, upperLeftY, width, height) end

---Moves the sprite and resets the bounds based on the image dimensions and center.
---@param x number
---@param y number
function Sprite:moveTo(x, y) end

---If the sprite doesn’t have an image, the sprite’s draw function is called as needed to update the display. The rect passed in is the current dirty rect being updated by the display list. The rect coordinates passed in are relative to the sprite itself (i.e. x = 0, y = 0 refers to the top left corner of the sprite). Note that the callback is only called when the sprite is on screen and has a size specified via `sprite:setSize()` or `sprite:setBounds()`.
---> Example: Overriding the sprite draw method
---```lua
----- You can copy and paste this example directly as your main.lua file to see it in action
---import "CoreLibs/graphics"
---import "CoreLibs/sprites"
---
---local mySprite = playdate.graphics.sprite.new()
---mySprite:moveTo(200, 120)
----- You MUST set a size first for anything to show up (either directly or by setting an image)
---mySprite:setSize(30, 30)
---mySprite:add()
---
----- The x, y, width, and height arguments refer to the dirty rect being updated, NOT the sprite dimensions
---function mySprite:draw(x, y, width, height)
---    -- Custom draw methods gives you more flexibility over what's drawn, but with the added benefits of sprites
---
---    -- Here we're just modulating the circle radius over time
---    local spriteWidth, spriteHeight = self:getSize()
---    if not self.radius or self.radius > spriteWidth then
---        self.radius = 0
---    end
---    self.radius += 1
---
---    -- Drawing coordinates are relative to the sprite (e.g. (0, 0) is the top left of the sprite)
---    playdate.graphics.fillCircleAtPoint(spriteWidth / 2, spriteHeight / 2, self.radius)
---end
---
---function playdate.update()
---    -- Your custom draw method gets called here, but only if the sprite is dirty
---    playdate.graphics.sprite.update()
---
---    -- You might need to manually mark it dirty
---    mySprite:markDirty()
---end
---```
---@param x number
---@param y number
---@param width number
---@param height number
function Sprite:draw(x, y, width, height) end

---Marks the rect defined by the sprite’s current bounds as needing a redraw.
function Sprite:markDirty() end