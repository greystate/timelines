# Put key here
APIKEY=<MUST-ADD-YOUR-API-KEY-HERE>

PROJECT_DIR=`pwd`
APIBASE="https://api.w3.org"
APIOUTDIR="$PROJECT_DIR/api-outputs"

# Create the output directory if necessary
if [[ ! -e "$APIOUTDIR" ]]; then
	mkdir "$APIOUTDIR"
fi

echo "Task: Get specifications from API"
# Create a list of `curl` commands
xsltproc -o $APIOUTDIR/curler.sh --stringparam directory "$APIOUTDIR/" --stringparam api-key "$APIKEY" "build-curler.xslt" specifications.xml

# Run the commands to fetch the data
sh $APIOUTDIR/curler.sh

echo "Task: Transform specifications into HTML timeline"
xsltproc -o timelines.html transform-spec.xslt specifications.xml

echo "Timeline created in $PROJECT_DIR/timelines.html"