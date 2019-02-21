# Rack
Simple rack application

run: rackup

test: curl --url http://localhost:9292/time?format=second,year,day,month,hour,minute -i
