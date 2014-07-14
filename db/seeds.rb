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

require 'scrape'

amc_index        = Scrape.amc_index
trailsnh_index   = Scrape.trailsnh_index
summitpost_index = Scrape.summitpost_index
wikipedia_index  = Scrape.wikipedia_index

# mountains
[
  ['Mt','Washington', 6288],
  ['Mt','Adams', 5774],
  ['Mt','Jefferson', 5712],
  ['Mt','Monroe', 5384],
  ['Mt','Madison', 5367],
  ['Mt','Lafayette', 5260],
  ['Mt','Lincoln', 5089],
  ['Mtn','South Twin', 4902, 'twinsouth'],
  ['','Carter Dome', 4832, 'carterdome'],
  ['Mt','Moosilauke', 4802],
  ['Mt','Eisenhower', 4780],
  ['Mtn','North Twin', 4761, 'twinnorth'],
  ['Mt','Carrigain', 4700],
  ['Mt','Bond', 4698],
  ['Mtn','Middle Carter', 4610, 'cartermiddle'],
  ['Mtn','West Bond', 4540, 'bondwest'],
  ['Mt','Garfield', 4500],
  ['Mt','Liberty', 4459],
  ['Mtn','South Carter', 4430, 'cartersouth'],
  ['Mtn','Wildcat', 4422, 'wildcata'],
  ['Mt','Hancock', 4420],
  ['South Peak Kinsman Mountain','South Kinsman', 4358, 'kinsmansouth'],
  ['Mt','Field', 4340],
  ['Mt','Osceola', 4340],
  ['Mt','Flume', 4328],
  ['Mtn','South Hancock', 4319, 'hancocksouth'],
  ['Mt','Pierce', 4310],
  ['North Peak Kinsman Mountain','North Kinsman', 4293, 'kinsmannorth'],
  ['Mt','Willey', 4285],
  ['','Bondcliff', 4265],
  ['Mtn','Zealand', 4260],
  ['North Peak Tripyramid Mountain','North Tripyramid', 4180, 'tripyramidnorth'],
  ['Mt','Cabot', 4170],
  ['East Peak Mount Osceola','East Osceola', 4156, 'osceolaeast'],
  ['Middle Peak Mount Tripyramid','Middle Tripyramid', 4140, 'tripyramidmiddle'],
  ['Mt','Cannon', 4100],
  ['Mt','Hale', 4054],
  ['Mt','Jackson', 4052],
  ['Mt','Tom', 4051],
  ['Wildcat Mountain, D Peak','Wildcat, D Peak', 4050, 'wildcatd'],
  ['Mt','Moriah', 4049],
  ['Mt','Passaconaway', 4043, 'passaconway'],
  ["Owl's Head (Franconia)","Owl's Head", 4025, 'owlshead'],
  ['','Galehead', 4024],
  ['Mt','Whiteface', 4020],
  ['Mt','Waumbek', 4006],
  ['Mt','Isolation', 4004],
  ['Mt','Tecumseh', 4003]
].each do |full_clue, name, elev, fourkpage|
  pp "------------"

  mountain = Mountain.find_or_create_by( name: name) 

  fourkpage ||= name.downcase
  url = "http://4000footers.com/#{fourkpage}.shtml"
  pp url
  attrs = Scrape.fourkfooters url
  if attrs.blank?
    puts "ERROR SCAPING #{name}"
    next
  end

  full_name = case full_clue
  when 'Mt'
    "Mount #{name}"
  when 'Mtn'
    "#{name} Mountain"
  when ''
    name
  else
    full_clue
  end

  attrs.merge!(
    # name: name,
    full_name: full_name,
    state: 'NH',
    elevation: elev
  )
  # pp name
  # pp attrs
  rating = attrs.delete(:rating)
  mountain.update_attributes attrs
  mountain.links.find_or_create_by site_name: '4000footers.com' do |link|
    link.url = url
    link.rating = rating
  end

  mountain.links.find_or_create_by site_name: 'Appalachian Mountain Club' do |link|
    link.url = amc_index[name][:url]
    link.rating = amc_index[name][:rating]
  end
  mountain.links.find_or_create_by site_name: 'Trails NH (hiking conditions)' do |link|
    link.url = trailsnh_index[name][:url]
  end
  mountain.links.find_or_create_by site_name: 'SummitPost.org' do |link|
    link.url = summitpost_index[name][:url] if summitpost_index[name]
  end
  mountain.links.find_or_create_by site_name: 'Wikipedia' do |link|
    link.url = wikipedia_index[name][:url]
  end
end


# hikers
[
  ['Jonathan Linowes', 'jonathan@linowes.com', '1957-07-11', 'jsl65.jpg'],
  ['Lisa Linowes', 'lisa@linowes.com', '1956-01-20', 'lisa.jpg'],
  ['Rayna Linowes', 'rayna@linowes.com', '1990-10-14', 'rayna.jpg'],
  ['Jarrett Linowes', 'jaf268@wildcats.unh.edu', '1992-04-18', 'jarrett.jpg'],
  ['Steven Linowes', 'sjlinowe@syr.edu', '1994-06-16', 'steven.jpg'],
  ['Shira Linowes', 'shira@linowes.com', '1998-12-09', 'shira.jpg'],
  ['Nikki (dog)', '', '2006-01-11']
].each do |name, email, birth, image|
  url = "/assets/#{image}"
  attrs = {name: name, email: email, profile_image_url: url, profile_chip_url: url}
  if hiker = Hiker.where(name: name).first
    hiker.update_attributes attrs
  else
    Hiker.create attrs
  end
end

# user
jon = Hiker.where( name: 'Jonathan Linowes').first
unless jon.user
  User.create( provider: 'facebook', uid: "10203290081348033", hiker: jon)
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
    fullnames = hikers.map {|first| "#{first} Linowes"}
    trip = Trip.create date: date.to_date
    trip.mountains << Mountain.where( name: mountains )
    trip.hikers << Hiker.where( name: fullnames )
  end
end

if Rails.env.development? && Hiker.count < 10
  20.times do
    hiker = FactoryGirl.create :hiker
  end
end
 