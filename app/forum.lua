module("forum", package.seeall)

require "lfs"
require "json/json"
require "forum/utils"

if forum_base ~= nil then
  lfs.chdir(forum_base)   
end

public_root = public_root or "/"
cgi = os.getenv("SCRIPT_NAME")

request = {
  post = {},
  get = parse_qs(os.getenv("QUERY_STRING"))
}

-- read POST data from STDIN
-- only read if there is any data,
-- otherwise the script hangs on some servers
if tonumber(os.getenv("CONTENT_LENGTH")) ~= nil then
  request.post = parse_qs(io.read("*all"))
end

function main()
  if get_cookie('author', '') == '' or request.get.x == "username" then
    require "forum/username"
  elseif request.get.x == "post" then
    require "forum/save_topic"
  elseif request.get.x == "topic" then
    require "forum/show_topic"
  elseif request.get.x == "reply" then
    require "forum/save_reply"
  elseif request.get.x == "sync_data" then
    require "forum/sync_data"
  elseif request.get.x == "filter" then
    require "forum/show_filtered"
  else
    require "forum/show_index"
  end
end
