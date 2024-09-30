library(plotly)
data <- read.csv(
  paste(
    getwd(),
    "grondwaterpeildata.csv",
    sep = "/"
  ),
  header = TRUE,
  sep = "\t"
)
data$Datum <- as.POSIXct(data$Datum, format = "%Y-%m-%d %H:%M:%S")
data$Waterstand.gecorrigeerd <-
  replace(
    data$Waterstand.gecorrigeerd,
    data$Waterstand.gecorrigeerd > 1500,
    NA
  )
data$Waterstand.gecorrigeerd <- data$Waterstand.gecorrigeerd - 1460.7

regendata <- read.csv(
  paste(
    getwd(),
    "neerslaggr.csv",
    sep = "/"
  ),
  header = TRUE
)
regendata$YYYYMMDD <- as.character(regendata$YYYYMMDD)
regendata$YYYYMMDD <- as.POSIXct(regendata$YYYYMMDD, format = "%Y%m%d")
regendata$RH <- as.numeric(regendata$RH)
regendata$RH <- replace(regendata$RH, regendata$RH == -1, 0.5)
regendata$RH <- regendata$RH / 10

fig <- plot_ly(data)

fig <- fig %>% add_lines(
  x = ~Datum,
  y = ~Waterstand.gecorrigeerd,
  name = "grondwaterstand",
  yaxis = "y1",
  line = list(color = "rgb(144, 168, 120)")
)
fig <- fig %>% add_bars(
  x = regendata$YYYYMMDD,
  y = regendata$RH,
  name = "dagneerslag",
  yaxis = "y2",
  marker = list(color = "rgb(39, 144, 176)")
)

fig <- fig %>%
  layout(
    showlegend = FALSE,
    margin = list(r = 50),
    title = "Grondwaterstand Spoorpark",
    xaxis = list(
      rangeselector =
        list(buttons = list(
          list(
            count = 1,
            label = "Dag",
            step = "day",
            stepmode = "backward"
          ),
          list(
            count = 7,
            label = "Week",
            step = "day",
            stepmode = "backward"
          ),
          list(
            count = 1,
            label = "Maand",
            step = "month",
            stepmode = "backward"
          ),
          list(
            count = 3,
            label = "3 M",
            step = "month",
            stepmode = "backward"
          ),
          list(
            count = 6,
            label = "6 M",
            step = "month",
            stepmode = "backward"
          ),
          list(
            count = 1,
            label = "Jaar",
            step = "year",
            stepmode = "backward"
          ),
          list(
            label = "Alles",
            step = "all"
          )
        )), rangeslider = list(visible = TRUE)
    ),
    yaxis = list(
      title = "grondwaterstand (cm onder maaiveld)",
      color = "rgb(144, 168, 120)",
      range = list(-400, -150)
    ),
    yaxis2 = list(
      title = "dagneerslag (cm)",
      overlaying = "y",
      side = "right",
      range = list(250, 0),
      color = "rgb(39, 144, 176)"
    )
  )
htmltools::save_html(fig,
  file = paste(getwd(),
    "website",
    "index.html",
    sep = "/"
  )
)
