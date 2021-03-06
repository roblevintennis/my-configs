ldap OpenLDap on Mac Notes
---------------------------

OpenLDap Setup -- November 17, 2009

I used the following guides:

<http://openldap.darwinports.com/><br />

Nice Ruby/LDap Tut:  
<http://geekdamana.blogspot.com/2008/10/this-one-is-better-ruby-net-ldap.html><br />

Presumably, the url to git it:  
<http://github.com/dim/ruby-net-ldap>

This looks like it might be interesting for a GUI:  
<http://www.jumpbox.com/app/openldap><br />

###### Installing OpenLDap on MacBook

$ port search ldap
$ port info openldap
$ locate openldap
$ sudo port install openldap

--->  Attempting to fetch openldap-2.3.35.tgz from http://distfiles.macports.org/openldap
--->  Configuring openldap
[...]
--->  Building openldap  
--->  Staging openldap into destroot  
--->  Creating launchd control script  

    A startup item has been generated that will aid in  
    starting openldap with launchd. It is disabled  
    by default. Execute the following command to start it,  
    and to cause it to launch at startup:  
    sudo launchctl load -w /Library/LaunchDaemons/org.macports.slapd.plist  
--->  Installing openldap @2.3.35_1  
--->  Activating openldap @2.3.35_1   
--->  Cleaning openldap  

*Note that it also installed openssl-0.9.8l and db44 (Berkeley DB) as well.*

$ which ldapsearch
/opt/local/bin/ldapsearch
$ which ldapadd
/opt/local/bin/ldapadd

Also in /opt/local/bin:  
ldapcompare, ldapadd@ -> ldapmodify, ldapdelete, ldapmodify, ldapmodrdn, ldappasswd, ldapsearch, ldapwhoami   
In fact, a `man -k ldap` includes (much more than) the following:  
ldapcompare(1)           - LDAP compare tool  
ldapdelete(1)            - LDAP delete entry tool  
ldapmodify(1), ldapadd(1) - LDAP modify entry and LDAP add entry tools  
ldapmodrdn(1)            - LDAP rename entry tool  
ldappasswd(1)            - change the password of an LDAP entry   
ldapsearch(1)            - LDAP search tool   
ldapwhoami(1)            - LDAP who am i? tool  
ldif(5)                  - LDAP Data Interchange Format  
slapd(8)                 - Stand-alone LDAP Daemon  
slapd-ldap(5)            - LDAP backend to slapd  
slapd.access(5)          - access configuration for slapd, the stand-alone LDAP daemon  
slapd.conf(5)            - configuration file for slapd, the stand-alone LDAP daemon  
slapd.plugin(5)          - plugin configuration for slapd, the stand-alone LDAP daemon  
slappasswd(8)            - OpenLDAP password utility  
slurpd(8)                - Standalone LDAP Update Replication Daemon  


So I see paths that concern me because they BOTH have my slapd.conf, etc., stuff. I guess we'll try to work this out.
$ l /opt/local/etc/openldap/  
$ l /etc/openldap/  

I find some interesting directions for setting this up on Mac
<http://www.macgeekery.com/hacks/software/shared_address_book_via_ldap>

I also notice that the /etc is aliased to /private/etc on Mac:  
/etc@ -> private/etc

# THIS WORKED!  

## No Blank Spaces at end!!!!
<font color="red">This will give errors like:</font>      
    ldap_add: Invalid syntax (21)

_Find slapd.conf:_    
$ sudo find / -iname slapd.conf   
/opt/local/etc/openldap/slapd.conf    
/private/etc/openldap/slapd.conf    


    include                 /opt/local/etc/openldap/schema/core.schema
    include		    /opt/local/etc/openldap/schema/cosine.schema
    include                 /opt/local/etc/openldap/schema/inetorgperson.schema
    include                 /opt/local/etc/openldap/schema/nis.schema
    pidfile		    /opt/local/var/run/slapd.pid
    argsfile		    /opt/local/var/run/slapd.args

    database	bdb
    suffix		"dc=mycompany,dc=com"
    rootdn		"cn=Manager,dc=mycompany,dc=com"
    rootpw {SSHA}g57gXnL4nkDtutiltL3kIihpLjKGD1VB
    directory	/opt/local/var/openldap-data

*Note: the SSHA was obtained by doing: !r slappasswd -s CLEAR_TEXT (and then it for some reason puts it on the next line so I had to put it up by the rootpw*

### /tmp/base.ldif

dn: dc=mycompany,dc=com
dc: mycompany
objectClass: top
objectClass: dcObject
objectClass: organization
o: My Company Inc.

dn: cn=bogus,dc=mycompany,dc=com
objectClass: organizationalRole
cn: bogus

dn: cn=testuser,dc=mycompany,dc=com
objectClass: organizationalRole
cn: testuser


### Starting slapd

    $ sudo /opt/local/libexec/slapd -d -1    
    

### ldapadd
    ldapadd -x -D "cn=Manager,dc=mycompany,dc=com" -W -f /tmp/base.ldif
    
### Ldap Search

ldapsearch -x -b 'dc=mycompany,dc=com' '(objectclass=*)'

     extended LDIF

     LDAPv3
     base <dc=mycompany,dc=com> with scope subtree
     filter: (objectclass=*)
     requesting: ALL

     mycompany.com
    dn: dc=mycompany,dc=com
    dc: mycompany
    objectClass: dcObject
    objectClass: organization
    o: My Company Inc.

     bogus, mycompany.com
    dn: cn=bogus,dc=mycompany,dc=com
    objectClass: organizationalRole
    cn: bogus

     testuser, mycompany.com
    dn: cn=testuser,dc=mycompany,dc=com
    objectClass: organizationalRole
    cn: testuser

     search result
    search: 2
    result: 0 Success

     numResponses: 4
     numEntries: 3
    

*Less Verbose:*  
    ldapsearch -x -LLL '(objectclass=*)'

###### Search for specific 
    $ ldapsearch -x -LLL -b 'dc=mycompany,dc=com' '(cn=bogus)'

    dn: cn=bogus,dc=mycompany,dc=com
    objectClass: organizationalRole
    cn: bogus
    
### Delete

    $ ldapdelete -x -W -D 'cn=Manager,dc=mycompany,dc=com' 'cn=bogus,dc=mycompany,dc=com'  
    Enter LDAP Password:   

    $ ldapsearch -x -LLL -b 'dc=mycompany,dc=com' '(cn=bogus)'
    [Nothing returned because he's deleted!]    

### Organizational Units
So we want to create a directory tree with something like:

             company
	        |
	    |   |    |
	    IT  HR   Mkt

So we create an ldif (ldap data interchange format) file:    

    dn: ou=IT,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalunit
    ou: IT
    description: Information Technologies

    dn: ou=HR,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalunit
    ou: HR
    description: Human Resources

    dn: ou=R&D,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalunit
    ou: R&D
    description: Research and Development

    dn: ou=Mkt,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalunit
    ou: Mkt 
    description: Marketing

_Remember that ldif files cannot have spaces at the end of the file!!!!_    

And issue the following command:    
    ldapadd -x -D "cn=Manager,dc=mycompany,dc=com" -W -f /tmp/orgs.dif 


Then we see what we have:

    $ ldapsearch -x -b 'dc=mycompany,dc=com' '(objectclass=*)'
    ldapsearch -x -b 'dc=mycompany,dc=com' '(objectclass=*)'

    dn: dc=mycompany,dc=com
    dc: mycompany
    objectClass: dcObject
    objectClass: organization
    o: My Company Inc.

    dn: cn=testuser,dc=mycompany,dc=com
    objectClass: organizationalRole
    cn: testuser

    dn: ou=IT,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalUnit
    ou: IT
    description: Information Technologies

    dn: ou=HR,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalUnit
    ou: HR
    description: Human Resources

    dn: ou=R&D,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalUnit
    ou: R&D
    description: Research and Development

    dn: ou=Mkt,dc=mycompany,dc=com
    objectClass: top
    objectClass: organizationalUnit
    ou:: TWt0IA==
    description: Marketing

    search: 2
    result: 0 Success

Note we can also search with the hostname included as follows:    
     $ ldapsearch -x -h localhost -b 'dc=mycompany,dc=com' '(objectclass=*)'   
## Adding persons

_Again, be careful of spaces!_

--persons.dif

    dn: uid=rlevin, ou=IT, dc=mycompany, dc=com
    objectClass: top
    objectClass: person
    objectClass: organizationalPerson
    objectClass: inetOrgPerson
    cn: Rob Levin
    cn: Robin Levin
    sn: Levin
    givenName: Rob Levin
    uid: rlevin
    mail: roblevintennis@gmail.com
    description: Rob Levin in the IT Dept

    dn: uid=llevin, ou=HR, dc=mycompany, dc=com
    objectClass: top
    objectClass: person
    objectClass: organizationalPerson
    objectClass: inetOrgPerson
    cn: Lynn Levin
    cn: Lynn Guidotti Levin
    sn: Levin
    givenName: Lynn Guidotti
    uid: llevin
    mail: llevin@fake.com
    description: Lynn Levin in the HR Dept

    dn: uid=hlevin, ou=R&D, dc=mycompany, dc=com
    objectClass: top
    objectClass: person
    objectClass: organizationalPerson
    objectClass: inetOrgPerson
    cn: Hank Levin
    cn: Henry Levin
    cn: Henry Martin Levin
    sn: Levin
    givenName: Henry Martin Levin
    uid: hlevin
    mail: hlevin@fake.com
    description: Hank Levin in the R&D Dept

    dn: uid=hilalevin, ou=Mkt, dc=mycompany, dc=com
    objectClass: top
    objectClass: person
    objectClass: organizationalPerson
    objectClass: inetOrgPerson
    cn: Hila Levin
    cn: Hila Eden Levin
    sn: Levin
    givenName: Hila EdenLevin
    uid: hilalevin
    mail: hilalevin@fake.com
    description: Hila Levin in the Marketing Dept.
     
## Change type    

Another alternative is to put the changetype: instruction in the ldif file as one of add|delete|modify
and then I believe we could use ldapmodify to execute all of these commands (or have add delete, etc., all in the same ldif file for the various different entries).

## Ruby net/ldap Gem

#### Example of auth:      

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

#### Example of a search against an LDAP directory:       

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

#### Example of adding:    

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
      p ldap.get_operation_result # just debugging - outputs: #<OpenStruct error_message="", code=0, matched_dn="", message="Success">
    end

---
## phpldapadmin
TBC


---


#### Troubleshooting Notes

Something about a system.log error:
<http://blog.macadmincorner.com/slapd-error-in-systemlog/>
    $ /usr/libexec/slapd -Tt
    could not stat config file "/etc/openldap/slapd.conf": No such file or directory (2)
    slaptest: bad configuration file!

The fix was as simple as:

    sudo cp /etc/openldap/slapd.conf.default /etc/openldap/slapd.conf
    ldapadd -x -D "cn=Manager,dc=example,dc=com" -W -f /tmp/base.ldif


_Image Example -- IGNORE THIS_
    <img src="/roblevintennis/my-configs/raw/master/cucumber/google_webrat_mechanize_google_pass_5.png" />


#### Edit the slapd.conf file  

sudo cp /etc/openldap/slapd.conf.default /etc/openldap/slapd.conf

and then made the following edits:

    database        bdb
    suffix          "dc=my-domain,dc=com"
    rootdn          "cn=Manager,dc=my-domain,dc=com"
    rootpw                                                                       
    {SSHA}kEdXL/PBatqeAQvKlBbdS4ttHxXX/3sO                                       


_Above is sha of one of my typical passwd's ;-)_

###### Launch the daemon   
sudo launchctl load -w /Library/LaunchDaemons/org.macports.slapd.plist
sudo launchctl unload -w /Library/LaunchDaemons/org.macports.slapd.plist


### Setting up OpenLDAP on OS X Leopard

<http://www.highlylogical.com/archives/25>


Recently I was asked to look at building a web application that would run on Tomcat and use Active Directory for authentication. Since I didn’t exactly know how to do this, I thought it would be interesting to get an OSS LDAP server up and running on my Mac and try hooking into it with Tomcat. Since I couldn’t find this already on the net, I thought it would be handy to document the process I went through to get this set up.First, you will need to have the following packages installed:- MacPorts- TomcatNow for the step-by-step:Install OpenLDAP from MacPorts

 sudo port install openldap

Copy slapd.conf.default to slapd.conf

cp /opt/local/etc/openldap/slapd.conf.default /opt/local/etc/openldap/slapd.conf

Customize OpenLDAP configuration for Tomcat sample schema

edit /opt/local/etc/openldap/slapd.conf

Add additional schemas needed to support the Tomcat sample:

include		/opt/local/etc/openldap/schema/cosine.schemainclude		/opt/local/etc/openldap/schema/inetorgperson.schema

Also set suffix and rootdn as shown in this sample. There’s no need to change the database type, however.Notice that the slapd.conf file defines a location that doesn’t exist for a pidfile and argsfile, so we’ll need to create the directory:

sudo mkdir /opt/local/var/run

Start up OpenLDAP:

sudo /opt/local/libexec/slapd

Check that it’s running:

ps -ef|grep slapd

If it’s not, use -d -1 options on the command line to see what’s causing it to fail.Copy the LDIF sample file shown on the Tomcat page into a text file.Import the sample data:

 ldapadd -x -D "cn=Manager,dc=example,dc=com" -W -f tomcatsample.ldif

Backup Tomcat’s server config

cd tomcat_rootcp conf/server.xml conf/server.xml.backup

Edit the realm definition as shown on the Tomcat page – authentication should not be needed to do LDAP lookups with the default configuration

edit conf/server.xml


