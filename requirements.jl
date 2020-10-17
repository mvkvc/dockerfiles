metadata_packages = ["Atom",
		"Juno",
		"IJulia",
		"Flux",
		"MLJ",
		"DifferentialEquations",
		"DataFrames",
		"LightGraphs",
		"Plots"]

using Pkg
Pkg.update()
for package=metadata_packages
    Pkg.add(package)
end

Pkg.resolve()
