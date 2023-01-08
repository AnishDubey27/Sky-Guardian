FROM python:3.9
RUN mkdir /weather_detector
WORKDIR /weather_detector
ADD . /weather_detector/
RUN pip install -r requirements.txt
EXPOSE 8000
CMD python manage.py runserver 0.8000

