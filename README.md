# Python tools for TWAMP and TWAMP light

This is the Python2 to Python3 conversion of [twampy](https://github.com/nokia/twampy/tree/master).
On top of that it adds support for logging the results in json and exposing them via Prometheus metrics.

Twampy is a Python implementation of the Two-Way Active Measurement
Protocol (TWAMP and TWAMP light) as defined in RFC5357. This tool
was developed to validate the Nokia SR OS TWAMP implementation.



## Usage


Start responder:

```bash
python3 twampy.py responder
```

Start sender:

```bash
python3 twampy.py sender --json --metrics
```

## Prometheus metrics

The metrics are exposed on port 8000.

```bash
curl localhost:8000/metrics
```

```text
# HELP python_gc_objects_collected_total Objects collected during gc
# TYPE python_gc_objects_collected_total counter
python_gc_objects_collected_total{generation="0"} 319.0
python_gc_objects_collected_total{generation="1"} 60.0
python_gc_objects_collected_total{generation="2"} 0.0
# HELP python_gc_objects_uncollectable_total Uncollectable objects found during GC
# TYPE python_gc_objects_uncollectable_total counter
python_gc_objects_uncollectable_total{generation="0"} 0.0
python_gc_objects_uncollectable_total{generation="1"} 0.0
python_gc_objects_uncollectable_total{generation="2"} 0.0
# HELP python_gc_collections_total Number of times this generation was collected
# TYPE python_gc_collections_total counter
python_gc_collections_total{generation="0"} 33.0
python_gc_collections_total{generation="1"} 2.0
python_gc_collections_total{generation="2"} 0.0
# HELP python_info Python platform information
# TYPE python_info gauge
python_info{implementation="CPython",major="3",minor="12",patchlevel="0",version="3.12.0"} 1.0
# HELP process_virtual_memory_bytes Virtual memory size in bytes.
# TYPE process_virtual_memory_bytes gauge
process_virtual_memory_bytes 2.66973184e+08
# HELP process_resident_memory_bytes Resident memory size in bytes.
# TYPE process_resident_memory_bytes gauge
process_resident_memory_bytes 3.2518144e+07
# HELP process_start_time_seconds Start time of the process since unix epoch in seconds.
# TYPE process_start_time_seconds gauge
process_start_time_seconds 1.70012840124e+09
# HELP process_cpu_seconds_total Total user and system CPU time spent in seconds.
# TYPE process_cpu_seconds_total counter
process_cpu_seconds_total 89.16
# HELP process_open_fds Number of open file descriptors.
# TYPE process_open_fds gauge
process_open_fds 8.0
# HELP process_max_fds Maximum number of open file descriptors.
# TYPE process_max_fds gauge
process_max_fds 1.048576e+06
# HELP twampy_result TWAMP result
# TYPE twampy_result gauge
twampy_result{twampy_result="ok"} 1.0
twampy_result{twampy_result="error"} 0.0
# HELP twampy_latency TWAMP latency in ms
# TYPE twampy_latency histogram
# HELP twampy_loss TWAMP loss in percent
# TYPE twampy_loss gauge
twampy_loss{direction="outbound"} 0.0
twampy_loss{direction="inbound"} 0.0
twampy_loss{direction="roundtrip"} 0.0
# HELP twampy_jitter TWAMP jitter in ms
# TYPE twampy_jitter histogram
twampy_jitter_bucket{direction="outbound",le="0.005"} 0.0
twampy_jitter_bucket{direction="outbound",le="0.01"} 0.0
twampy_jitter_bucket{direction="outbound",le="0.025"} 0.0
twampy_jitter_bucket{direction="outbound",le="0.05"} 0.0
twampy_jitter_bucket{direction="outbound",le="0.075"} 1.0
twampy_jitter_bucket{direction="outbound",le="0.1"} 5.0
twampy_jitter_bucket{direction="outbound",le="0.25"} 7.0
twampy_jitter_bucket{direction="outbound",le="0.5"} 15.0
twampy_jitter_bucket{direction="outbound",le="0.75"} 18.0
twampy_jitter_bucket{direction="outbound",le="1.0"} 18.0
twampy_jitter_bucket{direction="outbound",le="2.5"} 18.0
twampy_jitter_bucket{direction="outbound",le="5.0"} 18.0
twampy_jitter_bucket{direction="outbound",le="7.5"} 18.0
twampy_jitter_bucket{direction="outbound",le="10.0"} 18.0
twampy_jitter_bucket{direction="outbound",le="+Inf"} 18.0
twampy_jitter_count{direction="outbound"} 18.0
twampy_jitter_sum{direction="outbound"} 5.706886090339186
twampy_jitter_bucket{direction="inbound",le="0.005"} 0.0
twampy_jitter_bucket{direction="inbound",le="0.01"} 0.0
twampy_jitter_bucket{direction="inbound",le="0.025"} 5.0
twampy_jitter_bucket{direction="inbound",le="0.05"} 9.0
twampy_jitter_bucket{direction="inbound",le="0.075"} 15.0
twampy_jitter_bucket{direction="inbound",le="0.1"} 18.0
twampy_jitter_bucket{direction="inbound",le="0.25"} 18.0
twampy_jitter_bucket{direction="inbound",le="0.5"} 18.0
twampy_jitter_bucket{direction="inbound",le="0.75"} 18.0
twampy_jitter_bucket{direction="inbound",le="1.0"} 18.0
twampy_jitter_bucket{direction="inbound",le="2.5"} 18.0
twampy_jitter_bucket{direction="inbound",le="5.0"} 18.0
twampy_jitter_bucket{direction="inbound",le="7.5"} 18.0
twampy_jitter_bucket{direction="inbound",le="10.0"} 18.0
twampy_jitter_bucket{direction="inbound",le="+Inf"} 18.0
twampy_jitter_count{direction="inbound"} 18.0
twampy_jitter_sum{direction="inbound"} 0.8582545184015388
twampy_jitter_bucket{direction="roundtrip",le="0.005"} 0.0
twampy_jitter_bucket{direction="roundtrip",le="0.01"} 0.0
twampy_jitter_bucket{direction="roundtrip",le="0.025"} 0.0
twampy_jitter_bucket{direction="roundtrip",le="0.05"} 0.0
twampy_jitter_bucket{direction="roundtrip",le="0.075"} 1.0
twampy_jitter_bucket{direction="roundtrip",le="0.1"} 2.0
twampy_jitter_bucket{direction="roundtrip",le="0.25"} 7.0
twampy_jitter_bucket{direction="roundtrip",le="0.5"} 14.0
twampy_jitter_bucket{direction="roundtrip",le="0.75"} 17.0
twampy_jitter_bucket{direction="roundtrip",le="1.0"} 18.0
twampy_jitter_bucket{direction="roundtrip",le="2.5"} 18.0
twampy_jitter_bucket{direction="roundtrip",le="5.0"} 18.0
twampy_jitter_bucket{direction="roundtrip",le="7.5"} 18.0
twampy_jitter_bucket{direction="roundtrip",le="10.0"} 18.0
twampy_jitter_bucket{direction="roundtrip",le="+Inf"} 18.0
twampy_jitter_count{direction="roundtrip"} 18.0
twampy_jitter_sum{direction="roundtrip"} 6.46590716933948
# HELP twampy_jitter_created TWAMP jitter in ms
# TYPE twampy_jitter_created gauge
twampy_jitter_created{direction="outbound"} 1.7001284122339122e+09
twampy_jitter_created{direction="inbound"} 1.7001284122340562e+09
twampy_jitter_created{direction="roundtrip"} 1.7001284122340806e+09
````



