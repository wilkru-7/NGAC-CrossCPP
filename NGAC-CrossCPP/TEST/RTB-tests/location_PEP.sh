# Authors: André Christofferson & Wilma Krutrök

echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/users.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/objects.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/cassociates.pl" --data-urlencode "token=admin_token"

# echo 'Combining policies'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=objects&combined=temp&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=temp&policy2=cond_associates&combined=combined_policies&token=admin_token"

# echo 'Set the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo ''
echo 'PEP access - is_same_site for u1'
echo 'Set Access query -  G D D'
curl -s "http://127.0.0.1:8005/peapi/book?objname=o1&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book?objname=o2&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book?objname=o3&operations=book"

echo ''
echo 'Stressing '
curl -s "http://127.0.0.1:8005/peapi/book?objname=o1&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book?objname=o2&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book?objname=o3&operations=book"
