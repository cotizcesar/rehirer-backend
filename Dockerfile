FROM python:3.11 as base

ARG POETRY_VERSION=1.3.2

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1
ENV POETRY_VIRTUALENVS_CREATE false

RUN pip install --upgrade pip

# Install: Poetry Installation
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"
RUN poetry self add poetry-plugin-export
RUN poetry --version

WORKDIR /app

# Install: Poetry dependencies
COPY poetry.lock pyproject.toml ./

COPY . ./

CMD ["bash"]

# Run: Image
FROM base as production

EXPOSE 8000

ENV DEBUG=1

RUN poetry install --no-root

COPY . ./

CMD uvicorn rehirer_backend.main:app --host 0.0.0.0 --port 8000
