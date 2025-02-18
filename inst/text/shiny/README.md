# WRITE APP NAME HERE

This app was created using the PHS Shiny app template from the [`{phstemplates}`](https://public-health-scotland.github.io/phstemplates/) package.

## Instructions for use

* Run the app by opening app.R and clicking 'Run' in the top right-hand corner
* `setup.R` contains required packages and is where any data should be read in
* `data/` is a folder for storing data to be read in
* `www/` contains the app stylesheet and PHS icon images
* `pages/` should contain an R script for each tab in your app with the content of that tab. This needs to be linked back to the `ui` in `app.R`
* `functions/` contains R scripts with functions for the app

## PHS shiny app examples

* [COVID-19 dashboard](https://github.com/Public-Health-Scotland/COVID-19-Publication-Dashboard)
* [COVID-19 wider impacts dashboard](https://github.com/Public-Health-Scotland/covid-wider-impacts/tree/master/shiny_app)
* [ScotPHO profiles](https://github.com/Public-Health-Scotland/scotpho-profiles-tool)

## Accessibility

An aim of any app is making sure it can be used by as many people as possible.

This includes those with:

* impaired vision
* motor difficulties
* cognitive impairments or learning disabilities
* deafness or impaired hearing

For example, someone with impaired vision might use a screen reader.

PHS has created guidance on how to make your app as accessible as possible. It can be found in the knowledge base from this 
[link](https://public-health-scotland.github.io/knowledge-base/docs/Information%20Sharing?doc=Dashboard%20Accessibility%20Guidance.md).

We hope to build-in some of these basic features into this template in the future.
