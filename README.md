# Multiple Linear Regression Analysis of Median Port Time Across Country–Ship-Type Groups

This project investigates structural determinants of **median time in port** using aggregated maritime performance data. Specifically, the analysis examines how vessel characteristics (average age and gross tonnage), commercial market segments, and country-level differences are associated with variation in port time at the *country × ship-type* level. A sequence of nested linear regression models is developed, evaluated using information criteria and hypothesis testing, and interpreted to understand systematic patterns in global port performance.

## Data

Data used in this project are obtained from the **UNCTAD Port Calls and Performance Statistics**  
<https://unctadstat.unctad.org/datacentre/dataviewer/US.PortCalls>

The dataset provides aggregated operational statistics on vessel arrivals, port performance metrics, and ship characteristics across global economies. For this analysis, observations are grouped at the **country × ship-type** level, allowing the study to focus on structural differences across commercial market segments and national contexts rather than individual vessels or ports. Key variables include:

- Median time in port (days)  
- Average vessel age (years)  
- Average vessel size (gross tonnage)  
- Ship-type classification (commercial market segment)  
- Country-level identifiers 

## External Resources
The final report and code were written by Chang Li, but the following resources were used for preliminary research:

* LLM-based chatbots (ex. *ChatGPT Edu*) — used for major grammar refinement and writing clarity.
* Grammarly — used for minor grammar refinement and sentence clarity. 

# Acknowledgments

This project repository is based on the template provided by [Rohan Alexander](https://github.com/RohanAlexander/starter_folder/tree/main).