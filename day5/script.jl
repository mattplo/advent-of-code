
lines = readlines(joinpath(@__DIR__,"./input.txt"))

function codes_to_ids(codes::Vector{String})
    ids = Vector{Int}()
    for code in codes
        binary_code = map(char -> (char==='F' || char==='L') ? '0' : '1', code)
        seat_id = parse(Int,binary_code,base=2)
        push!(ids,seat_id)
    end
    return ids
end

function find_missing_seat(seat_ids::Vector{Int})
    sorted_seats=sort(seat_ids)
    for i in 1:length(sorted_seats)-1
        if sorted_seats[i+1]!==sorted_seats[i]+1
            @show sorted_seats[i+1]
            @show sorted_seats[i]
        end
    end
end


maximum(codes_to_ids(lines))
find_missing_seat(codes_to_ids(lines))
