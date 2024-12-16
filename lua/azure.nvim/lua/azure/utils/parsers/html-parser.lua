local M = {}

function M.parse_html(html)
  html = html:gsub("<strong>(.-)</strong>", "**%1**") -- Bold
  html = html:gsub("<b>(.-)</b>", "**%1**") -- Bold
  html = html:gsub("<em>(.-)</em>", "_%1_") -- Italics
  html = html:gsub("<i>(.-)</i>", "_%1_") -- Italics
  html = html:gsub('<a href="(.-)">(.-)</a>', "[%2](%1)") -- Links
  html = html:gsub("<br ?/?>", "\n") -- Line breaks
  html = html:gsub("<p>(.-)</p>", "%1\n\n") -- Paragraphs
  html = html:gsub("<ul>", ""):gsub("</ul>", "") -- Remove unordered list tags
  html = html:gsub("<li>(.-)</li>", "- %1\n") -- List items

  -- Remove remaining HTML tags
  html = html:gsub("<[^>]+>", "")

  -- Trim leading and trailing whitespace
  html = html:gsub("^%s+", ""):gsub("%s+$", "")

  return html
end

return M
