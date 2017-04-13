# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

company_info= [["Tencent","Shenzhen, China"] ,["Teambition","Shanghai, China"] ,
 ["Amazon.com","Seattle, WA, US"] ,["Pied Piper","Silicon Valley, US"] ,["MEWE","Beijing, China"] ,
 ["dribbble","remote"] ,["Alphabet Inc.","Mountain View, CA, US"] ,["Hacker News","remote"] ,
 ["Bandcamp","remote"]]

jobs_info = [["Web Developer","##"],[ "Mobile Developer","##"],["Game Developer","##"],
[["Designer","##"],"Data Analyst","##"],["Product Manager"," ##"],["Social Media Operator"," ##"],["Business Developer"," ##"]]


puts "this seed will create an admin account automatically, 10 public jobs, and 10 hidden jobs"

create_account = User.create([email: "example@gmail.com", password:"123456",password_confirmation: "123456",is_admin:"true"])

puts "Admin account created."

create_account_user = User.create([email: "123456@gmail.com", password:"123456",password_confirmation: "123456",is_admin:"false"])

puts "User account created."

create_jobs = for i in 1..30 do
	job_test=jobs_info[rand(0..4)]
	company_test=company_info[rand(0..8)]
	Job.create!([title: job_test[0],description: job_test[1], wage_upper_bound: rand(50..99)*100,
		wage_lower_bound: rand(10..49)*100, is_hidden:"false",location:company_test[1],company_name:company_test[0]])
end

puts "30 Public jobs created."

create_jobs = for i in 1..30 do
	job_test=jobs_info[rand(0..4)]
	company_test=company_info[rand(0..8)]
	Job.create!([title: job_test[0],description: job_test[1], wage_upper_bound: rand(50..99)*100,
		wage_lower_bound: rand(10..49)*100, is_hidden:"true",location:company_test[1],company_name:company_test[0]])
end

puts "30 Hidden jobs created."
