---@meta

---Extensions for the table library.

---Returns the first index of `element` in the given array-style table. If the table does not contain `element`, the function returns nil.
---@param table table
---@param element any
---@return integer? index
function table.indexOfElement(table, element) end

---Returns the size of the given table as multiple values (`arrayCount`, `hashCount`)
---@param table table
---@return integer arrayCount, integer hashCount
function table.getsize(table) end

---Returns a new Lua table with the array and hash parts preallocated to accommodate `arrayCount` and `hashCount` elements respectively.
---
---> **Note**:
---> If you can make a decent estimation of how big your table will need to be, `table.create()` can be much more efficient than the alternative, especially in loops. For example, if you know your array is always going to contain approximately ten elements, say `myArray = table.create( 10, 0 )` instead of `myArray = {}`.
---@param arrayCount integer
---@param hashCount integer
---@return table
function table.create(arrayCount, hashCount) end

---`shallowcopy` returns a shallow copy of the `source` table. If a `destination` table is provided, it copies the contents of `source` into `destination` and returns `destination`. The copy will contain references to any nested tables.
---@param source table
---@param destination table?
---@return table copy `destination` if it exists, otherwise a new table
function table.shallowcopy(source, destination) end

---`deepcopy` returns a deepcopy of the `source` table. The copy will contain copies of any nested tables.
---@param source table
---@return table copy
function table.deepcopy(source) end