# install.packages("ggplot2")
# install.packages("GGally")
library(ggplot2)

(library(magrittr))

lt <- 1:10
print(lt)

lt %<>% log2() %>%
    sin() %>%
    sum() %>%
    sqrt()

print(lt)

data(iris)
print(head(iris))

agr_iris <- iris %>%
    aggregate(. ~ Species, ., mean) %>%
    print()



plot1 <- ggplot(data = iris, aes(x = Petal.Width)) +
    geom_histogram(aes(fill = Species, color = Species), bins = 18) +
    geom_vline(data = agr_iris, aes(xintercept = Petal.Width, color = Species), linetype = "dashed")
ggsave("plot1.jpg", plot = plot1)

library("GGally")
plot2 <- ggpairs(data = iris, aes(color = Species))
ggsave("plot2.jpg", plot = plot2)




library(cluster)
x <- iris[, 1:4]
y <- iris[, 5]

sum_sqr <- c()

for (i in 1:10) {
    kmeans_res <- kmeans(x, i)
    sum_sqr <- append(sum_sqr, kmeans_res$tot.withinss)
}

plot3 <- ggplot(data.frame(iteration = 1:length(sum_sqr), value = sum_sqr), aes(x = iteration, y = sum_sqr)) +
    geom_line()
ggsave("plot3.jpg", plot = plot3)

kmeans_res <- kmeans(x, 3)
plot4 <- ggplot(iris, aes(x = Petal.Width, y = Petal.Width, color = kmeans_res$cluster)) +
    geom_point()
ggsave("plot4.jpg", plot = plot4)
