module SmartHome

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

abstract sig LightState {}
one sig ON, OFF extends LightState {}

abstract sig DoorState {}
one sig LOCKED, UNLOCKED extends DoorState {}

abstract sig AlarmState {}
one sig ACTIVE, INACTIVE extends AlarmState {}

abstract sig TempState {}
one sig SAFE, HIGH extends TempState {}

fact SmartHomeRules {

    all d : Door |
        d.doorState = LOCKED or d.doorState = UNLOCKED

    -- ❌ INTENTIONALLY WEAK RULE (to allow counterexample)
    all a : Alarm, d : Door |
        a.alarmState = ACTIVE implies d.doorState = UNLOCKED

    all t : Temperature, a : Alarm |
        t.tempState = HIGH implies a.alarmState = ACTIVE

    all l : Light |
        l.lightState = ON or l.lightState = OFF
}

assert AlarmRequiresLockedDoor {

    all a : Alarm, d : Door |
        a.alarmState = ACTIVE implies d.doorState = LOCKED
}

assert HighTemperatureActivatesAlarm {

    all t : Temperature, a : Alarm |
        t.tempState = HIGH implies a.alarmState = ACTIVE
}

assert ValidDoorState {

    all d : Door |
        not (d.doorState = LOCKED and d.doorState = UNLOCKED)
}

check AlarmRequiresLockedDoor for 5
check HighTemperatureActivatesAlarm for 5
check ValidDoorState for 5

pred ShowSmartHome {}

run ShowSmartHome for 3
