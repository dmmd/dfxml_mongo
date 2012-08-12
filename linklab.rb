require 'sinatra'

get '/' do
  ##{port}#{request.script_name}
  base = "#{request.scheme}://#{request.host}:#{request.port}"
end