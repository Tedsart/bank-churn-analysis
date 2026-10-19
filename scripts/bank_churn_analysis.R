# Bank Churn Analysis — exploratory analysis in R
# Temidayo Kukoyi · https://temidayokukoyi.vercel.app/work/bank-churn-analysis
# Source notebook: https://www.kaggle.com/code/tedsart/edts-bank-churn-analysis

# Load libraries
library(readxl)
library(dplyr)
library(ggplot2)
library(corrplot)

# Load dataset (the workbook lives in /data in this repository)
df <- read_excel("data/bank-churn-Analysis.xlsx")

# Convert columns to factors
df$Exited <- factor(df$Exited, labels = c("Stayed", "Churned"))
df$Gender <- as.factor(df$Gender)
df$Geography <- as.factor(df$Geography)
df$`Card Type` <- as.factor(df$`Card Type`)
df$HasCrCard <- factor(df$HasCrCard, labels = c("No Card", "Has Card"))
df$IsActiveMember <- factor(df$IsActiveMember, labels = c("Inactive", "Active"))

# 1. Churn by Age Groups
df %>%
  mutate(AgeGroup = cut(Age, breaks=c(18,30,40,50,60,100),
                        labels=c("18-30","31-40","41-50","51-60","60+"))) %>%
  ggplot(aes(x=AgeGroup, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Age Groups", y="Proportion") +
  theme_minimal()

# Churn by Credit Score
ggplot(df, aes(x=CreditScore, fill=Exited)) +
  geom_histogram(position="identity", alpha=0.5, bins=30) +
  labs(title="Credit Score by Churn", x="Credit Score", y="Count") +
  theme_minimal()

# Churn by Gender
ggplot(df, aes(x=Gender, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Gender", y="Proportion") +
  theme_minimal()

# Churn by Geography
ggplot(df, aes(x=Geography, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Geography", y="Proportion") +
  theme_minimal()

# Churn by Card Type
ggplot(df, aes(x=`Card Type`, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Card Type", y="Proportion") +
  theme_minimal()

# 2. Churn vs Satisfaction Score
ggplot(df, aes(x=`Satisfaction Score`, fill=Exited)) +
  geom_histogram(position="identity", alpha=0.5, bins=20) +
  labs(title="Satisfaction Score by Churn", x="Satisfaction Score", y="Count") +
  theme_minimal()

# Churn vs Complaints
ggplot(df, aes(x=Complain, fill=Exited)) +
  geom_histogram(position="identity", alpha=0.5, bins=20) +
  labs(title="Complaints by Churn", x="Complain", y="Count") +
  theme_minimal()

# 3. Churn vs Number of Products
ggplot(df, aes(x=NumOfProducts, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Number of Products", y="Proportion") +
  theme_minimal()

# 4. Churn vs Credit Card & Active Membership
ggplot(df, aes(x=HasCrCard, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Credit Card Ownership", y="Proportion") +
  theme_minimal()

ggplot(df, aes(x=IsActiveMember, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Active Membership", y="Proportion") +
  theme_minimal()

# 5. Churn vs Estimated Salary
ggplot(df, aes(x=EstimatedSalary, fill=Exited)) +
  geom_histogram(position="identity", alpha=0.5, bins=20) +
  labs(title="Estimated Salary by Churn", x="Estimated Salary", y="Count") +
  theme_minimal()

# Churn vs Balance
ggplot(df, aes(x=Balance, fill=Exited)) +
  geom_histogram(position="identity", alpha=0.5, bins=20) +
  labs(title="Balance by Churn", x="Balance", y="Count") +
  theme_minimal()

# 6. Churn vs Tenure
ggplot(df, aes(x=Tenure, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Tenure", y="Proportion") +
  theme_minimal()

# 7. Churn by Card Type (reinforced)
ggplot(df, aes(x=`Card Type`, fill=Exited)) +
  geom_bar(position="fill") +
  labs(title="Churn by Card Type", y="Proportion") +
  theme_minimal()

# 8. Churn by Geography (proportions)
df %>%
  group_by(Geography, Exited) %>%
  summarise(count=n(), .groups='drop') %>%
  ggplot(aes(x=Geography, y=count, fill=Exited)) +
  geom_col(position="fill") +
  labs(title="Churn Proportion by Geography", y="Proportion") +
  theme_minimal()

# 9. Churn vs Points Earned
ggplot(df, aes(x=`Point Earned`, fill=Exited)) +
  geom_histogram(position="identity", alpha=0.5, bins=20) +
  labs(title="Points Earned by Churn", x="Points Earned", y="Count") +
  theme_minimal()

# 10. Churn Risk Profile (correlation heatmap)
numeric_df <- df %>% select(where(is.numeric))
cor_mat <- cor(numeric_df, use="complete.obs")
corrplot(cor_mat, method="color", tl.cex=0.8, number.cex=0.7, title="Correlation Heatmap (Risk Profile)")
