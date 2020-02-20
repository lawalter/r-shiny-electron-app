# intro -------------------------------------------------------------------


# libraries ---------------------------------------------------------------

library(shiny)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)

# ui ----------------------------------------------------------------------

# Define UI for application:

ui <- fluidPage(

  # Application title:
  titlePanel("Color Band Combination Generator"),

  # Sidebar with input options:
  sidebarLayout(
    sidebarPanel(

      checkboxGroupInput("colorVector",
                         "Colors available:",
                         choices = list("Aluminum" = "X",
                                        "Red" = "R", "Orange" = "O",
                                        "Yellow" = "Y", "Green" = "G",
                                        "Blue" = "B", "Purple" = "M",
                                        "Pink" = "P", "White" = "W",
                                        "Black" = "K", "Grey" = "E"),
                         selected = c("X", "R", "O", "Y", "G", "B", "W")),

      numericInput("nBands",
                   "Number of bands:",
                   min = 1,
                   max = 6,
                   step = 1,
                   value = 4),

      numericInput("nBands",
                   "Number of right bands:",
                   min = 1,
                   max = 3,
                   step = 1,
                   value = 2),

      numericInput("nBands",
                   "Number of left bands:",
                   min = 1,
                   max = 3,
                   step = 1,
                   value = 2)
    ),

    # Show a plot of the generated distribution:
    mainPanel(
      verbatimTextOutput("colorVect"),
      tableOutput("view")
    )
  )
)

# server ------------------------------------------------------------------

# Define color combo function:

get_colors <-
  function(
    colorVector,                # A vector of available color bands, coded
    nBands = 4,                 # The number of bands
    nPositions = nBands,        # The number of possible band positions
    xPositions = 1:nPositions,  # The position of the X band, from LT to RB
    nLeft = nPositions/2,   # The maximum number of bands on the left leg
    nRight = nPositions/2   # The maximum number of bands on the right leg
  ) {
    # Add blank if the number of bands < the number of positions:
    if(nBands < nPositions){
      colorVector <-
        c(colorVector, '')
    }
    map_dfc(
      1:(nPositions/2),
      function(x) {
        x = colorVector
      }) %>%
      expand(!!! rlang::syms(names(.))) %>%
      # Unite upper and lower bands:
      unite('color', sep = '') %>%
      # Add blanks:
      mutate(
        color =
          str_pad(
            color,
            width = nPositions/2,
            side = 'right',
            pad = '_')) %>%
      # All potential combos of left and right legs:
      expand(
        left = color,
        right = color) %>%
        {if(!is.null(nLeft)) {
          filter(., (str_count(left, '[A-Z]') == nLeft))
        } else .} %>%
        {if(!is.null(nRight)) {
          filter(., (str_count(left, '[A-Z]') == nRight))
        } else .} %>%
      # Unite as a single expression:
      unite('color', sep = '') %>%
      # Correct number of bands:
      filter(str_count(color, '[A-Z]') == nBands) %>%
      {if("X" %in% colorVector){
        filter(
          .,
          # Combos with one, and only one, aluminum:
          str_count(.$color, 'X') == 1,
          # Aluminum at chosen position:
          str_locate(.$color, 'X')[,1] %in% xPositions)
      } else .} %>%
      # Randomize output:
      sample_n(size = nrow(.))
  }

# Define server logic:

server <- function(input, output) {

  dataInput <- reactive({
    get_colors(input$colorVector,
               nBands = input$nBands,
               nLeft = input$nLeft,
               nRight = input$nRight)
  })

  output$view <- renderTable({
    dataInput()
  })

  output$colorVect <- renderText(input$colorVector)

}

# run ---------------------------------------------------------------------

# Run the application:

shinyApp(ui = ui, server = server)

