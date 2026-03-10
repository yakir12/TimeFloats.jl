module TimeFloats

import Dates: Nanosecond, Microsecond, Millisecond, Second, Day, Minute, Hour, Week
import Dates: value, Time, CompoundPeriod, FixedPeriod, periods
import Base: uniontypes

export tofloat, fromfloat, tosecond, fromsecond

"""
    tosecond(x)

Convert `x` to a float representation of `x` in seconds. `x` can be any type in the `Dates.FixedPeriod` union-type (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Day`, and `Week`), `Time`, or `Dates.CompoundPeriod`.

# Examples
```jldoctest
julia> using Dates

julia> tosecond(Millisecond(1500))
1.5
```
"""
tosecond(x) = tofloat(Second, x)


@doc """
    tofloat(::Type{T}, x) where {T<:FixedPeriod}

Convert `x` to a float representation of `x` as a `T`. `T` is any of the types in the `Dates.FixedPeriod` union-type (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Day`, or `Week`). `x` can be any of the types in the `Dates.FixedPeriod` union-type, `Time`, or `Dates.CompoundPeriod`.

# Examples
```jldoctest
julia> using Dates

julia> tofloat(Millisecond, Second(1))
1000.0
```
""" tofloat

for S in uniontypes(FixedPeriod), T in uniontypes(FixedPeriod)
    if S == T
        @eval tofloat(::Type{$S}, x::$T) = Float64(value(x))
    elseif oneunit(S) < oneunit(T)
        @eval tofloat(::Type{$S}, x::$T) = Float64(value($S(x)))
    else
        @eval tofloat(::Type{$S}, x::$T) = Float64(x/convert($T, $S(1)))
    end
end

tofloat(::Type{S}, x::Time) where {S<:FixedPeriod} = tofloat(S, x - Time(0))

# uncanonicalize(x::CompoundPeriod) = convert(typeof(minimum(oneunit, periods(x))), x)

function tofloat(::Type{S}, x::CompoundPeriod) where {S<:FixedPeriod}
    p = periods(x)
    isempty(p) && return 0.0
    tofloat(S, convert(typeof(minimum(oneunit, p)), x))
end

"""
    fromsecond(x::Real)

Convert `x` seconds to a CompoundPeriod. The resulting `CompoundPeriod` will include the largest `FixedPeriods` needed to accurately describe `x`.

# Examples
```jldoctest
julia> using Dates

julia> fromsecond(1001//1000)
1 second, 1 millisecond

julia> fromsecond(1.5)
1 second, 500 milliseconds
```

## Notice
Any accuracy after the 9th decimal place of `x` is ignored for nanoseconds. 

```jldoctest
julia> using Dates

julia> fromsecond(0.0000000019)
1 nanosecond
```
"""
fromsecond(x::Real) = fromfloat(x, Second)

@doc """
    fromfloat(x::Real, ::Type{S}) where {S<:FixedPeriod}

Convert `x` `S` to a `CompoundPeriod`. `S` is any of the types in the `Dates.FixedPeriod` union-type (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Day`, or `Week`). The resulting `CompoundPeriod` will include the largest `FixedPeriods` needed to accurately describe `x`.

# Examples
```jldoctest
julia> using Dates

julia> fromfloat(1, Second)
1 second
```
""" fromfloat

next(::Type{Week}) = (Day, 7)
next(::Type{Day}) = (Hour, 24)
next(::Type{Hour}) = (Minute, 60)
next(::Type{Minute}) = (Second, 60)
next(::Type{Second}) = (Millisecond, 1000)
next(::Type{Millisecond}) = (Microsecond, 1000)
next(::Type{Microsecond}) = (Nanosecond, 1000)
next(::Type{Nanosecond}) = (Nothing, 0)

function fromfloat(x::Real, ::Type{S}) where S<:FixedPeriod
    res = CompoundPeriod()
    _S = S
    while x ≠ 0
        Δ = trunc(x)
        res += _S(Δ)
        _S, m = next(_S)
        if _S isa Nothing
            break
        end
        x -= Δ
        x *= m
    end
    return res
end

fromfloat(x::Int, ::Type{S}) where {S<:FixedPeriod} = CompoundPeriod(S(x))

end

