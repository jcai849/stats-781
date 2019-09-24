for filename in $(ls ~/inzightta/R); do
    ln -s ~/inzightta/R/$filename ~/stats-781/dissertation/R/$filename
done
ln -s ~/inzightta-shiny/app.R ~/stats-781/dissertation/R/app.R
