# # users
# admin = 'jonathan@linowes.com'
# unless User.where(email: admin).present?
#   pswd = ENV['PASSWORD']
#   if pswd.present?
#     User.create email: admin, password: pswd
#   else
#     puts "Warning: cannot create admin user without PASSWORD=secret rake db:seed"
#   end
# end

# mountains
[
  ['Washington', 6288],
  ['Adams', 5774],
  ['Jefferson', 5712],
  ['Monroe', 5384],
  ['Madison', 5367],
  ['Lafayette', 5260],
  ['Lincoln', 5089],
  ['South Twin', 4902],
  ['Carter Dome', 4832],
  ['Moosilauke', 4802],
  ['Eisenhower', 4780],
  ['North Twin', 4761],
  ['Carrigain', 4700],
  ['Bond', 4698],
  ['Middle Carter', 4610],
  ['West Bond', 4540],
  ['Garfield', 4500],
  ['Liberty', 4459],
  ['South Carter', 4430],
  ['Wildcat', 4422],
  ['Hancock', 4420],
  ['South Kinsman', 4358],
  ['Field', 4340],
  ['Osceola', 4340],
  ['Flume', 4328],
  ['South Hancock', 4319],
  ['Pierce', 4310],
  ['North Kinsman', 4293],
  ['Willey', 4285],
  ['Bondcliff', 4265],
  ['Zealand', 4260],
  ['North Tripyramid', 4180],
  ['Cabot', 4170],
  ['East Osceola', 4156],
  ['Middle Tripyramid', 4140],
  ['Cannon', 4100],
  ['Hale', 4054],
  ['Jackson', 4052],
  ['Tom', 4051, 'Mt. Tom'],
  ['Wildcat, D Peak', 4050],
  ['Moriah', 4049],
  ['Passaconaway', 4043],
  ["Owl's Head", 4025],
  ['Galehead', 4024],
  ['Whiteface', 4020],
  ['Waumbek', 4006],
  ['Isolation', 4004],
  ['Tecumseh', 4003]
].each do |name, elev, fullname|
  attrs = {name: name, elevation: elev}
  if mountain = Mountain.where(name: name).first
    mountain.update_attributes attrs
  else
    Mountain.create attrs
  end
end


# hikers
[
  ['Jonathan Linowes', 'jonathan@linwoes.com', '1957-07-11'],
  ['Lisa Linowes', 'lisa@linowes.com', '1956-01-20'],
  ['Rayna Linowes', 'rayna@linowes.com', '1990-10-14'],
  ['Jarrett Linowes', 'jaf268@wildcats.unh.edu', '1992-04-18'],
  ['Steven Linowes', 'sjlinowe@syr.edu', '1994-06-16'],
  ['Shira Linowes', 'shira@linowes.com', '1998-12-09'],
  ['Nikki (dog)', '', '2006-01-11']
].each do |name, email, birth|
  attrs = {name: name, email: email}
  if hiker = Hiker.where(name: name.split(' ').first).first
    hiker.update_attributes attrs
  else
    Hiker.create attrs
  end
end




# trips
[
  ['2014-06-08', ['East Osceola', 'Osceola'], ['Jonathan', 'Lisa', 'Shira']],
  ['2014-05-25', 'Waumbek', ['Jonathan', 'Lisa', 'Jarrett', 'Steven']],
  ['2013-06-16', 'Washington', ['Jonathan', 'Lisa', 'Rayna', 'Jarrett', 'Steven', 'Shira']],
  ['2013-06-03', ['Eisenhower', 'Pierce'], ['Jonathan', 'Lisa', 'Rayna', 'Steven']],
  ['2012-07-29', 'Cannon', ['Lisa', 'Jarrett', 'Steven']],
  ['2012-07-15', ['Hancock', 'South Hancock'], ['Jonathan', 'Lisa', 'Jarrett', 'Shira', 'Nikki (dog)']],
  ['2012-05-19', 'Monroe', ['Jonathan', 'Lisa', 'Rayna', 'Nikki (dog)']],
  ['2012-03-12', 'Tom', ['Jonathan', 'Lisa']],
  ['2011-06-19', 'Moosilauke', ['Jonathan', 'Lisa']],
  ['2010-07-11', 'Cannon', ['Jonathan', 'Lisa', 'Rayna', 'Jarrett', 'Steven', 'Shira']],
  ['2010-07-01', 'Moosilauke', ['Jonathan', 'Lisa']],
  ['2004-10-01', 'Lafayette', ['Jonathan', 'Lisa', 'Rayna', 'Jarrett', 'Steven']]
].each do |date, mountains, hikers|
  # NOTE: Not updating, only creating
  unless Trip.where(date: date).present?
    trip = Trip.create date: date.to_date
    trip.mountains << Mountain.where( name: mountains )
    trip.hikers << Hiker.where( name: hikers )
  end
end

if Rails.env.development?
  20.times do
    hiker = FactoryGirl.create :hiker
  end
end
 