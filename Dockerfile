ARG MODEL_URL
ARG MODEL_NAME
FROM public.ecr.aws/lambda/python:3.11-preview

RUN yum install git unzip -y && yum clean all
RUN git clone https://github.com/workdd/recommand-title.git && pip install -r recommand-title/requirements.txt

RUN cp recommand-title/app.py ${LAMBDA_TASK_ROOT} && rm -rf recommand-title

WORKDIR ${LAMBDA_TASK_ROOT}

ARG MODEL_URL
ARG MODEL_NAME
RUN curl -O $MODEL_URL && unzip $MODEL_NAME && rm -rf $MODEL_NAME

CMD [ "app.handler" ]
