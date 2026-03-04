module TimeFloats

import Dates: Nanosecond, Second, Day, value, Time, CompoundPeriod, FixedPeriod, periods
import Base: uniontypes

export tofloat, fromfloat, tosecond, fromsecond

const fixedperiods::Vector{DataType} = sort(uniontypes(FixedPeriod), by=oneunit, rev = true)

const magnitude = let
    inns = oneunit.(fixedperiods)./Nanosecond(1)
    mag = Int.(inns[1:end-1] ./ inns[2:end])
    push!(mag, 1)
    Pair.(fixedperiods, mag)
end

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

for S in fixedperiods, T in fixedperiods
    if S == T
        @eval tofloat(::Type{$S}, x::$T) = Float64(value(x))
    elseif oneunit(S) < oneunit(T)
        @eval tofloat(::Type{$S}, x::$T) = Float64(value($S(x)))
    else
        @eval tofloat(::Type{$S}, x::$T) = Float64(x/convert($T, $S(1)))
    end
end

tofloat(::Type{S}, x::Time) where {S<:FixedPeriod} = tofloat(S, x - Time(0))

function tofloat(::Type{S}, x::CompoundPeriod) where {S<:FixedPeriod}
    p = periods(x)
    isempty(p) && return 0.0
    tofloat(S, convert(typeof(minimum(oneunit, p)), x))
end

"""
    fromsecond(::Type{T}, x::Real) where {T<:Union{FixedPeriod, Time, CompoundPeriod}}

Convert `x` seconds to a `T`. `T` is any of the types in the `Dates.FixedPeriod` union-type (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Day`, and `Week`), `Time`, or `Dates.CompoundPeriod`.

# Examples
```jldoctest
julia> using Dates

julia> fromsecond(Millisecond, 1.5)
1500 milliseconds
```

## Notice
This conversion is inherently lossy: the resulting `T` instance might not be able to accurately represent the float seconds. In the following example, we want to convert 0.0015 seconds, i.e. 1.5 milliseconds, to `Millisecond`s. Since `Millisecond`s can only hold integers, the 1.5 milliseconds is rounded to 2:

```jldoctest
julia> using Dates

julia> fromsecond(Millisecond, 0.0015)
2 milliseconds
```

This is perhaps more common when converting to time units that are longer than seconds:

```jldoctest
julia> using Dates

julia> fromsecond(Minute, 1)
0 minutes
```
"""
fromsecond(::Type{T}, x::Real) where {T<:Union{FixedPeriod, Time, CompoundPeriod}} = fromfloat(T, x, Second)

@doc """
    fromfloat(::Type{T}, x::Real, ::Type{S}) where {T<:Union{FixedPeriod, Time, CompoundPeriod}, S<:FixedPeriod}

Convert `x` `S` to a `T`. `S` is any of the types in the `Dates.FixedPeriod` union-type (i.e. `Nanosecond`, `Microsecond`, `Millisecond`, `Second`, `Minute`, `Hour`, `Day`, or `Week`), while `T` is any of the types in the `Dates.FixedPeriod` union-type, `Time`, or `Dates.CompoundPeriod`.

# Examples
```jldoctest
julia> using Dates

julia> fromfloat(Millisecond, 1, Second)
1000 milliseconds
```

## Notice
This conversion is inherently lossy: the resulting `T` instance might not be able to accurately represent the float `S`. In the following example, we want to convert 1.5 milliseconds to `Millisecond`s. Since `Millisecond`s can only hold integers, the 1.5 milliseconds is rounded to 2:

```jldoctest
julia> using Dates

julia> fromfloat(Millisecond, 1.5, Millisecond)
2 milliseconds
```

This is perhaps more common when converting to time units that are longer than what the float represents:

```jldoctest
julia> using Dates

julia> fromfloat(Minute, 1, Millisecond)
0 minutes
```
""" fromfloat

for S in fixedperiods, T in fixedperiods
    if S == T
        @eval fromfloat(::Type{$T}, x::Real, ::Type{$S}) = $T(round(Int, x))
    elseif oneunit(S) < oneunit(T)
        @eval fromfloat(::Type{$T}, x::Real, ::Type{$S}) = $T(round(Int, x / value($S($T(1)))))
    else
        @eval fromfloat(::Type{$T}, x::Real, ::Type{$S}) = $T(round(Int, x * value($T($S(1)))))
    end
end

trim(::Type{CompoundPeriod}, x) = x
function trim(::Type{Time}, x) 
    ps = periods(x)
    res = Time(0)
    for p in ps
        if oneunit(p) < Day(1)
            res += p
        end
    end
    return res
end

function fromfloat(::Type{T}, x::Real, ::Type{S}) where {T<:Union{Time, CompoundPeriod}, S<:FixedPeriod}
    i = findfirst(==(S), fixedperiods)
    res = CompoundPeriod()
    for (F, m) in @view magnitude[i:end]
        Δ = trunc(x)
        x -= Δ
        x *= m
        res += F(Δ)
    end
    return trim(T, res)
end

end
