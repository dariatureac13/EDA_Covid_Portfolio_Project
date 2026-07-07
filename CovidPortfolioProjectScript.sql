SELECT
*
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4



-- Select Data that we are going to be using

SELECT
location,
date,
total_cases,
new_cases,
total_deaths,
population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country
SELECT
location,
date,
total_cases,
total_deaths,
(total_deaths/total_cases)*100 DeathPercentage
FROM CovidDeaths
WHERE location = 'Moldova' 
AND continent IS NOT NULL
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Shows what percentage of population got Covid

SELECT
location,
date,
total_cases,
population,
(total_cases/population)*100 InfectedPopulationPercentage
FROM CovidDeaths
--WHERE location = 'Moldova'
WHERE continent IS NOT NULL
ORDER BY 1,2


-- Looking at Countries with Highest Infection Rate compared to Population

SELECT
location,
MAX(total_cases) HighestInfectionCount,
population,
MAX((total_cases/population))*100 InfectedPopulationPercentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY InfectedPopulationPercentage DESC

 SELECT * FROM CovidDeaths

-- Showing Countries with Highest Death Count per Population

SELECT
location,
MAX(total_deaths) TotalDeathCount,
population
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY TotalDeathCount DESC

-- Let's break things down by continent



-- Showing continents with the highest death count per population

SELECT
continent,
MAX(total_deaths) TotalDeathCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- GLOBAL NUMBERS


SELECT
SUM(new_cases) total_cases,
SUM(cast(new_deaths as int)) total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases)*100 DeathPercentage
FROM CovidDeaths
--WHERE location = 'Moldova'
WHERE continent IS NOT NULL
--GROUP BY date
ORDER BY 1,2


-- Looking at Total Population vs Vaccinations

-- USE CTE

WITH PopvsVac (continent, location, date, population,new_vaccinations, RollingPeopleVaccinated)
AS
(
SELECT 
dea.continent,
dea.location,
dea.date,
dea.population,
vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) RollingPeopleVaccinated
FROM CovidDeaths dea
JOIN CovidVaccinations vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)

SELECT *, (RollingPeopleVaccinated*1.0/population)*100
FROM PopvsVac
ORDER BY location,date




