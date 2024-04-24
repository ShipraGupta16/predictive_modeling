# Predictive modeling

Aim of this work is to perform exploratory data analysis (EDA), data visualization, and predictive modeling to gain insights into the relationship between multiple predictors (independent variables) and an outcome event (dependent variable) from a dataset.

Data: A Synthetic Splicing Dataset.

#### Introduction <br>
Gene splicing is a biological process that occurs in eukaryotic cells to generate functional messenger RNA (mRNA) molecules from the precursor RNA. The primary purpose of gene splicing is to remove non-coding regions (introns) and join the coding regions (exons) to create a mature mRNA molecule that can be translated into a protein. <br>

This analysis utilized a synthetic dataset containing the expressions of 3 splicing factors and a related splicing event across 100 subjects. The objective is to perform exploratory data analysis (EDA), data visualization, and predictive modeling to gain insights into the relationships between splicing factors (predictors) and the splicing event (outcomes).

#### Dataset explanations
*	SubjectID: This column uniquely identifies each subject in the experiment.
*	SplicingFactor1, SplicingFactor2, SplicingFactor3: These columns represent the expression levels of three splicing factors measured for each subject. Splicing factors are proteins that regulate the splicing process, which is an essential step in gene expression. During splicing, introns (non-coding regions) are removed from a pre-mRNA molecule, and exons (coding regions) are joined together to create a mature mRNA molecule. Splicing factors influence which exons are included in the final mRNA product, and therefore, they can control the protein that is ultimately produced from a gene.
*	SplicingEvent: This column represents the outcome of the splicing event for each subject. It refers to the difference in exon usage between two isoforms of a transcript. An isoform is a variation of an RNA molecule that arises from alternative splicing of a pre-mRNA molecule. The value in this column indicates how much these splicing factors influence the splicing event.

#### Dataset explorations
*	Splicing factor 1 and 2 have outliers in the dataset based on histogram and boxplots.
*	There were no missing values in the dataset.
*	Based on correlation analysis (default Pearson) and multiple regression analysis, Splicing factor 1 has a positive relationship, Splicing factor 2 has a negative relationship and Splicing factor 3 has no relationship with splicing event.
Predictive modelling: 
*	I used createDataPartition() function from the caret package is used to create indices for partitioning the data. It takes the SplicingEvent column from the splicing_data dataset as the target variable. p = 0.7 specifies that 70% of the data will be used in the training set, while the remaining 30% will be used for testing.
*	I applied multiple linear regression analysis where the outcome or dependent variable is SplicingEvent, and the independent variables or multiple predictors are SplicingFactor1, SplicingFactor2, and SplicingFactor3.
*	The coefficients represent the estimated effect of each independent variable on the dependent variable. Here, a one-unit increase in SplicingFactor1 is associated with a 1.8698 increase in the predicted value of SplicingEvent, holding other variables constant.
*	The standard errors measure the variability of the coefficient estimates. The t-values indicate whether the coefficients are significantly different from zero. In this output, "SplicingFactor1" and "SplicingFactor2" have significant coefficients because their p-values are very low (p < 0.05), while "SplicingFactor3" is not significant (p = 0.170).
*	The R-squared value (0.5937) represents the proportion of variance in the dependent variable explained by the independent variables. Hence, approximately 59.37% of the variance in SplicingEvent is accounted for by the independent variables.
*	The F-statistic tests the overall significance of the model. Here, the F-statistic is significant (p-value: 2.588e-13), indicating that at least one of the independent variables has a significant effect on SplicingEvent. <br>

Overall, the model is statistically significant, but the significance of individual predictors varies. SplicingFactor1 and SplicingFactor2 have significant effects on SplicingEvent, while SplicingFactor3 do not influence SplicingEvent. Furthermore, Splicing factor 1 has a positive significant effect and Splicing factor 2 has a negative significant effect on splicing event.


