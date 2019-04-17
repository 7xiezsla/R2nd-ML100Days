require(dplyr)

# 想像一個 dataframe 有兩個欄位，一個是國家，一個是人口，求人口數最多的國家

# 宣告欄位值
col_country <- c('台灣','中國','日本','韓國')
col_population <- sample.int(10000000,size = length(col_country))

# 產生dataframe
df <- data.frame('國家' = col_country,
                 '人口' = col_population,
                 stringsAsFactors = F)

# 檢視資料
df %>% head(5)

# 排序
df <- df %>% arrange(desc(人口))

sprintf('人口數最多的國家為 : %s',df$國家[1]) %>% print
sprintf('          人口數為 : %d 人',df$人口[1]) %>% print


# 讀取txt檔
require(httr)

url <- 'https://raw.githubusercontent.com/vashineyu/slides_and_others/master/tutorial/examples/imagenet_urls_examples.txt'

doc <- url %>% GET %>% content

# \n換行 \t分欄位
row_list <- doc %>% strsplit(.,'\n') %>% unlist
row_list <- row_list %>% lapply(.,function(t) {
  temp <- t %>% strsplit(.,'\t') %>% unlist
  output <- data.frame('編號' = temp[1],
                       '連結' = temp[2],
                       stringsAsFactors = F)
  return(output)
})

# 產生dataframe
df <- row_list %>% bind_rows

# 讀取圖片，請讀取上面 data frame 中的前 5 張圖片
require(jpeg)

img_link_list <- df$連結 %>% head(5)

img_list <- img_link_list %>% lapply(., function(img_link) {
  output <- tryCatch({
    res <- img_link %>% GET
    if(res$status_code == 200) {
      img <- res %>% content
    } else {
      img <- 'lost'
    }
    return(img)
  },error = function(e) {
    return('error')
  },waring = function(w) {
    return('warning')
  })
  return(output)
})

img_link_list[1] %>% readJPEG

img_link_list[5] %>% GET %>% content


