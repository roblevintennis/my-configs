require 'rubygems'
require 'mechanize'

agent = WWW::Mechanize.new
page = agent.get('http://google.com/')
google_form = page.form('f')
google_form.q = 'ruby mechanize'
page = agent.submit(google_form)
pp page

