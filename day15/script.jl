
function spoken_number(start_numbers::Vector{Int},nth::Int)
    turn = 1
    spoken_numbers = Dict{Int,Int}()
    spoken_number=0
    last_spoken_number=0
    while turn <= nth
        last_spoken_number=spoken_number
        if turn<=length(start_numbers)
            spoken_number=start_numbers[turn]
        else
            if haskey(spoken_numbers,last_spoken_number)
                spoken_number=turn-1-spoken_numbers[last_spoken_number]
            else
                spoken_number=0
            end
        end
        spoken_numbers[last_spoken_number]=turn-1
        turn+=1
    end
    spoken_number
end

spoken_number([8,13,1,0,18,9],2020)
spoken_number([8,13,1,0,18,9],30000000)
