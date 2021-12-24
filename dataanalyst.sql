-- here found out where was the first omicron was reported and on what date it was reported.
select * from CovidCases cc
join Covidvariant cv
on cc.date = cv.Day and cc.location = cv.Entity
where omicron >= 1
order by date,Day;

--we can do the same for each and every variant mentioned in the data set.

-- now saperating the new variant from the old variant.

select *, (cc.total_cases)-(cv.Beta+cv.Epsilon+cv.Gamma+cv.Kappa+cv.Delta+cv.Alpha+cv.Lambda+cv.Mu+cv.omicron) as oldvariant from CovidCases cc
join Covidvariant cv
on cc.date = cv.Day and cc.location = cv.Entity
--where oldvariant < 0
order by date,Day,location,continent;

--selecting the few columns 
select cc.continent, cc.location,cc.date ,cc.population,cc.total_cases,cv.Beta,cv.Epsilon,cv.Gamma,cv.Kappa,cv.Alpha,cv.Lambda,cv.Mu,cv.Omicron, (cc.total_cases)-(cv.Beta+cv.Epsilon+cv.Gamma+cv.Kappa+cv.Delta+cv.Alpha+cv.Lambda+cv.Mu+cv.omicron) as oldvariant from CovidCases cc
join Covidvariant cv
on cc.date = cv.Day and cc.location = cv.Entity
--where oldvariant < 0
order by date,Day,location,continent;

--creating the temp table
drop table if exists #allVariants
create Table #allVariants
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
total_cases numeric,
Beta numeric,
Epsilon numeric,
Gamma numeric,
Kappa numeric,
Alpha numeric,
Lambda numeric,
Mu numeric,
Omicron numeric,
oldvariant numeric
)
insert into #allVariants

select cc.continent, cc.location,cc.date ,cc.population,cc.total_cases,cv.Beta,cv.Epsilon,cv.Gamma,cv.Kappa,cv.Alpha,cv.Lambda,cv.Mu,cv.Omicron, (cc.total_cases)-(cv.Beta+cv.Epsilon+cv.Gamma+cv.Kappa+cv.Delta+cv.Alpha+cv.Lambda+cv.Mu+cv.omicron) as oldvariant from CovidCases cc
join Covidvariant cv
on cc.date = cv.Day and cc.location = cv.Entity
--where oldvariant < 0
order by date,Day,location,continent;

select * from #allVariants

-- creating view for data visulaization 
create view allVariants as 
select cc.continent, cc.location,cc.date ,cc.population,cc.total_cases,cv.Beta,cv.Epsilon,cv.Gamma,cv.Kappa,cv.Alpha,cv.Lambda,cv.Mu,cv.Omicron, (cc.total_cases)-(cv.Beta+cv.Epsilon+cv.Gamma+cv.Kappa+cv.Delta+cv.Alpha+cv.Lambda+cv.Mu+cv.omicron) as oldvariant from CovidCases cc
join Covidvariant cv
on cc.date = cv.Day and cc.location = cv.Entity
--where oldvariant < 0
--order by date,Day,location,continent;