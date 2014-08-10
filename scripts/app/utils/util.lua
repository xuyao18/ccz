function trim(str)
  return (str:gsub("^%s*(.-)%s*$", "%1"))
end