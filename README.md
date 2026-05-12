# Predictive Analytics: Soccer Performance Data and All-SEC Honors

**Author:** Caleb Reid  
**Course:** Data Science Final Paper  
**Date:** May 12, 2025

## Overview

This project builds an elastic net classification model to predict All-SEC award selections in NCAA Division I women's soccer using Wyscout performance metrics. The model identifies which performance metrics are most influential in earning an All-SEC honor.

## Files

| File | Description |
|------|-------------|
| `Reid_finalPaper.tex` | LaTeX source file |
| `Reid_finalPaper.bib` | BibTeX references |
| `Reid_finalPaper.pdf` | Compiled paper |
| `wyscoutExample.png` | Example of Wyscout data format (Table 1) |
| `dataOverviewTable.png` | Overview of the final dataset (Table 2) |
| `posBreakdown.png` | All-SEC selections by position (Table 3) |
| `confusionMatrixGT2.png` | Model confusion matrix on test set (Table 4) |

## Key Findings

- **goalsPer90** was the most influential predictor (OR = 83.6%)
- **shotsPer90** was second (OR = 41.4%)
- Top 3 predictors were all attacking metrics
- Model achieved a kappa of 0.48 (moderate agreement) and sensitivity of 0.44
- The model correctly identified 6/9 All-SEC athletes in the test set

## Data Sources

- **Rosters:** Scraped from SEC team websites using the `rvest` package in RStudio
- **All-SEC Awards:** secsports.com (2023–2025)
- **Performance Metrics:** Wyscout (top 10 per metric per season)

## Methods

- Sample: 1,283 SEC women's soccer players across 2023–2025 regular seasons
- Elastic net logistic regression with 5-fold cross-validation stratified on `allSEC`
- 80/20 train/test split
- Tuning parameter selected via Cohen's Kappa (λ = 0.037, mixture = 0.75)
