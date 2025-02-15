# Fire Ecology database (FEDB)

The ***Fire Ecology database*** is being developed by  [José R. Ferrer-Paris](https://github.com/jrfep) and David Keith in the Centre for Ecosystem Science, University of New South Wales

Please cite this work as:

> Ferrer-Paris, J. R. and Keith, D. A. (2025) Fire Ecology database to inform fire ecology research and management. Version 1.1.1. Centre for Ecosystem Science, University of New South Wales, Sydney, Australia. Retrieved from <https://osf.io/hu96w>

This work has been supported by:

- [University of New South Wales](https://www.unsw.edu.au/)
- [NSW Bushfire Research Hub](https://www.bushfirehub.org/)
- [NESP Threatened Species Recovery Hub](https://www.nespthreatenedspecies.edu.au/)
- NSW Department of Planning & Environment (now [Department of Climate Change, Energy, the Environment and Water](https://www.nsw.gov.au/departments-and-agencies/dcceew))

## Components of the project

### SQL structure of the database

:dart: [This repository](https://github.com/ces-unsw-edu-au/fireveg-db) contains sql commands for defining the basic structure of the tables in a PostgreSQL database.

Instructions to use this repository are in the `doc/` folder. SQL code is in the `psql/` folder. Some figures in folder `figs/`.

This repository is part of the OSF project component:

> Ferrer-Paris, J. R., & Sánchez-Mercado, A. (2023, September 12). Fire Ecology database: SQL structure of the database. Retrieved from [osf.io/4csyz](https://osf.io/4csyz/)


### Project overview

<!--// Need to update this figure
![Overview of project resources](figs/Fireveg-project-resources.png)
//-->
This project consists of several linked components:

***🔥 Fire Ecology database: A database for fire research and management*** OSF project [osf.io/hu96w](https://osf.io/hu96w/) with following components:

  - :file_cabinet: **SQL structure of the database** / OSF project component [osf.io/4csyz](https://osf.io/4csyz)
    - :gear: Source code for defining the structure of the tables in a PostgreSQL database is available in this [GitHub repository](https://github.com/ces-unsw-edu-au/fireveg-db) <-- :dart: You are here! -->
  - :briefcase: **Code for database imports and data curation** / OSF project component [osf.io/rj68t](https://osf.io/znuge)
    - :gear: Source code for populating and managing the database is available in this [GitHub repository](https://github.com/ces-unsw-edu-au/fireveg-db-imports)
  - :computer: **Webapp for browsing the Fire Ecology database** / OSF project component [osf.io/rj68t](https://osf.io/rj68t)
    - :gear: Source code for setting up and running the Flask webapp id available in the [GitHub repository](https://github.com/ces-unsw-edu-au/fireveg-webapp)
    - :computer: Acess to the [Webapp](http://fireecologyplants.net) (Register with a verified email address)
  - :bar_chart: **Export data records from Fire Ecology database** / OSF project component [osf.io/h96q2](https://osf.io/h96q2/)
    - :gear: Source code in [GitHub repository](https://github.com/ces-unsw-edu-au/fireveg-db-exports/)
    - :label: Data in Figshare DOI:[10.6084/m9.figshare.23361002](https://doi.org/10.6084/m9.figshare.23361002)
    - :label: Data in Figshare DOI:[10.6084/m9.figshare.24125088](https://doi.org/10.6084/m9.figshare.24125088)
  - :technologist: **Data analysis and visualisation** / OSF project component [osf.io/kjevh](https://osf.io/kjevh)
    - Notebooks with code and plots
      - :gear: Source code in [GitHub repository](https://github.com/ces-unsw-edu-au/fireveg-analysis)
    - Presentations
      - :gear: Source code in [BitBucket repository](https://bitbucket.org/fireveg/fireveg-presentations)
      - :speech_balloon: [Presentation slides](https://rpubs.com/jrfep/firevegdb-ESA2023) 


