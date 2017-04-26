# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company_info= [["Tencent","Shenzhen, China","hr@qq.com"] ,["Teambition","Shanghai, China","hr@tb.com"] ,
 ["Amazon.com","Seattle, WA, US","hr@amazon.com"] ,["Pied Piper","Silicon Valley, US","hr@pp.com"] ,["MEWE","Beijing, China","hr@mewe.com"] ,
 ["dribbble","remote","hr@dribbble.com"] ,["Alphabet Inc.","Mountain View, CA, US","hr@alphabet.com"] ,["Hacker News","remote","hr@hackernews.com"] ,
 ["Bandcamp","remote","hr@bandcamp.com"]]

jobs_info = [["Web Developer","#"],["Mobile Developer","#"],["Game Developer","#"],
["Designer","#"],["Data Analyst","#"],["Product Manager","#"],["Social Media Operator","#"],["Business Developer","#"]]

puts "this seed will create an admin account automatically, 30 public jobs, and 10 hidden jobs"

create_account = User.create([email: "example@gmail.com", password:"123456",password_confirmation: "123456",is_admin:"true"])
puts "Admin account created."

create_jobs = for i in 1..30 do
	job_test=jobs_info[rand(0..4)]
	company_test=company_info[rand(0..8)]
	Job.create!([title: job_test[0],description: job_test[1], wage_upper_bound: rand(100..200)*100,
		wage_lower_bound: rand(70..99)*100, is_hidden:"false",location:company_test[1],company_name:company_test[0],contact_email:company_test[2]])
end

puts "30 public jobs created."


create_jobs = for i in 1..10 do
	job_test=jobs_info[rand(0..4)]
	company_test=company_info[rand(0..8)]
  Job.create!([title: job_test[0],description: job_test[1], wage_upper_bound: rand(100..200)*100,
		wage_lower_bound: rand(70..99)*100, is_hidden:"true",location:company_test[1],company_name:company_test[0],contact_email:company_test[2]])
end

puts "10 hidden jobs created."
