# Central Sands Groundwater – Decision Support Application

Live app: [https://connect.doit.wisc.edu/wgnhs-central-sands-groundwater/](https://connect.doit.wisc.edu/wgnhs-central-sands-groundwater/)

## Project Goal

Originally, the goal was to provide a tool that can be used to inform actions for the reduction of groundwater nitrate in central Wisconsin. However, we moved away from trying to predict/quantify nitrate. Instead, we focused primarily on showing contributing zones, flow paths, and transit times.

## Developer setup 

### Prerequisites
- Install [RStudio Desktop](https://posit.co/download/rstudio-desktop/)
- Install [Git](https://git-scm.com/downloads)
- Create a [Github account](https://github.com/)

### Create new RStudio project from Github
1. In RStudio, choose File > New project to open the New Project Wizard
2. On the Create Project screen, choose Version Control
3. On the Create Project from Version Control screen, choose Git
4. On the Clone Git Repository screen, enter the URL of this repository (https://github.com/wgnhs/Central-Sands-Nitrate.git) into the Repository URL field. Leave other fields as they are.
5. Click Create Project.

### Run the app locally
1. In RStudio, open one of the follow files: server.R, ui.R or global.R 
2. Click Run App in the upper right corner of the file window.
3. To run the logic without running the RShiny app, open CentralSandsNitrateEstimator.R and run the `mainNitrateEstimator` function.

## Publishing code changes

This RShiny app is automatically published to UW-Madison's Posit Connect service https://connect.doit.wisc.edu from Github.

- Changes to the main branch are published to [https://connect.doit.wisc.edu/wgnhs-central-sands-groundwater/](https://connect.doit.wisc.edu/wgnhs-central-sands-groundwater/)
- Changes to the dev branch are published to [https://connect.doit.wisc.edu/dev-wgnhs-central-sands-groundwater/](https://connect.doit.wisc.edu/dev-wgnhs-central-sands-groundwater/)

To publish code changes, you need to push them to the dev branch of this repository https://github.com/wgnhs/Central-Sands-Nitrate, then open and merge a pull request to the main branch.

**IMPORTANT! Only WGNH affiliates who are members of the WGNHS Github organization can publish code changes.Contact WGNHS IT staff to add your Github account to the WGNHS Github organization.**

### Publish changes to dev environment

1. Switch to the dev branch in RStudio by clicking the branches menu in the Git panel and choosing dev
2. Make your code changes, save and click Run App to preview your changes locally
3. Changed files will appear in the Git panel. Click the checkbox beside each modified file to Stage files for pushing to Github.
4. In the Git panel, click the Commit button.
5. Make sure dev is selected in the branch menu, then type a description of the changes in the Commit Message box and click the Commit button.
6. In the Git panel, make sure dev is selected in the branch menu and click the Push button to send the code changes to Github.
7. Changes to the dev branch will be automatically published to [https://connect.doit.wisc.edu/dev-wgnhs-central-sands-groundwater/](https://connect.doit.wisc.edu/dev-wgnhs-central-sands-groundwater/) . It may take several minutes for the changes to appear.

### Publish changes to production environment
To published changes to the production environment, you must first complete tthe steps above to publish changes to the dev Github branch and dev Posit Connect environment. Changes to the production environment require a Github pull request, which must be merged approved and merged by another WGNHS Github user.

2. Log into [Github](https://github.com/) . 
3. Go to the {WGNHS Central-Sands-Nitrate repository](https://github.com/wgnhs/Central-Sands-Nitrate) and click the [Pull Requests tab](https://github.com/wgnhs/Central-Sands-Nitrate/pulls).
4. Click New Pull Request and select the following settings:
    - base repository: wgnhs/Central-Sands-Nitrate
    - base: main
    - compare: dev
5. Review the changes shown in the list of commits, then click Create pull request
6. Enter a title and description for the pull request, assign another WGNHS Github user (lizkrznarich or schoep) as a reviewer and click Create pull request
7. The pull request will be approved and merged to the main branch by the reviewe. Once merged, changes will be automatically deployed to [https://connect.doit.wisc.edu/wgnhs-central-sands-groundwater/](https://connect.doit.wisc.edu/wgnhs-central-sands-groundwater/)

## Pseudocode

When the user clicks on the map, the app performs the following steps:

1. Grab the latitude and longitude
2. Draw a buffer zone around the latitude and longitude
3. Find MODPATH model pathlines that intersect with the buffer zone
4. Find the starting point associated with each pathline and find the land cover associated with that point
5. Display relevant information

---

## Data Needed to Run (Dependencies)

Data sets needed for the application to run are in the `Data Sets` directory:

| File | Purpose | Location |
|------|---------|----------|
| MODPATH Path lines | Stores information about the groundwater path lines. This information is split into two files (due to size): | - Data Sets/Particles_Pathlines_May2025/1particle_top_pathlines_0.shp<br>- Data Sets/Particles_Pathlines_May2025/1particle_top_pathlines_1.shp |
| MODPATH Startpoints | The starting points used by the MODPATH model. Also includes WiscLand 2 land cover associated with each starting point. | Data Sets/Particles_Pathlines_May2025/startpoints_with_wiscland.shp |

---

## Other Files

Other files needed for the application to work properly are stored in the `Misc_Shapefiles` and `www` directories:

| File | Purpose | Location |
|------|---------|----------|
| Pathline Boundary | Shows the outline of the model boundary | Misc_Shapefiles/prelim_ff_model_bounds_proposed.shp |
| Pumping Wells | Shows the locations of pumping wells | Misc_Shapefiles/pumping_well_pts.shp |
| Groundwater Diagram | A diagram explaining basic groundwater concepts | www/groundWaterDiagram.png |
| 3D Flowlines | An example of a 3D representation of flowlines | www/test3Dflowlines.html |

---

## Data Ontology and Style Guide

Below is the variable naming/ontology used for this code. While I aimed for consistency, this was implemented partway through development, so there may be some discrepancies.

| Type of Data | Name | Suffix | Example |
|--------------|------|--------|---------|
| Information downloaded from somewhere (shapefile, csv, spreadsheet, etc.) | Data set | DataSet | floDataSet, objDataSet |
| Information subsetted from a Data Set | Subset | Set | floSet, objSet |
| The row index of a given object | Index | Index | floIndex, objIndex |
| The object | ID | ID | floID, objID |

---

## General Information about the MODPATH Model

- Each pathline has one startpoint.
- Some startpoints do not have pathlines. This happens because the model lays out a grid of startpoints without “prevalidating” that it will end up with a pathline. This means the model may attempt a point, but it is invalid.
- Matching up pathlines to startpoints is non-trivial. The logic is in `getFloDataSet`. Pathlines and startpoints are stored in different shapefiles without a proper foreign key. Pathlines are split into two files, and there are no unique identifiers. The column `partidloc_` is used as the foreign key for matching pathlines to startpoints, with an offset depending on whether the startpoint is associated with the first or second pathline file.

---

## Potential Future Work

- Add user input to allow users to select which landcover data they’d like to use.
- Add an exportable table (doable in Shiny) that allows users to export land cover and transit time information about each flowline. A prototype (non-exportable) table exists in the call to `output$flowlineInfoTable` in the server file.
- Add a 3D rendering of the flowpaths.
  - A preliminary test worked on a subset of the full file using a conversion script. The full MODPATH file was not processed due to time constraints.

---

## Miscellaneous

- **Feature Switches:**  
  We initially wanted toggles for certain features (to limit functionality for some users or for A/B testing). In the end, all features remained enabled. Implementing feature switches for user-by-user control would require significant effort, and added complexity to the Shiny code without much benefit for this use case. Still, it was a worthwhile idea to explore.

- **Nitrate Prediction:**  
  The server file’s call to `output$landCoverExplainer` currently outputs nitrate predictions. It might make sense to remove it, as there is no linear regression model loaded for WiscLand data—so only placeholder lower and upper bounds are displayed.

- **Backwards Compatibility with CropScape Data:**  
  The app originally used CropScape for land cover data but switched to WiscLand for better model performance. Some legacy code allows for backwards compatibility with CropScape. Specifically, `runNitrateEstimator()` can be run with the `landCoverCode` argument set to 1. For this to work, you need a file containing the CropScape class names and must update the `getCropScapeClassNames` function accordingly.

---
