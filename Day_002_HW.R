require(dplyr)

# 設定 data_path
dir_data <- './D2_data/'

fileName <- paste0(dir_data,'application_train.csv')

sprintf('Path of read in data: %s',fileName) %>% print

# 讀檔
app_train <- read.csv(fileName) # 較慢

require(data.table)
app_train <- fread(fileName,nThread = 4) # 較快

# 資料的 row 數以及 column 數
sprintf('   row數 : %d',nrow(app_train)) %>% print
sprintf('column數 : %d',length(app_train)) %>% print

# 列出所有欄位
app_train %>% names

# 擷取部分資料
app_train %>% head(5)

# 其他操作
app_train %>% summary
