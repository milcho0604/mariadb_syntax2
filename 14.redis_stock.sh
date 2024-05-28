# !/bin/bash

# aplle:quantity:1에 수량을 250개 넣음
set apple:quantity:1 250
# 200번 반복하면서 재고 확인 및 감소, redis-cli에서 나와서 입력
for i in {1..200}; do
    quantity=$(redis-cli -h localhost -p 6379 get apple:quantity:1)
    if [ "$quantity" -lt 1 ]; then
        echo "재고가 부족합니다. 현재 재고: $quantity"
        break;
    fi 
    # 재고감소
    redis-cli -h localhost -p 6379 decr apple:quantity:1
    echo "현재 재고: $quantity"
done

