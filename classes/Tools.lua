function extended (child, parent)
    setmetatable(child,{__index = parent}) 
end
