# Load required library
library(ggplot2)
library(reshape2) 
library(gridExtra)
library(corrplot)
library(caret) 

# set the path of your directory
setwd("")

######################### Data Exploration ###################################
  
# load the data
splicing_data <- read.csv("test_data.csv")

# Perform summary statistics on the dataset
summary(splicing_data)

# Check for missing values using sapply function
missing_values <- sapply(splicing_data, function(x) sum(is.na(x)))
print(missing_values) # all columns return 0, so no missing values

# Check for any outliers in the dataset through a histogram 
# Create the plot object:
hist_SplicingFactor1 <- ggplot(splicing_data, aes(x = SplicingFactor1)) +
  geom_histogram(binwidth = 0.4, fill = "lightskyblue", color = "black") +
  labs(title = "SplicingFactor1", x = "SplicingFactor1", y = "Frequency")

hist_SplicingFactor2 <- ggplot(splicing_data, aes(x = SplicingFactor2)) +
  geom_histogram(binwidth = 0.4, fill = "lightskyblue", color = "black") +
  labs(title = "SplicingFactor2", x = "SplicingFactor2", y = "Frequency")

hist_SplicingFactor3 <- ggplot(splicing_data, aes(x = SplicingFactor3)) +
  geom_histogram(binwidth = 0.4, fill = "lightskyblue", color = "black") +
  labs(title = "SplicingFactor3", x = "SplicingFactor3", y = "Frequency")

hist_SplicingEvent <- ggplot(splicing_data, aes(x = SplicingEvent)) +
  geom_histogram(binwidth = 0.4, fill = "lightskyblue", color = "black") +
  labs(title = "SplicingEvent", x = "SplicingEvent", y = "Frequency")

# Arrange the histograms in a grid, 2 columns by 2 rows
grid.arrange(hist_SplicingFactor1, hist_SplicingFactor2, hist_SplicingFactor3, hist_SplicingEvent, ncol = 2)

# Another visualization to view the outliers clearly
melted_data <- reshape2::melt(splicing_data, id.vars = "SubjectID")

# Create boxplot visualizations
boxplots <- ggplot(melted_data, aes(x = variable, y = value)) +
  geom_boxplot(fill = "lightsalmon", color = "black") +
  labs(title = "Distribution of Splicing Factors and Splicing Event",
       x = "Variable",
       y = "Expression Level/Value") +
  theme_minimal() +
  facet_wrap(~variable, scales = "free")

# Print the boxplots
print(boxplots)

# Generate a correlation matrix to assess the relationships between splicing factors & splicing event.
correlation_matrix <- cor(splicing_data[, -1]) # removing the SubjectID column, default is pearson
print(correlation_matrix)

# Convert correlation matrix to data frame and melt it
correlation_df <- melt(correlation_matrix)

# Plot the correlation matrix as a heatmap for better visualization
ggplot(data = correlation_df, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  theme_classic() +
  scale_fill_gradient2(low = "blue", mid = "white", high = "firebrick3", midpoint = 0) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
  plot.title = element_text(hjust=0.5)) +
  labs(x = NULL, y = NULL) + ggtitle("Correlation Matrix")

##################### Data Visualization ########################

# splicing factor 1 and splicing event boxplot as q1
q1 <- ggplot(splicing_data, aes(y = SplicingFactor1)) +
  geom_boxplot(fill = "bisque", color = "black") +
  labs(title = "SPF-1 vs SplicingEvent",
       x = "SplicingFactor1",
       y = "SplicingEvent")

# splicing factor 2 and splicing event boxplot as q2
q2 <- ggplot(splicing_data, aes(y = SplicingFactor2)) +
  geom_boxplot(fill = "bisque", color = "black") +
  labs(title = "SPF-2 vs SplicingEvent",
       x = "SplicingFactor2",
       y = "SplicingEvent")

# splicing factor 3 and splicing event boxplot as q3
q3 <- ggplot(splicing_data, aes(y = SplicingFactor3)) +
  geom_boxplot(fill = "bisque", color = "black") +
  labs(title = "SPF-3 vs SplicingEvent",
       x = "SplicingFactor3",
       y = "SplicingEvent")

# Combine the plots using grid arrange function
grid.arrange(q1, q2, q3, nrow = 1)

# Creating scatterplots to visualize the relationships for each splicing factor and splicing event
# splicing factor 1 and splicing event scatterplot as p1
p1 <- ggplot(splicing_data, aes(x = SplicingFactor1, y = SplicingEvent)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red", size = 0.5) +  # Add linear regression line
  labs(title = "Scatterplot on SPF-1 vs SplicingEvent",
       x = "SplicingFactor1",
       y = "SplicingEvent")

# splicing factor 2 and splicing event scatterplot as p2
p2 <- ggplot(splicing_data, aes(x = SplicingFactor2, y = SplicingEvent)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red", size = 0.5) +  # Add linear regression line
  labs(title = "Scatterplot on SPF-2 vs SplicingEvent",
       x = "SplicingFactor2",
       y = "SplicingEvent")

# splicing factor 3 and splicing event scatterplot as p3
p3 <- ggplot(splicing_data, aes(x = SplicingFactor3, y = SplicingEvent)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red", size = 0.5) +  # Add linear regression line
  labs(title = "Scatterplot on SPF-3 vs SplicingEvent",
       x = "SplicingFactor3",
       y = "SplicingEvent")

# Combine the above 3 plots using grid arrange function
grid.arrange(p1, p2, p3, nrow = 1)

##################### Predictive Modeling #########################

# Set the seed for reproducibility
set.seed(999)

# Split the dataset into training set (70%) and testing set (30%)
train_indices <- createDataPartition(splicing_data$SplicingEvent, p = 0.7, list = FALSE)
training_set <- splicing_data[train_indices, ]
testing_set <- splicing_data[-train_indices, ]

dim(training_set) # 72 by 5
dim(testing_set) # 28 by 5

# Build multiple linear regression model
linear_model <- lm(SplicingEvent ~ SplicingFactor1 + SplicingFactor2 + SplicingFactor3, data = training_set)

# Print the summary of the linear regression model
summary(linear_model)

# Splicing factor 1 has the positive significant effect on the splicing event.
# Splicing factor 2 has a negative significant effect on the splicing event.
# Splicing factor 3 has no significant effect on the splicing event.