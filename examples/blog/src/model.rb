require 'rubygems'
require_gem 'facets', '= 1.4.5'
require '/home/manveru/prog/projects/nitroproject/glycerin'
require 'og'

class Comment
  attr_accessor :text, String
  attr_accessor :time, Time
  attr_accessor :author_name, String
  attr_accessor :author_email, String
end

class Entry
  attr_accessor :title, String
  attr_accessor :text, String
  attr_accessor :time, Time
  has_many Comment
end