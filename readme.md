# Welcome to our project!
In order to run our examples you have to first ensure that SWI-Prolog is installed on your computer and it can be found here https://www.swi-prolog.org/.

The NGAC Policy server needs to be started and example 6 also uses the PEP server.

Our main examples can be found in the folder NGAC-CrossCpp/EXAMPLES/EXAMPLES/.

There also exist some test examples in NGAC-CrossCpp/TEST/RTB-tests/ where the policies in those examples exists in NGAC-CrossCpp/POLICIES/ and the conditions can be found in the condition.pl file 

## How to start NGAC Policy Server
1. Start SWI-Prolog in the folder NGAC-CROSSCPP by typing swipl in a command line. (`?-`should be visible in the command line if started correctly)
2. Compile the ngac tools by typing `[ngac].` in prolog.
3. Start the ngac tools by typing `ngac.`
4. Start the ngac server by typing `server.` (errors may be stated but the server should have been started anyway, the CME server needs to be started for the errors to go away but this is not needed for our examples)

## How to start the NGAC PEP Server.
1. Start SWI-Prolog in the folder PEP-RAP (subfolder of NGAC-CROSSCPP) by typing swipl in a command line.
2. Compile the PEP server by typing `[pep].`
3. Start the PEP server by typing `pep_server.`

## Running the examples.
The examples can be located in the folder `NGAC-CrossCpp/EXAMPLES/EXAMPLES/` and can be run when both the Policy server and the PEP server is started. These does not need to be run from the prolog interface and can be run by just writing `sh example1.sh` in the command line. (The error compound_name_arity/3 may be present when running the examples and this is due to the loading of conditions. They do however work as intended so this error can be ignored)