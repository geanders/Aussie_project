<!-- README.md is generated from README.Rmd. Please edit that file -->
Research Questions:
-------------------

-   Have mining and milling operations at the Ranger Mine contaminated the surrounding Alligators River Region with radionuclides and metals?
    -   Where are the sample types of interest located in relation to the mine?
    -   How do the concentrations of radionuclides and metals change with distance from the mine?

Problem
-------

The Alligator Rivers Region is a province in the wet-dry tropics of northeastern Australia. The land in this region is rich in uranium, and since 1980 has been home to a large mine. [This is the Ranger Uranium mine](http://www.world-nuclear.org/information-library/country-profiles/countries-a-f/appendices/australia-s-uranium-mines.aspx#ranger): ![Image of the Ranger Uranium Mine](images/RMDRanger2005.png)

An Australian government entity called the [Environmental Research Institute of the Supervising Scientist](http://www.environment.gov.au/science/supervising-scientist) (ERISS) has been collecting animal and environmental samples from the land around the mine, in the general area of the Alligator Rivers Watershed and Kakadu National Park: ![Image of watershed](images/australia_with_mine.png)

These have been collected since mine activity began. The samples have been measured for many different mine contaminants including the heavy metals Copper (Cu), Arsenic (As), Lead (Pb), Mercury (Hg), isotopes of Uranium (U), Thorium (Th), Radium (Ra), Polonium (Po), Actinium (Ac), and Potassium (K) - specifically <sup>234</sup>U, <sup>238</sup>U, <sup>230</sup>Th, <sup>232</sup>Th, <sup>226</sup>Ra, <sup>228</sup>Ra, <sup>210</sup>Pb, <sup>210</sup>Po, <sup>228</sup>Th, <sup>227</sup>Ac, and <sup>40</sup>K. All of these metals and radionuclides are naturally occurring, but may have been released during mining and milling at the mine.

Radionuclide information is measured using the SI unit of activity, the Becquerel (Bq). This unit is defined as one radioactive decay or disintegration per second.

The location of the mine and the surrounding region is show below. Locations of sample collection are indicated.

<img src="README-largemap-1.png" style="display: block; margin: auto;" />

Samples from flora, fauna, and soil and water have been gathered by the ERISS. The specific sample types can be clustered based on their ecological niche and purpose in the watershed, to contain the following groups: water, fish, molluscs, freshwater animals, freshwater plants, freshwater sediment, terrestrial animals, terrestrial plants, and terrestrial soil. The following map shows the collection locations of these varying sample types, near the Ranger Mine.

<img src="README-smallmap-1.png" style="display: block; margin: auto;" />

This dataset of environmental samples has been continually gathered by the ERISS to keep track of mine contaminants in the region over space and time. The dataset was recently published in the [Journal of Environmental Radioactivity](http://www.sciencedirect.com/science/article/pii/S0265931X16301928).

Attempting to answer the research questions proposed, using this dataset, is important for many reasons. One reason is to better understand the overall impacts of uranium mining on water and fauna, as 1/3 of the land in the region forms the Kakadu National Park. Addtionally, most of the remaining land is aboriginally owned. Because of this ownership, there are concerns about the contamination of bush foods, and also the contamination of flora for wild animal consumption. After mine closure, the site is to be remediated by 2026 and incorporated into Kakadu. Knowing where and to what level contaminants can be found is also central to this ultimate goal.

Analysis
--------

The initial dataset was made available as an .xlsx file. The only manual process was to load the file into Excel and save as a .csv file; all other data cleaning was performed using an R script. Most of the data cleanup consisted of cosmetic and convenience changes, renaming variables and setting data types. We created a variable called `sample_type` to group samples by substrate, such as Terrestrial Plants or Fish. This is important for both our analysis and for the Shiny app.

The dataset includes geospatial data using Easting and Northing in two different zones of a Mercator Projection. We used functions from the `rgdal` and `sp` packages to convert to lat-long coordinates, which we were then able to plot using `ggplot2`.

A number of sample results were reported as below detection limits, in the form of "<value", where value is the detection limit rather than an actual measured value.  We discussed several possibilities for managing these results.  We found references that directly used the LOD as a result (highly conservative), that used 0 as the result (effectively loses results), or divided the LOD by a factor (2 or $\sqrt{2}$) for use as a result (could be considered arbitary).  We elected to go the highly conservative route and use the LOD as the value. 


##Results


Below are the results for the radionuclide concentration (Bq/Kg) in Molluscs as a function of the year sampled. The color of each point is scaled by it's proximity to the mine. 

<img src="README-Mollusc-1.png" style="display: block; margin: auto;" />

If the presence of the mine had a direct impact on the radionuclide concentrations in the environment, one would expect to see concentrations of radionuclides increase over time, from the point before the mine was established to after. However, there is no apparent data to indicate an upward trend in radionuclide concentration over time, nor does the radionuclide concentration seem to depend on distance for a particular year.

The fluctuations in radionuclide content are most likely caused by naturally occuring radionuclides within the local geology, as molluscs spend their lives embedded in the land! There has been a presence of these entities in the sampled environments, preceding any excavation from the mine.

As water is fluid (PUN!) in this area, unlike the land or relatively static molluscs, we can look specifically at the content of radionuclides in the water samples taken over time.

<img src="README-Rad_vs._Distance-1.png" style="display: block; margin: auto;" />

As one can see, there is a slight downward trend in the amount of radionuclides in water samples as are taken farther and farther from the mine. The water samples represented in the graph above reflect those taken from all sampled years.

<img src="README-Heavy_Metal-1.png" style="display: block; margin: auto;" />

The figure above shows metal concentrations in samples as a function of distance from the mine. Both copper and lead show a potentially significant correlation with distance; mercury may as well. This figure also shows one side effect of our decision to treat results below the limits of detection as results equal to the limit of detection; a common detection threshold for lead was ~25 mg/l.

Further Research
----------------

While the dataset is quite robust in general, there are some limitations. For example, there are very few samples of insects available. For locations more than a few kilometers from the mine, there are not many repeat samples such that a time course could be studied. Since the primary focus was environmental samples, there does not appear to have been a concerted effort conducted to study animals and their uptake of heavy metals and radionuclides.

Interestingly, the same group that published the initial data set recently published a short communication entitled '[A tool for calculating concentration ratios from large environmental data sets](https://www.ncbi.nlm.nih.gov/pubmed/27579895). This publication outlines a tool developed in MS Excel that predicts biological accumulation of mine contaminants, given their proximity to environmental samples with certain concentrations of both metals and radionuclides. We'd expect others to start analyzing this current data set in light of this newly developed tool, since these many environmental measures can now been linked to biological outcomes.
