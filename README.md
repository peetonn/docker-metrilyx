# Quick start

1. Start OpenTSDB [docker container](https://github.com/peetonn/docker-opentsdb) first

2. Use Dockerfile provided to start Metrilyx:
<pre>
    $ docker run \
        -d --name metrilyx \
        -e ACCESS_ADDRESS="&lt;vm-machine-ip&gt;:&lt;host-port&gt;" \
        -p &lt;host-port&gt;:80 \
        --link opentsdb:OPENTSDB \
        peetonn/docker-metrilyx:latest
</pre>

    > `<vm-machine-ip>` can be found by running `docker-machine ip <vm-machine-name>`. For the default VM machine: `docker-machine ip default`
    
    > `<host-port>` can be arbitrary (usually 8080)

3. Go to `<vm-machine-ip>:<host-port>` in your browser
