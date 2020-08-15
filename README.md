# udi-application-appointment-check

Simple selenium script for checking UDI police appointment availability for a citizenship application.

To run this script from GitHub, the GitHub action needs the properties *udi_email* and *udi_password*
set as secrets in the cloned project. This can be done in the settings tab under secrets. This data is
the same that is being used to login and not visible to the outside or in logs.

By default, the script is run between 5am and 11pm each half hour. This behavior can by the cron
expression in the *.github/workflows/main.yaml* file.

The amounts of months to be checked is set by the navigation in the *check-udi.side* file. The first month
being checked is the current month with any subsequent months being set by the individual steps. Additional
months can be set by adding additional steps.

You can test the script locally by running

```cmd
./check-udi.side <email> <password>
echo $?
```

The script returns status code *0* if the check did successfully run but not discover any new appointments and
*1* otherwise. A summary is also printed. As a result of the status codes, GitHub will notify you in case new
appointments have become available.

The git configuration is set to avoid any accidental checkins of passwords or user identity but take extra
care when committing to a cloned repository.

Best of luck on getting an appointment!
