local M = {}

function M:peek()
	local url = ya.file_cache(self)
	if not url or not fs.cha(url) then
		url = self.file.url
	end

	ya.image_show(url, self.area)
	ya.preview_widgets(self, {})
end

-- No need to seek single images
function M:seek(units) end

function M:preload()
	local cache = ya.file_cache(self)
	if not cache or fs.cha(cache) then
		return 1
	end

	ya.dbg("before createimage")
	local createimage = Command("fontimage")
		:args({
			"-o /tmp/yazi/fontimage.png",
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

	ya.dbg("after createimage")
	-- return ya.image_precache("/tmp/yazi/fontimage.png", cache) and 1 or 2
end

return M
