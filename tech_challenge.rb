app_id = 'umxbi8zj'
api_key = '1da89d0c08354cc43301eca6bec0b25188903c41'
require 'httparty'
require 'json'
require 'csv'

# headers
headers = {"Content-Type" => "application/json","Accept" => "application/json"}

# basic auth
auth = {:username => app_id, :password => api_key}

# get first 50 users
response = HTTParty.get('https://api.intercom.io/users', :headers => headers, :basic_auth => auth)

# iterate through users and put user_ids and emails in an array
users = response["users"]
user_details = users.map {|u| [u["email"], u["user_id"]]}
userids = users.map {|u| u["id"]}

# Get the part of the string before @ in the email addresses
emails = user_details.map {|e| e[0]}
names = []
emails.each do |e|
  if e.instance_of? String
    names << e.split('@')[0]
  else
    names << ""
  end
end

ids_names = userids.zip(names)
# update users to have name values determined above
# ids_names.each do |item|
# response = HTTParty.post("https://api.intercom.io/users", :basic_auth => auth, :headers => headers, :body => {:id => item[0], :name => item[1], :custom_attributes => {:projects => 1}}.to_json)
# puts response
# end

# write array of emails and user_ids to a csv
# CSV.open("tech_challenge.csv", "a+") do |csv|
#   csv << ["email","user_id"]
# end
# user_details.each do |item|
#   CSV.open("tech_challenge.csv", "a+") do |csv|
#     csv << [item[0],item[1]]
#   end
# end

# use pagination to get the last 50 users (or at least the last page)
# response = HTTParty.get('https://api.intercom.io/users?page=2', :headers => headers, :basic_auth => auth)
# puts response

# create leads from CSV file
# CSV.foreach('tech_challenge.csv') do |row|
#   if row[0].instance_of? String
#     response = HTTParty.post("https://api.intercom.io/contacts", :basic_auth => auth, :headers => headers, :body => {:email => row[0]}.to_json)
#     puts response
#   end
# end
row = ['test@testtesttest.com','12345']
response = HTTParty.post("https://api.intercom.io/contacts", :basic_auth => auth, :headers => headers, :body => {:email => row[0], :user_id => row[1]}.to_json)
puts response
