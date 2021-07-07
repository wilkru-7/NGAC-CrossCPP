# Authors: André Christofferson & Wilma Krutrök

# Load policies and use composition
echo 'Load policies'
# curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/users.pl" --data-urlencode "token=admin_token"
# curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/general_location.pl" --data-urlencode "token=admin_token"
# curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/business_hours.pl" --data-urlencode "token=admin_token"

echo '\nCombining policies - Example 2 (Users + General condition with same location)'
# curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=general_cond_location&combined=combined_policy1&token=admin_token"
# curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=business_hours&combined=combined_policy2&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=all" --data-urlencode "token=admin_token"

echo '\nSet Access query - G G G G'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o3&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book"

echo '\nSet Access query - D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book"

echo '\nSet Access query - G G G G'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(u1,o1)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_location(u2,o2)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o3&ar=book&cond=is_same_location(u3,o3)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book&cond=is_same_location(u4,o2)"

echo '\nSet Access query - D D D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=is_same_location(u1,o2)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=is_same_location(u2,o1)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=is_same_location(u3,o1)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book&cond=is_same_location(u4,o1)"

echo '\nSet Access query - D D D D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(u1,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(_,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(test,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(_,'test')"