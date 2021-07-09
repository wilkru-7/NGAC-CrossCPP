# Authors: André Christofferson & Wilma Krutrök

# Test is_same_location where location is retrived from JSON files in folder JSON/
echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/users.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/objects.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/associate_siteA.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/associate_siteBC.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/associate_locationBC.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/general_business_hours.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/general_isWeekday.pl" --data-urlencode "token=admin_token"

curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=objects&combined=temp&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=temp&policy2=associate_siteA&combined=combined_policies&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=combined_policies&policy2=associate_siteBC&combined=combined_policies1&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies1" --data-urlencode "token=admin_token"

echo '\nTesting for same condition'
echo '\nSet Access query - G G G G G G D D D D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book&cond=is_same_site(siteA,siteA)"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=is_same_site(siteA,siteA)"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteB,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteB,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"

curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=combined_policies&policy2=associate_locationBC&combined=combined_policies2&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies2" --data-urlencode "token=admin_token"


curl -s "http://127.0.0.1:8001/paapi/readpol?token=admin_token"

echo '\nTesting for same condition'
echo '\nSet Access query - G G D D G G'
curl -s -g "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s -g "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=[is_same_site(siteA,siteA),is_same_location(u1,o1)]"
curl -s -g "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=[siteA,siteA,u3,o1]"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book&cond=is_same_location(u3,o2)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book&cond=is_same_site(siteA,siteA)"

echo '\nTesting for 1 non argument and 1 with argument'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=combined_policies&policy2=general_business_hours&combined=combined_policies2&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies2" --data-urlencode "token=admin_token"

echo '\nSet Access query - G G G G G G D D D D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book&cond=is_same_site(siteA,siteA)"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=is_same_site(siteA,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=is_same_site(siteA,siteA)"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteB,siteA)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteB,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"

echo '\nTesting for 2 non argumental conditions'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=temp&policy2=general_business_hours&combined=combined_policies&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=combined_policies&policy2=general_isWeekday&combined=combined_policies1&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies1" --data-urlencode "token=admin_token"

curl -s "http://127.0.0.1:8001/paapi/readpol?token=admin_token"

echo '\nSet Access query - G G G G G G D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book"