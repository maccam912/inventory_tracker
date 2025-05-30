Any new github actions workflows need to use runs-on: inventory-tracker-set
That is my custom action runner set.

If you ever get an error when committing, it's probably because a pre-commit check did not pass. Fix the pre-commit checks so they all run and try again.

Remember, with pre-commit it will check for issues such as formatting and tests, but it might NOT change them. You might still have to reformat manually and commit again.
