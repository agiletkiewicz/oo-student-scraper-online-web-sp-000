require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    roster = Nokogiri::HTML(html)
    
    students = []
    
    roster.css("div.student-card").each do |student|
      hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      students << hash
    end
    students
  end



  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    student_page = Nokogiri::HTML(html)
    
    hash = {
      :profile_quote => student_page.css("div.profile-quote").text,
      :bio => student_page.css("div.description-holder p").text
    }
    
    if student_page.css("div.social-icon-container a").attribute("href").value.include?("twitter")
        hash[:twitter] = student_page.css("div.social-icon-container a").attribute("href").value
    end
     if student_page.css("div.social-icon-container a").attribute("href").value.include?("linkedin")
        hash[:linkedin] = student_page.css("div.social-icon-container a").attribute("href").value
    end
    
    hash
    
  end



end


        # elsif link.include?("linkedin")
        # hash[:linkedin] = link 
        # elsif link.include?("github")
        # hash[:github] = link
        # elsif link.include?("flatiron")
        # hash[:blog] = link 


# social: student_page.css("div.social-icon-container")
# social.css("a").attribute("href").value
  # :twitter=> 
  # :linkedin=> 
  # :github=> 
  # :blog=>
  # :profile_quote=> student_page.css("div.profile-quote").text
  # :bio=> student_page.css("div.description-holder p").text
  
  
  