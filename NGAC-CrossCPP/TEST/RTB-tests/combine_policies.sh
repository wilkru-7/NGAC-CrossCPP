# Authors: André Christofferson & Wilma Krutrök

# Combining user policy with general policies
echo 'Combining policies - Example 1 (Users + general)'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=general&combined=combined_policies&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo '\nSet Access query - G G G G G G D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book"

echo '\nCombining policies - Example 2 (Users + General condition)'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=general_cond&combined=combined_policies&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

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
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteA,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"

# curl -s -g "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=[location_user=siteA,location_object=siteB]"
echo '\nCondition check'
#curl -s --trace-ascii /dev/stdout 'http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(site, site)'

echo 'Combining policies - Example 3 (Users + Objects + Associates)'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=objects&combined=temp&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=temp&policy2=associates&combined=combined_policies&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo '\nSet Access query - G G G G G G D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book"

echo 'Combining policies - Example 4 (Users + Objects + Associates Conditional)'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=objects&combined=temp&token=admin_token"
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=temp&policy2=cond_associates&combined=combined_policies&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

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

echo 'Combining policies - Example 5 (Users + Location)'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=location&combined=combined_policies&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo '\nSet Access query - G G D D D D D D D D D D '
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteA,siteB)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteA,_)"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=is_same_site(siteA,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=is_same_site(siteA,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book&cond=is_same_site(siteA,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book&cond=is_same_site(siteA,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book&cond=is_same_site(siteA,_)"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=is_same_site(siteA,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=is_same_site(siteA,_)"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(siteB,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=is_same_site(_,_)"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"