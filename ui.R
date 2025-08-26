#Purpose: code for the UI for the Interactive Map, a shiny app

# Define UI for application
dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    tabsetPanel(
      id = "mainPanel",

      #First tab - Purpose and Disclaimer----
      tabPanel(
        title = "Purpose and Disclaimer",
        fluidRow(
          box(width = 8, htmlOutput("appPurpose"))
        ),
        fluidRow(
          box(width = 8, htmlOutput("appDisclaimer"))
        ),
        fluidRow(
          box(width = 8, htmlOutput("appHowTo"))
        ),
        fluidRow(
          column(width = 4, img(src = "CentralSandsFlowPaths_1inch.png")),
          column(width = 4, img(src = "WGNHS_color-flush-150ppi_2inch.png")),
        )
        
      ),
      
      
      #Second tab - Interactive Display----
      tabPanel(
        title = "Interactive Map",
        fluidRow(
          box(width = 4, withSpinner(leafletOutput(outputId = "map", height = "500px"), caption = "Rendering Map..."), htmlOutput("mapExplainer")),
          box(width = 4, withSpinner(plotOutput(outputId = "landCoverBarPlot", height = "500px"), caption = "Determining Land Cover..."), htmlOutput("landCoverExplainer")),
          box(width = 4, withSpinner(plotOutput(outputId = "flowTimeHistogram", height = "500px"), caption ="Processing Transit Times..."), htmlOutput("transitTimeExplainer"))
          ),
        fluidRow(
          box(width = 10, htmlOutput("limitationsAndDataSources"))
          )
        ),
      
      #Third tab - Additional Info----
      tabPanel(
        title = "Additional Resources",
        fluidRow(
          box(htmlOutput("externalLinks"))
          ),
        fluidRow(
          box(width = 6, htmlOutput("modelAssumptions"))
          ),
        fluidRow(
          column(width = 6, h2("2D versus 3D pathlines"), "The interactive map shows the horizontal flows but the flow paths shown in the map also flow vertically.
           The figure shown to the right illustrates this. Flows that start farther away from the discharge point are deeper and those nearer are more shallow
           The longer and deeper flow paths take longer to reach their discharge points and so they are generally older.
           The shorter and shallower flow paths take less time to reach their discharge points and so they are generally younger.
           In general, longer flow paths are deeper and older and shorter flowpaths are younger and more shallow."),
          column(width = 6, imageOutput("groundWaterImage")),
          )
        )
        )
    ),
  title = "Interactive Groundwater Flow Map"
)
