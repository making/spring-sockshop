# How to deploy Spring Sock Shop on Kubernetes

## Prepare CLIs

* `kubectl`
* [Carvel](https://carvel.dev/#install)
  * `ytt`
  * `kbld`
  * `kapp`

#![](http://www.plantuml.com/plantuml/png/XLCnRiCm3Dpv2Y9JD2WFo13a4va23qOif49jsPNa8IZoznfjVA2f2faitXrvHri-fzp6F0yzjRSyHhua5ud2s3dUXNJaDDu-xUnt_4tCLn_kqQLqVA7DWkrVPoFEDhhE9qDFAZhOsXDVqOzkFXnEkh_CaLnKIO2BB4jbDfKT7kchLrYP4HnIOhQOB9EAsNL5RPjRczj-lFyjj9UGqS1gygGD3ATIMPh5_792RJQLy0060wNHqzE7doOVi8l4J84e9-1m4rZDSMeVWmjOIK3Bt48zniv5Q5V0R4iP2o0oQHKHRZ6how88yNKgNCmR0iolOKCaAz1OkAdmU8Vh1AHWEq_szEzF92AzLM7-EoMILeLwXwgCBik3RSdwHb6gyUn2Dm_z3m00)


## Without Ingress

### Deploy User API

First of all, deploy User API

```
./k8s/deploy.sh user-api
```

Check `sock-user`'s External IP.

```
$ kubectl get service -n sock-user sock-user
NAME        TYPE           CLUSTER-IP      EXTERNAL-IP      PORT(S)          AGE
sock-user   LoadBalancer   100.71.166.83   192.168.11.161   8080:31794/TCP   48s
```

Check if an access token can be issued with the IP like following.

```
$ curl http://192.168.11.161:8080/oauth/token -u sock:sock -d grant_type=client_credentials 
{"access_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsic29jayJdLCJzY29wZSI6WyJvcGVuaWQiLCJjYXRhbG9nOnJlYWQiLCJjdXN0b21lcjpyZWFkIiwiY3VzdG9tZXI6d3JpdGUiLCJvcmRlcjpyZWFkIiwib3JkZXI6d3JpdGUiLCJjYXJ0OnJlYWQiLCJjYXJ0OndyaXRlIiwic2hpcHBpbmc6cmVhZCIsInNoaXBwaW5nOndyaXRlIiwicGF5bWVudDphdXRoIl0sImlzcyI6Imh0dHA6Ly8xOTIuMTY4LjExLjE2MTo4MDgwL29hdXRoL3Rva2VuIiwiZXhwIjoxNjEwNzIyOTAxLCJpYXQiOjE2MTA2MzY1MDEsImF1dGhvcml0aWVzIjpbIlJPTEVfVFJVU1RFRF9DTElFTlQiXSwianRpIjoiLTB3Y3lKRjJ0bHlCMHotalpvZ1VxZGY4WXQ4IiwiY2xpZW50X2lkIjoic29jayJ9.BqUpoSeWeztnEPISO81gWVlFQthkWKQzCk11nfEp077QUhWljZH5LG7Y4gqufowJ-aNU-WTB4PYpmuGyFydV86evjihIBNFW0Nsm3WQKxEPS93rpw1zJILEqQq7-KhTkd8ZpbthQCLs9meNGux-vOlOWwKSsyu2iajf5--1T6brgG4HxDi_Q5duPOQ6qaisiSev4FzCgUPS22KyQVFmbobfzcxCFeonmkFSGw5jdRNsjs-TgXcfpp_sGsdMu8BYSzh-OJzWLbzNYhqJi2nHtq0dd-Zsqs8ns-LWS97_qqjPl76NecUExwGz2gqjGHkTUga8RLkv3QCp5_RmaJzDtUQ","token_type":"bearer","expires_in":86399,"scope":"openid catalog:read customer:read customer:write order:read order:write cart:read cart:write shipping:read shipping:write payment:auth","id_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsic29jayJdLCJzY29wZSI6WyJvcGVuaWQiXSwiaXNzIjoiaHR0cDovLzE5Mi4xNjguMTEuMTYxOjgwODAvb2F1dGgvdG9rZW4iLCJleHAiOjE2MTA3MjI5MDEsImlhdCI6MTYxMDYzNjUwMSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9UUlVTVEVEX0NMSUVOVCJdLCJqdGkiOiItMHdjeUpGMnRseUIwei1qWm9nVXFkZjhZdDgiLCJjbGllbnRfaWQiOiJzb2NrIn0.RGeBHjNfpt8l71H_bQlk9z7LQU-jgeKR3TDSU0V24itkGZC5Eye2H5-bBsZNExJDfzjzCSV_D5LfWr879MUrfyax5vzy72PMUmceD8d7aR1UxfhSv87aZIpzvPG_sGOy-EPaQ94wra9qEk46mKg_0YNph7uaTT259KYd8gVm33VYYapoe6nhM8c8pn-eAHKPRA69ShKHUZIqCZutSb8AfDJLQkF2nIA91LFdb-B6Kygc2Foqy81bPiPJs_HIrZ3fBCWM2NA_oz_UVQapvvPWJsIUrR2tzt57YF7kzUnZVJ7FkKUenrq_8p2BZwCEoLTwDm_Dvxzh6NrExVCjZPxGKg"}
```

### Deploy Catalog API

```
./k8s/deploy.sh catalog-api
```

### Deploy Cart API

```
./k8s/deploy.sh cart-api
```

### Deploy Payment API

```
./k8s/deploy.sh payment-api
```

### Deploy Shipping API

```
./k8s/deploy.sh shipping-api
```

### Deploy Order API

```
./k8s/deploy.sh order-api
```

### Deploy Shop UI

Configure `http://<sock-user's External IP>:8080` to `YTT_sock_user_external_url`

In the case above,

```
YTT_sock_user_external_url=http://192.168.11.161:8080 \
./k8s/deploy.sh shop-ui
```

Check `sock-ui`'s External IP.

```
$ kubectl get service -n sock-ui sock-ui
NAME      TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)          AGE
sock-ui   LoadBalancer   100.65.149.233   192.168.11.162   8080:31863/TCP   43s
```

Update User API with the `sock-ui`'s External IP like following.

```
YTT_sock_ui_external_url=http://192.168.11.162:8080 \
./k8s/deploy.sh user-api
```

Go to `http://<sock-ui's External IP>:8080`

![image](https://user-images.githubusercontent.com/106908/104609969-f5115800-56c6-11eb-8cf6-663c0303271d.png)

You can log in as a demo user (username: `jdoe` / password: `demo`).

Deployed pods are below

```
$ kubectl get pod -A | grep sock
sock-cart              sock-cart-7bb74c984-6sqkg                           1/1     Running   1          17m
sock-cart              sock-cart-7bb74c984-wg2g6                           1/1     Running   0          17m
sock-cart              sock-cart-mysql-f54588cc5-dxq9n                     1/1     Running   0          17m
sock-catalog           sock-catalog-6c54f9674-5bq9n                        1/1     Running   0          18m
sock-catalog           sock-catalog-6c54f9674-x94sk                        1/1     Running   0          18m
sock-catalog           sock-catalog-mysql-75b9544bd6-5b7fn                 1/1     Running   0          18m
sock-order             sock-order-847754f44-f5g9s                          1/1     Running   0          14m
sock-order             sock-order-847754f44-jhc2j                          1/1     Running   0          14m
sock-order             sock-order-mysql-76bb884c7c-m7ft4                   1/1     Running   0          14m
sock-payment           sock-payment-66c9f449dc-qw8bm                       1/1     Running   0          15m
sock-shipping          sock-shipping-6f888c88b-z6vxc                       1/1     Running   1          14m
sock-shipping          sock-shipping-mysql-54598775bb-nm9k7                1/1     Running   0          14m
sock-ui                sock-ui-6cb7895cbd-l49s9                            1/1     Running   0          8m11s
sock-ui                sock-ui-6cb7895cbd-ls8dp                            1/1     Running   0          8m11s
sock-ui                sock-ui-redis-master-7c88d94dc4-h5dv4               1/1     Running   0          8m11s
sock-user              sock-user-7db4cf4c9c-6nxrv                          1/1     Running   0          6m13s
sock-user              sock-user-7db4cf4c9c-88ncv                          1/1     Running   0          5m51s
sock-user              sock-user-mysql-76bd667c95-csfps                    1/1     Running   0          21m
sock-user              sock-user-redis-master-5fb694bbc8-d4xj5             1/1     Running   0          21m
```


## With Ingress and Cert Manager (Let's Encrypt)


Following steps use `ClusterIssuer` object named `letsencrypt-maki-lol` as bellow

```
$ kubectl get clusterissuer -o wide
NAME                   READY   STATUS                                                 AGE
letsencrypt-maki-lol   True    The ACME account was registered with the ACME server   22h
```

and `apple.maki.lol` is used as a sample domain.

### Deploy User API

First of all, deploy User API

```
YTT_sock_ui_external_url=https://spring-socks.apple.maki.lol \
YTT_sock_user_external_url=https://sock-user.apple.maki.lol \
YTT_sock_issuer_url=${YTT_sock_user_external_url}/oauth/token \
YTT_use_ingress=True \
YTT_cluster_issuer_name=letsencrypt-maki-lol \
./k8s/deploy.sh user-api
```

Check if an access token can be issued.

```
$ curl https://sock-user.apple.maki.lol/oauth/token -u sock:sock -d grant_type=client_credentials
{"access_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsic29jayJdLCJzY29wZSI6WyJvcGVuaWQiLCJjYXRhbG9nOnJlYWQiLCJjdXN0b21lcjpyZWFkIiwiY3VzdG9tZXI6d3JpdGUiLCJvcmRlcjpyZWFkIiwib3JkZXI6d3JpdGUiLCJjYXJ0OnJlYWQiLCJjYXJ0OndyaXRlIiwic2hpcHBpbmc6cmVhZCIsInNoaXBwaW5nOndyaXRlIiwicGF5bWVudDphdXRoIl0sImlzcyI6Imh0dHBzOi8vc29jay11c2VyLmFwcGxlLm1ha2kubG9sL29hdXRoL3Rva2VuIiwiZXhwIjoxNjEwNzIxNzUxLCJpYXQiOjE2MTA2MzUzNTEsImF1dGhvcml0aWVzIjpbIlJPTEVfVFJVU1RFRF9DTElFTlQiXSwianRpIjoiLU9TWnZYWkxBSDBYWGpZR0hqazY5N1NlVnQ4IiwiY2xpZW50X2lkIjoic29jayJ9.B1pzuNKBsZBpbUN3N7jP91ukDl0YgGsGqIAyR3e65Qyr2MkuK1RmED0dt6pSHpcTQ0eHQqZJ3B-wJcjIIODi1F0Az2tCdWhnNBPAh3G0xKcmicY_rGpZVADz8OQt9Ws2NAYXeCuSQ16wKOdy3CzzclVPSa-1ptNAILgRm-qQddO5mCRSkWbvvpivbNXPt1SfYEku9RTh9pnA9HiM2gEL313u1E8gy6-RWJU70G5SAiwYLmWGr-E6kAkb6ALekMr3VOW12MqOZGEB4uW9Oi5jRFitgJL3Zg6PFxB-JFgC2KlPR-4jP4ufFvbyDBEuKvb4-_jojWRj51AVPKAEjACyrA","token_type":"bearer","expires_in":86399,"scope":"openid catalog:read customer:read customer:write order:read order:write cart:read cart:write shipping:read shipping:write payment:auth","id_token":"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsic29jayJdLCJzY29wZSI6WyJvcGVuaWQiXSwiaXNzIjoiaHR0cHM6Ly9zb2NrLXVzZXIuYXBwbGUubWFraS5sb2wvb2F1dGgvdG9rZW4iLCJleHAiOjE2MTA3MjE3NTEsImlhdCI6MTYxMDYzNTM1MSwiYXV0aG9yaXRpZXMiOlsiUk9MRV9UUlVTVEVEX0NMSUVOVCJdLCJqdGkiOiItT1NadlhaTEFIMFhYallHSGprNjk3U2VWdDgiLCJjbGllbnRfaWQiOiJzb2NrIn0.MesOEN_uBCoLa4TSLk0l09SBh9OQDdryRQPdfpiXglhe_cWgcfXe4HuXEIhlRt_fE3n5M_-SH8zyeWTLOFTTOKJGjoxF4nWNiTOPtXUNwCrp9-gaP4ODX2ahKMXF1zjt7piDBFuHIXICQFUqnZrzNHtBBdWFciGTFTifXKhR7aLdj3MdLFvdAShVpfRZqg76JChK99WkUC8rIhbW50dp1mDicnkiSBECneRGNw5rtOPDQWBoyT4UPWg4cF7taXOfOLmDT51Pu2ebO5Cdm4d6i2XWu3DM0Wh77oYpQE23IsupTRSeTMMt26vGwL7Z_kSH9fr5sftYsLUBrFXGuEOvhw"}
```

### Deploy Catalog API

```
YTT_sock_issuer_url=https://sock-user.apple.maki.lol/oauth/token \
./k8s/deploy.sh catalog-api
```

### Deploy Cart API

```
YTT_sock_issuer_url=https://sock-user.apple.maki.lol/oauth/token \
./k8s/deploy.sh cart-api
```

### Deploy Payment API

```
YTT_sock_issuer_url=https://sock-user.apple.maki.lol/oauth/token \
./k8s/deploy.sh payment-api
```

### Deploy Shipping API

```
YTT_sock_issuer_url=https://sock-user.apple.maki.lol/oauth/token \
./k8s/deploy.sh shipping-api
```

### Deploy Order API

```
YTT_sock_issuer_url=https://sock-user.apple.maki.lol/oauth/token \
./k8s/deploy.sh order-api
```

### Deploy Shop UI

```
YTT_sock_ui_external_url=https://spring-socks.apple.maki.lol \
YTT_sock_user_external_url=https://sock-user.apple.maki.lol \
YTT_sock_issuer_url=${YTT_sock_user_external_url}/oauth/token \
YTT_use_ingress=True \
YTT_cluster_issuer_name=letsencrypt-maki-lol \
./k8s/deploy.sh shop-ui
```

Go to [https://spring-socks.apple.maki.lol](https://spring-socks.apple.maki.lol)

![image](https://user-images.githubusercontent.com/106908/104606170-c7c2ab00-56c2-11eb-8bad-fcaf55b66285.png)

You can log in as a demo user (username: `jdoe` / password: `demo`).
