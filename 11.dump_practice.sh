# local컴퓨터의 board DB -> 마이그레이션 -> linux이전
# linuxdp db를 설치 -> loca의 dump 작업 후 sql쿼리 생성 -> github에 upload -> git clone -> linux에서 해당 쿼리 실행

# 도커에서 내 mariadb이름 확인
docker ps ->  my_mariadb
# 접속
docker exec -it my_mariadb /bin/bash
# 덤프파일 생성
mariadb-dump -u root -p board > dumpfile.sql

#리눅스에서 mariadb 서버 설치
sudo apt-get install mariadb-server

# mariadb 서버 시작
sudo systemctl start mariadb

# mariadb 접속 테스트
sudo mariadb -u root -p

# mariadb에 들어와서 데이터베이스만 생성
create database board;

# git 설치 확인
git --version

# git이 없다면 설치 
sudo apt install git

# git을 통해 repo clone
git clone repository주소

# git에서 clone한 파일을 집어 넣음(덤프 복원)
mysql -u root -p board < dumpfile.sql

