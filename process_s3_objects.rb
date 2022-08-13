require "erb"
require "yaml"

PREFIX_REGEX = /\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} +\d+ /

documents = []

while line = STDIN.gets
    next if line.include? ".DS_Store"

    filepath = line.sub(PREFIX_REGEX, "").chomp
    escaped_filepath = ERB::Util.url_encode(filepath)
    url = "https://australian-cycling-history.s3.ap-southeast-2.amazonaws.com/#{escaped_filepath}"

    documents << { "name" => filepath, "url" => url }
end

STDOUT.puts documents.to_yaml
