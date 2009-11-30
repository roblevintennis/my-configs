require 'rubygems'
require 'net/ldap'
ldap = Net::LDAP.new
ldap.host = localhost
ldap.port = 389
ldap.auth "Manager", "ur_passwd"
if ldap.bind
  # authentication succeeded
else
  # authentication failed
end

Quick Example of a search against an LDAP directory:
require 'rubygems'
require 'net/ldap'

ldap = Net::LDAP.new :host => server_ip_address,
     :port => 389,
     :auth => {
	   :method => :simple,
	   :username => "cn=Manager,dc=mycompany,dc=com",
	   :password => "ur_passwd"
     }

filter = Net::LDAP::Filter.eq( "cn", "replace_with_user*" )
treebase = "dc=mycompany,dc=com"

ldap.search( :base => treebase, :filter => filter ) do |entry|
  puts "DN: #{entry.dn}"
  entry.each do |attribute, values|
    puts "   #{attribute}:"
    values.each do |value|
      puts "      --->#{value}"
    end
  end
end

p ldap.get_operation_result

