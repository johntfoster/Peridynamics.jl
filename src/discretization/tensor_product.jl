export create_grid

"""
    create_grid(bounds[, steps])

Create a Cartesian grid by discretizing the line segment, rectangle, or box 
defined by `bounds` in increments of `steps`.  If `steps` is not defined, a 
default step size of 1.0 will be used in all directions.

# Arguments
- `bounds::Array{<:Number}`: Array that defines the min/max values of a line 
segment(1D), rectangle (2D), or box (3D) that the grid will be placed in.  The 
first row of the array defines the min values, the second row defines the max 
values.
- `steps`::Array: Array that defines how many steps in each direction.  If the 
array values in `steps` are integers then those values define how many points 
are used in each direction.  If the array values in `steps` are floating point 
numbers then those values define the step size in each direction.

# Examples
```jldoctest
julia> create_grid([0; 2], [2])
2-element Array{Float64,1}:
 0.0
 2.0
```

```jldoctest
julia> create_grid([0 0; 2 2], [2.0 1.0])
6×2 Array{Float64,2}:
 0.0  0.0
 0.0  1.0
 0.0  2.0
 2.0  0.0
 2.0  1.0
 2.0  2.0
```

```jldoctest
julia> create_grid([0 0 0; 2 2 2], [2 2 2])
8×3 Array{Float64,2}:
 0.0  0.0  0.0
 0.0  0.0  2.0
 0.0  2.0  0.0
 0.0  2.0  2.0
 2.0  0.0  0.0
 2.0  0.0  2.0
 2.0  2.0  0.0
 2.0  2.0  2.0
```
"""
function create_grid(bounds::Array{<:Number}, steps::Array{T}) where {T<:Union{AbstractFloat, Integer}}
    
    if length(size(bounds)) == 1
        dimension = 1
    else
        dimension = size(bounds)[2] 
    end
    
    if dimension ≠ length(steps)
        throw(ArgumentError("""Dimension mismatch in arguments.  bounds indicates 
                dimension = $dimension. steps indicates dimension = $(length(steps))"""))
    end
    
    if T <: AbstractFloat
        my_range = (start, step, stop) -> start:step:stop
    elseif T <: Integer
        my_range = (start, step, stop) -> LinRange(start, stop, step)
    end
    
    if dimension == 1
        xrange = my_range(bounds[1], steps[1], bounds[2])
        number_of_points = length(xrange)
        x = [ i for i in xrange ]
    elseif dimension == 2
        xrange = my_range(bounds[1,1], steps[1], bounds[2, 1])
        yrange = my_range(bounds[1,2], steps[2], bounds[2, 2])
        x = [ x for x in xrange for j in 1:length(yrange) ]
        y = [ y for i in 1:length(xrange) for y in yrange ]
        [x y]
    elseif dimension == 3
        xrange = my_range(bounds[1,1], steps[1], bounds[2, 1])
        yrange = my_range(bounds[1,2], steps[2], bounds[2, 2])
        zrange = my_range(bounds[1,2], steps[3], bounds[2, 3])
        x = [ x for x in xrange for j in 1:length(yrange) for k in 1:length(zrange) ]
        y = [ y for i in 1:length(xrange) for y in yrange for k in 1:length(zrange) ]
        z = [ z for i in 1:length(xrange) for j in 1:length(yrange) for z in zrange ]
        [x y z]
    else
        throw(ArgumentError("Can't have more than 3 spatial dimensions for grid."))
    end
    
end

function create_grid(bounds::Array{<:Number})

    if length(size(bounds)) == 1
        dimension = 1
    else
        dimension = size(bounds)[2] 
    end

    if dimension == 1
        steps = [1.0]
    elseif dimension == 2
        steps = [1.0 1.0]
    elseif dimension == 3
        steps = [1.0 1.0 1.0]
    else
        throw(ArgumentError("Can't have more than 3 spatial dimensions for grid."))
    end

    create_grid(bounds, steps)

end
    
