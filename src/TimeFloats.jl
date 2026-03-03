module TimeFloats

import Dates: Nanosecond, Second, value, Time, CompoundPeriod, canonicalize, FixedPeriod

export tofloat, fromfloat, tosecond, fromsecond

const fixedperiods = Base.uniontypes(FixedPeriod)

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

for S in fixedperiods, T in fixedperiods
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
tofloat(::Type{S}, x::Time) where {S<:FixedPeriod} = tofloat(S, x - Time(0))

tofloat(::Type{S}, x::CompoundPeriod) where {S<:FixedPeriod} = tofloat(S, convert(typeof(minimum(oneunit, x.periods)), x))

"""
    fromsecond(T<:TimePeriod, x)

Approximate a float representation of `x` in seconds to a `T` time period. `T` can be any of the subtypes of `TimePeriod` (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, and `Hour`), `Time`, or `Dates.CompoundPeriod`.

# Examples
```julia-repl
julia> fromsecond(Millisecond, 1.5)
1500 milliseconds
```
"""
fromsecond(::Type{T}, x) where {T} = fromfloat(T, x, Second)

for S in fixedperiods, T in fixedperiods
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
fromfloat(::Type{Time}, x::Real, ::Type{S}) where {S<:FixedPeriod} = Time(0) + fromfloat(Nanosecond, x, S)

fromfloat(::Type{CompoundPeriod}, x::Real, ::Type{S}) where {S<:FixedPeriod} = canonicalize(fromfloat(Nanosecond, x, S))

end
