# Authors: André Christofferson & Wilma Krutrök

# Test the combination attribute level and location check
echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/users.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/several_cond.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/objects.pl" --data-urlencode "token=admin_token"

echo '\nCombining policies - Example 1 (Users + Same location with management level)'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=several_cond&combined=combined_policies3&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=combined_policies3&policy2=objects&combined=combined_policies&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo '\nSet Access query - G G G G'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location('\"u1\"','\"o1\"')"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_location('\"u2\"','\"o2\"')"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o3&ar=book&cond=is_same_location('\"u3\"','\"o3\"')"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book&cond=is_same_location('\"u4\"','\"o2\"')"

echo '\nSet Access query - D D D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=is_same_location('\"u1\"','\"o2\"')"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=is_same_location('\"u2\"','\"o1\"')"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=is_same_location('\"u3\"','\"o1\"')"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book&cond=is_same_location('\"u4\"','\"o1\"')"

echo '\nSet Access query - D D D D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location('\"u1\"',_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(_,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location('\"test\"',_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_location(_,'test')"