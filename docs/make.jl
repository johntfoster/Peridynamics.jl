using Documenter
using Peridynamics

DocMeta.setdocmeta!(Peridynamics.Discretization, :DocTestSetup, :(using Peridynamics.Discretization); recursive=true)

makedocs(
    sitename = "Peridynamics",
    format = Documenter.HTML(),
    modules = [Peridynamics]
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/johntfoster/Peridynamics.jl.git"
)
