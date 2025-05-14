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

	local fontimage = Command("fontimage")
		:args({
			"-o /tmp/fontimage.png",
			"--pixelsize 120",
			"--fontname",
			"--pixelsize 80",
			"--text '  ABCDEFGHIJKLMNOPQRSTUVWXYZ  '",
			"--text '  abcdefghijklmnopqrstuvwxyz  '",
			"--text '  0123456789.:,;(*!?') ff fl fi ffi ffl  '",
			"--text '  The quick brown fox jumps over the lazy dog.  '",
			tostring(self.file.url),
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	local output = Command("cat")
		:args({
			"/tmp/fontimage.png",
		})
		:stdout(Command.PIPED)
		:stderr(Command.PIPED)
		:output()

	if not output then
		return 0
	end

	return fs.write(cache, output.stdout) and 1 or 2
end

return M
