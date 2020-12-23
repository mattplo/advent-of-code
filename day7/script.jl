using LightGraphs
using SimpleWeightedGraphs
using GraphPlot
using BenchmarkTools

rules = readlines(joinpath(@__DIR__,"./input.txt"))

function build_graph(rules::Vector{String},reverse=true)
    bags_nb = length(rules)
    bags_ids = Dict{String,Int}()
    nodes_labels = Vector{String}()
    graph = SimpleWeightedDiGraph(bags_nb)
    i=1
    for rule in rules
        bag_color = rule[1:minimum(findfirst("bags contain",rule))-2]
        push!(nodes_labels,bag_color)
        bags_ids[bag_color]=i
        i+=1
    end
    i=1
    for rule in rules
        content = rule[maximum(findfirst("bags contain",rule))+2:end]
        for bag in split(content[1:length(content)-1],", ",keepempty=false)
            if bag!="no other bags"
                res = match(r"^([0-9]*) (.*?) bags?$",bag)
                bag_color = res[2]
                bag_nb = parse(Int,res[1])
                if reverse
                    add_edge!(graph,bags_ids[bag_color],i,bag_nb)
                else
                    add_edge!(graph,i,bags_ids[bag_color],bag_nb)
                end
            end
        end
        i+=1
    end
    return graph,bags_ids,nodes_labels
end

function part1(rules::Vector{String})
    graph,bags_ids,nodes_labels = build_graph(rules)
    distances = gdistances(graph, bags_ids["shiny gold"])
    number_ancestors = count(i->0<i<typemax(Int),distances)
    return number_ancestors
end

function part2(rules::Vector{String})
    graph,bags_ids,nodes_labels = build_graph(rules,false)
    edge_weights = [weight(edge) for edge in edges(graph)]
    nodes_values = zeros(length(rules))
    function compute_node_value!(nodes_values,node)
        temp = 1
        for child in outneighbors(graph,node)
            if nodes_values[child]==0
                compute_node_value!(nodes_values,child)
            end

            temp+=graph.weights[child,node]*nodes_values[child]
        end
        nodes_values[node]=temp
    end
    compute_node_value!(nodes_values,bags_ids["shiny gold"])
    return nodes_values[bags_ids["shiny gold"]]-1
end

part1(rules)
part2(rules)
