module wellwisejlplots

export traceplot, densplot

using Makie, KernelDensity, Interpolations


function traceplot(res::Dict{Any,Any}, pos::Integer, burnin::Integer)
    Iteration = [burnin + i for i in 1:(size(res[1], 1)-burnin)]
    cols = [:black, :blue, :red, :green, :yellow]
    # make plot
    parname = string(names(res[1])[pos])
	scene = Scene()
    for chain in res
      lines!(scene, Iteration, chain[2][(burnin+1):end,pos], 
        color = cols[chain[1]],
        axis = (
           names = (axisnames = ("Iteration", parname),),
           grid = (linewidth = (0, 0),),
           )
           )
    end
    return scene
end


function traceplot(res::Dict{Any,Any}, colnm::Symbol, burnin::Integer)
    Iteration = [burnin + i for i in 1:(size(res[1], 1)-burnin)]
    cols = [:black, :blue, :red, :green, :yellow]
    # make plot
    parname = string(colnm)
	scene = Scene()
    for chain in res
      lines!(scene, Iteration, chain[2][colnm][(burnin+1):end], 
        color = cols[chain[1]],
        axis = (
           names = (axisnames = ("Iteration", parname),),
           grid = (linewidth = (0, 0),),
           )
           )
    end
    return scene
end
traceplot(res::Dict{Any,Any}, pos::Integer) = traceplot(res, pos, 0)
traceplot(res::Dict{Any,Any}, colnm::Symbol) = traceplot(res, colnm, 0)


function densplot(res::Dict{Any,Any}, pos::Integer, burnin::Integer)
    Iteration = [burnin + i for i in 1:(size(res[1], 1)-burnin)]
    cols = [:black, :blue, :red, :green, :yellow]
    # make plot
    parname = string(names(res[1])[pos])
	scene = Scene()
    for chain in res
      vals = chain[2][(burnin+1):end,pos]
      rng = (minimum(vals), maximum(vals))
      x = range(rng[1], stop=rng[2], length=101)
      kdens = kde(vals)
      dens = pdf(kdens, x)
      lines!(scene, x, dens, 
        color = cols[chain[1]],
        axis = (
           names = (axisnames = (parname, "Density"),),
           grid = (linewidth = (0, 0),),
           )
           )
    end
    return scene
end

function densplot(res::Dict{Any,Any}, colnm::Symbol, burnin::Integer)
    Iteration = [burnin + i for i in 1:(size(res[1], 1)-burnin)]
    cols = [:black, :blue, :red, :green, :yellow]
    # make plot
    parname = string(colnm)
	scene = Scene()
    for chain in res
      vals = chain[2][colnm][(burnin+1):end]
      rng = (minimum(vals), maximum(vals))
      x = range(rng[1], stop=rng[2], length=101)
      kdens = kde(vals)
      dens = pdf(kdens, x)
      lines!(scene, x, dens, 
        color = cols[chain[1]],
        axis = (
           names = (axisnames = (parname, "Density"),),
           grid = (linewidth = (0, 0),),
           )
           )
    end
    return scene
end
densplot(res::Dict{Any,Any}, pos::Integer) = densplot(res, pos, 0)
densplot(res::Dict{Any,Any}, colnm::Symbol) = densplot(res, colnm, 0)

end # module
