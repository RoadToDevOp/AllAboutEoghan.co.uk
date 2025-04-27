import azure.functions as func
import logging
from azure.cosmos import CosmosClient
import os

app = func.FunctionApp()

@app.function_name(name="GetVisitorCount")
@app.route(route="visitor-count", methods=["GET"])
def get_visitor_count(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        # Initialize Cosmos DB client
        endpoint = os.environ["COSMOS_ENDPOINT"]
        key = os.environ["COSMOS_KEY"]
        client = CosmosClient(endpoint, key)
        database = client.get_database_client(os.environ["COSMOS_DATABASE"])
        container = database.get_container_client(os.environ["COSMOS_CONTAINER"])

        # Get the counter document
        counter_doc = container.read_item(item="visitor_counter", partition_key="visitor_counter")
        count = counter_doc.get('count', 0)

        # Increment the counter
        counter_doc['count'] = count + 1
        container.replace_item(item="visitor_counter", body=counter_doc)

        return func.HttpResponse(
            body=f'{{"count": {counter_doc["count"]}}}',
            mimetype="application/json",
            status_code=200
        )

    except Exception as e:
        logging.error(f"Error: {str(e)}")
        return func.HttpResponse(
            body=f'{{"error": "Internal server error"}}',
            mimetype="application/json",
            status_code=500
        ) 