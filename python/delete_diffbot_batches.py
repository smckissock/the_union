from requests import get, post


def delete_batch(batch_name):
    params = {'token': '3cf697d4387a105d959518bd5b682679', 'name': batch_name, 'delete': 1}
    get('https://api.diffbot.com/v3/bulk', params=params)