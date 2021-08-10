# Authors: André Christofferson & Wilma Krutrök

# This example illustrates how we would want to combine two policies with the same 
# asocciates but different conditions. Here we would want both conditions to be fulfilled
# in order to get granted access but as it is now only the condition "is_business_hours" is
# considered in the policy.

#Here we load all the policies that will be used in following test example
echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=EXAMPLES/EXAMPLES/book_lift.pl" --data-urlencode "token=admin_token"
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=EXAMPLES/EXAMPLES/book_lift2.pl" --data-urlencode "token=admin_token"

echo 'Combining policies - book_lift + book_lift2)'
curl -s "http://127.0.0.1:8001/paapi/combinepol?policy1=book_lift&policy2=book_lift2&combined=combined_policies&token=admin_token"

echo ''
echo 'Set the policy to book_lift '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combined_policies" --data-urlencode "token=admin_token"

echo ''
echo 'Set the condition needed for the policy'
curl -s -G "http://127.0.0.1:8001/paapi/loadcondi" --data-urlencode "cond_elements=[
	condition_predicate(is_same_location,[name, name]),
	(is_same_location(LocationA,LocationB) :- LocationA == LocationB)
	]" --data-urlencode "token=admin_token"
    
curl -s -G "http://127.0.0.1:8001/paapi/loadcondi" --data-urlencode "cond_elements=[
	condition_predicate(is_business_hours,[]),
	(is_business_hours :- condition_variable_value(hour_now,Hour), Hour =< 18, Hour >= 16)
	]" --data-urlencode "token=admin_token"
# Does not work to write "is_same_location(Location, Location)." here.

echo ''
echo 'Set Access query - G G G G D D D D (if localhost time is between 07-18, else all Denies)'

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
