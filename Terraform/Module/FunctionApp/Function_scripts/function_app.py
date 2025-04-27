import azure.functions as func
import logging
from azure.cosmos import CosmosClient, exceptions
import os
import json

app = func.FunctionApp()

@app.function_name(name="GetVisitorCount")
@app.route(route="visitor-count", methods=["GET"])
def get_visitor_count(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        # Initialize Cosmos DB client
        connection_string = os.environ["COSMOS_DB_CONNECTION_STRING"]
        client = CosmosClient.from_connection_string(connection_string)
        
        database = client.get_database_client(os.environ["COSMOS_DB_DATABASE_NAME"])
        container = database.get_container_client(os.environ["COSMOS_DB_CONTAINER_NAME"])

        # Attempt to get the counter document
        try:
            counter_doc = container.read_item(item="visitor_counter", partition_key="visitor_counter")
            count = counter_doc.get('count', 0)
        except exceptions.CosmosResourceNotFoundError:
            # Create the counter document if it doesn't exist
            counter_doc = {
                "id": "visitor_counter",
                "count": 0
            }
            container.create_item(body=counter_doc)

        # Increment the counter
        counter_doc['count'] = counter_doc.get('count', 0) + 1
        container.replace_item(item="visitor_counter", body=counter_doc)

        # Set CORS headers
        headers = {
            "Access-Control-Allow-Origin": "*",
            "Content-Type": "application/json"
        }

        return func.HttpResponse(
            body=json.dumps({"count": counter_doc["count"]}),
            mimetype="application/json",
            headers=headers,
            status_code=200
        )

    except exceptions.CosmosHttpResponseError as ce:
        logging.error(f"Cosmos DB Error: {str(ce)}")
        return func.HttpResponse(
            body=json.dumps({"error": "Database error", "details": str(ce)}),
            mimetype="application/json",
            status_code=500
        )
    except Exception as e:
        logging.error(f"Unexpected Error: {str(e)}")
        return func.HttpResponse(
            body=json.dumps({"error": "Internal server error"}),
            mimetype="application/json",
            status_code=500
        )