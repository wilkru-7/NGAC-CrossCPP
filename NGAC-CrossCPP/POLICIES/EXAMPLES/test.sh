# Authors: André Christofferson & Wilma Krutrök

# 

echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/EXAMPLES/book_lift.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/EXAMPLES/book_room.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/EXAMPLES/read_file.pl" --data-urlencode "token=admin_token"

# echo ''
# echo 'Combining policies - Example 2 (Users + General condition with same location)'
# curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=general_cond_location&combined=combined_policies&token=admin_token"

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
echo 'Set Access query - G G G G D D'
# Allowed to book and condition fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book"

# Not allowed to book
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book"

echo ''
echo 'run context_notify setting is_business_hours to false'
curl -s --globoff "http://127.0.0.1:8001/epp/context_notify?context=[is_business_hours:false]&token=epp_token"

echo ''
echo 'Set Access query - D D D D D D'
# Allowed to book and condition fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book"

# Not allowed to book
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book"