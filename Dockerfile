# Utilizamos una imagen base de Node.js basada en Debian Bullseye
FROM node:18-bullseye

# Instalamos OpenJDK 17
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Instalamos herramientas adicionales necesarias
RUN apt-get install -y unzip

# Descargamos commandlinetools
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip -O commandlinetools.zip

# Descomprimimos y movemos a una carpeta
RUN mkdir -p /usr/local/android-sdk/cmdline-tools
RUN unzip commandlinetools.zip -d /usr/local/android-sdk/cmdline-tools
RUN mv /usr/local/android-sdk/cmdline-tools/cmdline-tools /usr/local/android-sdk/cmdline-tools/latest
RUN rm commandlinetools.zip

# Establecemos variables de entorno para Android SDK
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/cmdline-tools/latest/bin

# Instalamos las herramientas necesarias del SDK
RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

# Instalar adb
RUN apt-get update && apt-get install -y android-tools-adb

# Configuramos un directorio de trabajo
WORKDIR /app

# Mantener el contenedor en ejecución
CMD ["tail", "-f", "/dev/null"]
