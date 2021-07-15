# Authors: André Christofferson & Wilma Krutrök

# This example does not currently work but illustrates how to test 
# the policy defined in combine_conditions.pl. The syntax for making 
# the access call in this file is currently not supported but would be
# needed in order to have several conditions in a single policy.
# In this example we have one condition with variables and one without,
# if there were to exist several conditions with variables they would 
# need to be included in the access call, for example like this:
# http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=[is_same_location(locationA,locationA), condition2(var1, var2)]

#Here we load all the policies that will be used in following test example
echo 'Load policies'
curl -s -G "http://127.0.0.1:8001/paapi/loadpol" --data-urlencode "policyfile=EXAMPLES/EXAMPLES/combine_conditions.pl" --data-urlencode "token=admin_token"

echo ''
echo 'Set the policy to combine_conditions - book_lift '
curl -s -G "http://127.0.0.1:8001/paapi/setpol?policy=combine_conditions" --data-urlencode "token=admin_token"

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
echo 'Set Access query - G G G G D D D D'
# Allowed to book and condition fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=[is_same_location(locationA,locationA)]"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=[is_same_location(locationB,locationB)]"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o1&ar=book&cond=[is_same_location(locationA,locationA)]"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u3&object=o2&ar=book&cond=[is_same_location(locationA,locationA)]"

# Allowed to book but condition not fulfilled
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o1&ar=book&cond=[is_same_location(locationA,locationB)]"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o2&ar=book&cond=[is_same_location(locationB,locationA)]"

# Not allowed to book
curl -s "http://127.0.0.1:8001/pqapi/access?user=u1&object=o2&ar=book&cond=[is_same_location(locationA,locationA)]"
curl -s "http://127.0.0.1:8001/pqapi/access?user=u2&object=o1&ar=book&cond=[is_same_location(locationA,locationA)]"
