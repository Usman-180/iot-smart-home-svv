module SmartHome

-- =========================
-- SIGNATURES
-- =========================

sig Light {
    lightState : one LightState
}

sig Door {
    doorState : one DoorState
}

sig Alarm {
    alarmState : one AlarmState
}

sig Temperature {
    tempState : one TempState
}

-- =========================
-- STATES
-- =========================

abstract sig LightState {}
one sig ON, OFF extends LightState {}

abstract sig DoorState {}
one sig LOCKED, UNLOCKED extends DoorState {}

abstract sig AlarmState {}
one sig ACTIVE, INACTIVE extends AlarmState {}

abstract sig TempState {}
one sig SAFE, HIGH extends TempState {}

-- =========================
-- FACTS / INVARIANTS
-- =========================

fact SmartHomeRules {

    -- Door must always have valid state
    all d : Door |
        d.doorState = LOCKED or
        d.doorState = UNLOCKED

    -- If alarm is ACTIVE then door must be LOCKED
    all a : Alarm, d : Door |
        a.alarmState = ACTIVE
        implies
        d.doorState = LOCKED

    -- HIGH temperature activates alarm
    all t : Temperature, a : Alarm |
        t.tempState = HIGH
        implies
        a.alarmState = ACTIVE

    -- Light must always have valid state
    all l : Light |
        l.lightState = ON or
        l.lightState = OFF
}

-- =========================
-- ASSERTIONS
-- =========================

assert AlarmRequiresLockedDoor {

    all a : Alarm, d : Door |
        a.alarmState = ACTIVE
        implies
        d.doorState = LOCKED
}

assert HighTemperatureActivatesAlarm {

    all t : Temperature, a : Alarm |
        t.tempState = HIGH
        implies
        a.alarmState = ACTIVE
}

assert ValidDoorState {

    all d : Door |
        not (
            d.doorState = LOCKED and
            d.doorState = UNLOCKED
        )
}

-- =========================
-- CHECKS
-- =========================

check AlarmRequiresLockedDoor for 5

check HighTemperatureActivatesAlarm for 5

check ValidDoorState for 5

-- =========================
-- PREDICATE
-- =========================

pred ShowSmartHome {}

run ShowSmartHome for 5
