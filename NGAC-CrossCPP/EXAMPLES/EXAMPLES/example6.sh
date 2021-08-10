# Authors: André Christofferson & Wilma Krutrök

# In this example we test doing the access request to the PEP and retreiving the location from
# both the PEP and PDP. In order for this example to work remember to start both PEP server and
# NGAC sever.

echo 'Load policy'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=EXAMPLES/EXAMPLES/book_lift.pl" --data-urlencode "token=admin_token"

# echo 'Set the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=book_lift" --data-urlencode "token=admin_token"

# The location is retreived in the PEP before making the access call to the PDP
echo ''
echo 'PEP access - is_same_locaation for u1'
echo 'Set Access query -  G D D'
curl -s "http://127.0.0.1:8005/peapi/book_PEP?objname=o1&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book_PEP?objname=o2&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book_PEP?objname=o3&operations=book"

# Here the location is retreived by the PDP inside the condition
echo ''
echo 'PDP access - is_same_locaation for u1'
echo 'Set Access query -  G D D'
curl -s "http://127.0.0.1:8005/peapi/book_PDP?objname=o1&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book_PDP?objname=o2&operations=book"
curl -s "http://127.0.0.1:8005/peapi/book_PDP?objname=o3&operations=book"