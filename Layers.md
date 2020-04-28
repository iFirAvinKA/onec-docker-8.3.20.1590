# Примеры сборки и наслаивания

Ниже список последовательно собираемых образов для различных целей. Все слои, кроме client и client-vnc "наслаиваются" друг на друга через переопределение аргументов сборки BASE_IMAGE и BASE_TAG.

## Запуск 1С

* client
* client-vnc

## 1С и OneScript

* client
* client-vnc
* oscript

## 1С + OneScript для запуска VA

* client
* client-vnc
* oscript
* test-agent

## 1C как Jenkins агент

* client
* client-vnc
* jdk
* jenkins-agent

## 1С + OneScript как Jenkins агент

* client
* client-vnc
* oscript
* jdk
* jenkins-agent

## 1С + OneScript как Jenkins агент для запуска тестов

* client
* client-vnc
* oscript
* jdk
* test-utils
* jenkins-agent

## EDT

* edt

## EDT как Jenkins агент

* edt
* jenkins-agent

## OneScript как Jenkins агент

* oscript поверх library/adoptopenjdk:14-hotspot
* jenkins-agent

## Сервер хранилища + Apache

* crs
* crs-apache
