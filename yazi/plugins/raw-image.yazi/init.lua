local M = {}

local function convert_to_cache(src, cache_path)
	local success = os.execute(string.format("convert '%s' -auto-orient -resize 1000x1000 '%s'", src, cache_path))
	return success == true or success == 0
end

function M:peek(job)
	local start = os.clock()
	local url = ya.file_cache(job)

	-- Convert TIFF/DNG to PNG if needed
	local cached = url:gsub("%.[^/.]+$", "") .. ".png"
	if not fs.cha(cached) then
		if not convert_to_cache(job.file.url, cached) then
			ya.preview_widget(job, ui.Text("Failed to convert image"):area(job.area))
			return
		end
	end
	url = cached
	if not url or not fs.cha(url) then
		url = job.file.url
	end

	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))

	local _, err = ya.image_show(url, job.area)
	ya.preview_widget(job, err and ui.Text(tostring(err)):area(job.area):wrap(ui.Wrap.YES))
end

function M:seek() end

function M:preload(job)
	local cache = ya.file_cache(job)

	local cached = cache:gsub("%.[^/.]+$", "") .. ".png"
	if fs.cha(cached) then
		return true
	end
	return convert_to_cache(job.file.url, cached)

	if not cache or fs.cha(cache) then
		return true
	end

	return ya.image_precache(job.file.url, cache)
end

function M:spot(job)
	local rows = self:spot_base(job)
	rows[#rows + 1] = ui.Row {}

	ya.spot_table(
		job,
		ui.Table(ya.list_merge(rows, require("file"):spot_base(job)))
			:area(ui.Pos { "center", w = 60, h = 20 })
			:row(job.skip)
			:row(1)
			:col(1)
			:col_style(th.spot.tbl_col)
			:cell_style(th.spot.tbl_cell)
			:widths { ui.Constraint.Length(14), ui.Constraint.Fill(1) }
	)
end

function M:spot_base(job)
	local info = ya.image_info(job.file.url)
	if not info then
		return {}
	end

	return {
		ui.Row({ "Image" }):style(ui.Style():fg("green")),
		ui.Row { "  Format:", tostring(info.format) },
		ui.Row { "  Size:", string.format("%dx%d", info.w, info.h) },
		ui.Row { "  Color:", tostring(info.color) },
	}
end

return M
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

	output = Command("ffmpegthumbnailer")
		:args({
			"-q 8",
			"-c jpeg",
			"-s 1080",
			"-m",
			"-i",
			tostring(self.file.url),
			"-o /dev/stdout",
			"2>/dev/null",
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
