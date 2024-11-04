Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD213214;
	Mon,  4 Nov 2024 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710078; cv=none; b=VhrRyYbrpAhi7nurirzjVxLJitLg1zj3xiHAtMSHfLE0XEOrQ/JeZRAbYrQF+EEgvzaX7+rfXiuK2wZPU422KF/XyVFbGG4hl1ooORiqhv90/f+3iJCcMsm47388UKBuGo/yODv9GjcEj7XUwiPVxZquDQtpGGNzyxnpF4NZ3UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710078; c=relaxed/simple;
	bh=NGV3URn//MNt6TNIxM7qh0d3R6qI0K4QaslkHHzl+RY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=olD4/9Qiix7xXfmHnwfYXKhugDtOFo5uAZte+eYaiNrJnsjvpx+q8/tAsIz1yknkzPS+RcLKT4nf23MWEpUXrPeTzkoFHBxTQ6ivavXRnW5S6wOLl5nz3Isj37Tgb3g7cA7kkS4MS4eyas6gQoymq/rrztof9jWvEPFaRVbEp44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XhlRD5yjmz1T8BF;
	Mon,  4 Nov 2024 16:45:28 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 156CB180105;
	Mon,  4 Nov 2024 16:47:46 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 4 Nov
 2024 16:47:44 +0800
Subject: Re: [PATCH net-next] net/smc: Optimize the search method of reused
 buf_desc
To: <dust.li@linux.alibaba.com>, <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
	<alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <kuba@kernel.org>
References: <20241101082342.1254-1-liqiang64@huawei.com>
 <20241101105253.GG101007@linux.alibaba.com>
 <fa7dc8fc-fc6a-5ee1-94a2-b4ad62624834@huawei.com>
 <20241104081304.GB54400@linux.alibaba.com>
From: Li Qiang <liqiang64@huawei.com>
Message-ID: <57ca11f4-1194-2fe0-426b-ef049c4fc884@huawei.com>
Date: Mon, 4 Nov 2024 16:47:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241104081304.GB54400@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf200001.china.huawei.com (7.202.181.227)



在 2024/11/4 16:13, Dust Li 写道:
> On 2024-11-02 14:43:52, Li Qiang wrote:
>>
>>
>> 在 2024/11/1 18:52, Dust Li 写道:
>>> On 2024-11-01 16:23:42, liqiang wrote:
>>>> connections based on redis-benchmark (test in smc loopback-ism mode):
>>> ...
>>> ```
>>
>> I tested with nginx, the test command is:
>> # server
>> smc_run nginx
>>
>> # client
>> smc_run wrk -t <2,4,8,16,32,64> -c 200 -H "Connection: close" http://127.0.0.1
>>
>> Requests/sec
>> --------+---------------+---------------+
>> req/s	| without patch	| apply patch	|
>> --------+---------------+---------------+
>> -t 2	|6924.18	|7456.54	|
>> --------+---------------+---------------+
>> -t 4	|8731.68	|9660.33	|
>> --------+---------------+---------------+
>> -t 8	|11363.22	|13802.08	|
>> --------+---------------+---------------+
>> -t 16	|12040.12	|18666.69	|
>> --------+---------------+---------------+
>> -t 32	|11460.82	|17017.28	|
>> --------+---------------+---------------+
>> -t 64	|11018.65	|14974.80	|
>> --------+---------------+---------------+
>>
>> Transfer/sec
>> --------+---------------+---------------+
>> trans/s	| without patch	| apply patch	|
>> --------+---------------+---------------+
>> -t 2	|24.72MB	|26.62MB	|
>> --------+---------------+---------------+
>> -t 4	|31.18MB	|34.49MB	|
>> --------+---------------+---------------+
>> -t 8	|40.57MB	|49.28MB	|
>> --------+---------------+---------------+
>> -t 16	|42.99MB	|66.65MB	|
>> --------+---------------+---------------+
>> -t 32	|40.92MB	|60.76MB	|
>> --------+---------------+---------------+
>> -t 64	|39.34MB	|53.47MB	|
>> --------+---------------+---------------+
>>
>>>
>>>>
>>>>    1. On the current version:
>>>>        [x.832733] smc_buf_get_slot cost:602 ns, walk 10 buf_descs
>>>>        [x.832860] smc_buf_get_slot cost:329 ns, walk 12 buf_descs
>>>>        [x.832999] smc_buf_get_slot cost:479 ns, walk 17 buf_descs
>>>>        [x.833157] smc_buf_get_slot cost:679 ns, walk 13 buf_descs
>>>>        ...
>>>>        [x.045240] smc_buf_get_slot cost:5528 ns, walk 196 buf_descs
>>>>        [x.045389] smc_buf_get_slot cost:4721 ns, walk 197 buf_descs
>>>>        [x.045537] smc_buf_get_slot cost:4075 ns, walk 198 buf_descs
>>>>        [x.046010] smc_buf_get_slot cost:6476 ns, walk 199 buf_descs
>>>>
>>>>    2. Apply this patch:
>>>>        [x.180857] smc_buf_get_slot_free cost:75 ns
>>>>        [x.181001] smc_buf_get_slot_free cost:147 ns
>>>>        [x.181128] smc_buf_get_slot_free cost:97 ns
>>>>        [x.181282] smc_buf_get_slot_free cost:132 ns
>>>>        [x.181451] smc_buf_get_slot_free cost:74 ns
>>>>
>>>> It can be seen from the data that it takes about 5~6us to traverse 200 
>>>
>>> Based on your data, I'm afraid the short-lived connection
>>> test won't show much benificial. Since the time to complete a
>>> SMC-R connection should be several orders of magnitude larger
>>> than 100ns.
>>
>> Sorry, I didn't explain my test data well before.
>>
>> The main optimized functions of this patch are as follows:
>>
>> ```
>> struct smc_buf_desc *smc_buf_get_slot(...)
>> {
>> 	struct smc_buf_desc *buf_slot;
>>        down_read(lock);
>>        list_for_each_entry(buf_slot, buf_list, list) {
>>                if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
>>                        up_read(lock);
>>                        return buf_slot;
>>                }
>>        }
>>        up_read(lock);
>>        return NULL;
>> }
>> ```
>> ...
>>
>> The optimized code is as follows:
>>
>> ```
>> static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
>> {
>>        struct smc_buf_desc *buf_free;
>>        struct llist_node *llnode;
>>
>>        if (llist_empty(buf_llist))
>>                return NULL;
>>        // lock-less link list don't need an lock
>          ^^^ kernel use /**/ for comments

Ok I will change it. :-)

> 
>>        llnode = llist_del_first(buf_llist);
>>        buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
> 
> If 2 CPU both passed the llist_empty() check, only 1 CPU can get llnode,
> the other one should be NULL ?

Well, what you said makes sense, I think the previous judgment of llist_empty
is useless and can be deleted. This function should be changed to:
```
static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
{
	struct smc_buf_desc *buf_free;
	struct llist_node *llnode;

	/* lock-less link list don't need an lock */
	llnode = llist_del_first(buf_llist);
        if (llnode == NULL)
            return NULL;
	buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
	WRITE_ONCE(buf_free->used, 1);
	return buf_free;
}
```

If there is only one node left in the linked list, multiple CPUs will
compete based on CAS instructions in llist_del_first. In the end, only
one consumer will get the node, and other consumers will get the null pointer.

Thank you!

> 
>>        WRITE_ONCE(buf_free->used, 1);
>>        return buf_free;
>> }
>> ```

-- 
Best regards,
Li Qiang
