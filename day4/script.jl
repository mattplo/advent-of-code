
lines = read(joinpath(@__DIR__,"./input.txt"),String)

function check_fields_part1(fields::Dict{String,String})
    @show fields
    for (key,val) in fields
        if val == "" && key != "cid"
            return false
        end
    end
    return true
end

function check_fields_part2(fields::Dict{String,String})
    @show fields
    if fields["byr"]=="" || !(1920 <= parse(Int,fields["byr"]) <= 2002)
        return false
    end
    if fields["iyr"]=="" || !(2010 <= parse(Int,fields["iyr"]) <= 2020)
        return false
    end
    if fields["eyr"]=="" || !(2020 <= parse(Int,fields["eyr"]) <= 2030)
        return false
    end
    len_hgt = length(fields["hgt"])
    if length(fields["hgt"])>2
        height_value = parse(Int,fields["hgt"][1:len_hgt-2])
        height_unit = fields["hgt"][len_hgt-1:len_hgt]
        if !((height_unit == "cm" && 150 <= height_value <= 193) || (height_unit == "in" && 59 <= height_value <= 76))
            return false
        end
    else
        return false
    end
    if !(occursin(r"^#[a-f0-9]{6}$",fields["hcl"]))
        return false
    end
    if !(fields["ecl"] in ["amb","blu","brn","gry","grn","hzl","oth"])
        return false
    end
    if !(occursin(r"^[0-9]{9}$",fields["pid"]))
        return false
    end
    return true
end

function check_passports(file::String,checking_function)
    valid_passports=0
    passports = split(file,"\n\n",keepempty=false)
    for passport in passports
        fields = Dict("hcl" => "","ecl" => "","hgt" => "","pid" => "","iyr" => "","eyr" => "","cid" => "","byr" => "")
        props = split(passport,('\n',' '),keepempty=false)
        for prop in props
            key = prop[1:3]
            value = prop[5:length(prop)]
            fields[key]=value
        end
        valid_passports += checking_function(fields)
    end
    return valid_passports
end

check_passports(lines,check_fields_part1)
check_passports(lines,check_fields_part2)
