# Counterexample Analysis

A contradiction was intentionally introduced into the Alloy model.

Rule:
Alarm ACTIVE implies Door UNLOCKED

This violated the security invariant because alarm activation should require locked doors.

Alloy Analyzer successfully detected the inconsistency and generated a counterexample.

This demonstrates the effectiveness of formal verification in identifying invalid system states.
