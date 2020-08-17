# udi-application-appointment-check

A simple selenium script for checking UDI police appointment availability for a citizenship application.

To run this script from GitHub, the GitHub action needs the properties *udi_email* and *udi_password*
set as secrets in the cloned project. This can be done in the settings tab under secrets. This data is
the same that is being used to login and not visible to the outside or in logs. Additionally, the
*check_limit* property must be set to a combination of [month year] which is the latest date of interest.
The month must be fully spelled out in English, e.g *August 2021*.

By default, the script is run between 5am and 11pm each half hour. This behavior can be configured by
changing the cron expression in the *.github/workflows/main.yaml* file. The time zone on GitHub is UTC

You can test the script locally by running

```cmd
./check-udi.side <email> <password> <limit>
```

The script returns status code *0* if the check did successfully run but not discover any new appointments or
timeout. If it fails or discovers an available appointment, status code *1* is returned. A summary is printed
in any case to make the log better readable. GitHub notifies the account holder on status code *1* such that 
the available appointment can be booked.

The git configuration is set to avoid any accidental checkins of passwords, user identity or desired date but
take extra caution when committing to a cloned repository.

Best of luck on getting an appointment!
