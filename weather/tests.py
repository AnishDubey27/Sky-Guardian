from django.test import TestCase
import unittest
import requests

class TestWeatherAPI(unittest.TestCase):
    def test_weather_api_response(self):
        api_key = "b1c2bd95540dce6f19593055c44d3113"
        url = f"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid={api_key}"
        response = requests.get(url)
        self.assertEqual(response.status_code, 200, "API key is incorrect")
        data = response.json()
        self.assertIn('weather', data)
        self.assertIn('main', data['weather'][0])
        self.assertIn('temp', data['main'])

class TestDjango(TestCase):
    def test_is_installed(self):
        from django.conf import settings
        self.assertTrue('django' in settings.INSTALLED_APPS)
