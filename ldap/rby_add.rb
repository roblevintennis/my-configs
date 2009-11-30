require 'rubygems'
require 'net/ldap'

dn = "cn=Charlie Brown, ou=HR, dc=mycompany, dc=com"
attr = {
  :cn => "Charlie Brown",
  :objectclass => ["top", "person", "organizationalPerson", "inetOrgPerson"],
  :sn => "Brown",
  :uid => "cbrown",
  :mail => "cbrown@example.com"
}

Net::LDAP.open( :host => 'localhost',
                :port => 389, 
		:auth => {:method => :simple, :username => 'cn=Manager,dc=mycompany,dc=com', :password => 'PUT_UR_PASSWORD_HERE'} ) do |ldap|


  ldap.add( :dn => dn, :attributes => attr )
  p ldap.get_operation_result
end

