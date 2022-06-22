#' Create a diagramme of the architecture of DWH_Import
#'
#' This scripts creates a diagram of the architecture of DWH_Import and saves it.


# Clean slate ---------------------------------------------------------------------------------

rm(list = ls())

# save graph to file ---------------------------------------------------------------------------------
saveGraph = TRUE
path = 'vignettes/images/investmentConceptMap.png'
# Load the packages ---------------------------------------------------------------------------

packagesToLoad = c('DiagrammeR', 'DiagrammeRsvg', 'rsvg')
for (package in packagesToLoad) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package,dependencies = TRUE)
    require(package, character.only = TRUE)
  }
}


# Define the structure ------------------------------------------------------------------------

diagrammeString = paste( '
        digraph boxes_and_circles {

                         # a "graph" statement
                         graph [overlap = true, fontsize = 10]

                         # # an import specific node state
                         # node [shape = oval, fontname = Helvetica, fontcolor = black]
                         # A [label = <Import specific code>];

                         # several package "node" statements
                         node [shape = box, fontname = Helvetica, fontcolor = black]
                         Investor [label = <Investor> ];
                         subgraph {
                            rank = same;
                            Property [label = <Property> ];
                            Loan [label = <Loan> ];
                         }
                         subgraph {
                              rank = same;
                              Income [label = <Income> ];
                              Spending [label = <Spending> ];
                         }
                         Cashflow [label = <Cash flow> ];
                         landlord [label = <landlord> color=blue fontcolor = blue];


                         # several "edge" statements
                         # A->B [label = <interfaces with>, dir = both]
                         Investor->Property [label = "finds"]
                         Investor->Loan [label = "pays \n down payment"]
                         Property->Loan [label = "requires capital"]
                         Property->Income [label = "increases"]
                         {Property Loan}->Spending [label = "increases"]
                         Income->Cashflow [label = "increases"]
                         Spending->Cashflow [label = "decreases"]
                         landlord->Cashflow [label = "evaluates" color=blue fontcolor = blue]
                         }
                         ')


# Build the diagramm2 --------------------------------------------------------------------------

DiagrammeR::grViz(diagrammeString)

# Save the graph --------------------------------------------------------------------------
if (!saveGraph) {
  path = tempfile()
}
svg = charToRaw(DiagrammeRsvg::export_svg(DiagrammeR::grViz(diagrammeString)))
rsvg::rsvg_png(svg = svg, file = path, width = 1260, height = 1260 )
