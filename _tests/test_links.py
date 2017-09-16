#!/usr/bin/env python
# -*- encoding: utf-8

import pytest
import requests


@pytest.mark.parametrize('path', [
    # Check pagination is working correctly
    '/page/2/', '/page/3/',
])
def test_pages_appear_correctly(path):
    resp = requests.get(f'http://localhost:5757/{path}')
    assert resp.status_code == 200


@pytest.mark.parametrize('path, text_in_page', [
    ('2017/', 'Posts from 2017'),
    ('2017/07/', 'Posts from July 2017'),
    ('', 'Older posts'),
    ('', '<title>alexwlchan</title>'),
    ('archive/', '<h3>2017</h3>'),
])
def test_text_appears_in_pages(path, text_in_page):
    resp = requests.get(f'http://localhost:5757/{path}')
    assert resp.status_code == 200
    assert text_in_page in resp.text


@pytest.mark.parametrize('path, text', [
    # Year markers only appear in the global archives, not year or month pages
    ('2017/', '<h3>2017</h3>'),
    ('2017/07/', '<h3>2017</h3>'),
])
def test_text_does_not_appear_in_pages(path, text):
    resp = requests.get(f'http://localhost:5757/{path}')
    assert resp.status_code == 200
    assert text not in resp.text