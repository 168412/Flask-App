FROM python:3.8-slim-buster
WORKDIR /myapp1 
RUN pip install --upgrade pip
COPY . /myapp1/
RUN pip install -r requirements.txt
CMD ["python", "/myapp1/main.py"] 