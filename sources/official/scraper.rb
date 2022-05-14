#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    field :name do
      node.css('.mabo0').text.tidy
    end

    field :position do
      node.css('.txt_grey').text.tidy
    end

    def empty?
      name.to_s.empty?
    end

    def node
      noko.parent
    end
  end

  class Members
    def member_items
      super.reject(&:empty?)
    end

    def member_container
      noko.css('.col-12 > img')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
