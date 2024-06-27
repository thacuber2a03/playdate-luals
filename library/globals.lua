---@meta

---The Playdate runtime uses `import` instead of the standard Lua `require` function, and it behaves a little differently:
---All files imported from main.lua (and imported from files imported from main.lua, and so on) are compiled into
---a single pdz file, and `import` runs the code from the file only once.
---A second `import` call from **anywhere** in the pdz will do nothing.
---@param moduleName string
---@return unknown
function import(moduleName) end

---This function does not exist in the Playdate's API.
---@deprecated
function require(modname) end

---This function does not exist in the Playdate's API.
---@deprecated
function load(chunk, chunkname, mode, env) end

---This function does not exist in the Playdate's API.
---@deprecated
function loadfile(filename, mode, env) end

---This function does not exist in the Playdate's API.
---@deprecated
function loadstring(text, chunkname) end

---@class kTextAlignment
---@field public left unknown
---@field public center unknown
---@field public right unknown
kTextAlignment = {}

---Represents a class.
---
---> **Alert**:
---> This class only exists to fill a hole in the API.
---> It is not part of the official Playdate API, and will likely never be.
---
---> **Warning**:
---> Only extend this class if you're making a class using the `class` function.
---
---@see class
---@class playdate.Class
---@field public super playdate.Class The parent of this class.
local Class = {}

---Callback to initialize a class once it has been instanciated.
---
---> **Warning**:
---> Only extend `playdate.Class` if you're making a class using `class`.
---
---@see class
---@type fun(self: playdate.Class, ...)
Class.init = nil

---Starts the creation of a class. `.extends()` must be called right after this function.
---
---> **Warning**:
---> You must import `CoreLibs/object` to use this function.
---> Only create classes through this function.
---> Extend `playdate.Class` or any other class
---> that extends that class after you're done to have all its methods.
---> For example, to set the type of a new class:
---> ```lua
---> ---@class ClassName : playdate.Class
---> ClassName = {}
---> class("ClassName").extends()
---> ```
---> To set the type of a class that extends something other than Object:
---> ```lua
---> ---@class ClassName : ParentClass
---> ClassName = {}
---> class("ClassName").extends(ParentClass)
---> ```
---
---@param className string
---@param properties table<string, any>?
---@param namespace table?
---@return playdate.ClassSpec classSpec
function class(className, properties, namespace) end

---Represents a class currently being made.
---
---> **Alert**:
---> This class only exists to fill a hole in the API.
---> It is not part of the official Playdate API, and will likely never be.
---
---> **Warning**:
---> Never extend this class. Only extend `playdate.Class` if you're making a class using `class`.
---
---@see playdate.Class
---@see class
---@class playdate.ClassSpec
local ClassSpec = {}

---Specify the class to extend. Pass nothing to extend Object.
---@param parent playdate.Class?
function ClassSpec.extends(parent) end