# Load the Module::Install bundled in ./inc/
use inc::Module::Install;

# Define metadata
name     'Devel-Loading';
all_from 'lib/Devel/Loading.pm';
githubmeta;

WriteAll;

