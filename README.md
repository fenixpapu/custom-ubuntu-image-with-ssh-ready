# Custom ubuntu image ready with ssh

-  Mình có note thành blogs ở [đây](https://github.com/fenixpapu/blogs/blob/master/posts/2023/0222-custom-ubuntu-image-with-ready-ssh-service.md)

- Mình đang cần thực hành ansible và bản chất ansible là ssh vào các conserver để cấu hình. Nên mình tạo repo này để custom 
image ubuntu luôn. Mỗi lần docker run là mình sẽ có container ssh được từ laptop sẵn luôn.


## Prepare

- `id_rsa.pub` là file chứa public key của máy mình trong đường dẫn `~/.ssh/id_rsa.pub` dùng để khi container up chúng ta có thể ssh vào thẳng luôn.

- Dockerfile tuỳ biến ubuntu image với việc tạo user, add file và add key..

## Create image

- Chạy câu lệnh sau để build image:

```sh
docker build -t ubuntu_custom .
```

- Chạy server với image mới tạo thôi nào:
```sh
docker run -d --name ubuntu_redis -it ubuntu_custom
```

- Chạy lệnh này để lấy IP container vừa chạy thôi:

```sh
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ubuntu_redis
```

- ssh vào container với các câu lệnh sau:

```sh
ssh ubuntu@172.17.0.3 
# 172.17.0.3 là IP output của lệnh trên
# hoặc lệnh dưới:
ssh -i id_rsa ubuntu@172.17.0.3
```

- Xóa known_hosts, vì container thay đổi liên tục, cần xóa nội dung trong file này để có thể login được:

```sh
rm ~/.ssh/known_hosts
```