select 
 id as payment_id,
 metadata.order_id as order_id, 
 currency as payment_method,
 amount/100 as amount, 
 status, 
 created_at
from {{ source('stripe', 'payment') }}