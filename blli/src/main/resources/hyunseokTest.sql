drop table blli_permanent_dead_posting cascade constraint;
CREATE TABLE blli_permanent_dead_posting (
	posting_url     VARCHAR2(300) NOT NULL,
	posting_title   VARCHAR2(450) NOT NULL,
	constraint pk_permanent_dead_posting primary key(posting_url, posting_title)
);

select * from blli_small_product;

select count(*) from blli_small_product;

select count(*) from blli_small_product where small_product_status = 'dead';

select count(*) from blli_small_product where small_product_status = 'unconfirmed';

select count(*) from blli_small_product group by mid_category;

select * from blli_small_product where mid_category = '캐릭터/패션인형' and small_product_status = 'dead';

select * from blli_small_product where mid_category = '캐릭터/패션인형' and small_product_status = 'unconfirmed';

select count(*) from blli_small_product where mid_category = '캐릭터/패션인형';

select count(*) from blli_small_product where small_product_status = 'confirmedbyadmin';