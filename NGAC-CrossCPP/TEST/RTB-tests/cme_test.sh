# Authors: André Christofferson & Wilma Krutrök

# Testing the CME with context variables
echo 'Load policy'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=POLICIES/book_lift_cond.pl" --data-urlencode "token=admin_token"

# echo '\nSet the policy to example3b '
# curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=example3b" --data-urlencode "token=admin_token"

echo '\nAccess call specifying context variables - expect grant '
curl -s -g 'http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=[location_user=siteA,location_object=siteA]'

echo '\nrun context_notify setting locations to SiteA'
curl -s 'http://127.0.0.1:8001/epp/context_notify?context=[location_user=siteA, location_object=siteA]&token=epp_token'

echo '\nAccess call without specifying condition/context variables - expect grant'
curl -s 'http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book'

echo '\nrun context_notify setting locations to SiteA and SiteB'
curl -s 'http://127.0.0.1:8001/epp/context_notify?context=[location_user=siteA, location_object=siteB]&token=epp_token'

echo '\nAccess call without specifying condition/context variables - expect deny'
curl -s 'http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book'