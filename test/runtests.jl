using Dates
using TimeFloats
using Test

### to float

@test tofloat(Nanosecond, Nanosecond(1500)) == 1500.0
@test tofloat(Nanosecond, Microsecond(1500)) == 1500_000.0
@test tofloat(Nanosecond, Millisecond(1500)) == 1500_000_000.0
@test tofloat(Nanosecond, Second(1500)) == 1500_000_000_000.0
@test tofloat(Nanosecond, Minute(1500)) == 1500_000_000_000.0 * 60
@test tofloat(Nanosecond, Hour(1500)) == 1500_000_000_000.0 * 60 * 60
@test tofloat(Nanosecond, Time(1,2,3,4,5,6)) == (60*60 + 2*60 + 3) * 1e9 + 4e6 + 5e3 + 6
@test tofloat(Nanosecond, Second(1) + Millisecond(500)) == 1500_000_000.0

@test tofloat(Microsecond, Nanosecond(1500)) == 1.5
@test tofloat(Microsecond, Microsecond(1500)) == 1500.0
@test tofloat(Microsecond, Millisecond(1500)) == 1500_000.0
@test tofloat(Microsecond, Second(1500)) == 1500_000_000.0
@test tofloat(Microsecond, Minute(1500)) == 1500_000_000.0 * 60
@test tofloat(Microsecond, Hour(1500)) == 1500_000_000.0 * 60 * 60
@test tofloat(Microsecond, Time(1,2,3,4,5,6)) == (60*60 + 2*60 + 3) * 1e6 + 4e3 + 5 + 6e-3
@test tofloat(Microsecond, Second(1) + Millisecond(500)) == 1500_000.0

@test tofloat(Millisecond, Nanosecond(1500)) == 0.0015
@test tofloat(Millisecond, Microsecond(1500)) == 1.5
@test tofloat(Millisecond, Millisecond(1500)) == 1500.0
@test tofloat(Millisecond, Second(1500)) == 1500_000.0
@test tofloat(Millisecond, Minute(1500)) == 1500_000.0 * 60
@test tofloat(Millisecond, Hour(1500)) == 1500_000.0 * 60 * 60
@test tofloat(Millisecond, Time(1,2,3,4,5,6)) == (60*60 + 2*60 + 3) * 1e3 + 4 + 5e-3 + 6e-6
@test tofloat(Millisecond, Second(1) + Millisecond(500)) == 1500.0

@test tofloat(Second, Nanosecond(1500)) == 0.0000015
@test tofloat(Second, Microsecond(1500)) == 0.0015
@test tofloat(Second, Millisecond(1500)) == 1.5
@test tofloat(Second, Second(1500)) == 1500.0
@test tofloat(Second, Minute(1500)) == 1500.0 * 60
@test tofloat(Second, Hour(1500)) == 1500.0 * 60 * 60
@test tofloat(Second, Time(1,2,3,4,5,6)) ≈ (60*60 + 2*60 + 3) + 4e-3 + 5e-6 + 6e-9 # rounding error
@test tofloat(Second, Second(1) + Millisecond(500)) == 1.5

@test tofloat(Minute, Nanosecond(1500)) ≈ 0.0000015 / 60 # rounding error
@test tofloat(Minute, Microsecond(1500)) == 0.0015 / 60
@test tofloat(Minute, Millisecond(1500)) == 1.5 / 60
@test tofloat(Minute, Second(1500)) == 1500.0 / 60
@test tofloat(Minute, Minute(1500)) == 1500.0
@test tofloat(Minute, Hour(1500)) == 1500.0 * 60
@test tofloat(Minute, Time(1,2,3,4,5,6)) == (60 + 2 + 3/60) + 4e-3/60 + 5e-6/60 + 6e-9/60
@test tofloat(Minute, Second(1) + Millisecond(500)) == 1.5 / 60

@test tofloat(Hour, Nanosecond(1500)) ≈ 0.0000015 / 60 / 60 # rounding error
@test tofloat(Hour, Microsecond(1500)) == 0.0015 / 60 / 60
@test tofloat(Hour, Millisecond(1500)) == 1.5 / 60 / 60
@test tofloat(Hour, Second(1500)) == 1500.0 / 60 / 60
@test tofloat(Hour, Minute(1500)) == 1500.0 / 60
@test tofloat(Hour, Hour(1500)) == 1500.0
@test tofloat(Hour, Time(1,2,3,4,5,6)) == (1 + 2/60 + 3/60/60) + 4e-3/60/60 + 5e-6/60/60 + 6e-9/60/60
@test tofloat(Hour, Second(1) + Millisecond(500)) == 1.5 / 60 / 60

@test tosecond(Nanosecond(1500)) == 0.0000015
@test tosecond(Microsecond(1500)) == 0.0015
@test tosecond(Millisecond(1500)) == 1.5
@test tosecond(Second(1500)) == 1500.0
@test tosecond(Minute(1500)) == 1500.0 * 60
@test tosecond(Hour(1500)) == 1500.0 * 60 * 60
@test tosecond(Time(1,2,3,4,5,6)) ≈ (60*60 + 2*60 + 3) + 4e-3 + 5e-6 + 6e-9 # rounding error
@test tosecond(Second(1) + Millisecond(500)) == 1.5

### fromfloat

@test fromfloat(Nanosecond, 1500, Nanosecond) == Nanosecond(1500)
@test fromfloat(Nanosecond, 1500, Microsecond) == Nanosecond(1500_000)
@test fromfloat(Nanosecond, 1500, Millisecond) == Nanosecond(1500_000_000)
@test fromfloat(Nanosecond, 1500, Second) == Nanosecond(1500_000_000_000)
@test fromfloat(Nanosecond, 1500, Minute) == Nanosecond(1500_000_000_000 * 60)
@test fromfloat(Nanosecond, 1500, Hour) == Nanosecond(1500_000_000_000 * 60 * 60)
@test fromfloat(Time, (60*60 + 2*60 + 3) * 1e9 + 4e6 + 5e3 + 6, Nanosecond) == Time(1,2,3,4,5,6)
@test fromfloat(Dates.CompoundPeriod, 1500_000_000, Nanosecond) == Second(1) + Millisecond(500)

@test fromfloat(Microsecond, 1500, Nanosecond) == Microsecond(2) # lossy
@test fromfloat(Microsecond, 1500, Microsecond) == Microsecond(1500)
@test fromfloat(Microsecond, 1500, Millisecond) == Microsecond(1500_000)
@test fromfloat(Microsecond, 1500, Second) == Microsecond(1500_000_000)
@test fromfloat(Microsecond, 1500, Minute) == Microsecond(1500_000_000 * 60)
@test fromfloat(Microsecond, 1500, Hour) == Microsecond(1500_000_000 * 60 * 60)
@test fromfloat(Time, (60*60 + 2*60 + 3) * 1e6 + 4e3 + 5 + 6e-3, Microsecond) == Time(1,2,3,4,5,6)
@test fromfloat(Dates.CompoundPeriod, 1500_000, Microsecond) == Second(1) + Millisecond(500)

@test fromfloat(Millisecond, 1500, Nanosecond) == Millisecond(0) # lossy
@test fromfloat(Millisecond, 1500, Microsecond) == Millisecond(2)
@test fromfloat(Millisecond, 1500, Millisecond) == Millisecond(1500)
@test fromfloat(Millisecond, 1500, Second) == Millisecond(1500_000)
@test fromfloat(Millisecond, 1500, Minute) == Millisecond(1500_000 * 60)
@test fromfloat(Millisecond, 1500, Hour) == Millisecond(1500_000 * 60 * 60)
@test fromfloat(Time, (60*60 + 2*60 + 3) * 1e3 + 4 + 5e-3 + 6e-6, Millisecond) == Time(1,2,3,4,5,6)
@test fromfloat(Dates.CompoundPeriod, 1500, Millisecond) == Second(1) + Millisecond(500)

@test fromfloat(Second, 1500, Nanosecond) == Second(0) # lossy
@test fromfloat(Second, 1500, Microsecond) == Second(0 # lossy)
@test fromfloat(Second, 1500, Millisecond) == Second(2)
@test fromfloat(Second, 1500, Second) == Second(1500)
@test fromfloat(Second, 1500, Minute) == Second(1500 * 60)
@test fromfloat(Second, 1500, Hour) == Second(1500 * 60 * 60)
@test fromfloat(Time, (60*60 + 2*60 + 3) + 4e-3 + 5e-6 + 6e-9, Second) == Time(1,2,3,4,5,6)
@test fromfloat(Dates.CompoundPeriod, 1.5, Second) == Second(1) + Millisecond(500)

@test fromfloat(Minute, 1500, Nanosecond) == Minute(0) # lossy
@test fromfloat(Minute, 1500, Microsecond) == Minute(0 # lossy)
@test fromfloat(Minute, 1500, Millisecond) == Minute(0 # lossy)
@test fromfloat(Minute, 1500, Second) == Minute(1500 / 60)
@test fromfloat(Minute, 1500, Minute) == Minute(1500)
@test fromfloat(Minute, 1500, Hour) == Minute(1500 * 60)
@test fromfloat(Time, (60 + 2 + 3 / 60) + 4e-3 / 60 + 5e-6 / 60 + 6e-9 / 60, Minute) == Time(1,2,3,4,5,6)
@test fromfloat(Dates.CompoundPeriod, 1.5 / 60, Minute) == Second(1) + Millisecond(500)

@test fromfloat(Hour, 1500, Nanosecond) == Hour(0) # lossy
@test fromfloat(Hour, 1500, Microsecond) == Hour(0 # lossy)
@test fromfloat(Hour, 1500, Millisecond) == Hour(0 # lossy)
@test fromfloat(Hour, 1500, Second) == Hour(0 # lossy)
@test fromfloat(Hour, 1500, Minute) == Hour(1500 / 60)
@test fromfloat(Hour, 1500, Hour) == Hour(1500)
@test fromfloat(Time, (1 + 2 / 60 + 3 / 60 / 60) + 4e-3 / 60 / 60 + 5e-6 / 60 / 60 + 6e-9 / 60 / 60, Hour) == Time(1,2,3,4,5,6)
@test fromfloat(Dates.CompoundPeriod, 1.5 / 60 / 60, Hour) == Second(1) + Millisecond(500)

@test fromsecond(Nanosecond, 0.0000015) == Nanosecond(1500)
@test fromsecond(Microsecond, 0.0015) == Microsecond(1500)
@test fromsecond(Millisecond, 1.5) == Millisecond(1500)
@test fromsecond(Second, 1500.0) == Second(1500)
@test fromsecond(Minute, 1500.0 * 60) == Minute(1500)
@test fromsecond(Hour, 1500.0 * 60 * 60) == Hour(1500)
@test fromsecond(Time, (60*60 + 2*60 + 3) + 4e-3 + 5e-6 + 6e-9) == Time(1,2,3,4,5,6)
@test fromsecond(Dates.CompoundPeriod, 1.5) == Second(1) + Millisecond(500)
