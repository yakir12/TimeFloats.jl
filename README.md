# TimeFloats

[![Stable Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://yakir12.github.io/TimeFloats.jl/stable)
[![Development documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://yakir12.github.io/TimeFloats.jl/dev)
[![Test workflow status](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Test.yml/badge.svg?branch=main)](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Test.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/yakir12/TimeFloats.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/yakir12/TimeFloats.jl)
[![Docs workflow Status](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Docs.yml/badge.svg?branch=main)](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Docs.yml?query=branch%3Amain)
[![BestieTemplate](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/JuliaBesties/BestieTemplate.jl/main/docs/src/assets/badge.json)](https://github.com/JuliaBesties/BestieTemplate.jl)
[![Aqua QA](https://juliatesting.github.io/Aqua.jl/dev/assets/badge.svg)](https://github.com/JuliaTesting/Aqua.jl)
[![tested with JET.jl](https://img.shields.io/badge/%F0%9F%9B%A9%EF%B8%8F_tested_with-JET.jl-233f9a)](https://github.com/aviatesk/JET.jl)

`TimeFloats.jl` is a tiny utility package that converts between Julia's `Dates` period types (`Nanosecond`, `Second`, `Hour`, `Time`, `CompoundPeriod`, etc.) and plain floating-point numbers, using any `FixedPeriod` as the unit of measurement.

## Who needs this?
- Do you need to convert a `Dates.Time` to float seconds?
```julia
julia> tosecond(Time(13,39,42,652))
49182.652
```
- Do you need to convert a `Dates.CompoundPeriod` to float minutes?
```julia
julia> tofloat(Minute, Week(21) + Hour(32) + Millisecond(45))
213600.00075
```
- Do you need to convert a `Dates.Hour` to float nanoseconds?
```julia
julia> tofloat(Nanosecond, Hour(3))
1.08e13
```
- Or how about converting from a float seconds to its canonical form?
```julia
julia> fromsecond(92384756.9823465)
92384756 seconds, 982 milliseconds, 346 microseconds, 504 nanoseconds
```
- Or converting from a float milliseconds to `Minute`s (OBS: this approximates the result to the closest integer of minutes)?
```julia
julia> fromfloat(60_123, Millisecond)
60123 milliseconds
```

In short, if you've been copy-pasting `tosecond{T}(t::T) = t / convert(T, Base.Dates.Second(1))` from Kristoffer Carlsson's [post](https://discourse.julialang.org/t/convert-time-interval-to-seconds/3806/2?u=yakir12), then this package should be useful.

# Comparison with `DateFormats`

TimeFloats | DateFormats
--- | ---
tofloat(Minute, Second(3)) | Second(3) /ₜ Minute
tosecond(Millisecond(1500) + Day(1)) | (Millisecond(1500) + Day(1)) /ₜ Second
fromfloat(1.5, Minute) | 1.5 *ₜ Minute
fromsecond(123.456) | 123.456 *ₜ Second
tosecond(Time(13,39,42,652)) | (Time(13,39,42,652) - Time(0)) /ₜ Second
tofloat(Minute, Week(21) + Hour(32) + Millisecond(45)) | (Week(21) + Hour(32) + Millisecond(45)) /ₜ Minute
x | Dates and DateTimes handling

