# The Logic of Hypothesis Testing

In a hypothesis test, we start by assuming the null hypothesis is true. We then gather our evidence (data from a sample). Based on the evidence we can draw only one of two inferences: 

+ **reject** the null hypothesis $H_{o}$, or
+ **fail to reject** the null hypothesis $H_{o}$

If the data indicate we should "reject $H_{o}$," we can say that it is likely that $H_{a}$ is true. If instead the data indicate we should “fail to reject $H_{o}$”, we conclude that our sample did not provide sufficient evidence to support $H_{a}$. Note that based on sample data, we can never *accept* the null hypothesis. We can only conclude that we have insufficient evidence to reject it. This distinction is subtle but important.

The language of hypothesis tests is a bit arcane, so it can be useful to look at a concrete analog.  In the U.S. jury system, the defendant is assumed innocent unless proven otherwise.  That is, the null hypothesis is that the defendant is innocent.  Based on trial evidence, a jury can only

+ reject the null hypothesis that the defendant is innocent (that is, find that the defendant is guilty) or
+ fail to reject the null hypothesis that the defendant is innocent (that is, the defendant is acquitted).

The jury cannot conclude that the defendant is innocent (that is, that the null hypothesis is true), only that there is insufficient evidence to demonstrate that the defendant is guilty.

Formulating the null and alternative hypotheses is a challenging part of hypothesis testing. One begins by identifying an assertion about a population parameter and then translating the assertion into symbols. We give some examples of this process below.

**Problem:** Suppose that an airline company claims that the average weight of checked baggage is less than 15 pounds. To support the claim, the airline company conducts a random sample of 150 passengers and finds that the average weight of checked baggage is 14.2 pounds, with a standard deviation of 6.5 pounds. Do these data indicate that the average weight of checked baggage is less than 15 pounds? State the null and alternative hypotheses for this problem. Note that $\mu$ is the symbol for the population mean.

**Solution:** The first sentence contains an assertion about the population parameter: “the average weight of checked baggage is less than 15 pounds.” Because this is the assertion we wish to support with evidence, we write the alternative hypothesis ($H_{a}$) as $\mu < 15$ . This then implies that our null ($H_{o}$) is $\mu = 15$. 

**Problem:** Consumer Reports wants to compare the average lifetime for two brands of incandescent light bulbs. Specifically, it would like to test whether there is a difference between the average lifetime of bulbs made by each of the two companies. State the null and alternative hypotheses for this problem.

**Solution:** In symbols, let $\mu_{1}$ represent the average lifetime of bulbs of Company 1 and $\mu_{2}$ represent the average lifetime of bulbs of Company 2. Consumer Reports wonders whether there is evidence to suggest that the mean lifetime is different for the two companies, so the alternative hypothesis ($H_{a}$) would be that $\mu_{1} \ne \mu_{2}$. Our null ($H_{o}$) is then $\mu_{1} = \mu_{2}$. 

## The P-Value

The question remains of how to decide, based on our sample data, whether to reject or fail to reject the null hypothesis. This is done using probability theory by calculating what is called a **probability value**, or **p-value** for short. The p-value is always between 0 and 1 and indicates how consistent our observed  sample is with the given null hypothesis.  The higher the p-value, the more consistent our sample is with $H_{o}$; the lower the p-value, the more consistent our sample is with $H_{a}$. (Technically, the p-value tells us, if the null hypothesis is true, what the likelihood is that we would obtain a sample that is “as extreme” as the sample we gathered. Thus, a high p-value indicates that it is quite likely we would obtain a sample as extreme as ours if the null hypothesis is true, a low p-value indicates that it is unlikely we would obtain a sample like ours if the null hypothesis is true.)

We designate a threshold value for a p-value called a **significance level**, typically denoted **$\alpha$**. The convention is to set $\alpha$ = 0.05, but more generally, the choice of $\alpha$ depends upon the problem context (*e.g.*, a test comparing a new drug to an existing drug might  use a very small $\alpha$, whereas a test of a minor change might use a larger $\alpha$).

Calculating the p-value is an involved mathematical exercise; for our purposes, we will simply read it from the R output. We formally use the p-value to interpret the test results as follows:

+ If p-value $\le \alpha$ we reject the null hypothesis and say our result is statistically significant.
+ If p-value $> \alpha$ we fail to reject the null hypothesis and say our result is not statistically significant.

In what sense are we using the word *significant*? Webster’s Dictionary gives two interpretations of significance: “(1) having or signifying meaning; or (2) important or momentous.” In statistical work, significance does not necessarily imply momentous importance. For us, “significant” at the $\alpha$ level has a special meaning. It is the likelihood (or “risk”) that we reject the null hypothesis when it is in fact true.

### Some P-Value Cautions

The American Statistical Association issued an advisory article in 2019 urging caution in how p-values are used [@PVal-cautions]. In fact, many users of statistics interpret p-values incorrectly. The p-value is not the probability that the null hypothesis is true. That would actually be a very useful value to have, but unfortunately we usually don't have the ability to find it. 

The p-value is a conditional probability that says “assuming the null hypothesis is true, how likely is it that we would draw a sample as unusual (*i.e.*, "extreme") as ours?” It does not say, “given our data, what's the chance our null hypothesis is true”, which is a source of confusion for many people. The safest way to think about a p-value is as a measure of consistency. Given my observed sample data, is it consistent with my null hypothesis view of the world? If not, then I will reject that null view of the world and conclude that the alternative view is likely the correct one.

```{warning}
The p-value is not the probability that the null hypothesis is true.
```

## Type I and Type II Errors

The point of a hypothesis test is to make the correct decision about $H_o$. Unfortunately, hypothesis testing is not a simple matter of being right or wrong. A test of hypothesis is based on sample data and probability, so there is always a chance that an error has been made. In fact, there are two primary errors one can make:

+ A **Type I error** is made if we reject $H_o$ when in fact $H_o$ is true.

+ A **Type II error** is made if we fail to reject $H_o$ when in fact $H_a$ is true.

The hypothesis test is calibrated so that the probability of making a Type I error equals $\alpha$. If we choose a significance level ($\alpha$) of 0.05, this means there is a 5% chance that our hypothesis test will mistakenly reject $H_o$, given that $H_o$ is actually true. 

The probability of making a Type II error is denoted $\beta$. For a fixed sample size, the probability of making a Type I error ($\alpha$) and the probability of making a Type II error ($\beta$) are inversely related; as $\alpha$ is increased, $\beta$ is decreased, and vice versa. Therefore, $\alpha$ cannot be arbitrarily small, since $\beta$ likely will then become large.

As we can see, the process of hypothesis testing allows you to control the risk of a Type I error
because you set the value for $\alpha$. However, (ordinarily) you do not have the same control over $\beta$, or the probability of failing to reject a null hypothesis that is actually false. For this reason, it is best to avoid making Type II errors. Therefore, rather than “accepting” $H_o$ when the sample data fail to provide sufficient evidence to overturn $H_o$, we instead say we “fail to reject” $H_o$.

## Choosing the Appropriate Test

The process we have described so far is common to all forms of hypothesis testing. We always start by defining null and alternative hypotheses, then calculate a p-value from those hypotheses using sample data. However, the statistical test we use to calculate the p-value depends on the type of data we are working with. In R, the appropriate command depends on:

+ Whether you are conducting a one-sample, two-sample, or more-than-two-sample test
+ Whether you are comparing means or proportions

The remaining sections demonstrate how to conduct the appropriate test in R for each one of these scenarios. 