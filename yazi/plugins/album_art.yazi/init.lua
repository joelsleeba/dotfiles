local M = {}

function M:peek()
	local cache = ya.file_cache(self)
	if not cache then
		return
	end

	if self:preload() == 1 then
		ya.image_show(cache, self.area)
		ya.preview_widgets(self, {})
	end
end

-- No need to seek single images
function M:seek(units) end

function M:preload()
	local cache = ya.file_cache(self)
	if not cache or fs.cha(cache) then
		return 1
	end

	local function get_extension(filename)
		return filename:match("^.+(%..+)$")
	end

	local extension = get_extension(tostring(self.file.url))

	if extension == ".ogg" then
		output = Command("ffmpegthumbnailer")
			:args({
				"-q 6",
				"-s 0",
				"-c jpeg",
				"-i",
				tostring(self.file.url),
				"-o /dev/stdout",
			})
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:output()
	else
		output = Command("exiftool")
			:args({
				"-b",
				"-Coverart",
				"-Picture",
				tostring(self.file.url),
			})
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:output()
	end

	if not output then
		return 0
	end

	return fs.write(cache, output.stdout) and 1 or 2
end

return M
