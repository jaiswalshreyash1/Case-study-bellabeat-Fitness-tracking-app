{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"source":"<a href=\"https://www.kaggle.com/code/shreyashjaiswalshrey/case-study-bellabeat?scriptVersionId=110100312\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown","outputs":[],"execution_count":0},{"cell_type":"markdown","source":"# **Introduction Scenerio:**","metadata":{}},{"cell_type":"markdown","source":"> Bellabeat, a high-tech manufacturer of health-focused products for women. Bellabeat is a successful small company, but they have the potential to become a larger player in the global smart device market. Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. You have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices.The insights you discover will then help guide marketing strategy for the company.","metadata":{}},{"cell_type":"markdown","source":"# Key stakeholders :","metadata":{}},{"cell_type":"markdown","source":"1.  Urška Sršen: Bellabeat’s cofounder and Chief Creative Officer,\n2. Sando Mur: Mathematician and Bellabeat’s cofounder; key member of the Bellabeat executive team,\n3. Bellabeat marketing analytics team. ","metadata":{}},{"cell_type":"markdown","source":"#   Problem statement :\n   Sršen asks you to analyze smart device usage data in order to gain insight into how consumers use non-Bellabeat smart    devices.\n*   These questions will guide your analysis:\n1. What are some trends in smart device usage?\n2. How could these trends apply to Bellabeat customers?\n3. How could these trends help influence Bellabeat marketing strategy?","metadata":{}},{"cell_type":"markdown","source":"# Data Source\nSršen encourages you to use public data that explores smart device users’ daily habits. \nShe has refferedus a specific public data set:\n\n● FitBit Fitness Tracker Data (CC0: Public Domain, dataset made available through Mobius): \n\nThis Kaggle data set contains personal fitness tracker from thirty fitbit users. Thirty eligible Fitbit users consented to the submission of personal tracker data, including minute-level output for physical activity, heart rate, and sleep monitoring. It includes information about daily activity, steps, and heart rate that can be used to explore users’ habits.","metadata":{}},{"cell_type":"markdown","source":" # Including all general packages and libraries","metadata":{}},{"cell_type":"code","source":"#general purpose libraries\nlibrary(tidyverse)\nlibrary(ggplot2)\nlibrary(skimr)\nlibrary(janitor)\nlibrary(lubridate)\n","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"#  list files (Data location)","metadata":{}},{"cell_type":"code","source":"list.files(\"../input/fitbit\")","metadata":{"scrolled":true,"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Creating Dataframe","metadata":{}},{"cell_type":"code","source":"# creating data frames \ndaily_activity <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv\")\n\nsleep_day <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv\")\n\nweight_log <- read.csv(\"../input/fitbit/Fitabase Data 4.12.16-5.12.16/weightLogInfo_merged.csv\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Take a look at table data ","metadata":{}},{"cell_type":"code","source":"#use variable name to use the file\nhead(daily_activity)\nhead(sleep_day)\nhead(weight_log)\n","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# lets find out column names of the columns","metadata":{}},{"cell_type":"code","source":"colnames(daily_activity)\ncolnames(sleep_day)\ncolnames(weight_log)","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# lets find out how many unique participants are there ?","metadata":{}},{"cell_type":"code","source":"n_distinct(daily_activity$Id)\nn_distinct(sleep_day$Id)\nn_distinct(weight_log$Id)","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# how many number of rows are there ?","metadata":{}},{"cell_type":"code","source":"nrow(daily_activity)\nnrow(sleep_day)\nnrow(weight_log)","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# lets see what are some quick summary statistics ?","metadata":{}},{"cell_type":"markdown","source":"*  **For daily_activity dataframe**","metadata":{}},{"cell_type":"code","source":"daily_activity %>%\nselect( TotalSteps,\n       TotalDistance,\n       SedentaryMinutes,VeryActiveMinutes,\n       FairlyActiveMinutes,\n       LightlyActiveMinutes,\n       Calories )%>% summary()","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* **For sleep_day dataframe**","metadata":{}},{"cell_type":"code","source":"sleep_day %>% \nselect(TotalSleepRecords\n,TotalMinutesAsleep,\nTotalTimeInBed\n) %>% summary()","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* **For weight_log dataframe**","metadata":{}},{"cell_type":"code","source":"weight_log %>%\nselect(WeightKg,\n       WeightPounds,\n       Fat,\n       BMI \n) %>% summary()","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Analysis & Visualizations :","metadata":{}},{"cell_type":"markdown","source":"* **Daily_acivity,relationship between TotalSteps vs Sedentary Minutes**","metadata":{}},{"cell_type":"code","source":"ggplot(data = daily_activity) + geom_point(mapping= aes(x=TotalSteps,y=SedentaryMinutes,color=TotalSteps,fill=SedentaryMinutes)) +\ngeom_smooth(mapping= aes(x=TotalSteps,y=SedentaryMinutes))+\nlabs(title=\"Relationship between Steps_taken in a day vs sedentary minutes\",x=\"total steps\",y=\"sedentaryminutes\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* takeaways <- the chart show the negative corelation between the total steps vs sedentary minutes i.e. more steps leads to less sedetary minutes.","metadata":{}},{"cell_type":"markdown","source":"*  **daily_activity,relationship between Total Steps vs Calorie**","metadata":{}},{"cell_type":"code","source":"ggplot(data = daily_activity) + geom_point(mapping= aes(x=TotalSteps,y=Calories,color=TotalSteps,fill=Calories)) +\ngeom_smooth(mapping= aes(x=TotalSteps,y=Calories))+\nlabs(title=\"Relationship between TotalSteps vs Calories\",x=\"Total Steps\",y=\"Calories\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* takeaways <- the chart show the positive corelation between the total steps vs calories i.e. more steps leads to more calories burned.","metadata":{}},{"cell_type":"markdown","source":"*  **daily_activity,relationship between VeryActiveMinutes vs Calorie**","metadata":{}},{"cell_type":"code","source":"ggplot(data = daily_activity) + geom_point(mapping= aes(x=VeryActiveMinutes,y=Calories,color=VeryActiveMinutes,fill=Calories)) +\ngeom_smooth(mapping= aes(x=VeryActiveMinutes,y=Calories))+\nlabs(title=\"Relationship between VeryActiveMinutes vs Calories\",x=\"Very Active Minutes\",y=\"Calories\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* takeaways <- the chart show the positive corelation between the veryactiveminutes vs calories i.e. more minutes leads to more calories burned.","metadata":{}},{"cell_type":"markdown","source":"*  **daily_activity,relationship between FairlyActiveMinutes vs Calorie**","metadata":{}},{"cell_type":"code","source":"ggplot(data = daily_activity) + geom_point(mapping= aes(x=FairlyActiveMinutes,y=Calories,color=FairlyActiveMinutes,fill=Calories)) +\ngeom_smooth(mapping= aes(x=FairlyActiveMinutes,y=Calories))+\nlabs(title=\"Relationship between FairlyActiveMinutes vs Calories\",x=\"Fairly Active Minutes\",y=\"Calories\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* takeaways <- the chart show the negative corelation between the fairlyactiveminutes vs calories i.e. more minutes leads to less calories burned.","metadata":{}},{"cell_type":"markdown","source":"*  **daily_activity,relationship between LightlyActiveMinutes vs Calorie**","metadata":{}},{"cell_type":"code","source":"ggplot(data = daily_activity) + geom_point(mapping= aes(x=LightlyActiveMinutes,y=Calories,color=LightlyActiveMinutes,fill=Calories)) +\ngeom_smooth(mapping= aes(x=LightlyActiveMinutes,y=Calories))+\nlabs(title=\"Relationship between LightlyActiveMinutes vs Calories\",x=\"LightlyActiveMinutes\",y=\"Calories\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* takeaways <- the chart show the positive corelation between the lightactiveminutes vs calories i.e. more minutes leads to more calories burned","metadata":{}},{"cell_type":"markdown","source":"* **Sleep_activity,relationship between minuteasleep vs time_in_bed**","metadata":{}},{"cell_type":"code","source":"ggplot(data = sleep_day) + geom_point(mapping= aes(x=TotalMinutesAsleep,y=TotalTimeInBed,color=TotalMinutesAsleep,fill=TotalTimeInBed)) +\ngeom_smooth(mapping= aes(x=TotalMinutesAsleep,y=TotalTimeInBed))+\nlabs(title=\"Relationship between TotalMinutesAsleep vs TotalTimeInBed\",x=\"TotalMinutesAsleep\",y=\"TotalTimeInBed\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* takeaways <- the chart shows people who sleep less than 7 hours (420 mins),stay longer time on bed\n*  on an average the people are spending 40 minutes more on bed than they slept.","metadata":{}},{"cell_type":"markdown","source":"# Merging those 2 dataset together","metadata":{}},{"cell_type":"code","source":"combined_data_1 <- merge(daily_activity,sleep_day,by=\"Id\")\ncombined_data_2 <- merge(combined_data_1,weight_log,by=\"Id\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# distinct values in merged dataset","metadata":{}},{"cell_type":"markdown","source":"*  **distinct value in combined dataset 2 by ID**","metadata":{}},{"cell_type":"code","source":"n_distinct(combined_data_2$Id)","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"*  **distinct value in combined dataset 2 by BMI**","metadata":{}},{"cell_type":"code","source":"n_distinct(combined_data_2$BMI)","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"colnames(combined_data_2)","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* **ploting of combined dataset** ","metadata":{}},{"cell_type":"code","source":"ggplot(data = combined_data_2)+\ngeom_smooth(mapping= aes(x=TotalMinutesAsleep,y=TotalTimeInBed))+\ngeom_jitter(mapping= aes(x=TotalMinutesAsleep,y=TotalTimeInBed,size=BMI,color=BMI))+\nlabs(title=\"Relationship between TotalMinutesAsleep vs TotalTimeInBed in combined dataset\",x=\"TotalMinutesAsleep\",y=\"TotalTimeInBed\")","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* takeaways <-The largest cluster of plots is located between 330 mins and 550 mins in asleep time, and between 300 mins and 600 mins in the time in bed.\n* The Cluster of plots mostly contain BMI around 25-35.","metadata":{}},{"cell_type":"markdown","source":"* #  combined_data_2 ,Relationship between Total time slept vs Total steps per day with BMI values","metadata":{}},{"cell_type":"code","source":"ggplot(data=combined_data_2)+ \ngeom_jitter(mapping=aes(x=TotalMinutesAsleep,y=TotalSteps,color=BMI, size=BMI))+\ngeom_smooth(mapping=aes(x=TotalMinutesAsleep,y=TotalSteps))+\nlabs(x=\"Total time slept\",\n    y=\"Total steps per day\",\n    title=\"Relationship between Total time slept vs Total steps per day with BMI values\",\n    subtitle=\"how the sleeping time and steps per day are related to BMI ?\",\n    caption=\"Data collected by FitBit Fitness Tracker Data\")+\ngeom_vline(xintercept= 420 , color=\"purple3\", linetype=\"dashed\", size= 2)+\ngeom_hline(yintercept= 7500 , color=\"purple3\", linetype=\"longdash\", size= 2)+\nannotate(\"label\",color=\"plum4\",x=550, y=6000 , label=\"WHO RECOMMENDATION\")+\nannotate(\"rect\",xmin=150,xmax=800,ymin=-100,ymax=5000,color=\"blue\",fill=\"blue\",alpha=0.2)+\nannotate(\"label\",color=\"steelblue3\",x=500, y=150 , label=\"Lesser steps group\")+\nannotate(\"label\",color=\"red\",x=250, y=24000 , label=\"Active users\")+\nannotate(\"rect\",xmin=210,xmax=420,ymin=7500,ymax=23000,color=\"red\",fill=\"red\",alpha=0.2)\n","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* The higher BMI value user has lesser step per day\n* The higher BMI value user has irreguar sleeping time. ","metadata":{}},{"cell_type":"markdown","source":"* #  combined_data_2 ,Relationship between Total time slept vs Total steps per day with BMI values","metadata":{}},{"cell_type":"code","source":"ggplot(data=combined_data_2)+ \ngeom_smooth(mapping=aes(x=SedentaryMinutes,y=TotalSteps))+\ngeom_jitter(mapping=aes(x=SedentaryMinutes,y=TotalSteps,color=BMI, size=BMI))+\nlabs(x=\"Sedentary Time(min)\",\n    y=\"Total steps per day\",\n    title=\"Relationship between SedentaryMinutes vs Total steps per day with BMI values\",\n    subtitle=\"Who is the most frequent sitting person?\",\n    caption=\"Data collected by FitBit Fitness Tracker Data\")+\ngeom_hline(yintercept= 7500 , color=\"purple3\", linetype=\"longdash\", size= 2)+\nannotate(\"label\",color=\"plum4\",x=250, y=6000 , label=\"WHO RECOMMENDATION\")+\nannotate(\"rect\",xmin=600,xmax=1500,ymin=-500,ymax=5000,alpha=0.2)+\nannotate(\"label\",color=\"steelblue3\",size=3.6,x=1000, y=-1000, label=\"Lesser steps group\")+\nannotate(\"rect\",xmin=400,xmax=1250,ymin=7500,ymax=20000,color=\"red\",alpha=0.2)+\nannotate(\"label\",color=\"red\",x=1400, y=15000 , label=\"Intensive users\")\n","metadata":{"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"* The higher BMI value user has lesser step per day\n* The higher BMI value user has more sedentary time. ","metadata":{}},{"cell_type":"markdown","source":"# Recommendations : Based on analysis\n","metadata":{}},{"cell_type":"markdown","source":"**1.What are some trends in smart device usage?**\n* People with higher BMI value has lesser steps per day as well as more sedentary time, and irregular sleep cycles","metadata":{}},{"cell_type":"markdown","source":"**2. How could these trends apply to Bellabeat customers?**\n* The low level of sedentary minutes & higher level of BMI is mostly becuase of the person dont have enough time to do exercices \n* & also people have irregular sleeping time.","metadata":{}},{"cell_type":"markdown","source":"**3. How could these trends help influence Bellabeat marketing strategy?**\n* The target audience is female office employer who has little to no time to take care about their physical health & irregular sleep time users\n* We can make specific premium features like Short duration training plans, Long term healthy BMI stuctural plans, Sell health deit plan, Bed time remainders, Wake up time remainder, Calorie calculator, Calorie burner, Minimum steps for the day, Minimum sedentary minutes.","metadata":{}}]}