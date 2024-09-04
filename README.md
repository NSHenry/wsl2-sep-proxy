# WSL2 Symantec Endpoint Protection Proxy

This HTTP/HTTPS/FTP proxy allows WSL2 to communicate externally via a Docker image running in Windows.  
For example you can take advantage when you are using Symantec Endpoint Protection.

Pull and run the Docker Image
```
docker run -d --name wsl2-sep-proxy -p 9999:80 nshenry/wsl2-sep-proxy
```

Alter `/etc/environment` in order to make the proxy system-wide:
```
proxy_server=http://$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):9999
echo "# WSL SEP Proxy" | sudo tee -a /etc/environment
echo "# The Docker Container on Windows must be running for this to work." | sudo tee -a /etc/environment
echo "export http_proxy=${proxy_server}" | sudo tee -a /etc/environment
echo "export https_proxy=${proxy_server}" | sudo tee -a /etc/environment
```

~~ Alter your  `.bashrc` as follows. ~~ 
Note: This should no longer be necessary if using the above method.
```
proxy_server=http://$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):9999
echo "export http_proxy=${proxy_server}" >> ~/.bashrc
echo "export https_proxy=${proxy_server}" >> ~/.bashrc
```

If you use `apt`, add a proxy configuration with the following:
```
sudo touch /etc/apt/apt.conf.d/proxy.conf
echo "Acquire::http:Proxy \"${http_proxy}\";" | sudo tee -a /etc/apt/apt.conf.d/proxy.conf
echo "Acquire::https:Proxy \"${https_proxy}\";" | sudo tee -a /etc/apt/apt.conf.d/proxy.conf
```

If you use `yum`, add a proxy configuration with the following:
```
touch /etc/yum.conf
echo "proxy=${http_proxy}" >> /etc/yum.conf
```
