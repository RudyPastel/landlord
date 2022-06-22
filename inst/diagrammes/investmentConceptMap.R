#' Create a diagramme of the architecture of DWH_Import
#'
#' This scripts creates a diagram of the architecture of DWH_Import and saves it.


# Clean slate ---------------------------------------------------------------------------------

rm(list = ls())

# save graph to file ---------------------------------------------------------------------------------
saveGraph = !TRUE
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
                         B [label = <DataImportFramework> ];
                         subgraph {
                            rank = same;
                            E [label = <LH6MetaWrapper> ];
                            D [label = <LH6SQL> ];
                            L1 [label = <Package A> ];
                            L2 [label = <Package B> ];
                         }
                        C [label = <ImportUtils> ];


                         # several "edge" statements
                         # A->B [label = <interfaces with>, dir = both]
                         {B, D, E}->C
                         E->D
                         B->{D E}
                         L1->L2 [label = "depends \n on"]
                         }
                         ')


# Build the disgramm --------------------------------------------------------------------------

DiagrammeR::grViz(diagrammeString)

# Save the graph --------------------------------------------------------------------------
if (!saveGraph) {
  path = tempfile()
}
svg = charToRaw(DiagrammeRsvg::export_svg(DiagrammeR::grViz(diagrammeString)))
rsvg::rsvg_png(svg = svg, file = path, width = 1260, height = 385 )
