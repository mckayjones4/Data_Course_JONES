# Assignment 8
## Models
# A statistical model is a simple equation that explains trends in your data

# A few helpful rules:
# All continuous explanatory variables: Regression
## All categorial: ANOVA
### Mix of categorical and continuous explanatory: ANCoVA

# All continuous response variables: Regression, ANOVA, ANCoVA
## Catergorical response: ANOVA
### Proportion: Logistic regression
#### Count: Log-Linear model
##### Binary: Binary logistic

# load packages
library(modelr)
library(easystats)
library(broom)
library(tidyverse)
library(fitdistrplus)

# load some data
data("mtcars")
glimpse(mtcars)

# mpg is our dependent variable
## 1. try a simple lienar model with displacement and horsepower as explanatory variables
mod1 = lm(mpg~disp, data = mtcars)
summary(mod1)

# look at the relationsihp visually
mtcars %>%
  ggplot(aes(x = disp,
             y = mpg)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_minimal()

# make another model that incorportes speed
mod2 = lm(mpg ~ qsec, data = mtcars)
summary(mod2)

mtcars %>%
  ggplot(aes(x = disp,
             y = qsec)) +
  geom_point() +
  geom_smooth(method = 'lm') +
  theme_minimal()

# measuring the 'scatter' around each line can be done by the mean-squared error
## the smaller MSE, the better
mean(mod1$residuals^2) # 9.911209, this model is better
mean(mod2$residuals^2) # 29.0248

# add_predictions() function takes the data frame and model, allowing us to 
## look at what values the model assigns to the response variable
### ACTUAL vs PREDICTED values
df <- mtcars %>%
  add_predictions(mod1)

df %>% dplyr::select("mpg", "pred")

# Make a new data frame with the predictor values we want to access
# mod1 only has "disp" as a predictor
newdf <- data.frame(disp = c(500, 600, 700, 800, 900))

# making predictions
pred = predict(mod1, newdata = newdf)

# combining hypothetical input data with hypothetical predictions into one new data fram
hyp_preds <- data.frame(disp = newdf$disp,
                        pred = pred)

# add new column showing whether a data point is real or hypothetical
df$PredictionType <- "Real"
hyp_pred$PredictionType <- "Hypothetical"

# joining our real data and hypothetical data (with model predictions)
fullpreds <- full_join(df, hyp_preds)

# plot these predictions on the original graph
ggplot(fullpreds, aes(x = disp, y = pred, color = PredictionType)) +
  geom_point() + 
  geom_point(aes(y = mpg), color = "Black") +
  theme_minimal()

# Comparing Models
## define a 3rd model
mod3 <- glm(data = mtcars,
            formula = mpg~hp+disp+factor(am) + qsec)

# put all models into a list
mods <- list(mod1=mod1, mod2=mod2, mod3= mod3)
# apply "performance" function on all in the list and combine
map(mods, performance) %>% reduce(full_join)

# gather residuals from all 3 models
mtcars %>%
  gather_residuals(mod1,mod2,mod3) %>%
  ggplot(aes(x = model, y = resid, fill = model)) +
  geom_boxplot(alpha = .5) +
  geom_point() +
  theme_minimal()

# gather predictions from all 3 models
mtcars %>%
  gather_predictions(mod1, mod2, mod3) %>%
  ggplot(aes(x = disp, y = mpg)) +
  geom_point(size = 3) +
  geom_point(aes(y=pred,color=model)) +
  geom_smooth(aes(y=pred, color=model)) +
  theme_minimal()

#make sense of the model
report(mod3)

## My Assignment ##
# 1. load the mushroom growth data set
dat <- read.csv("../../Data/mushroom_growth.csv")

# 2. create several plots exploring relationships between the reposeponse and predictors
glimpse(dat)

dat %>%
  ggplot(aes(x = Humidity,
             y = GrowthRate,
             fill = Species)) +
  geom_boxplot()

dat %>%
  ggplot(aes(x = Nitrogen,
             y = GrowthRate,
             color = Species)) +
  geom_point() +
  geom_smooth()

dat %>%
  ggplot(aes(x = Light,
             y = GrowthRate,
             color = Species)) +
  geom_point()

# 3. define at least 4 models that explain the dependent variable "Growth Rate"
mod1 = glm(GrowthRate~Light, data = dat)
mod2 = glm(data = dat, formula = GrowthRate ~ Nitrogen)
mod3 = glm(data = dat, formula = GrowthRate ~ Humidity)
mod4 = glm(data = dat, formula = GrowthRate ~ Species)
mod5 = glm(data = dat, formula = GrowthRate ~ Temperature)
mod6 = glm(data = dat, formula = GrowthRate~ Light+Nitrogen+Temperature+Species)

# 4. Calculate the mean sq. error of each model
mean(mod1$residuals^2) #7702.834
mean(mod2$residuals^2) #9723.331
mean(mod3$residuals^2) #7854.92
mean(mod4$residuals^2) #9143.7
mean(mod5$residuals^2) #9636.742
mean(mod6$residuals^2) #7019.991

# 5. select the best model
compare_performance(mod1, mod2, mod3, mod4, mod5, mod6) %>%plot()

# model 6 is the best model
# 6. Add predictions based on new hypothetical values
## for the independent variables used in the model
df1 <- dat %>%
  add_predictions(mod6)

df1 %>% dplyr::select("GrowthRate", "pred")

# making predictions
newdf <- data.frame(Light = c(30, 40, 50, 60),
                    Nitrogen = c(50, 55, 60, 65))

pred = predict(mod1, newdata = newdf)

# combining hypothetical input data with hypothetical predictions into the new data frame
hyp_pred <- data.frame(Light = newdf$Light,
                       pred = pred)

# add a new column showing whether a data point is real or hypothetical
df1$PredictionType <- "Real"
hyp_pred$PredictionType <- "Hypothetical"

# join the real data and hypothetical data
full_preds <- full_join(df1, hyp_pred)

# 7. Plot these predictions alongside real data
full_preds %>%
  ggplot(aes(x = Nitrogen,
         y = pred,
         color = PredictionType)) +
  geom_point() +
  geom_point(aes(y=GrowthRate, color = "Black")) +
  theme_minimal()

# model non-linear relationships
data <- read.csv("../../Data/non_linear_relationship.csv")

glimpse(data)

# build a linear model to see what we're dealing with
linear_model <- lm(response~predictor, data = data)

# visualize how bad the linear model is
data %>%
  ggplot(aes(x = predictor,
             y = response)) +
  geom_point() +
  geom_smooth(method = 'lm', color = 'red')

# build a quadratic model instead
quad_model <- lm(response ~ predictor + I(predictor^2), data = data)

data %>%
  ggplot(aes(x= predictor,
             y = response)) +
  geom_point() +
  stat_smooth(method = 'lm', formula = y ~ x + I(x^2), color = "blue")
