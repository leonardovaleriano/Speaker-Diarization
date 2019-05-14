FROM trhongbinwang/anaconda3-tf-keras
MAINTAINER "Leonardo Valeriano"

# Set the working directory to /app
WORKDIR /app
# Copy the current directory contents into the container at /app
ADD . /app

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > \
	/etc/apt/sources.list

RUN apt-get update && apt-get install -y libgtk2.0-dev && \
	apt-get install python-pyaudio python3-pyaudio -y && \
    conda install jupyter -y && \
    conda install numpy pandas scikit-learn matplotlib seaborn pyyaml h5py -y && \
    conda install -c conda-forge librosa && \
	conda install pytorch torchvision

# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip
RUN cat requirements.txt | xargs -n 1 pip3 install


# Jupyter and Tensorboard ports
EXPOSE 8888 6006