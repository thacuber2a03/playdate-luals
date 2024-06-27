---@meta

---@enum playdate.graphics.Color

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

---Pushes the current graphics state to the context stack and creates a new context.
---
---> **Alert**:
---> If you draw into an image context with color set to `playdate.graphics.kColorClear`, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image.
---
---> **Note**:
---> `playdate.graphics.lockFocus(image)` will reroute drawing into an image, without saving the overall graphics context. 
---
---#### Example: Using contexts to reset drawing modifiers
---```lua
---local gfx = playdate.graphics
---
---gfx.setLineWidth(1) -- Original line width
---gfx.setColor(gfx.kColorBlack) -- Original color
---
---gfx.pushContext() -- Creating a new graphics context
---gfx.setLineWidth(5) -- Setting the line width to 5
---gfx.setColor(gfx.kColorWhite) -- Setting the draw color to white
---gfx.drawCircleAtPoint(200, 120, 10) -- Only thing you're trying to modify
---gfx.popContext() -- All modifications done during the context get removed
---
----- Unaffected by modifiers and gets drawn with the original color/line width
---gfx.drawLine(0, 120, 400, 120)
---```
---
---@see playdate.graphics.lockFocus
function playdate.graphics.pushContext() end

---Pushes the current graphics state to the context stack and creates a new context, applying the drawing functions to the image instead of the screen buffer.
---
---> **Alert**:
---> If you draw into an image context with color set to `playdate.graphics.kColorClear`, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image.
---
---> **Note**:
---> `playdate.graphics.lockFocus(image)` will reroute drawing into an image, without saving the overall graphics context. 
---
---#### Example: Using contexts to draw something to an image
---```lua
----- You can copy and paste this example directly as your main.lua file to see it in action
---import "CoreLibs/graphics"
---
----- In this example, we'll be drawing a smiley face to an image, which saves our
----- drawing, makes it easier to draw, and helps improve performance since we don't
----- have to redraw each element separately each time
---local gfx = playdate.graphics
---
---local smileWidth, smileHeight = 36, 36
---local smileImage = gfx.image.new(smileWidth, smileHeight)
----- Pushing our new image to the graphics context, so everything
----- drawn will be drawn directly to the image
---gfx.pushContext(smileImage)
---    -- => Indentation not required, but helps organize things!
---    gfx.setColor(gfx.kColorWhite)
---    -- Coordinates are based on the image being drawn into
---    -- (e.g. (x=0, y=0) refers to the top left of the image)
---    gfx.fillCircleInRect(0, 0, smileWidth, smileHeight)
---    gfx.setColor(gfx.kColorBlack)
---    -- Drawing the eyes
---    gfx.fillCircleAtPoint(11, 13, 3)
---    gfx.fillCircleAtPoint(25, 13, 3)
---    -- Drawing the mouth
---    gfx.setLineWidth(3)
---    gfx.drawArc(smileWidth/2, smileHeight/2, 11, 115, 245)
---    -- Drawing the outline
---    gfx.setLineWidth(2)
---    gfx.setStrokeLocation(gfx.kStrokeInside)
---    gfx.drawCircleInRect(0, 0, smileWidth, smileHeight)
----- Popping context to stop drawing to image
---gfx.popContext()
---
---function playdate.update()
---    -- Draw smile in the center of the screen
---    local screenWidth, screenHeight = playdate.display.getSize()
---    smileImage:drawAnchored(screenWidth/2, screenHeight/2, 0.5, 0.5)
---end
---
----- Works really well with sprites! Just set the sprite image to your new image
---local smileSprite = gfx.sprite.new(smileImage)
---smileSprite:add()
---```
---
---@param image playdate.graphics.Image
---@see playdate.graphics.Image
function playdate.graphics.pushContext(image) end

---Pops a graphics context off the context stack and restores its state.
function playdate.graphics.popContext() end

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

---Sets and gets the current drawing color for primitives.
---
---`color` should be one of the constants:
---* `playdate.graphics.kColorBlack`
---* `playdate.graphics.kColorWhite`
---* `playdate.graphics.kColorClear`
---* `playdate.graphics.kColorXOR`
---
---This color applies to drawing primitive shapes such as lines and rectangles, not bitmap images.
---
---> **Alert**:
---> `setColor()` and `setPattern()` / `setDitherPattern()` are mutually exclusive. Setting a color will overwrite a pattern, and vice versa. 
---@param color playdate.graphics.Color
function playdate.graphics.setColor(color) end

---@enum playdate.graphics.image.DitherType

---@enum playdate.graphics.image.FlipState

---PNG and GIF images in the source folder are compiled into a Playdate-specific format by pdc, and can be loaded into Lua with `playdate.graphics.image.new(path)`. Playdate images are 1 bit per pixel, with an optional alpha channel.
---@class playdate.graphics.image
---@field public kDitherTypeFloydSteinberg playdate.graphics.image.DitherType
---@field public kDitherTypeBurkes         playdate.graphics.image.DitherType
---@field public kDitherTypeAtkinson       playdate.graphics.image.DitherType
---@field public kImageUnflipped           playdate.graphics.image.FlipState
---@field public kImageFlippedX            playdate.graphics.image.FlipState
---@field public kImageFlippedY            playdate.graphics.image.FlipState
---@field public kImageFlippedXY           playdate.graphics.image.FlipState
playdate.graphics.image = {}

---PNG and GIF images in the source folder are compiled into a Playdate-specific format by pdc, and can be loaded into Lua with `playdate.graphics.image.new(path)`. Playdate images are 1 bit per pixel, with an optional alpha channel.
---@class playdate.graphics.Image
local Image = {} 

---Draws the image with its upper-left corner at location (`x`, `y`)
---@param x number
---@param y number
---@param flip playdate.graphics.image.FlipState?
---@param sourceRect playdate.geometry.Rect?
function Image:draw(x, y, flip, sourceRect) end

---Draws the image with its upper-left corner at location `p`.
---@param p playdate.geometry.Point
---@param flip playdate.graphics.image.FlipState?
---@param sourceRect playdate.geometry.Rect?
function Image:draw(p, flip, sourceRect) end

---@class playdate.graphics.Tilemap
local Tilemap = {}

---Creates a new blank image of the given width and height. The image can be drawn on using `playdate.graphics.pushContext()` or `playdate.graphics.lockFocus()`.
---@param width number
---@param height number
---@param bgColor playdate.graphics.Color? One of the color constants as used in `playdate.graphics.setColor()`, defaulting to `kColorClear`.
---@return playdate.graphics.Image
---@see playdate.graphics.setColor
---@nodiscard
function playdate.graphics.image.new(width, height, bgColor) end

---Returns a `playdate.graphics.image` object from the data at `path`. If there is no file at `path`, the function returns nil and a second value describing the error.
---@param path string
---@return playdate.graphics.Image? image, string error
---@nodiscard
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

---`lockFocus()` routes all drawing to the given playdate.graphics.image. playdate.graphics.unlockFocus() returns drawing to the frame buffer.
---
---> **Alert**:
---> If you draw into an image with color set to `playdate.graphics.kColorClear`, those drawn pixels will be set to transparent. When you later draw the image into the framebuffer, those pixels will not be rendered, i.e., will act as transparent pixels in the image.
---
---> **Note**:
---> `playdate.graphics.pushContext(image)` will also allow offscreen drawing into an image, with the additional benefit of being able to save and restore the graphics state. 
---
---#### Example: Drawing into multiple images with `lockFocus`
---```lua
----- If you're drawing into multiple different images, using lockFocus might be easier (and
----- slightly faster performance-wise) than having to repeatedly call pushContext/popContext
---
---local tinyCircle = gfx.image.new(10, 10)
---local smallCircle = gfx.image.new(20, 20)
---local mediumCircle = gfx.image.new(30, 30)
---local largeCircle = gfx.image.new(40, 40)
---
---gfx.lockFocus(tinyCircle) -- draw into tinyCircle image
----- Drawing coordinates are relative to the image, so (0, 0) is the top left of the image
---gfx.fillCircleInRect(0, 0, tinyCircle:getSize())
---gfx.lockFocus(smallCircle) -- draw into smallCircle image
---gfx.fillCircleInRect(0, 0, smallCircle:getSize())
---gfx.lockFocus(mediumCircle) -- draw into mediumCircle image
---gfx.fillCircleInRect(0, 0, mediumCircle:getSize())
---gfx.lockFocus(largeCircle) -- draw into largeCircle image
---gfx.fillCircleInRect(0, 0, largeCircle:getSize())
---gfx.unlockFocus() -- unlock focus to bring drawing back to frame buffer
---```
---
---@param image playdate.graphics.Image
function playdate.graphics.lockFocus(image) end

---Reroutes drawing to the frame buffer.
---
---#### Example: Drawing into multiple images with `lockFocus`
---```lua
----- If you're drawing into multiple different images, using lockFocus might be easier (and
----- slightly faster performance-wise) than having to repeatedly call pushContext/popContext
---
---local tinyCircle = gfx.image.new(10, 10)
---local smallCircle = gfx.image.new(20, 20)
---local mediumCircle = gfx.image.new(30, 30)
---local largeCircle = gfx.image.new(40, 40)
---
---gfx.lockFocus(tinyCircle) -- draw into tinyCircle image
----- Drawing coordinates are relative to the image, so (0, 0) is the top left of the image
---gfx.fillCircleInRect(0, 0, tinyCircle:getSize())
---gfx.lockFocus(smallCircle) -- draw into smallCircle image
---gfx.fillCircleInRect(0, 0, smallCircle:getSize())
---gfx.lockFocus(mediumCircle) -- draw into mediumCircle image
---gfx.fillCircleInRect(0, 0, mediumCircle:getSize())
---gfx.lockFocus(largeCircle) -- draw into largeCircle image
---gfx.fillCircleInRect(0, 0, largeCircle:getSize())
---gfx.unlockFocus() -- unlock focus to bring drawing back to frame buffer
---```
function playdate.graphics.unlockFocus() end

---Sprites are graphic objects that can be used to represent moving entities in your games, like the player, or the enemies that chase after your player. Sprites animate efficiently, and offer collision detection and a host of other built-in functionality. (If you want to create an environment for your sprites to move around in, consider using tilemaps or drawing a background image.)
---To have access to all the sprite functionality described below, be sure to import "CoreLibs/sprites" at the top of your source file.
---
---The simplest way to create a sprite is using sprite.new(image):
---
---#### Creating a standalone sprite
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
---#### Creating a sprite subclass
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
---#### Creating a sprite subclass with a custom initializer
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
playdate.graphics.sprite = {}

---Sprites are graphic objects that can be used to represent moving entities in your games, like the player, or the enemies that chase after your player. Sprites animate efficiently, and offer collision detection and a host of other built-in functionality. (If you want to create an environment for your sprites to move around in, consider using tilemaps or drawing a background image.)
---To have access to all the sprite functionality described below, be sure to import "CoreLibs/sprites" at the top of your source file.
---
---The simplest way to create a sprite is using sprite.new(image):
---
---### Creating a standalone sprite
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
---#### Creating a sprite subclass
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
---#### Creating a sprite subclass with a custom initializer
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
---@class playdate.graphics.Sprite
local Sprite = {}

---This class method (note the "." syntax rather than ":") returns a new sprite object.
---
---> **Alert**:
---> To see your sprite onscreen, you will need to call :add() on your sprite to add it to the display list. 
---
---@return playdate.graphics.Sprite
---@nodiscard
function playdate.graphics.sprite.new() end

---This class method (note the "." syntax rather than ":") returns a new sprite object from a previously loaded image.
---
---> **Alert**:
---> To see your sprite onscreen, you will need to call :add() on your sprite to add it to the display list. 
---
---@param image playdate.graphics.Image
---@return playdate.graphics.Sprite sprite
---@nodiscard
function playdate.graphics.sprite.new(image) end

---This class method (note the "." syntax rather than ":") returns a new sprite object from a previously loaded tilemap.
---
---> **Alert**:
---> To see your sprite onscreen, you will need to call :add() on your sprite to add it to the display list. 
---
---@param tilemap playdate.graphics.Tilemap
---@return playdate.graphics.Sprite sprite
---@nodiscard
function playdate.graphics.sprite.new(tilemap) end

--- This class method (note the "." syntax rather than ":") calls the `update()` function on every sprite in the global sprite list and redraws all of the dirty rects.
---
---> **Alert**:
---> You will generally want to call playdate.graphics.sprite.update() once in your playdate.update() method, to ensure that your sprites are updated and drawn during every frame. Failure to do so may mean your sprites will not appear onscreen.
---
---> **Warning**:
---> Be careful not confuse sprite.update() with sprite:update(): the former updates all sprites; the latter updates just the sprite being invoked.
---
function playdate.graphics.sprite.update() end

---> **Alert**:
---> You must import CoreLibs/sprites to use this function.
---
---A convenience function for drawing a background image behind your sprites.
---
---`drawCallback` is a routine you specify that implements your background drawing. The callback should be a function taking the arguments `x, y, width, height`, where `x`, `y`, `width`, `height` specify the region (in screen coordinates, not world coordinates) of the background region that needs to be updated.
---
---> **Info**:
---> Some implementation details: `setBackgroundDrawingCallback()` creates a screen-sized sprite with a z-index set to the lowest possible value so it will draw behind other sprites, and adds the sprite to the display list so that it is drawn in the current scene. The background sprite ignores the `drawOffset`, and will not be automatically redrawn when the draw offset changes; use `playdate.graphics.sprite.redrawBackground()` if necessary in this case. `drawCallback` will be called from the newly-created background sprite’s `playdate.graphics.sprite:draw()` callback function and is where you should do your background drawing. This function returns the newly created `playdate.graphics.sprite`.
---@see playdate.graphics.sprite.redrawBackground
---
---For additional background, here is the implementation of `setBackgroundDrawingCallback()` in the Playdate SDK. (This does not reflect how you should use `setBackgroundDrawingCallback()` in your game. For an example of game usage, see [A Basic Playdate Game in Lua](https://sdk.play.date/#basic-playdate-game).)
---```lua
---function playdate.graphics.sprite.setBackgroundDrawingCallback(drawCallback)
---    local bgsprite = gfx.sprite.new()
---    bgsprite:setSize(playdate.display.getSize())
---    bgsprite:setCenter(0, 0)
---    bgsprite:moveTo(0, 0)
---    bgsprite:setZIndex(-32768)
---    bgsprite:setIgnoresDrawOffset(true)
---    bgsprite:setUpdatesEnabled(false)
---    bgsprite.draw = function(s, x, y, w, h)
---            drawCallback(x, y, w, h)
---    end
---    bgsprite:add()
---    return bgsprite
---end
---```
---@param drawCallback fun(x: number, y: number, width: number, height: number)
---@return playdate.graphics.Sprite bgsprite # The background sprite itself.
function playdate.graphics.sprite.setBackgroundDrawingCallback(drawCallback) end

---> **Alert**: You must import CoreLibs/sprites to use this function.
---
---Marks the background sprite dirty, forcing the drawing callback to be run when playdate.graphics.sprite.update() is called.
---
function playdate.graphics.sprite.redrawBackground() end

---Called by `playdate.graphics.sprite.update()` (note the syntactic difference between the period and the colon) before sprites are drawn. Implementing `:update()` gives you the opportunity to perform some code upon every frame.
---> **Note**:
---> The update method will only be called on sprites that have had `add()` called on them, and have their updates enabled.
---
---> **Warning**
---> Be careful not confuse sprite:update() with sprite.update(): the latter updates all sprites; the former updates just the sprite being invoked.
---
function Sprite:update() end

---Adds the given sprite to the display list, so that it is drawn in the current scene.
function Sprite:add() end

---Sets the sprite’s drawing center as a fraction (ranging from 0.0 to 1.0) of the height and width. Default is 0.5, 0.5 (the center of the sprite). This means that when you call `:moveTo(x, y)`, the center of your sprite will be positioned at x, y. If you want x and y to represent the upper left corner of your sprite, specify the center as 0, 0.
---@param x number The x percentage of the center.
---@param y number The y percentage of the center.
function Sprite:setCenter(x, y) end

---`setBounds()` positions and sizes the sprite, used for drawing and for calculating dirty rects. upper-left-x and upper-left-y are relative to the overall display coordinate system.
---(If an image is attached to the sprite, the size will be defined by that image, and not by the width and height parameters passed in to `setBounds()`.)
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

---Moves the sprite by `x`, `y` pixels relative to its current position.
---@param x number
---@param y number
function Sprite:moveBy(x, y) end

---If the sprite doesn’t have an image, the sprite’s draw function is called as needed to update the display. The rect passed in is the current dirty rect being updated by the display list. The rect coordinates passed in are relative to the sprite itself (i.e. x = 0, y = 0 refers to the top left corner of the sprite). Note that the callback is only called when the sprite is on screen and has a size specified via `sprite:setSize()` or `sprite:setBounds()`.
---
---#### Example: Overriding the sprite draw method
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

---Animation utilities.
playdate.graphics.animation = {}

---`playdate.graphics.animation.loop` helps keep track of animation frames, especially for frames in an `playdate.graphics.imagetable`. For a more general timer see `playdate.timer` or `playdate.frameTimer`.
---
---> **Warning**:
---> You must import `CoreLibs/animation` to use these functions.
---
---@see playdate.graphics.Imagetable
---@see playdate.Timer
---@see playdate.FrameTimer
playdate.graphics.animation.loop = {}

----@class playdate.graphics.AnimationLoop
local AnimationLoop = {}

---Animators are lightweight objects that keep track of animation progress. They can animate between two numbers, two points, along a line segment, arc, or polygon, or along a compound path made up of all three.
---
---Usage is simple: create a new Animator, query for its current value when you need to update your animation, and optionally call `animator:ended()` to see if the animation is complete.
---
---> **Info**: Example code at `<Playdate SDK>/Examples/Single File Examples/animator.lua`.
---
---> **Warning**: You must import `CoreLibs/animator` to use these functions.
---
playdate.graphics.animator = {}

---Animators are lightweight objects that keep track of animation progress. They can animate between two numbers, two points, along a line segment, arc, or polygon, or along a compound path made up of all three.
---
---Usage is simple: create a new Animator, query for its current value when you need to update your animation, and optionally call `animator:ended()` to see if the animation is complete.
---
---> **Info**: Example code at `<Playdate SDK>/Examples/Single File Examples/animator.lua`.
---
---> **Warning**: You must import `CoreLibs/animator` to use these functions.
---
---@see playdate.graphics.Animator.ended
---@class playdate.graphics.Animator
local Animator = {}

---Animates between two number or `playdate.geometry.point` values.
---
---`duration` is the total time of the animation in milliseconds.
---
---`startValue` and `endValue` should be either numbers or `playdate.geometry.point`s.
---
---`easingFunction`, if supplied, should be a value from `playdate.easingFunctions`. If your easing function requires additional variables `s`, `a`, or `p`, set them on the animator directly after creation. For example:
---
---```lua
---local a = playdate.graphics.animator.new(1000, 0, 100, playdate.easingFunctions.inBack)
---a.s = 1.9
---```
---
---`startTimeOffset`, if supplied, will shift the start time of the animation by the specified number of milliseconds. (If positive, the animation will be delayed. If negative, the animation will effectively have started before the moment the animator is instantiated.)
---
---#### Example: Using an animator to animate movement
---
---```lua
----- You can copy and paste this example directly as your main.lua file to see it in action
---import "CoreLibs/graphics"
---import "CoreLibs/animator"
---
----- We'll be demonstrating how to use an animator to animate a square moving across the screen
---local square = playdate.graphics.image.new(20, 20, playdate.graphics.kColorBlack)
---
----- 1000ms, or 1 second
---local animationDuration = 1000
----- We're animating from the left to the right of the screen
---local startX, endX = -20, 400
----- Setting an easing function to get a nice, smooth movement
---local easingFunction = playdate.easingFunctions.inOutCubic
---local animator = playdate.graphics.animator.new(animationDuration, startX, endX, easingFunction)
---animator.repeatCount = -1 -- Make animator repeat forever
---
---function playdate.update()
---    -- Clear the screen
---    playdate.graphics.clear()
---
---    -- By using :currentValue() as the x value, the square follows along with the animation
---    square:draw(animator:currentValue(), 120)
---end
---```
---
---@see playdate.geometry.Point
---@see playdate.easingFunctions
function playdate.graphics.animator.new(duration, startValue, endValue, easingFunction, startTimeOffset) end

---Creates a new Animator that will animate along the provided `playdate.geometry.lineSegment`.
---
---#### Example: Using an animator to animate along a line
---
---```lua
----- You can copy and paste this example directly as your main.lua file to see it in action
---import "CoreLibs/graphics"
---import "CoreLibs/animator"
---
----- We'll be demonstrating how to use an animator to animate a square moving across the screen
---local square = playdate.graphics.image.new(20, 20, playdate.graphics.kColorBlack)
---
----- 1000ms, or 1 second
---local animationDuration = 1000
----- We're animating from the top left to the bottom right of the screen
---local line = playdate.geometry.lineSegment.new(0, 0, 400, 240)
---local animator = playdate.graphics.animator.new(animationDuration, line)
---
---function playdate.update()
---    -- Clear the screen
---    playdate.graphics.clear()
---
---    -- We can use :currentValue() directly, as it returns a point
---    square:draw(animator:currentValue())
---end
---```
---
---@param duration number Duration of the animation, in milliseconds
---@param lineSegment playdate.geometry.LineSegment
---@param easingFunction playdate.EasingFunction? Defaults to `playdate.easingFunctions.linear`.
---@param startTimeOffset number Shifts the start time of the animation by the specified number of milliseconds. (If positive, the animation will be delayed. If negative, the animation will effectively have started before the moment the animator is instantiated.)
---@return playdate.graphics.Animator animator
---@see playdate.graphics.animator.new
function playdate.graphics.animator.new(duration, lineSegment, easingFunction, startTimeOffset) end

---Returns true if the animation is completed. Only returns true if this function or `currentValue()` has been called since the animation ended in order to allow animations to fully finish before true is returned.
---
---@return boolean ended
---@see playdate.graphics.Animator.currentValue
---@nodiscard
function Animator:ended() end

---Returns the current value of the animation, which will be either a number or a `playdate.geometry.point`, depending on the type of animator.
---@return number | playdate.geometry.Point currentValue
---@see playdate.geometry.Point
function Animator:currentValue() end