#Purpose: code for the UI for the Interactive Map, a shiny app

# Define UI for application
dashboardPage(
  dashboardHeader(disable = TRUE),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    tags$head(
      tags$script(HTML("
          $(document).keyup(function(event) {
            if (event.keyCode == 13) { // 13 is the Enter key code
              $('#password_submit').click(); // Replace 'myActionButton' with your button's inputId
            }
          });
        "))
    ),
    tabsetPanel(
      id = "mainPanel",

      #First tab - Purpose and Disclaimer----
      tabPanel(
        title = "Purpose and Disclaimer",
        fluidRow(
          box(width = 8, h2("Purpose"), 
          p("The", tags$b("Central Sands Groundwater Tracker")," is a web application or app tool designed by the Wisconsin Geologic and Natural History Survey 
              (WGNHS) to help private well owners and communities understand the groundwater contributing zones, transit times and landcover at the start of groundwater 
              flow paths within the Wisconsin Central Sands. This app was created to assist with decisions concerning groundwater source locations, travel paths, and 
              transit times in the Central Sands of Wisconsin."),
          p("The app was created as an education tool and has been used to:

              1. Identify groundwater contributing areas in a given area.
              2. Understand how long groundwater may travel to a given area.
              3. Better understand how long it may take changes in land use or management to impact groundwater in a given area.
              4. Identify the landcover at the start of an identified groundwater flow path."),
          p("The app does not identify which groundwater flow paths flow directly to or are used by a specific well. 
              The app also does not inform users of how land uses along an identified groundwater flow path may affect the water quality."),
          p("The app is only a representation of groundwater flow in the Central Sands region of Central Wisconsin.  
          It is not applicable outside of the model area or for overland flow characteristics.  
          The WGNHS is not responsible for misuse or misrepresentation of the data."),
          p("The app was created using R statistical programming and SHINY programming that visualize MODPATH output and Cropscape data. 
          It was created by the WGNHS with input and review by UW-Madison Extension and Portage County.  See the ", tags$b("Model Assumptions")," tab for more information.
)")
          )
        ),
        fluidRow(
          box(width = 8, h2("Questions"), "For questions about the app, contact", tags$b("Dave Hart")," at the Wisconsin Geological and Natural History Survey (djhart@wisc.edu) or" , tags$b("Jennifer McNelly"),", Wood County Extension (jennifer.mcnelly@wisc.edu).")
        ),
        fluidRow(
          box(width = 8, h2("How to Use"), "Select the ", tags$b("Interactive Map")," tab above to bring up a map of the Central Sands. Then select a point within the grey outline of the Central Sands to see predicted flow paths, 
              land use, and transit times.")
        ),
        fluidRow(
          box(width = 8, h2("Disclaimer"), "This representation of flow paths, land use, and transit times in the Central Sands of Wisconsin is provided by the WGNHS on an as is basis. 
              WGNHS will not be liable for any damages of any kind arising from the use of these data, including, but not limited to direct, indirect, punitive, and consequential.
              WGNHS makes no warranties on these data, express, implied, statutory, or in any other provision of any agreement or communication,
              and specifically disclaims any implied warranties of merchantability or fitness for a particular purpose.")
        ),
        fluidRow(
          column(width = 4, img(src = "CentralSandsFlowPaths_72ppi.png")),
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
          box(width = 10, h2("Data Sources and Limitations"),
          p("This app uses flow path and land use data from peer reviewed sources. 
          The flow paths are from Baker and others (2025) which in turn were based on the groundwater model by Fienen and others (2022). 
          The land use data is from Wiscland 2.0, Levels 1 and 3. See the", tags$b("Additional Resources")," tab for these references and more background information."), 
          p("The flow paths are model representations of the groundwater flows and as such cannot be expected to provide a perfect match 
          to actual groundwater movement. There can be error associated with the flow paths, including the timing, start and end points.
          "))
          )
        ),
      
      #Third tab - Model Assumptions----
      tabPanel(
        title = "Model Assumptions",
        fluidRow(
          box(width = 6, htmlOutput("modelAssumptions"))
          ),
        fluidRow(
          box(width = 6, h2("2D versus 3D pathlines"), "The interactive map only shows horizontal groundwater flows.  
          In the real world, groundwater flow paths also move vertically. The figure shown below illustrates both horizontal 
          and vertical flows. Flows that start farther away from the discharge point move deeper while those flows nearer the discharge point 
          stay more shallow. The longer and deeper flow paths take more time to reach their discharge points and so that 
          groundwater is generally older. The shorter and shallower flow paths take less time to reach their discharge 
          points and so that groundwater is generally younger."),
          ),
        fluidRow(
          column(width = 6, imageOutput("groundWaterImage"),"US Geologic Survey Fact Sheet 063-01")
        )
        ),
      
      #Fourth tab - Additional Info----
      tabPanel(
        title = "Additional Resources",
        fluidRow(
          box(htmlOutput("externalLinks"))
        ),
        fluidRow(
          box(width = 6, h2("General Questions"), "For questions and more information about groundwater in the central sands, 
          contact", tags$b("Dave Hart")," at the Wisconsin Geological and Natural History Survey (djhart@wisc.edu) or" , tags$b("Jennifer McNelly")," 
          , Wood County Extension (jennifer.mcnelly@wisc.edu)"),
        )
      )     
      
    )
    ),
  title = "Interactive Groundwater Flow Map"
)
