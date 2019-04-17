require(dplyr)
require(ggplot2)

# [函式]平均平方方誤差 (y,y_hat) -> MSE
MSE <- function(y,y_hat) {
  y_error <- y - y_hat
  y_error_squared <- y_error^2
  mse <- sum(y_error_squared)/length(y_error_squared)
  return(mse)
}

# [函式]平均絕對誤差 (y,y_hat) -> MAE
MAE <- function(y,y_hat) {
  y_error <- y - y_hat
  y_error_absolute <- y_error %>% abs
  mae <- sum(y_error_absolute)/length(y_error_absolute)
  return(mae)
}

w <- 3
b <- 0.5

x_lin <- 0:100

y <- (x_lin + rnorm(length(x_lin)) * 5) *w + b

# 建立繪圖資料
pltdf <- data.frame(x_lin,y,legend = array('data',length(x_lin)),stringsAsFactors = F) 

# 建立畫布
plt <- ggplot(data = pltdf)

# 加圖名
plt <- plt + ggtitle('Assume we have data points')

# 加軸線
plt <- plt + aes(x_lin,y)

# 加點和標籤
plt <- plt + 
  geom_point(
    aes(
      x = x_lin,
        y = y,
        color = legend
      )
    )

# 文字置中
plt$theme$plot.title <- element_text(hjust = 0.5,size = 20)

# 繪制
plt

y_hat <- x_lin * w + b

# 複製前圖
plt2 <- plt

# 換圖名
plt2$labels$title <- 'Assume we have data points (And the prediction)'

# 畫線
plt2 <- plt2 + 
  geom_line(
    aes(
      x = x_lin,
      y = y_hat,
      color = 'prediction'
    )
    ,size = 1
  )

# 繪製
plt2