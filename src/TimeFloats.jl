module TimeFloats

import Dates: Nanosecond, Microsecond, Millisecond, Second, Minute, Hour, TimePeriod, AbstractTime, value, Time, CompoundPeriod, canonicalize

export tofloat, fromfloat, 
       # tonanosecond, tomicrosecond, tomillisecond, 
       tosecond, 
       # tominute, tohour,
       # fromnanosecond, frommicrosecond, frommillisecond,
       fromsecond,
       # fromminute, fromhour

const TIMEPERIODS = (Nanosecond, Microsecond, Millisecond, Second, Minute, Hour)

# tonanosecond(x) = tofloat(Nanosecond, x)
# tomicrosecond(x) = tofloat(Microsecond, x)
# tomillisecond(x) = tofloat(Millisecond, x)

"""
    tosecond(x)

Convert `x` to a float representation of `x` in seconds. `x` can be any of the subtypes of `TimePeriod` (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, and `Hour`), `Time`, or `Dates.CompoundPeriod`.

# Examples
```julia-repl
julia> toscond(Millisecond(1500))
1.5
```
"""
tosecond(x) = tofloat(Second, x)

# tominute(x) = tofloat(Minute, x)
# tohour(x) = tofloat(Hour, x)

for S in TIMEPERIODS, T in TIMEPERIODS
    if S == T
        @eval tofloat(::Type{$S}, x::$T) = Float64(value(x))
    elseif oneunit(S) < oneunit(T)
        @eval tofloat(::Type{$S}, x::$T) = Float64(value($S(x)))
    else
        @eval tofloat(::Type{$S}, x::$T) = x/convert($T, $S(1))
    end
end


"""
    tofloat(T<:TimePeriod, x)

Convert `x` to a float representation of `x` as a `T` time period. `T` can be any of the subtypes of `TimePeriod` (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, and `Hour`). `x` can be any of the subtypes of `TimePeriod`, `Time`, or `Dates.CompoundPeriod`.

# Examples
```julia-repl
julia> tofloat(Millisecond, Second(1))
1000.0
```
"""
tofloat(::Type{S}, x::Time) where {S<:TimePeriod}= tofloat(S, x - Time(0))

tofloat(::Type{S}, x::CompoundPeriod) where {S<:TimePeriod} = tofloat(S, convert(typeof(minimum(oneunit, x.periods)), x))

# fromnanosecond(::Type{T}, x) where {T<:AbstractTime} = fromfloat(T, x, Nanosecond)
# frommicrosecond(::Type{T}, x) where {T<:AbstractTime} = fromfloat(T, x, Microsecond)
# frommillisecond(::Type{T}, x) where {T<:AbstractTime} = fromfloat(T, x, Millisecond)

"""
    fromsecond(T<:TimePeriod, x)

Approximate a float representation of `x` in seconds to a `T` time period. `T` can be any of the subtypes of `TimePeriod` (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, and `Hour`), `Time`, or `Dates.CompoundPeriod`.

# Examples
```julia-repl
julia> fromsecond(Millisecond, 1.5)
1500 milliseconds
```
"""
fromsecond(::Type{T}, x) where {T<:AbstractTime} = fromfloat(T, x, Second)

# fromminute(::Type{T}, x) where {T<:AbstractTime} = fromfloat(T, x, Minute)
# fromhour(::Type{T}, x) where {T<:AbstractTime} = fromfloat(T, x, Hour)

for S in TIMEPERIODS, T in TIMEPERIODS
    if S == T
        @eval fromfloat(::Type{$T}, x::Real, ::Type{$S}) = $T(round(Int, x))
    elseif oneunit(S) < oneunit(T)
        @eval fromfloat(::Type{$T}, x::Real, ::Type{$S}) = $T(round(Int, x / value($S($T(1)))))
    else
        @eval fromfloat(::Type{$T}, x::Real, ::Type{$S}) = $T(round(Int, x * value($T($S(1)))))
    end
end

"""
    fromfloat(T<:AbstractTime, x::Real, S<:TimePeriod)

Approximate a float representation of `x` as a `S` time persiod to a `T`. `T` can be any of the subtypes of `TimePeriod` (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, and `Hour`), `Time`, and `Dates.CompoundPeriod`.

# Examples
```julia-repl
julia> fromfloat(Millisecond, 1, Second)
1000 milliseconds
```
"""
fromfloat(::Type{Time}, x::Real, ::Type{S}) where {S<:TimePeriod} = Time(0) + fromfloat(Nanosecond, x, S)

fromfloat(::Type{CompoundPeriod}, x::Real, ::Type{S}) where {S<:TimePeriod} = canonicalize(fromfloat(Nanosecond, x, S))

end
