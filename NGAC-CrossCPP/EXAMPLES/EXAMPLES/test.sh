# Authors: André Christofferson & Wilma Krutrök

#Here we load all the policies that will be used in following test example
echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=EXAMPLES/EXAMPLES/book_lift.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=EXAMPLES/EXAMPLES/book_room.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=EXAMPLES/EXAMPLES/read_file.pl" --data-urlencode "token=admin_token"

echo ''
echo 'Set the policy to book_lift '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=book_lift" --data-urlencode "token=admin_token"

echo ''
echo 'Set Access query - G G G G D D D D'
# Allowed to book and condition fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(locationA,locationA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_location(locationB,locationB)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=is_same_location(locationA,locationA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book&cond=is_same_location(locationA,locationA)"

# Allowed to book but condition not fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(locationA,locationB)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_location(locationB,locationA)"

# Not allowed to book
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=is_same_location(locationA,locationA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=is_same_location(locationA,locationA)"

# Tests for incomplete condition arguments
# echo '\nSet Access query - D D D D D'
# curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(u1,_)"
# curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(_,_)"
# curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
# curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(test,_)"
# curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(_,'test')"

echo ''
echo 'Set the policy to book_room'
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=book_room" --data-urlencode "token=admin_token"

echo ''
echo 'Set Access query - G G G G D D D D'
# Allowed to book and condition fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(locationA,locationA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_location(locationB,locationB)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=is_same_location(locationA,locationA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book&cond=is_same_location(locationA,locationA)"

# Allowed to book but condition not fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(locationA,locationB)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_location(locationB,locationA)"

# Not allowed to book
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=is_same_location(locationA,locationA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=is_same_location(locationA,locationA)"

echo ''
echo 'Set the policy to read_file'
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=read_file" --data-urlencode "token=admin_token"

echo ''
echo 'Set Access query - G G G G D D (if localhost time is between 07-18, else all Denies)'
# Allowed to read and condition fulfilled 
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=read"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=read"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=read"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=read"

# Not allowed to read
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=read"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=read"