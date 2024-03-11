---@meta

---The Playdate audio engine provides sample playback from memory for short on-demand samples, file streaming for playing longer files (uncompressed, MP3, and ADPCM formats), and a synthesis library for generating "computer-y" sounds. Sound sources are grouped into channels, which can be panned separately, and various effects may be applied to the channels. Additionally, signals can automate various parameters of the sound objects.
---@class playdate.sound
playdate.sound = {}

---Returns the sample rate of the audio system (44100). The sample rate is determined by the hardware, and is not currently mutable.
---@return integer sampleRate
function playdate.sound.getSampleRate() end

---@class playdate.sound.sampleplayer
playdate.sound.sampleplayer = {}

---Returns a new playdate.sound.sampleplayer object, with the sound data loaded in memory. If the sample can’t be loaded, the function returns nil and a second value containing the error.
---@param path string
---@return playdate.sound.sampleplayer? sampleplayer, string? error
function playdate.sound.sampleplayer.new(path) end

---Returns a new playdate.sound.sampleplayer object for playing the given sample.
---@param sample playdate.sound.sample
---@return playdate.sound.sampleplayer? sampleplayer, string? error
function playdate.sound.sampleplayer.new(sample) end

---`playdate.sound.sample` is an abstraction of an individual sound sample. If all you want to do is play a single sound sample, you may wish to use `playdate.sound.sampleplayer` instead. However, playdate.sound.sample exists so you can preload sounds and swap them in and out without fragmenting device memory.
---@see playdate.sound.sampleplayer
---@class playdate.sound.sample
playdate.sound.sample = {}