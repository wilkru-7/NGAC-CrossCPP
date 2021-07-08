# Authors: André Christofferson & Wilma Krutrök

echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/users.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/objects.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/cassociates.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/users_level.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/combine_cond_PEP.pl" --data-urlencode "token=admin_token"

# echo 'Combining policies'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=objects&combined=temp&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=temp&policy2=cond_associates&combined=combined_policies&token=admin_token"

# echo 'Set the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo ''
echo 'PEP access - is_same_site for u1'
echo 'Set Access query - G D D'
curl -s "http://127.0.0.1:8005/peapi/access?objname=o1&operations=book"
curl -s "http://127.0.0.1:8005/peapi/access?objname=o2&operations=book"
curl -s "http://127.0.0.1:8005/peapi/access?objname=o3&operations=book"

echo ''
echo 'PEP test1 - is_same_site for u3 (Access to all objects, but only o3 is at same site'
echo 'Set Access query - D D G'
curl -s "http://127.0.0.1:8005/peapi/test1?objname=o1&operations=book"
curl -s "http://127.0.0.1:8005/peapi/test1?objname=o2&operations=book"
curl -s "http://127.0.0.1:8005/peapi/test1?objname=o3&operations=book"

echo ''
# echo 'Combining policy'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users_level&policy2=combine_cond_PEP&combined=combined_policy&token=admin_token"
# echo 'Set the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policy" --data-urlencode "token=admin_token"

echo ''
echo 'PEP test2 - site_and_business for u1'
echo 'Set Access query - G D D'
curl -s "http://127.0.0.1:8005/peapi/test2?objname=o1&operations=book"
curl -s "http://127.0.0.1:8005/peapi/test2?objname=o2&operations=book"
curl -s "http://127.0.0.1:8005/peapi/test2?objname=o3&operations=book"

echo ''
# echo 'Combining policies'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=objects&combined=temp&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=temp&policy2=cond_associates&combined=combined_policies&token=admin_token"

# echo 'Set the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo ''
echo 'PEP test3 - Combines the results from two access calls, two grants = grant, otherwise deny (Might not follow NGAC)'
echo 'Set Access query - G'
curl -s "http://127.0.0.1:8005/peapi/test3?objname=o1&operations=book"
# curl -s "http://127.0.0.1:8005/peapi/test3?objname=o2&operations=book"
# curl -s "http://127.0.0.1:8005/peapi/test3?objname=o3&operations=book"