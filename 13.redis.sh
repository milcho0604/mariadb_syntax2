# redis 설치
sudo apt-get install redis-Server

# redis version 확인
redis-server --version

# redis 접속 
# cli : CommandLine Interface
redis-cli

# redis는 0~15번까지의 database로 구성
# 데이터베이스 선택 및 접속 -> default는 0번
select 번호

# 모든 키 조회하기
keys *

# 특정 키 값 조회하기
get 키
get test_key1




# 자료구조 세팅하기! -> key와 value 구조로 세팅하기 필요
# 일반 string 자료구조

set 키 값
set test_key1 test_value1
set user:email:1 hongildong@naver.com
set user:num 1

# key값 중복 시 자동으로 덮어쓰기 된다.
# 맵저장소에서 key값은 유일하게 관리가 되므로
# nx : not exist -> 해당 키 값이 ⭐없을 때 만⭐ set 할 수 있다.
set user:email:1 hongildong@naver.com nx

# ex(만료시간 - 초단위) - ttl(time to live)
set user:email:2 hong2@naver.com ex 20

# 특정 key 삭제
del user:email:1
# 현 database 모든 key값 삭제
flushdb

# 좋아요 기능 구현
set likes:posting:1 0
incr likes:posting:1 #특정 key값의 value를 1만큼 증가
decr likes:posting:1 #특정 key값의 value를 1만큼 감소
get likes:posting:1 #특정 key값을 조회
# 좋아요 기능은 동서싱 이슈가 발생할 가능성이 높음
# update posting set likes = likes + 1 where id = 1;이 발생
# lost update -> +1 
# 단, redis의 경우 싱글 스레이기 때문에 한 번에  한명만 들어올 수 있어서 이러한 동시성 이슈를 원천적으로 차단

# 재고 기능 구현
set product:1:stock 100
decr product:1:stock
get product:1:stock

# bash쉘을 활용하여 재고감소 프로그램 작성

# 캐싱 기능 구현
# 1번 author 회원 정보 조회
# select name, email, age from author where id = 1;
# 위 데이터의 결과값을 redis로 캐싱 : json 데이터 형식으로 저장
set user:1:detail "{\"name\":\"hong\", \"email\":\"hong@naver.com\", \"age\":30}" ex 10

# list
# redis의 list는 java의 deque와 같은 구조 즉, double-ended queue구조

# 데이터 왼쪽 삽입
LPUSH key value
# 데이터 오른쪽 삽입
RPUSH key value
# 데이터 왼쪽부터 꺼내기
LPOP key
# 데이터 오른쪽부터 꺼내기
RPOP key

lpush hongildongs hong1
lpush hongildongs hong2
lpush hongildongs hong3

lpop hongildongs

# 꺼내서 없애는게 아니라, 꺼내서 보기만
lrange hongildons -1 -1 # 제일 오른쪽 보기
lrange hongildons 0 0 # 제일 왼쪽 보기

# 데이터 개수 조회
llen key
llen hongildons
# list의 요소 조회시에는 범위지정
lrange hongildongs 0 -1 #처음부터 끝까지
# start부터 end까지 조회
lrange hongildongs start end
# TTL적용
expire hongildongs 30
# TT조회
ttl hongildongs

# pop과 push동시에
RPOPLPUSH A리스트 B리스트 # A리스트에서 빼서 B리스트에 넣을 수 있다.


# 어떤 목적으로 사용될수 있을까?
# 최근 방문한 페이지
# 5개 정도 데이터 push
# 최근방문한 페이지 3개 정도만 보여주는
rpush page www.google.com
rpush page www.naver.com
rpush page www.google.com
rpush page www.daum.com
rpush page www.naver.com

lrange page 2 -1

# 위 방문페이지를 5개에서 뒤로가기 앞으로가기 구현
# 뒤로가기 페이지를 누르면 뒤로가기 페이지가 뭔지 출력
# 다시 앞으로가기 누르면 앞으로 간 페이지가 뭔지 출력
rpush forwards www.google.com
rpush forwards www.naver.com
rpush forwards www.google.com
rpush forwards www.daum.com
rpush forwards www.naver.com

lrange myPage -1 -1
rpoplpush forwards backwards

# set자료구조
# set자료구조에 멤버 추가
sadd members member1
sadd members member2
sadd members member1

# set 조회
smembers members

# set에서 멤버 삭제
srem members member2
# set맴버 개수 반환
scard members
# 특정 멤버가 set안에 있는지 존재 여부 확인
sismember members member3

# 매일 방문자수 계산
sadd visit:2024-05-27 kch@naver.com
sadd visit:2024-05-27 kch@daum.com
sadd visit:2024-05-27 kch@google.com
sadd visit:2024-05-27 kch@kakao.com
sadd visit:2024-05-27 kch@kakao.com

scard visit:2024-05-27

# zset(sorted set)
zadd zmembers 3 member1
zadd zmembers 3 member2
zadd zmembers 1 member3
zadd zmembers 2 member4

# score기준 오름차순 정렬
zrange zmembers 0 -1
# score기준 내림차순 정렬
zrevrange zmembers 0 -1

# zset 삭제
zrem zmembers member2

# zrank는 해당 멤버가 index몇번째인지 출력 
zrank zmembers member3

# 최근 본 상품목록 => sorted set (zset)을 활용하는 것이 적절
zadd recent:products 192411 apple
zadd recent:products 192413 apple
zadd recent:products 192415 banana
zadd recent:products 192420 orange
zadd recent:products 192425 apple
zadd recent:products 192440 apple

zrevrange recent:products 0 2

# hashes
# 해당 자료구조애서는 문자, 숫자가 구분
hset product:1 name "apple" price 1000 stock 50
hget product:1 name
# 모든 객체값 get
hgetall product:1
# 특정 요소값 수정
hset product:1 stock 40

# 특정 요소의 값을 증가
hincrby product:1 stock 5
# 반대로,특정 요소의 값음 감소(-값을 줌)
hincrby product:1 stock -5
 
