# ==========================================
# Stage 1: 编译阶段 (Builder)
# 目标：提供 Go 环境，把源码编译成二进制文件
# ==========================================
FROM golang:1.22-alpine AS builder

# 在容器内创建一个工作目录
WORKDIR /app

# 把宿主机当前目录下的 main.go 拷贝到容器的 /app 目录下
COPY ./main.go /app/

# 执行 Go 编译命令，将 main.go 编译成名为 my-server 的可执行文件
RUN CGO_ENABLED=0 GOOS=linux go build -o my-server main.go

# ==========================================
# Stage 2: 生产运行阶段 (Runtime)
# 目标：提供极简的运行环境，只包含编译好的产物
# ==========================================
FROM alpine:3.23.3

# 在运行容器内创建一个工作目录
WORKDIR /root/

# 【核心考点】：从 builder 阶段，把 /app/my-server 这个文件，拷贝到当前运行阶段的目录下
COPY --from=builder /app/my-server .

# 声明容器运行时监听的端口（提示：看一眼刚才的 Go 代码监听了哪个端口）
EXPOSE 8080

# 容器启动时执行的默认命令，运行那个二进制文件
CMD ["./my-server"]