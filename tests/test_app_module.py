import pytest

from app.app_module import AppModule


@pytest.mark.parametrize('test_data', [
    ({"name": "test", "action": "jump"}),
    ({"name": "test2", "action": "jump2"}),
])
def test_app_module(test_data):
    test_obj = AppModule(**test_data)
    assert test_obj.get_name() == test_data.get("name")