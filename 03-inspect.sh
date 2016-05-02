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
    -v*|--verbose*)
    OUTPUT=
    VERBOSE=-v
    ;;
    *)
    # Unknown flag
    ;;
esac
done

# Get document with key name airline_10
echo Get airline_10
curl $VERBOSE -s -X GET http://$HOST/pools/default/buckets/travel-sample/docs/airline_10.json | python -m json.tool
if [ $? -ne 0 ]; then
echo "Failed to get airline_10"
exit 1
fi

# Get document with key name airline_10123
echo "Get airline_10123"
curl $VERBOSE -s -X GET http://$HOST/pools/default/buckets/travel-sample/docs/airline_10123.json | python -m json.tool
if [ $? -ne 0 ]; then
echo "Failed to update airline_10123"
exit 1
fi

# Create new document with key name new_doc_1
echo Get new_doc_1
curl $VERBOSE -s -X GET http://$HOST/pools/default/buckets/travel-sample/docs/new_doc_1 | python -m json.tool
if [ $? -ne 0 ]; then
echo "Failed to create new_doc_1"
exit 1
fi

# Create new document with key name new_doc_2                                                                   
echo Get new_doc_2
curl $VERBOSE -s -X GET http://$HOST/pools/default/buckets/travel-sample/docs/new_doc_2 | python -m json.tool
if [ $? -ne 0 ]; then
echo "Failed to create new_doc_2"
exit 1
fi

echo "Updated two documents and created two documents"
