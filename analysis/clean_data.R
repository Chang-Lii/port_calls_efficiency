library(readr)

port <- read_csv("data/US.PortCalls_20251117_203727.csv")

View(port)

head(port)

summary(port)

colSums(is.na(port))

sum(duplicated(port))

# 找出“整列都是 NA” 的列
all_na_cols <- sapply(port, function(x) all(is.na(x)))
all_na_cols

# 删掉这些列
df1 <- port[, !all_na_cols]

dim(df1)

# 找出名字里包含 MissingValue 或 Footnote 的列
meta_cols <- grep("MissingValue|Footnote", names(df1), value = TRUE)

meta_cols   # 你可以先看一下都有哪些

# 删掉这些标注列
df2 <- df1[, !(names(df1) %in% meta_cols)]

dim(df2)

# 删除 TEU 相关列
teu_cols <- grep("TEU", names(df2), value = TRUE)

# 删除 DWT 相关列
dwt_cols <- grep("dwt", names(df2), value = TRUE, ignore.case = TRUE)

df3 <- df2[, !(names(df2) %in% c(teu_cols, dwt_cols))]

colSums(is.na(df3))

df4 <- df3[!is.na(df3$Median_time_in_port_days_Value), ]

dim(df4)

colSums(is.na(df4))

df5 <-df4[df4$Economy_Label != "World", ]

unique(df5$Economy_Label)

df6 <- df5[df5$CommercialMarket_Label != "All ships", ]

unique(df6$CommercialMarket_Label)


write_csv(df6, "data/cleaned_data.csv")
