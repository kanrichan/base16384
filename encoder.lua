bytes = require("bytes")

-- @function encode covert string to base16384
-- @param str string need to encode
-- @return base16384 string
function encode(str)
    local offset = string.len(str) % 7
    local encd = {}
    for i = 0, string.len(str) - 7, 7 do
        local sum
        local b0, b1, b2, b3, b4, b5, b6 = string.byte(str, i + 1, i + 7)
        table.insert(encd, ((b0 >> 2) & 0x3f) + 0x4e)
        table.insert(encd, ((b0 << 6) | (b1 >> 2)) & 0xff)
        table.insert(encd, (((b1 << 4) | (b2 >> 4)) & 0x3f) + 0x4e)
        table.insert(encd, ((b2 << 4) | (b3 >> 4)) & 0xff)
        table.insert(encd, (((b3 << 2) | (b4 >> 6)) & 0x3f) + 0x4e)
        table.insert(encd, ((b4 << 2) | (b5 >> 6)) & 0xff)
        table.insert(encd, (b5 & 0x3f) + 0x4e)
        table.insert(encd, b6)
    end
    local i = math.floor(string.len(str) / 7) * 7
    local b0, b1, b2, b3, b4, b5, b6 = string.byte(str, i + 1, i + 7)
    if offset == 0 then
        -- do nothing
    elseif offset == 1 then
        table.insert(encd, ((b0 >> 2) & 0x3f) + 0x4e)
        table.insert(encd, (b0 << 6) & 0xc0)
    elseif offset == 2 then
        table.insert(encd, ((b0 >> 2) & 0x3f) + 0x4e)
        table.insert(encd, ((b0 << 6) | (b1 >> 2)) & 0xff)
        table.insert(encd, ((b1 << 4) & 0x30) + 0x4e)
    elseif offset == 3 then
        table.insert(encd, ((b0 >> 2) & 0x3f) + 0x4e)
        table.insert(encd, ((b0 << 6) | (b1 >> 2)) & 0xff)
        table.insert(encd, (((b1 << 4) | (b2 >> 4)) & 0x3f) + 0x4e)
        table.insert(encd, (b2 << 4) & 0xf0)
    elseif offset == 4 then
        table.insert(encd, ((b0 >> 2) & 0x3f) + 0x4e)
        table.insert(encd, ((b0 << 6) | (b1 >> 2)) & 0xff)
        table.insert(encd, (((b1 << 4) | (b2 >> 4)) & 0x3f) + 0x4e)
        table.insert(encd, ((b2 << 4) | (b3 >> 4)) & 0xff)
        table.insert(encd, ((b3 << 2) & 0x3c) + 0x4e)
    elseif offset == 5 then
        table.insert(encd, ((b0 >> 2) & 0x3f) + 0x4e)
        table.insert(encd, ((b0 << 6) | (b1 >> 2)) & 0xff)
        table.insert(encd, (((b1 << 4) | (b2 >> 4)) & 0x3f) + 0x4e)
        table.insert(encd, ((b2 << 4) | (b3 >> 4)) & 0xff)
        table.insert(encd, (((b3 << 2) | (b4 >> 6)) & 0x3f) + 0x4e)
        table.insert(encd, (b4 << 2) & 0xfc)
    elseif offset == 6 then
        table.insert(encd, ((b0 >> 2) & 0x3f) + 0x4e)
        table.insert(encd, ((b0 << 6) | (b1 >> 2)) & 0xff)
        table.insert(encd, (((b1 << 4) | (b2 >> 4)) & 0x3f) + 0x4e)
        table.insert(encd, ((b2 << 4) | (b3 >> 4)) & 0xff)
        table.insert(encd, (((b3 << 2) | (b4 >> 6)) & 0x3f) + 0x4e)
        table.insert(encd, ((b4 << 2) | (b5 >> 6)) & 0xff)
        table.insert(encd, (b5 & 0x3f) + 0x4e)     
    end
    table.insert(encd, string.byte("="))
    table.insert(encd, offset)
    return string.char(table.unpack(encd))
end
