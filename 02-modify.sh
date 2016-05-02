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

# Update document with key name airline_10
curl $VERBOSE -s $OUTPUT -X POST http://$HOST/pools/default/buckets/travel-sample/docs/airline_10.json -d "{\"id\":10,\"type\":\"airline\",\"name\":\"40-Mile Air\",\"iata\":\"Q5\",\"icao\":\"MLA\",\"callsign\":\"MILE-AIR\",\"country\":\"United States\",\"update\":\"added field\"}"
if [ $? -ne 0 ]; then
echo "Failed to update airline_10"
exit 1
fi

# Update document with key name airline_10123
curl $VERBOSE -s $OUTPUT -X POST http://$HOST/pools/default/buckets/travel-sample/docs/airline_10123.json -d "{\"id\":10123,\"type\":\"airline\",\"name\":\"Texas Wings\",\"iata\":\"TQ\",\"icao\":\"TXW\",\"callsign\":\"TXW\",\"country\":\"United States\",\"update\":\"added field\"}" 
if [ $? -ne 0 ]; then
echo "Failed to update airline_10123"
exit 1
fi

# Create new document with key name new_doc_1
curl $VERBOSE -s $OUTPUT -X POST http://$HOST/pools/default/buckets/travel-sample/docs/new_doc_1 -d "{\"id\":100000,\"type\":\"airline\",\"name\":\"Texas Wings\",\"iata\":\"TQ\",\"icao\":\"TXW\",\"callsign\":\"TXW\",\"country\":\"United States\"}"
if [ $? -ne 0 ]; then
echo "Failed to create new_doc_1"
exit 1
fi

# Create new document with key name new_doc_2                                                                   
curl $VERBOSE -s $OUTPUT -X POST http://$HOST/pools/default/buckets/travel-sample/docs/new_doc_2 -d "{\"id\":100001,\"type\":\"airline\",\"name\":\"Texas Wings\",\"iata\":\"TQ\",\"icao\":\"TXW\",\"callsign\":\"TXW\",\"country\":\"United States\"}"
if [ $? -ne 0 ]; then
echo "Failed to create new_doc_2"
exit 1
fi

echo "Updated two documents and created two documents"
