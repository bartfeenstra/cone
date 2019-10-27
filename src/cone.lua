local pl_utils = require('pl.utils')

local Cone = {}

function Cone.negotiate(header, available_values)
    pl_utils.assert_string(1, header)
    pl_utils.assert_arg(2, available_values, 'table')

    header = header:gsub('%s+', '')

    if not available_values then
        return nil
    end

    if not header then
        return available_values[1]
    end

    acceptable_values = {}
    unacceptable_values = {}
    for qualified_value in header:gmatch('([^,]+)') do
        value, quality = pl_utils.splitv(qualified_value, ';q=')
        if not quality then
            quality = 1
        else
            quality = tonumber(quality)
        end
        if quality == 0 then
            table.insert(unacceptable_values, value)
        else
            table.insert(acceptable_values, { value, quality})
        end
    end
    -- Sort the values by quality in descending order.
    table.sort(acceptable_values, function(a, b) return a[2] > b[2] end)

    for _, qualified_acceptable_value in ipairs(acceptable_values) do
        acceptable_value = qualified_acceptable_value[1]
        for _, available_value in pairs(available_values) do
            if acceptable_value == available_value then
                return acceptable_value
            end
        end
    end

    for _, available_value in ipairs(available_values) do
        if not contains(available_value, unacceptable_values) then
            return available_value
        end
    end

    return available_values[1]
end

function contains(needle, haystack)
    for _, haystack_value in pairs(haystack) do
        if haystack_value == needle then
            return true
        end
    end
    return false
end

return Cone
