#!/bin/bash

HOST=127.0.0.1:8091
OUTPUT="-o /dev/null"
VERBOSE=
for i in "$@"
do
case $i in
    -h=*|--host=*)
    HOST="${i#*=}"

    ;;
    -v=*|--verbose=*)
    OUTPUT=
    VERBOSE=-v
    ;;
    *)
            # unknown option
    ;;
esac
done

# Set storage index type
curl $VERBOSE -s $OUTPUT -X POST http://$HOST/settings/indexes -d "storageMode=forestdb"
if [ $? -ne 0 ]; then
echo "Index configuration failed"
exit 1
fi

# Setup services
curl $VERBOSE -s $OUTPUT -X POST http://$HOST/node/controller/setupServices -d "services=kv,index,n1ql,fts"
if [ $? -ne 0 ]; then
echo "Setting up services failed"
exit 1
fi

# Setup login credentials
curl $VERBOSE -s $OUTPUT -X POST http://$HOST/settings/web -d "username=Administrator" -d "password=password" -d "port=SAME"
if [ $? -ne 0 ]; then
echo "Setting up username and password failed"
exit 1
fi

# Setup sample buckets
curl $VERBOSE -s $OUTPUT -X POST -u Administrator:password http://$HOST/sampleBuckets/install -d "[\"beer-sample\",\"travel-sample\"]"
if [ $? -ne 0 ]; then
echo "Creating sample buckets failed"
exit 1
fi

echo "Cluster initialized successfully!"
echo
echo "Your login credentials are below:"
echo "Username: Admininstrator"
echo "Password: password"
echo
echo "Make sure to wait for sample data to load before proceeding with tutorial."