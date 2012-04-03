require "acts_as_authoritah/version"

module ActsAsAuthoritah
  module Matchers
  end
end

require "acts_as_authoritah/access_rule"
require "acts_as_authoritah/access_control_list"
require "acts_as_authoritah/identifier_parser"

require 'spreadsheet'
Spreadsheet.client_encoding = 'UTF-8'

require "acts_as_authoritah/spreadsheets/access_rights_mapper"
require "acts_as_authoritah/spreadsheets/spreadsheet_wrapper"
require "acts_as_authoritah/spreadsheets/spreadsheet_reader"
require "acts_as_authoritah/spreadsheets/spreadsheet_header_parser"
require "acts_as_authoritah/spreadsheets/spreadsheet_row_parser"
