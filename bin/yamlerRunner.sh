BASEDIR=$(dirname $0)
UNITYPATH=$BASEDIR/..

# initial conversion from separate schemas
BEACONMODELPATH=$BASEDIR/../../beacon-v2-Models/BEACON-V2-Model
BEACONFRAMEWORKPATH=$BASEDIR/../../beacon-framework-v2
# BEACONDOCPATH=$BASEDIR/../../beacon-v2-schema-documentation

BEACONMODELNAME=beacon-v2-default-model

git -C $BEACONMODELPATH pull
git -C $BEACONFRAMEWORKPATH pull
git -C $BEACONDOCPATH pull

# Documentation is now directly maintained in this repository; no need to update
# rsync -av $BEACONDOCPATH/docs/ $UNITYPATH/docs/
# rsync -av $BEACONDOCPATH/schemas/ $UNITYPATH/schemas/
# rsync -av $BEACONDOCPATH/bin/ $UNITYPATH/bin/

for KIND in src json
do
	mkdir -p $UNITYPATH/models/$KIND/$BEACONMODELNAME
	mkdir -p $UNITYPATH/framework/$KIND	
done

$BASEDIR/beaconYamler.py -i $BEACONMODELPATH -t json -x yaml -o $UNITYPATH/models/src/$BEACONMODELNAME
$BASEDIR/beaconYamler.py -i $BEACONFRAMEWORKPATH -t json -x yaml -o $UNITYPATH/framework/src

# recurring conversion from the source files to the exported versions
$BASEDIR/beaconYamler.py -i $UNITYPATH/models/src/$BEACONMODELNAME -t yaml -x json -o $UNITYPATH/models/json/$BEACONMODELNAME
$BASEDIR/beaconYamler.py -i $UNITYPATH/framework/src -t yaml -x json -o $UNITYPATH/framework/json
