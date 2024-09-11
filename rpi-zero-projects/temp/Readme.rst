Temperature Monitor
===================

Displays the temperature in a desired room and exposes a Prometheus endpoint to
graph the data using Grafana.

Tools
-----

1. Raspberry pi zero w
2. `DHT22`_ temperature/humidity sensor
3. Python 3.8.1
4. Flask
5. python3-libgpiod (or the one used in your distro)

Roadmap
-------

1. Display current temperature and humidity on CLI
2. Display current temperature and humidity using Flask
3. Use `prometheus_client`_ to expose metrics

.. _DHT22: https://www.amazon.com/dp/B0795F19W6/ref=cm_sw_r_tw_dp_x_juLEFbP2VH07E
.. _prometheus_client: https://github.com/prometheus/client_python
