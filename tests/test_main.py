from app.main import app

def test_home():
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200
    assert b"Hello" in response.data

def test_ping():
    client = app.test_client()
    response = client.get("/ping")
    assert response.status_code == 200
    assert b"pong" in response.data
