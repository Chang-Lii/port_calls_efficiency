library(tidyverse)

port <- read_csv("data/cleaned_data.csv")

################################### EDA #######################################
# Summary
summary(port$Median_time_in_port_days_Value)

######## Transform 前 #####################

# Histogram + Density
ggplot(port, aes(x = Median_time_in_port_days_Value)) +
  geom_histogram(aes(y = ..density..), bins = 30, 
                 fill = "skyblue", color = "white", alpha = 0.6) +
  geom_density(color = "red", linewidth = 0.5) +
  labs(
    x = "Median time in port (days)",
    y = "Density",
    title = "Distribution of Median Time in Port"
  ) +
  theme_minimal()

# Q-Q 图：检查是否严重偏离正态
qqnorm(port$Median_time_in_port_days_Value)
qqline(port$Median_time_in_port_days_Value)

######## Transform 后 #####################

# 先确认有没有 <=0 的值（如果有要特殊处理）
summary(port$Median_time_in_port_days_Value)

# 创建 log 变量
port <- port %>%
  mutate(
    log_median_time = log(Median_time_in_port_days_Value)
  )

# Histogram + Density(After log transformation)
ggplot(port, aes(x = log_median_time)) +
  geom_histogram(aes(y = ..density..), bins = 30,
                 fill = "skyblue", color = "white", alpha = 0.6) +
  geom_density(color = "red", linewidth = 0.5) +
  labs(
    x = "log(median time in port)",
    y = "Density",
    title = "Distribution of log(median time in port)"
  ) +
  theme_minimal()


# log(Y) 的 Q-Q 图
qqnorm(port$log_median_time)
qqline(port$log_median_time)


############################  构建模型  ##################################

### Base Model
model_0 <- lm(
  log_median_time ~ Average_age_of_vessels_years_Value + Average_size_GT_of_vessels_Value,
  data = port
)

summary(model_0)
anova(model_0)
AIC(model_0)
logLik(model_0)

### Model-1
model_1 <- lm(
  log_median_time ~ Average_age_of_vessels_years_Value +
    Average_size_GT_of_vessels_Value +
    CommercialMarket_Label,
  data = port
)
summary(model_1)
anova(model_0, model_1)
AIC(model_1)
logLik(model_1)

### Model-2
model_2 <- lm(
  log_median_time ~ Average_age_of_vessels_years_Value +
    Average_size_GT_of_vessels_Value +
    CommercialMarket_Label +
    Economy_Label,
  data = port
)

summary(model_2)
anova(model_1, model_2)
AIC(model_2)
logLik(model_2)

### 交互项_1
model_int1 <- lm(
  log_median_time ~ Average_age_of_vessels_years_Value +
    Average_size_GT_of_vessels_Value * CommercialMarket_Label +
    Economy_Label,
  data = port
)
summary(model_int1)
anova(model_int1)
anova(model_2, model_int1)  # 比较 Model 2 和新模型
AIC(model_int1)
logLik(model_int1)

### 交互项_2
model_int2 <- lm(
  log_median_time ~ Average_age_of_vessels_years_Value * CommercialMarket_Label +
    Average_size_GT_of_vessels_Value +
    Economy_Label,
  data = port
)
summary(model_int2)
anova(model_2, model_int2)
anova(model_int1, model_int2)
AIC(model_int2)
logLik(model_int2)


######################Evaluation#############################

### Residuals vs Fitted ###
plot(model_int1$fitted.values,
     residuals(model_int1),
     xlab = "Fitted values",
     ylab = "Residuals",
     main = "Residuals vs Fitted")
abline(h = 0, col = "red")

### Q–Q plot ###
qqnorm(residuals(model_int1), main = "Normal Q–Q Plot")
qqline(residuals(model_int1), col = "red")

### Scale-Location plot ###
plot(model_int1$fitted.values,
     sqrt(abs(residuals(model_int1))),
     xlab = "Fitted values",
     ylab = "Sqrt(|Residuals|)",
     main = "Scale–Location")

### Cook’s Distance ###
plot(cooks.distance(model_int1),
     ylab = "Cook's distance",
     main = "Cook's Distance")
abline(h = 4/length(model_int1$fitted.values),
       col = "red",
       lty = 2)
### Multicollinearity ###
library(car)

vif(model_int1)



