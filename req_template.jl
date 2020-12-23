metadata_packages = ["PKG1",
		"PKG2",
		"PKG3"]

using Pkg
Pkg.update()
for package=metadata_packages
    Pkg.add(package)
end

Pkg.resolve()
