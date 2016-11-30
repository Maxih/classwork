
@guests = @guests.select do |guest|
  guest.age.between?(40, 50)
end

json.array! @guests do |guest|
  json.partial! 'guest', guest: guest
end
