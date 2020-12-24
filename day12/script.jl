lines = readlines(joinpath(@__DIR__, "./input.txt"))

function part1(instructions::Vector{String})
    pos_x,pos_y=0,0
    directions=['E','S','W','N']
    directions_vectors = Dict('E'=>(1,0),'S'=>(0,1),'W'=>(-1,0),'N'=>(0,-1))
    current_direction = 1
    for line in instructions
        cmd = line[1]
        val = parse(Int,line[2:length(line)])
        if cmd == 'F'
            vec_x,vec_y=directions_vectors[directions[current_direction]]
            pos_x+=vec_x*val
            pos_y+=vec_y*val
        elseif cmd == 'L' || cmd == 'R'
            current_direction = mod1(current_direction+(cmd=='R' ? 1 : -1)*div(val,90),4)
        elseif cmd in directions
            vec_x,vec_y=directions_vectors[cmd]
            pos_x+=vec_x*val
            pos_y+=vec_y*val
        end
    end
    return abs(pos_x)+abs(pos_y)
end

function part2(instructions::Vector{String})
    pos_x,pos_y=0,0
    waypoint_x,waypoint_y=10,-1
    directions=['E','S','W','N']
    directions_vectors = Dict('E'=>(1,0),'S'=>(0,1),'W'=>(-1,0),'N'=>(0,-1))
    current_direction = 1
    for line in instructions
        cmd = line[1]
        val = parse(Int,line[2:length(line)])
        if cmd == 'F'
            pos_x+=waypoint_x*val
            pos_y+=waypoint_y*val
        elseif cmd == 'R'
            for i in 1:div(val,90)
                waypoint_y,waypoint_x=waypoint_x,-waypoint_y
            end
        elseif cmd == 'L'
            for i in 1:div(val,90)
                waypoint_x,waypoint_y=waypoint_y,-waypoint_x
            end
        elseif cmd in directions
            vec_x,vec_y=directions_vectors[cmd]
            waypoint_x+=vec_x*val
            waypoint_y+=vec_y*val
        end
    end
    return abs(pos_x)+abs(pos_y)
end

part1(lines)
part2(lines)
