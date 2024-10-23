# Waterdata
Het [Spoorpark Tilburg](https://spoorparktilburg.nl) heeft elektronische grondwaterpeilmeters.

Deze software leest [deze grondwaterpeil data](resource/archive/grondwaterdata/grondwaterpeildata.csv) uit en combineert die met de neerslaggevens van het KNMI tot [een grafiek](https://slspeek.github.io/waterdata/).

Voor meer informatie over dit project kunt u zich wenden tot [Lucy Bathgate](mailto:lucy.bathgate@gmail.com).

## Techniek

De software maakt gebruik van twee docker images
1. [plotly R image](https://github.com/slspeek/r-plotly-docker)
1. [lintr image](https://github.com/slspeek/lintr-docker)