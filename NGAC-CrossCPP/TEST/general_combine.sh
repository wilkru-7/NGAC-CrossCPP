echo 'Combining policies'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=users&policy2=general&combined=combined_policies&token=admin_token"

echo '\nSet the policy to combined policy '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"
#curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=test9" --data-urlencode "token=admin_token"
echo '\nSet Access query - G G G G G G D D'
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o1&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u4&object=o2&ar=book"

curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book"


