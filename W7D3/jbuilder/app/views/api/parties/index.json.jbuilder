json.array! @parties do |party|
  json.partial! "party", party: party
end
