with orders as ( 
    select * from {{ ref('stg_jaffle_shop__orders') }}
),

payment as (
    select * from {{ ref('stg_stripe__payment') }}
),

payment_orders as (

    select
        order_id,
        sum(case when status='success' then amount end) as amount
    from payment
    group by 1

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        coalesce (payment_orders.amount, 0) as amount

    from orders
    left join payment_orders using (order_id)

)

select * from final