---@meta

---The Playdate audio engine provides sample playback from memory for short on-demand samples, file streaming for playing longer files (uncompressed, MP3, and ADPCM formats), and a synthesis library for generating "computer-y" sounds. Sound sources are grouped into channels, which can be panned separately, and various effects may be applied to the channels. Additionally, signals can automate various parameters of the sound objects.
playdate.sound = {}

---Returns the sample rate of the audio system (44100). The sample rate is determined by the hardware, and is not currently mutable.
---@return integer sampleRate
function playdate.sound.getSampleRate() end

---The sampleplayer class is used for playing short samples like sound effects. Audio data is loaded into memory at instantiation, so it plays with little overhead. For longer audio like background music, the fileplayer class may be more appropriate; there, audio data is streamed from disk as it’s played and only a small portion of the data is in memory at any given time.
---> **Info**: Unlike fileplayer, sampleplayer cannot play MP3 files. For a balance of good performance and small file size, we recommend encoding audio into ADPCM .wav files. 
playdate.sound.sampleplayer = {}

---Returns a new playdate.sound.sampleplayer object, with the sound data loaded in memory.
---@param path string The path to the audio file.
---@return playdate.sound.Sampleplayer? sampleplayer, string? error # The sampleplayer, and an error if it couldn't be loaded.
function playdate.sound.sampleplayer.new(path) end

---Returns a new playdate.sound.sampleplayer object for playing the given sample.
---@param sample playdate.sound.Sample The sample to use for making the sampleplayer.
---@return playdate.sound.Sampleplayer? sampleplayer, string? error # The sampleplayer, and an error if it couldn't be loaded.
function playdate.sound.sampleplayer.new(sample) end

---@class playdate.sound.Sampleplayer
local Sampleplayer = {}

---Returns a new playdate.sound.sampleplayer with the same sample, volume, and rate as the given sampleplayer.
---@return playdate.sound.Sampleplayer
function Sampleplayer:copy() end

---Starts playing the sample.
---@param repeatCount integer? Amount of times to repeat. If zero, repeats endlessly, until stopped with `playdate.sound.sampleplayer:stop()`. Defaults to 1.
---@param rate number? Rate to play the sample at. If omitted, defaults to the value previously set with `playdate.sound.sampleplayer:setRate()`.
function Sampleplayer:play(repeatCount, rate) end

---Schedules the sound for playing.
---
---Only one event can be queued at a time. If `playAt()` is called while another event is queued, it will overwrite it with the new values.
---
---@param when number When to play the sound. Relative to the audio device's time scale as returned by `playdate.sound.getCurrentTime()`.
---@param vol number? At what volume to play the sound. Defaults to the value previously set with `playdate.sound.sampleplayer:setVolume()`.
---@param rightVol number? At what volume to play the sound in the right channel. If this is present, `vol` will represent the volume of the left channel. Defaults to `vol`'s value.
---@param rate number? At what rate to play the sample. Defaults to the value previously set with `playdate.sound.sampleplayer:setRate()`.
---@return boolean wasAdded # Whether the sample was successfully added to the sound channel.
function Sampleplayer:playAt(when, vol, rightVol, rate) end

---Sets the playback volume (0.0 - 1.0) for left and right channels. If the sampleplayer is currently playing using the default volume (that is, it wasn’t triggered by `playAt()` with a volume given) it also changes the volume of the playing sample.
---
---@param left number # The volume of the left channel.
---@param right number? # The volume of the right channel. If omitted, it defaults to `left`'s value.
function Sampleplayer:setVolume(left, right) end

---Returns the playback volume for the sampleplayer.
---@return number left, number? right # A single value for mono sources, and a pair of values for stereo sources.
function Sampleplayer:getVolume() end

---`playdate.sound.sample` is an abstraction of an individual sound sample. If all you want to do is play a single sound sample, you may wish to use `playdate.sound.sampleplayer` instead. However, playdate.sound.sample exists so you can preload sounds and swap them in and out without fragmenting device memory.
playdate.sound.sample = {}

---`playdate.sound.sample` is an abstraction of an individual sound sample. If all you want to do is play a single sound sample, you may wish to use `playdate.sound.sampleplayer` instead. However, playdate.sound.sample exists so you can preload sounds and swap them in and out without fragmenting device memory.
---@class playdate.sound.Sample
local Sample = {}