-- Separate table for each query
CREATE TABLE incidents_by_vehicle (
    regnr text,
    ccode text,
    incident_time timeuuid,
    driver_name text,
    driver_pid bigint,
    incident_location text,
    penalty int,
    PRIMARY KEY ((regnr, ccode), incident_time)
) WITH CLUSTERING ORDER BY (incident_time DESC);

CREATE TABLE incidents_by_driver (
    regnr text,
    ccode text,
    incident_time timeuuid,
    driver_name text static,
    driver_pid bigint,
    incident_location text,
    penalty int,
    PRIMARY KEY (driver_pid, incident_time)
) WITH CLUSTERING ORDER BY (incident_time DESC);

CREATE TABLE penalty_by_driver(
    driver_pid bigint PRIMARY KEY,
    sum_penalty counter
);

UPDATE penalty_by_driver SET sum_penalty = sum_penalty + 2 WHERE driver_pid = 1;