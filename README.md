top
=====

这是一个用于调用淘宝API接口的模块
##安装
<pre>
    npm install yi-top
</pre>
##使用
* 引入TOP类
```javascript
var TOP = require('yi-top');
```

* 初始化API配置

```javascript
    TopClient = new TOP({appkey:'123456',secret:'654321'});
```
或者
```javascript
    TopClient = new TOP();
    TopClient.init({appkey:'123456',secret:'654321',session:'987654321'});
```

* 调用Rest API

```javascript
TopClient.api({
    method:'taobao.item.get',
    fields:'detail_url,num_iid,title,nick,type,cid,seller_cids,props,input_pids,input_str,desc,pic_url,num,valid_thru,list_time,delist_time,stuff_status,location,price,post_fee,express_fee,ems_fee,has_discount,freight_payer,has_invoice,has_warranty,has_showcase,modified,increment,approve_status,postage_id,product_id,auction_point,property_alias,item_img,prop_img,sku,video,outer_id,is_virtual',
    num_iid:'16933971649'
},function(err,resp){
    if(err){
        console.error(err);
    }
    else{
        console.log(resp);
    }
});
```

* 调用Widget API

```javascript
TopClient.widget({
    method: 'taobao.taobaoke.widget.items.convert',
    fields: 'num_iid,click_url,commission,commission_rate,commission_num,commission_volume,shop_click_url,seller_credit_score,volume',
    num_iids: '16933971649,22817632561',
    outer_code: 'avicha'
},function(err,resp){
    if(err){
        console.error(err);
    }
    else{
        console.log(JSON.stringify(resp));
    }
});
```
* 使用POST方法调用API

```javascript
TopClient.widget({
    method: 'taobao.taobaoke.widget.items.convert',
    fields: 'num_iid,click_url,commission,commission_rate,commission_num,commission_volume,shop_click_url,seller_credit_score,volume',
    num_iids: '16933971649,22817632561',
    outer_code: 'avicha'
},'post',function(err,resp){
    if(err){
        console.error(err);
    }
    else{
        console.log(JSON.stringify(resp));
    }
});
```
