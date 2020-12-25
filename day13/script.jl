lines = readlines(joinpath(@__DIR__, "./input.txt"))

function part1(lines::Vector{String})
    timestamp = parse(Int,lines[1])
    buses = parse.(Int,filter(x->x != "x",split(lines[2],",",keepempty=false)))
    min_wait = typemax(Int)
    selected_bus = 0
    for bus in buses
        wait = bus - timestamp%bus
        if wait < min_wait
            selected_bus=bus
            min_wait=wait
        end
    end
    return selected_bus*min_wait
end

# gives the lowest x satisfying x ≡ ai mod ni for i
function chinese_remainder(n::Array, a::Array)
    product = prod(n)
    x = sum(ai * invmod(div(product,ni), ni) * div(product,ni) for (ni, ai) in zip(n, a))
    return min(mod(x,product),mod(-x,product))
end

function part2(lines::Vector{String})
    a = Vector{Int}()
    n = Vector{Int}()
    buses = split(lines[2],",",keepempty=false)
    i=0
    for bus in buses
        if bus != "x"
            bus = parse(Int,bus)
            push!(n,bus)
            push!(a,i)
        end
        i+=1
    end
    return chinese_remainder(n,a)
end

part1(lines)
part2(lines)
