# Use the official python 3.9 image
FROM python:3.9

# Set the working directory to code
WORKDIR /code

# Copy the current directory contents to continer /code
COPY ./requirements.txt /code/requirements.txt

# Install requirements.txt
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# Set up a new user named 'User'
RUN useradd user

# Switch to user user
USER user

# Set home to user's home directory
ENV HOME=/home/user PATH=/home/user/.local/bin:$PATH

# Set the working directory to user's home directory
WORKDIR $HOME/app

# Copy the current directory contents to the container at $HOME/app setting the owner to USer's directory
COPY --chown=user . $HOME/app

# Start fastapi app on port 7860
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]
