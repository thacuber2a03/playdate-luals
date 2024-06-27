---@meta

---@alias playdate.file.FileMode unknown

---The `playdate.file` module contains functions which allow you to interact with files on Playdate’s filesystem.
---It contains the `playdate.file.file` submodule for interacting with an opened file.
---
---## About the Playdate filesystem
---
---Behind the scenes, there are two directories your game has access to: the root of your app bundle (read-only),
---and a `Data` directory unique to your game (readable and writeable) where you can store your game’s saved state or other data.
---
---From your game’s perspective, these two locations are treated as one. If you attempt to read a file, the Playdate OS will first
---look for the file in the `Data` directory, then look in the app bundle. If you attempt to create or append to a file, this file
---will be created in your game’s `Data` directory. Calling `playdate.file.listFiles()` returns a list of files and directories
---at the root of both your app bundle and your game’s `Data` directory.
---
---@see playdate.file.listFiles
---
---You are not permitted access to files outside of these two directories.
---
---@class _playdate.file
---@field public kFileRead playdate.file.FileMode
---@field public kFileWrite playdate.file.FileMode
---@field public kFileAppend playdate.file.FileMode
playdate.file = {}

---Returns a `playdate.file.File` corresponding to the opened file. mode should be one of the following:
---@see playdate.file.File
---
---- `playdate.file.kFileRead`: the file is opened for reading; the system first looks in the `/Data/<bundleid>` folder for the given file, then in the game’s pdx folder if it isn’t found.
---- `playdate.file.kFileWrite`: the file is created if it doesn’t exist, truncated to zero length if it does, then opened for writing.
---- `playdate.file.kFileAppend`: the file is created if it doesn’t exist, opened for writing, with new data written to the end of the file.
---
---If the file couldn’t be opened, a second return value indicates the error. The filesystem has a limit of 64 simultaneous open files.
---
---> **Equivalent to `playdate->file->open()` in the C API.**
---
---@param path string
---@param mode playdate.file.FileMode? If not specified, defaults to `playdate.file.kFileRead`.
---@return playdate.file.File?, string? error
---@nodiscard
function playdate.file.open(path, mode) end

---The `playdate.file` module contains functions which allow you to interact with files on Playdate’s filesystem.
---It contains the `playdate.file.file` submodule for interacting with an opened file.
---
---## About the Playdate filesystem
---
---Behind the scenes, there are two directories your game has access to: the root of your app bundle (read-only),
---and a `Data` directory unique to your game (readable and writeable) where you can store your game’s saved state or other data.
---
---From your game’s perspective, these two locations are treated as one. If you attempt to read a file, the Playdate OS will first
---look for the file in the `Data` directory, then look in the app bundle. If you attempt to create or append to a file, this file
---will be created in your game’s `Data` directory. Calling `playdate.file.listFiles()` returns a list of files and directories
---at the root of both your app bundle and your game’s `Data` directory.
---
---@see playdate.file.listFiles
---
---You are not permitted access to files outside of these two directories.
---
---@class playdate.file.File
local File = {}

---Closes the file.
---> **Equivalent to `playdate->file->close()` in the C API.**
function File:close() end

---Writes the given string to the file and returns the number of bytes written if successful, or 0 and a second return value describing the error.
---If you wish to include line termination characters (`\n`, `\r`), please include them in the string.
---@param string any
---@return integer bytesWritten, string? error
---@nodiscard
function File:write(string) end

---Flushes any buffered data written to the file to the disk.
---> **Equivalent to `playdate->file->flush()` in the C API.**
function File:flush() end

---Returns the next line of the file, delimited by either `\n` or `\r\n`.
---The returned string does not include newline characters.
---@return string line
function File:readline() end

---Returns a buffer containing up to `numberOfBytes` bytes from the file, and the number of bytes read.
---If the read failed, the function returns `nil` and a second value describing the error.
---> **Equivalent to `playdate->file->read()` in the C API.**
---@param numberOfBytes integer
---@return string? buffer, integer|string bytesOrError
---@nodiscard
function File:read(numberOfBytes) end

---Sets the file read/write position to the given byte offset.
---> **Equivalent to `playdate->file->seek()` in the C API.**
---@param offset number
function File:seek(offset) end

---Returns the current bytw offset of the read/write position in the file.
---> **Equivalent to `playdate->file->tell()` in the C API.**
---@return number byteOffset
---@nodiscard
function File:tell() end

---Returns an array containing the file names in the given directory path as strings.
---Folders are indicated by a slash (`/`) at the end of the filename.
---
---> **Note**:
---> For a game with default access permissions, `listFiles()`, `listFiles("/")`, and `listFiles(".")` should all return the same result.)
---
---> **Equivalent to `playdate->file->listfiles()` in the C API.**
---
---@param path string
---@param showHidden boolean? If set, files beginning with a period will be included; otherwise, they are skipped.
---@return string[] files
---@nodiscard
function playdate.file.listFiles(path, showHidden) end

---Returns a list of all files and folders your game has access to.
---
---> **Note**:
---> For a game with default access permissions, `listFiles()`, `listFiles("/")`, and `listFiles(".")` should all return the same result.)
---
---@return string[] files
---@nodiscard
function playdate.file.listFiles() end

---Returns true if a file exists at the given path.
---Unlike the image or sound loading functions, this function requires path to include the file extension since it cannot be inferred from context.
---Additionally, note that asset files are compiled into a format easier for Playdate to use and will have a different extension: `.wav` and `.aiff` audio files are compiled to `.pda` format,
---and `.gif` and `.png` files become `.pdi`s.
---@param path string
---@return boolean
---@nodiscard
function playdate.file.exists(path) end

---Returns true if a directory exists at the given path.
---@param path string
---@return boolean
---@nodiscard
function playdate.file.isdir(path) end

---Creates a directory at the given path, under the `/Data/<bundleid>` folder. See "About the Playdate Filesystem" for details.
---
---`playdate.file.mkdir()` will create all intermediate directories, if a succession of directories ("testdir/testdir/testdir/") is specified in path.
---
---> **Equivalent to `playdate->file->mkdir()` in the C API.**
---
---@see playdate.file
---@param path string
function playdate.file.mkdir(path) end

---Deletes the file at the given path. Returns true if successful, else false.
---@param path string
---@param recursive boolean? If set, this function will delete the directory at path and its contents, otherwise the directory must be empty to be deleted.
---@return boolean success
function playdate.file.delete(path, recursive) end

---Returns the size of the file at the given path.
---@param path string
---@return integer size
function playdate.file.getSize(path) end

---Returns the type of the file at the given path.
---@param path string
---@return string? type
function playdate.file.getType(path) end

---The modification date/time of a file.
---@class playdate.file.ModTime
---@field public year string 4-digit year (until 10,000 AD)
---@field public month integer Month of the year, where 1 is January and 12 is December
---@field public day integer Day of the month, 1 - 31
---@field public hour integer In 24-hour format: 0 - 23
---@field public minute integer 0 - 59
---@field public second integer 0 - 59 (or 60 on a leap second)

---Returns the modification date/time of the file at the given path.
---@param path string
---@return playdate.file.ModTime
function playdate.file.modtime(path) end

---Renames the file at `path`, if it exists, to the value of `newPath`.
---This can result in the file being moved to a new directory, but directories will not be created.
---> **Equivalent to `playdate->file->rename()` in the C API.**
---@param path string
---@param newPath string
---@return boolean success
function playdate.file.rename(path, newPath) end

---Loads the compiled .pdz file at the given location and returns the contents as a function.
---The `.pdz` extension on path is optional.
---@param path string
---@param env table? If specified, is used as the function’s global namespace instead of `_G`.
---@return fun(): ...unknown
function playdate.file.load(path, env) end

---Runs the pdz file at the given location. Equivalent to `playdate.file.load(path, env)()`.
---
---The `.pdz` extension on path is optional. Values returned from the pdz file are left on the stack.
---
---@param path string
---@param env table? If specified, is used as the function’s global namespace instead of `_G`.
---@return unknown ...
function playdate.file.run(path, env) end