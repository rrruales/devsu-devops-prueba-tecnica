FROM python:3.11.3-alpine3.18

RUN addgroup -g 1000 tmpusrgp
RUN adduser -u 1000 -G tmpusrgp -h /home/tmpusr -D tmpusr
USER tmpusr
RUN mkdir -p /home/tmpusr/app
WORKDIR /home/tmpusr/app

COPY --chown=tmpusr:tmpusrgp requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY --chown=tmpusr:tmpusrgp . .

RUN python manage.py makemigrations
RUN python manage.py migrate
EXPOSE 8000
ENTRYPOINT [ "python" ]
CMD [ "manage.py", "runserver", "0.0.0.0:8000" ]