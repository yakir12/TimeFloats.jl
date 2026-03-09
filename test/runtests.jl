using Dates
using TimeFloats
using Test
using Aqua
using JET

const time123456ns = 3723004005006 # == (60*60 + 2*60 + 3) * 1e9 + 4e6 + 5e3 + 6

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
        @test tofloat(Day, Day(1500)) == 1500.0
        @test tofloat(Day, Week(1500)) == 1500.0 * 7
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
        @test tofloat(Week, Day(1500)) == 1500.0 / 7
        @test tofloat(Week, Week(1500)) == 1500.0
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
    @testset "integers" for T in (Nanosecond, Microsecond, Millisecond, Second, Minute, Hour, Day, Week)
        @test fromfloat(1500, T) == T(1500)
    end
    @testset "fractionals" begin
        @test fromfloat(15.123, Nanosecond) == Nanosecond(15) # lossy
        @test fromfloat(15 + 123//1000, Microsecond) == Nanosecond(15123)
        @test fromfloat(15 + 123//1000 + 456//1000_000, Millisecond) == Nanosecond(15123456)
        @test fromfloat(15 + 123//1000, Second) == Millisecond(15123)
        @test fromfloat(1500 + 12//60 + 11//60//1000, Minute) == Minute(1500) + Second(12) + Millisecond(11)
        @test fromfloat(1500 + 1//10, Hour) == Hour(1500) + Minute(6)
        @test fromfloat(1500 + 1//24, Day) == Day(1500) + Hour(1)
        @test fromfloat(1500 + 1//7, Week) == Week(1500) + Day(1)
    end
end
@testset "fromsecond" begin
    @testset "integers" begin
        @test fromsecond(1500) == Second(1500)
    end
    @testset "fractionals" begin
        @test fromsecond(15 + 123//1000) == Second(15) + Millisecond(123)
    end
end

@testset "round trip" begin
    for T in (Nanosecond, Microsecond, Millisecond, Second, Minute, Hour, Day, Week)
        org = T(123)
        @test fromsecond(tosecond(org)) == org
    end
end

@testset "edge cases" begin
    @testset "empty CompoundPeriod" begin
        @test tofloat(Nanosecond, Dates.CompoundPeriod()) == 0.0
        @test tofloat(Second, Dates.CompoundPeriod()) == 0.0
        @test tofloat(Week, Dates.CompoundPeriod()) == 0.0
    end

    @testset "zero values" begin
        @test iszero(tofloat(Minute, Hour(0)))
        @test iszero(tosecond(Millisecond(0)))
        @test isempty(Dates.periods(fromfloat(0, Week)))
        @test isempty(Dates.periods(fromsecond(0)))
        @test isempty(Dates.periods(fromfloat(0.0, Day)))
        @test isempty(Dates.periods(fromsecond(0.0)))
    end

    @testset "negative values" begin
        @test tosecond(Second(-5)) == -5.0
        @test tosecond(Millisecond(-1500)) == -1.5
        @test tofloat(Minute, Hour(-2)) == -120.0
        @test fromsecond(-1.5) == Millisecond(-1500)
        @test fromsecond(-90.0) == Second(-90)
        @test tofloat(Second, Second(-1) + Millisecond(-500)) == -1.5
        @test fromfloat(-3//2 - 1//60//2, Minute) == Minute(-1) + Second(-30) + Millisecond(-500)
    end

    @testset "large values" begin
        @test tosecond(Week(1000)) == 1000.0 * 60 * 60 * 24 * 7
        @test tofloat(Nanosecond, Day(100)) == 100.0 * 24 * 60 * 60 * 1e9
        @test fromsecond(1e10) == Second(1e10)
    end
end

@testset "Aqua.jl" begin
    Aqua.test_all(TimeFloats)
end

@testset "JET tests" begin
    JET.test_package(TimeFloats; target_modules = (TimeFloats,))
end
