using Dates
using TimeFloats
using Test
using Aqua

const time123456ns = (60*60 + 2*60 + 3) * 1e9 + 4e6 + 5e3 + 6

@testset "tofloat" begin
    @testset "nanosecond" begin
        @test tofloat(Nanosecond, Nanosecond(1500)) == 1500.0
        @test tofloat(Nanosecond, Microsecond(1500)) == 1500_000.0
        @test tofloat(Nanosecond, Millisecond(1500)) == 1500_000_000.0
        @test tofloat(Nanosecond, Second(1500)) == 1500_000_000_000.0
        @test tofloat(Nanosecond, Minute(1500)) == 1500_000_000_000.0 * 60
        @test tofloat(Nanosecond, Hour(1500)) == 1500_000_000_000.0 * 60 * 60
        @test tofloat(Nanosecond, Day(1500)) == 1500_000_000_000.0 * 60 * 60 * 24
        @test tofloat(Nanosecond, Week(1500)) == 1500_000_000_000.0 * 60 * 60 * 24 * 7
        @test tofloat(Nanosecond, Time(1,2,3,4,5,6)) == time123456ns
        @test tofloat(Nanosecond, Second(1) + Millisecond(500)) == 1500_000_000.0
    end
    @testset "microsecond" begin
        @test tofloat(Microsecond, Nanosecond(1500)) == 1.5
        @test tofloat(Microsecond, Microsecond(1500)) == 1500.0
        @test tofloat(Microsecond, Millisecond(1500)) == 1500_000.0
        @test tofloat(Microsecond, Second(1500)) == 1500_000_000.0
        @test tofloat(Microsecond, Minute(1500)) == 1500_000_000.0 * 60
        @test tofloat(Microsecond, Hour(1500)) == 1500_000_000.0 * 60 * 60
        @test tofloat(Microsecond, Day(1500)) == 1500_000_000.0 * 60 * 60 * 24
        @test tofloat(Microsecond, Week(1500)) == 1500_000_000.0 * 60 * 60 * 24 * 7
        @test tofloat(Microsecond, Time(1,2,3,4,5,6)) == time123456ns*1e-3
        @test tofloat(Microsecond, Second(1) + Millisecond(500)) == 1500_000.0
    end
    @testset "millisecond" begin
        @test tofloat(Millisecond, Nanosecond(1500)) == 0.0015
        @test tofloat(Millisecond, Microsecond(1500)) == 1.5
        @test tofloat(Millisecond, Millisecond(1500)) == 1500.0
        @test tofloat(Millisecond, Second(1500)) == 1500_000.0
        @test tofloat(Millisecond, Minute(1500)) == 1500_000.0 * 60
        @test tofloat(Millisecond, Hour(1500)) == 1500_000.0 * 60 * 60
        @test tofloat(Millisecond, Day(1500)) == 1500_000.0 * 60 * 60 * 24
        @test tofloat(Millisecond, Week(1500)) == 1500_000.0 * 60 * 60 * 24 * 7
        @test tofloat(Millisecond, Time(1,2,3,4,5,6)) == time123456ns*1e-6
        @test tofloat(Millisecond, Second(1) + Millisecond(500)) == 1500.0
    end
    @testset "second" begin
        @test tofloat(Second, Nanosecond(1500)) == 0.0000015
        @test tofloat(Second, Microsecond(1500)) == 0.0015
        @test tofloat(Second, Millisecond(1500)) == 1.5
        @test tofloat(Second, Second(1500)) == 1500.0
        @test tofloat(Second, Minute(1500)) == 1500.0 * 60
        @test tofloat(Second, Hour(1500)) == 1500.0 * 60 * 60
        @test tofloat(Second, Day(1500)) == 1500.0 * 60 * 60 * 24
        @test tofloat(Second, Week(1500)) == 1500.0 * 60 * 60 * 24 * 7
        @test tofloat(Second, Time(1,2,3,4,5,6)) ≈ time123456ns*1e-9
        @test tofloat(Second, Second(1) + Millisecond(500)) == 1.5
    end
    @testset "minute" begin
        @test tofloat(Minute, Nanosecond(1500)) ≈ 0.0000015 / 60 # rounding error
        @test tofloat(Minute, Microsecond(1500)) == 0.0015 / 60
        @test tofloat(Minute, Millisecond(1500)) == 1.5 / 60
        @test tofloat(Minute, Second(1500)) == 1500.0 / 60
        @test tofloat(Minute, Minute(1500)) == 1500.0
        @test tofloat(Minute, Hour(1500)) == 1500.0 * 60
        @test tofloat(Minute, Day(1500)) == 1500.0 * 60 * 24
        @test tofloat(Minute, Week(1500)) == 1500.0 * 60 * 24 * 7
        @test tofloat(Minute, Time(1,2,3,4,5,6)) == time123456ns*1e-9 / 60
        @test tofloat(Minute, Second(1) + Millisecond(500)) == 1.5 / 60
    end
    @testset "hour" begin
        @test tofloat(Hour, Nanosecond(1500)) ≈ 0.0000015 / 60 / 60 # rounding error
        @test tofloat(Hour, Microsecond(1500)) == 0.0015 / 60 / 60
        @test tofloat(Hour, Millisecond(1500)) == 1.5 / 60 / 60
        @test tofloat(Hour, Second(1500)) == 1500.0 / 60 / 60
        @test tofloat(Hour, Minute(1500)) == 1500.0 / 60
        @test tofloat(Hour, Hour(1500)) == 1500.0
        @test tofloat(Hour, Day(1500)) == 1500.0 * 24
        @test tofloat(Hour, Week(1500)) == 1500.0 * 24 * 7
        @test tofloat(Hour, Time(1,2,3,4,5,6)) == time123456ns*1e-9 / 60 / 60
        @test tofloat(Hour, Second(1) + Millisecond(500)) == 1.5 / 60 / 60
    end
    @testset "day" begin
        @test tofloat(Day, Nanosecond(1500)) ≈ 0.0000015 / 60 / 60 / 24
        @test tofloat(Day, Microsecond(1500)) == 0.0015 / 60 / 60 / 24
        @test tofloat(Day, Millisecond(1500)) == 1.5 / 60 / 60 / 24
        @test tofloat(Day, Second(1500)) == 1500.0 / 60 / 60 / 24
        @test tofloat(Day, Minute(1500)) == 1500.0 / 60 / 24
        @test tofloat(Day, Hour(1500)) == 1500.0 / 24
        @test tofloat(Day, Day(1500)) == 1500.0 * 24 / 24
        @test tofloat(Day, Week(1500)) == 1500.0 * 24 * 7 / 24
        @test tofloat(Day, Time(1,2,3,4,5,6)) ≈ time123456ns*1e-9 / 60 / 60 / 24
        @test tofloat(Day, Second(1) + Millisecond(500)) == 1.5 / 60 / 60 / 24
    end
    @testset "week" begin
        @test tofloat(Week, Nanosecond(1500)) ≈ 0.0000015 / 60 / 60 / 24 / 7
        @test tofloat(Week, Microsecond(1500)) ≈ 0.0015 / 60 / 60 / 24 / 7
        @test tofloat(Week, Millisecond(1500)) == 1.5 / 60 / 60 / 24 / 7
        @test tofloat(Week, Second(1500)) ≈ 1500.0 / 60 / 60 / 24 / 7
        @test tofloat(Week, Minute(1500)) == 1500.0 / 60 / 24 / 7
        @test tofloat(Week, Hour(1500)) == 1500.0 / 24 / 7
        @test tofloat(Week, Day(1500)) == 1500.0 * 24 / 24 / 7
        @test tofloat(Week, Week(1500)) == 1500.0 * 24 * 7 / 24 / 7
        @test tofloat(Week, Time(1,2,3,4,5,6)) ≈ time123456ns*1e-9 / 60 / 60 / 24 / 7
        @test tofloat(Week, Second(1) + Millisecond(500)) == 1.5 / 60 / 60 / 24 / 7
    end
    @testset "tosecond" begin
        @test tosecond(Nanosecond(1500)) == 0.0000015
        @test tosecond(Microsecond(1500)) == 0.0015
        @test tosecond(Millisecond(1500)) == 1.5
        @test tosecond(Second(1500)) == 1500.0
        @test tosecond(Minute(1500)) == 1500.0 * 60
        @test tosecond(Hour(1500)) == 1500.0 * 60 * 60
        @test tosecond(Day(1500)) == 1500.0 * 60 * 60 * 24
        @test tosecond(Week(1500)) == 1500.0 * 60 * 60 * 24 * 7
        @test tosecond(Time(1,2,3,4,5,6)) ≈ time123456ns*1e-9
        @test tosecond(Second(1) + Millisecond(500)) == 1.5
    end
end

@testset "fromfloat" begin
    @testset "nanosecond" begin
        @test fromfloat(Nanosecond, 1500, Nanosecond) == Nanosecond(1500)
        @test fromfloat(Nanosecond, 1500, Microsecond) == Nanosecond(1500_000)
        @test fromfloat(Nanosecond, 1500, Millisecond) == Nanosecond(1500_000_000)
        @test fromfloat(Nanosecond, 1500, Second) == Nanosecond(1500_000_000_000)
        @test fromfloat(Nanosecond, 1500, Minute) == Nanosecond(1500_000_000_000 * 60)
        @test fromfloat(Nanosecond, 1500, Hour) == Nanosecond(1500_000_000_000 * 60 * 60)
        @test fromfloat(Nanosecond, 1500, Day) == Nanosecond(1500_000_000_000 * 60 * 60 * 24)
        @test fromfloat(Nanosecond, 1500, Week) == Nanosecond(1500_000_000_000 * 60 * 60 * 24 * 7)
        @test fromfloat(Time, time123456ns, Nanosecond) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1500_000_000, Nanosecond) == Second(1) + Millisecond(500)
    end
    @testset "microsecond" begin
        @test fromfloat(Microsecond, 1500, Nanosecond) == Microsecond(2) # lossy
        @test fromfloat(Microsecond, 1500, Microsecond) == Microsecond(1500)
        @test fromfloat(Microsecond, 1500, Millisecond) == Microsecond(1500_000)
        @test fromfloat(Microsecond, 1500, Second) == Microsecond(1500_000_000)
        @test fromfloat(Microsecond, 1500, Minute) == Microsecond(1500_000_000 * 60)
        @test fromfloat(Microsecond, 1500, Hour) == Microsecond(1500_000_000 * 60 * 60)
        @test fromfloat(Microsecond, 1500, Day) == Microsecond(1500_000_000 * 60 * 60 * 24)
        @test fromfloat(Microsecond, 1500, Week) == Microsecond(1500_000_000 * 60 * 60 * 24 * 7)
        @test fromfloat(Time, time123456ns*1e-3, Microsecond) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1500_000, Microsecond) == Second(1) + Millisecond(500)
    end
    @testset "millisecond" begin
        @test fromfloat(Millisecond, 1500, Nanosecond) == Millisecond(0) # lossy
        @test fromfloat(Millisecond, 1500, Microsecond) == Millisecond(2)
        @test fromfloat(Millisecond, 1500, Millisecond) == Millisecond(1500)
        @test fromfloat(Millisecond, 1500, Second) == Millisecond(1500_000)
        @test fromfloat(Millisecond, 1500, Minute) == Millisecond(1500_000 * 60)
        @test fromfloat(Millisecond, 1500, Hour) == Millisecond(1500_000 * 60 * 60)
        @test fromfloat(Millisecond, 1500, Day) == Millisecond(1500_000 * 60 * 60 * 24)
        @test fromfloat(Millisecond, 1500, Week) == Millisecond(1500_000 * 60 * 60 * 24 * 7)
        @test fromfloat(Time, time123456ns*1e-6, Millisecond) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1500, Millisecond) == Second(1) + Millisecond(500)
    end
    @testset "second" begin
        @test fromfloat(Second, 1500, Nanosecond) == Second(0) # lossy
        @test fromfloat(Second, 1500, Microsecond) == Second(0) # lossy
        @test fromfloat(Second, 1500, Millisecond) == Second(2)
        @test fromfloat(Second, 1500, Second) == Second(1500)
        @test fromfloat(Second, 1500, Minute) == Second(1500 * 60)
        @test fromfloat(Second, 1500, Hour) == Second(1500 * 60 * 60)
        @test fromfloat(Second, 1500, Day) == Second(1500 * 60 * 60 * 24)
        @test fromfloat(Second, 1500, Week) == Second(1500 * 60 * 60 * 24 * 7)
        @test fromfloat(Time, time123456ns*1e-9, Second) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1.5, Second) == Second(1) + Millisecond(500)
    end
    @testset "minute" begin
        @test fromfloat(Minute, 1500, Nanosecond) == Minute(0) # lossy
        @test fromfloat(Minute, 1500, Microsecond) == Minute(0) # lossy
        @test fromfloat(Minute, 1500, Millisecond) == Minute(0) # lossy
        @test fromfloat(Minute, 1500, Second) == Minute(1500 / 60)
        @test fromfloat(Minute, 1500, Minute) == Minute(1500)
        @test fromfloat(Minute, 1500, Hour) == Minute(1500 * 60)
        @test fromfloat(Minute, 1500, Day) == Minute(1500 * 60 * 24)
        @test fromfloat(Minute, 1500, Week) == Minute(1500 * 60 * 24 * 7)
        @test fromfloat(Time, time123456ns*1e-9 / 60, Minute) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1.5 / 60, Minute) == Second(1) + Millisecond(500)
    end
    @testset "hour" begin
        @test fromfloat(Hour, 1500, Nanosecond) == Hour(0) # lossy
        @test fromfloat(Hour, 1500, Microsecond) == Hour(0) # lossy
        @test fromfloat(Hour, 1500, Millisecond) == Hour(0) # lossy
        @test fromfloat(Hour, 1500, Second) == Hour(0) # lossy
        @test fromfloat(Hour, 1500, Minute) == Hour(1500 / 60)
        @test fromfloat(Hour, 1500, Hour) == Hour(1500)
        @test fromfloat(Hour, 1500, Day) == Hour(1500 * 24)
        @test fromfloat(Hour, 1500, Week) == Hour(1500 * 24 * 7)
        @test fromfloat(Time, time123456ns*1e-9 / 60 / 60, Hour) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1.5 / 60 / 60, Hour) == Second(1) + Millisecond(500)
    end
    @testset "day" begin
        @test fromfloat(Day, 1500, Nanosecond) == Day(0) # lossy
        @test fromfloat(Day, 1500, Microsecond) == Day(0) # lossy
        @test fromfloat(Day, 1500, Millisecond) == Day(0) # lossy
        @test fromfloat(Day, 1500, Second) == Day(0) # lossy
        @test fromfloat(Day, 1500, Minute) == Day(1)
        @test fromfloat(Day, 1500, Hour) == Day(62) # banker's rounding rounds 1500/24 down
        @test fromfloat(Day, 1500, Day) == Day(1500)
        @test fromfloat(Day, 1500, Week) == Day(1500 * 7)
        @test fromfloat(Time, time123456ns*1e-9 / 60 / 60 / 24, Day) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1.5 / 60 / 60 / 24, Day) == Second(1) + Millisecond(500)
    end
    @testset "week" begin
        @test fromfloat(Week, 1500, Nanosecond) == Week(0) # lossy
        @test fromfloat(Week, 1500, Microsecond) == Week(0) # lossy
        @test fromfloat(Week, 1500, Millisecond) == Week(0) # lossy
        @test fromfloat(Week, 1500, Second) == Week(0) # lossy
        @test fromfloat(Week, 1500, Minute) == Week(0)
        @test fromfloat(Week, 1500, Hour) == Week(9) # banker's rounding rounds 1500/24 down
        @test fromfloat(Week, 1500, Day) == Week(214)
        @test fromfloat(Week, 1500, Week) == Week(1500)
        @test fromfloat(Time, time123456ns*1e-9 / 60 / 60 / 24 / 7, Week) == Time(1,2,3,4,5,6)
        @test fromfloat(Dates.CompoundPeriod, 1.5 / 60 / 60 / 24 / 7, Week) == Second(1) + Millisecond(500)
    end
    @testset "fromsecond" begin
        @test fromsecond(Nanosecond, 0.0000015) == Nanosecond(1500)
        @test fromsecond(Microsecond, 0.0015) == Microsecond(1500)
        @test fromsecond(Millisecond, 1.5) == Millisecond(1500)
        @test fromsecond(Second, 1500.0) == Second(1500)
        @test fromsecond(Minute, 1500.0 * 60) == Minute(1500)
        @test fromsecond(Hour, 1500.0 * 60 * 60) == Hour(1500)
        @test fromsecond(Day, 1500.0 * 60 * 60 * 24) == Day(1500)
        @test fromsecond(Week, 1500.0 * 60 * 60 * 24 * 7) == Week(1500)
        @test fromsecond(Time, time123456ns*1e-9) == Time(1,2,3,4,5,6)
        @test fromsecond(Dates.CompoundPeriod, 1.5) == Second(1) + Millisecond(500)
    end
end

@testset "round trip" begin
    for T in (Nanosecond, Microsecond, Millisecond, Second, Minute, Hour, Day, Week)
        org = T(123)
        @test fromsecond(T, tosecond(org)) == org
    end

    org = Time(1,2,3,4,5,6)
    @test fromsecond(Time, tosecond(org)) == org

    org = Nanosecond(1) + Microsecond(2) + Millisecond(3) + Second(4) + Minute(5) + Hour(6) + Day(7) + Week(8)
    @test fromsecond(Dates.CompoundPeriod, tosecond(org)) == org
end

@testset "Aqua.jl" begin
    Aqua.test_all(TimeFloats)
end
