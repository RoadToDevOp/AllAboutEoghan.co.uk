import unittest
from unittest.mock import patch, MagicMock
import azure.functions as func
from function_app import get_visitor_count

class TestFunctionApp(unittest.TestCase):
    @patch('function_app.CosmosClient')
    def test_get_visitor_count(self, mock_cosmos_client):
        # Mock the Cosmos DB client and its methods
        mock_container = MagicMock()
        mock_database = MagicMock()
        mock_client = MagicMock()

        mock_client.get_database_client.return_value = mock_database
        mock_database.get_container_client.return_value = mock_container
        mock_cosmos_client.return_value = mock_client

        # Mock the counter document
        mock_container.read_item.return_value = {'count': 5}
        mock_container.replace_item.return_value = {'count': 6}

        # Create a mock HTTP request
        req = func.HttpRequest(
            method='GET',
            body=None,
            url='/api/visitor-count',
            params={}
        )

        # Call the function
        response = get_visitor_count(req)

        # Assert the response
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.get_body().decode(), '{"count": 6}')

        # Verify the Cosmos DB interactions
        mock_container.read_item.assert_called_once_with(
            item="visitor_counter",
            partition_key="visitor_counter"
        )
        mock_container.replace_item.assert_called_once()

if __name__ == '__main__':
    unittest.main() 