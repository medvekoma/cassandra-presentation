# Exercise

## Context

We are creating the datastore for the European Traffic Incidents Office.
All incidents arrive with the following information:
- Registration number
- Registration country code
- Driver PID
- Driver name
- Incident's date and time
- Incident place - country code
- Incident place name
- Penalty points (if any)

## Requirements

1. Provide a list of incidents of a vehicle 
for a specific date range, sorted by incident's date and time (newest first).
1. Provide the same list for a driver (identified by pid), sorted by vehicle, 
then by date and time (newest first).
1. Display the penalty points collected by a specific vehicle.

## What to prepare

* Table definitions
* CQL statements for data ingestion
* CQL statements for data retrieval