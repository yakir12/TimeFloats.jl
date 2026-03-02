# TimeFloats

[![Stable Documentation](https://img.shields.io/badge/docs-stable-blue.svg)](https://yakir12.github.io/TimeFloats.jl/stable)
[![Development documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://yakir12.github.io/TimeFloats.jl/dev)
[![Test workflow status](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Test.yml/badge.svg?branch=main)](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Test.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/yakir12/TimeFloats.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/yakir12/TimeFloats.jl)
[![Docs workflow Status](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Docs.yml/badge.svg?branch=main)](https://github.com/yakir12/TimeFloats.jl/actions/workflows/Docs.yml?query=branch%3Amain)
[![BestieTemplate](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/JuliaBesties/BestieTemplate.jl/main/docs/src/assets/badge.json)](https://github.com/JuliaBesties/BestieTemplate.jl)

Do you need to convert a `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Time`, or `CompoundPeriod` to a float second, e.g. `Millisecond(1500)` to `1.5`?
```
using TimeFloats
julia> tosecond(Millisecond(1500))
1.5
```

This small package does exactly that.

## tofloat
This package converts any `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Time`, or `CompoundPeriod` to a floating number (`Float64`) representing some `TimePeriod` of your choice (not just `Second` as shown above) with the `tofloat(T<:TimePeriod, x)` function. `x` can be any of the subtypes of `TimePeriod` (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, and `Hour`), `Time`, or `Dates.CompoundPeriod`, and `T` must be a subtypes of `TimePeriod`.

## fromfloat
`fromfloat(T<:AbstractTime, x::Real, S<:TimePeriod)` does the inverse of `tofloat`: given `x` nanoseconds, microseconds, milliseconds, seconds, minutes, or hours (denoted by `S`, a subtype of `TimePeriod`), express it as an instance of type `T` (can be any `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Time`, or `CompoundPeriod`). Note that this can be a lossy conversion, e.g. 2 minutes as `Hour` is `Hour(0)` (not `Hour(2/60)`).

## Convinience functions
There are two convinience functions defnied in this package for the most common cases where you want to convert to seconds, `tosecond`, and when you want to convert from seconds, `fromsecond`.
