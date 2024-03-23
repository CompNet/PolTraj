
PolTraj
===================
*Analysis of the professional trajectories of French politicians*

* Copyright 2019-2023 Noémie Fevrat & Vincent Labatut

PolTraj is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation. For source availability and license information see `licence.txt`

* Lab website: http://lia.univ-avignon.fr/
* GitHub repo: https://github.com/CompNet/PolTraj
* Contact: vincent.labatut@univ-avignon.fr

-----------------------------------------------------------------------

## Description
This set of R scripts was written to perform a sequence analysis of BRÉF (Base de données Révisée des Élu·es de France), a data base containing a description of all types of reprsentatives elected in France.


# Data
In order to execute the script, you need first to retrieve the BRÉF database, described in [LFM'20] (see also GitHub project [BrefInit](https://github.com/CompNet/BrefInit). However, these data are under embargo until the end of Noémie Févrat's PhD.
(**TODO** upate)


## Organization
Here are the folders composing the project:
* Folder `in`: all the input files, including raw data, secondary data and verification files.
* Folder `log`: log files produced during the processing.
* Folder `out`: data files and plots produced during the processing.
* Folder `src`: all the source files.


## Installation
You just need to install `R` and the required packages:

1. Install the [`R` language](https://www.r-project.org/)
2. Download this project from GitHub and unzip.
3. Install the required packages: 
   1. Open the `R` console.
   2. Set the current directory as the working directory, using `setwd("<my directory>")`.
   3. Run the install script `src/install.R`.


## Use
In order to load the tables and generate the description files:

1. Open the `R` console.
2. Set the project root as the working directory, using `setwd` again.
3. Launch the `src/main.R` script, and the files will be generated in the `out` folder. 


## Dependencies
* ...


## Todo
* Update the data link after the end of the embargo.
* Update HAL reference of the report.


## References
 * **[LFM'20]** V. Labatut, N. Févrat & G. Marrel, *BRÉF – Base de données Révisée des Élu·es de France*, Technical Report, Avignon Université, 2020. [⟨hal-02886580⟩](https://hal.archives-ouvertes.fr/hal-02886580)
