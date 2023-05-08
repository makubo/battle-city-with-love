-- Thanx https://stackoverflow.com/a/20067270
function removeDuplicateTableValues(table)
    local hash = {}
    local res = {}

    for _,v in ipairs(table) do
       if (not hash[v]) then
           res[#res+1] = v
           hash[v] = true
       end
    end

    return res
end
