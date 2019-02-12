# Setup

As user ```debian```:

```
sudo apt update
sudo apt install -y ti-opencl libboost-dev libopencv-core-dev libopencv-imgproc-dev libopencv-highgui-dev libjson-c-dev gedit wmctrl eog

cd
git clone https://github.com/jadonk/tidl-api
cd tidl-api/
git checkout origin/v01.02.02-bb.org -b v01.02.02-bb.org
make -j2 build-api

sudo mkdir -p /usr/share/ti/tidl
sudo chown -R 1000:1000 /usr/share/ti/tidl/

make -j2 build-examples

cd /usr/share/ti/tidl
ln -s /home/debian/tidl-api/examples

sudo cp /home/debian/tidl-api/examples/classification/tidl-demo.* /etc/systemd/systemd
sudo systemctl enable tidl-demo.timer
sudo systemctl enable tidl-demo.service

sudo shutdown -r now
```

#Various use cases:
#
# 1. Live camera input, using 2xEVE and 2xDSP cores, based on model with single layers group 
./tidl_classification -g 1 -d 2 -e 2 -l ./imagenet.txt -s ./classlist.txt -i 1 -c ./stream_config_j11_v2.txt
# 2. Use video clip as input stream, using 2xEVE and 2xDSP cores, based on model with single layers group 
./tidl_classification -g 1 -d 2 -e 2 -l ./imagenet.txt -s ./classlist.txt -i ./clips/test50.mp4 -c ./stream_config_j11_v2.txt
# 3. Use video clip as input stream, using 2xEVE and 1xDSP cores, based on model with two layers group (1st layers group running on EVE, 2nd layers group on DSP)
./tidl_classification -g 2 -d 1 -e 2 -l ./imagenet.txt -s ./classlist.txt -i ./clips/test50.mp4 -c ./stream_config_j11_v2.txt
# 4. Use video clip as input stream, using no EVEs and 2xDSP cores, based on model with single layers group
./tidl_classification -g 1 -d 2 -e 0 -l ./imagenet.txt -s ./classlist.txt -i ./clips/test50.mp4 -c ./stream_config_j11_v2.txt


