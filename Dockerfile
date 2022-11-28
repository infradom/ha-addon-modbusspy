ARG BUILD_FROM
FROM $BUILD_FROM

RUN \
  apk add --no-cache \
    python3 \
    py3-pip


EXPOSE 5020

# Copy data for add-on
COPY ./requirements.txt /app/requirements.txt
COPY ./ha-addon-modbusspy.py  /app/ha-addon-modbusspy.py

WORKDIR /app
RUN pip install -r requirements.txt

#RUN adduser modbusspy 
#RUN mkdir -p /home/modbusspy/.ssh
#COPY idkey.pub /home/modbusspy/.ssh/authorized_keys
#RUN chown modbusspy:modbusspy /home/modbusspy/.ssh/authorized_keys && chmod 600 /home/modbusspy/.ssh/authorized_keys
##RUN service ssh start
#EXPOSE 22
#CMD ["/usr/sbin/sshd","-D"]

CMD python3 ha-addon-modbusspy.py