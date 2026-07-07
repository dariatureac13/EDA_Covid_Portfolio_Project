# Global COVID-19 Data Exploration: Tracking Infections, Mortality, and Vaccination Progress

An End-to-End SQL-driven Exploratory Data Analysis (EDA) of global COVID-19 tracking metrics to uncover country-level mortality risks, infection penetration rates, and the rolling progression of national vaccination campaigns.
---

## ⚙️ Project Type Flags

- Exploratory Data Analysis (EDA)
- SQL Analysis / Querying
- Data Pipeline / ETL

---

## Table of Contents
1. [Project Overview](#1-project-overview)
2. [Objectives](#2-objectives)
3. [Project Scope & Tools](#3-project-scope--tools)
4. [Repository Structure](#4-repository-structure)
5. [Data Workflow](#5-data-workflow)
6. [Data Model & Schema](#6-data-model--schema)
7. [Analysis & Metrics](#8-analysis--metrics)

---

## 1. Project Overview

**Context:** During the peak periods of the global pandemic, health organizations collected vast amounts of daily tracking metrics, including case counts, deaths, and vaccine deployments. Navigating this fragmented global scale data makes it difficult to draw straightforward comparisons between disparate regions without rigid relational models.

**Problem Statement:** Raw global datasets often suffer from varying scales, implicit tracking anomalies (such as country aggregates masquerading as continental entries), and data-type formatting issues that mask underlying country-specific trends in population infection rates and vaccination rollouts.

**Approach:** This project structures and cleans daily timeline records in SQL Server Management Studio (SSMS). Using relational JOIN logic, custom data-type casting, Common Table Expressions (CTEs), and advanced window functions (SUM() OVER...), the analysis extracts cleaned macro-level indicators across distinct timelines.

**Outcome:** Developed a highly performant, reproducible portfolio SQL script that systematically calculates country-specific mortality risks, maximum national infection penetration rates, aggregate continental rankings, and a day-by-day rolling calculation of global vaccine delivery.

---

## 2. Objectives

- **Primary Objective:** Build a robust, optimized SQL portfolio script that performs comprehensive exploratory data analysis on global historical COVID-19 records to identify high-risk regions.
- **Secondary Objective 1:** Establish clear, dynamic tracking for national case-to-death ratios (Mortality Risk Percentage) tailored to specific target geographic profiles (e.g., Moldova).
- **Secondary Objective 2:** Calculate and isolate precise population-to-infection rates (InfectedPopulationPercentage) to identify countries with the highest viral saturation.


---

## 3. Project Scope & Tools

### Scope

| Dimension | Details |
|-----------|---------|
| **In Scope** | Country-level daily tracking timelines; metric logs for new/total cases, deaths, and populations; rolling global vaccination dose logs. |
| **Out of Scope** | Patient-level clinical charts, vaccine brand segmentations, demographic breakdown by age brackets, and regional micro-data (city/state level). |
| **Time Period** |Comprehensive early pan-pandemic timeline records up through mid-2021. |
| **Granularity** | Daily aggregated timeline rows per country entity. |

### Tools & Technologies

| Category | Tool(s) Used |
|----------|-------------|
| Data Storage | Microsoft SQL Server (MS SQL) / SSMS, CSV files |
| Data Processing | T-SQL (Transact-SQL), BULK INSERT Pipelines |
| Analysis |Complex Window Functions, Table Partitioning, CTE Expressions|
| Version Control |  Git / GitHub|


## 4. Repository Structure

```
main/
│
├── data
├── scripts
└── README.md                 
```


## 5. Data Workflow

1. **Source:** Two highly granular flat files (CovidDeaths.csv and CovidVaccinations.csv) separated by semicolons, containing multi-million row potential entries.
2. **Ingestion:** Managed via programmatic T-SQL scripts utilizing high-speed BULK INSERT routines routing records into structured database schemas.
3. **Cleaning:** Addressed regional European formatting issues where decimals were encoded as commas (,), converting them to standard periods (.), transforming structural entries using TRY_CAST to bypass mathematical division faults, and neutralizing row duplication caused by inline continent summary aggregates using WHERE continent IS NOT NULL.
4. **Transformation:** Upgraded static integer schemas directly into adaptive FLOAT columns on core calculated fields to completely eliminate zero-value mathematical results during division operations.
5. **Analysis:** Employed compound JOIN filters matching on concurrent geographic codes (location) and specific timeline steps (date) nested inside robust Common Table Expressions.
6. **Output:** Clear, clean analytical matrix datasets ordered sequentially via structured positional indexes.

---

## 6. Data Model & Schema


### Dataset / Table: `CovidDeaths`

| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| `iso_code` | VARCHAR(10) | Global country standard identification code | MDA |
| `continent` | VARCHAR(50) | Broad geographic regional classification | Europe |
| `location` |VARCHAR(100) | Specific nation or tracked country zone | Moldova |
| `date` | DATE | Exact day of the documented timeline log | 2020-03-24 |
| `total_cases` | FLOAT| Running cumulative total of verified infections | 109.0 |
| `new_cases` | FLOAT | Newly documented infections on this day | 15.0 |
| `total_deaths` |FLOAT | Running cumulative total of documented fatalities | 1.0 |
| `population` | BIGINT | Total population baseline metric | 4033963 |
...
> **Row count :** 85172


### Dataset / Table: `CovidVaccinations`

| Field Name | Data Type | Description | Example Value |
|------------|-----------|-------------|---------------|
| `iso_code` | VARCHAR(10) | Global country standard identification code | MDA |
| `location` | VARCHAR(100) | Specific nation or tracked country zone | Moldova |
| `date` | DATE | Exact day of the documented timeline log | 2021-04-01 |
| `new_vaccinations` | VARCHAR(50) | Count of vaccine doses administered on this date | 1240 |
...

> **Row count :** 85172

> **Date range:** 2020-02-24 – Mid-2021

> **Key join / relationship:** `CovidDeaths.location = CovidVaccinations.location` AND `CovidDeaths.date = CovidVaccinations.date`


---


## 7. Analysis & Metrics

### Analytical Approach

The repository is explicitly organized around programmatic validation queries. The analysis begins with broad global overview aggregates, focuses down onto specialized national cross-sections, and finishes by building windowed accumulation layers to safely compute population delivery tracking logic over highly dynamic intervals.

### Key Metrics Defined

| Metric | Plain-Language Definition | Why It Matters |
|--------|--------------------------|----------------|
| `DeathPercentage` |The percentage ratio of total fatalities relative to total verified infection cases on any given calendar date. | Measures immediate local clinical mortality risk and mortality severity fluctuations. |
| `InfectedPopulationPercentage` | The portion of a country's total population that has contracted the virus up to that date. | Defines the exact societal infection penetration rate. |
| `RollingPeopleVaccinated` | Cumulative running summation of sequential vaccine administrations computed on a day-to-day timeline. | Maps out the ongoing delivery velocity of global healthcare deployments. |

