TOP = require '../index'
TopClient = new TOP()
TopClient.init appkey:'your_appkey',secret:'your_secret'
TopClient.api
    method:'taobao.item.get'
    fields:'detail_url,num_iid,title,nick,type,cid,seller_cids,props,input_pids,input_str,desc,pic_url,num,valid_thru,list_time,delist_time,stuff_status,location,price,post_fee,express_fee,ems_fee,has_discount,freight_payer,has_invoice,has_warranty,has_showcase,modified,increment,approve_status,postage_id,product_id,auction_point,property_alias,item_img,prop_img,sku,video,outer_id,is_virtual'
    num_iid:'16933971649'
,(err,resp)->
    if err
        console.error err
    else
        console.log JSON.stringify resp