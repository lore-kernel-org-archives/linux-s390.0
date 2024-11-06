Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A067519046E;
	Wed,  6 Nov 2024 07:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730876717; cv=none; b=Xu0TTeIHszsO33qG9H4tCX2kNMsMvLJK04hdJ/81vL45rDY9NUZ2jb6KybaD5U41ZbyNxr3kHY/1ErhJzciIgEPbzrhdOd9BRuNnyYJZmIkavfMo3xnH+QpMiYFC+RqIlbU2l1QH2ID5kEr1vSInaZBnYzlL5X5wIeVKeMiPtHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730876717; c=relaxed/simple;
	bh=FlrbajGkVWKZv7DBfiNmX0RwbnrSl4eKa+pz0LV46GQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=khqsQMkrs9HCYy93ga6FW3Xdwev0xMzINEuSDfpIVKSroVvIuaLXnDYEUnmUmqolwu2OoTzShjFufBKMUgAgnlYo8pwdWsINpg323k1j4r0OBzauBwtghmhNp29mny4paKj5wSh/VYWDGxp3AYDy9WITH9rg31zxViqCFGQ6y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xjx3S075VzNqYG;
	Wed,  6 Nov 2024 15:02:28 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id BE481140384;
	Wed,  6 Nov 2024 15:05:04 +0800 (CST)
Received: from [10.110.54.32] (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 6 Nov
 2024 15:05:03 +0800
Subject: Re: [PATCH v2 net-next] net/smc: Optimize the search method of reused
 buf_desc
To: <dust.li@linux.alibaba.com>, <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>,
	<alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<guwen@linux.alibaba.com>, <kuba@kernel.org>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>, <gaochao24@huawei.com>
References: <20241101082342.1254-1-liqiang64@huawei.com>
 <20241105031938.1319-1-liqiang64@huawei.com>
 <20241105144457.GB89669@linux.alibaba.com>
From: Li Qiang <liqiang64@huawei.com>
Message-ID: <07f7e770-f78c-b272-f077-c238f1dc030b@huawei.com>
Date: Wed, 6 Nov 2024 15:05:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241105144457.GB89669@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200001.china.huawei.com (7.202.181.227)



在 2024/11/5 22:44, Dust Li 写道:
> On 2024-11-05 11:19:38, liqiang wrote:
>> [...]
>> I tested the time-consuming comparison of this function
>> under multiple connections based on redis-benchmark
>> (test in smc loopback-ism mode):
>> The function 'smc_buf_get_slot' takes less time when a
>> new SMC link is established:
>> 1. 5us->100ns (when there are 200 active links);
>> 2. 30us->100ns (when there are 1000 active links).
>> [...]
>> -/* try to reuse a sndbuf or rmb description slot for a certain
>> - * buffer size; if not available, return NULL
>> - */
>> -static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
>> -					     struct rw_semaphore *lock,
>> -					     struct list_head *buf_list)
>> +/* use lock less list to save and find reuse buf desc */
>> +static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
>> {
>> -	struct smc_buf_desc *buf_slot;
>> +	struct smc_buf_desc *buf_free;
>> +	struct llist_node *llnode;
>>
>> -	down_read(lock);
>> -	list_for_each_entry(buf_slot, buf_list, list) {
>> -		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
>> -			up_read(lock);
>> -			return buf_slot;
>> -		}
>> -	}
>> -	up_read(lock);
>> -	return NULL;
>> +	/* lock-less link list don't need an lock */
>> +	llnode = llist_del_first(buf_llist);
>> +	if (!llnode)
>> +		return NULL;
>> +	buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
>> +	WRITE_ONCE(buf_free->used, 1);
>> +	return buf_free;
> 
> Sorry for the late reply.
> 
> It looks this is not right here.
> 
> The rw_semaphore here is not used to protect against adding/deleting
> the buf_list since we don't even add/remove elements on the buf_list.
> The cmpxchg already makes sure only one will get an unused smc_buf_desc.

I first came up with the idea of ​​​​optimizing because this function needs to
traverse all rmbs/sndbufs, which includes all active links and is a waste
of time and unnecessary.

Changing to an llist linked list implementation can ensure that a free buf_slot
with a 'used' mark of 0 can be directly obtained every time, without the need
to start traversing from the first element of the rmbs/sndbufs linked list.

> 
> Removing the down_read()/up_read() would cause mapping/unmapping link
> on the link group race agains the buf_slot alloc/free here. For exmaple
> _smcr_buf_map_lgr() take the write lock of the rw_semaphore.

Read from the relevant code, here only a buf_slot is found in the
down_read/up_read and 'used' is set to 0, while the 'used' is read
in other down_write/up_write code.

so I have two questions:

1. Is the read lock of rw_semaphore necessary here? (The read lock here
   is mutually exclusive with the write lock elsewhere, what is guaranteed
   should be that in the critical section of the write lock, all
   'smc_buf_desc->used' statuses in rmbs/sndbufs will not change.)
2. If is necessary, can we add it in new implement of this patch, like this?

```
{
        struct smc_buf_desc *buf_free;
        struct llist_node *llnode;

        /* lock-less link list don't need an lock */
        llnode = llist_del_first(buf_llist);
        if (!llnode)
                return NULL;
        buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
	up_read(lock);
        WRITE_ONCE(buf_free->used, 1);
	down_read(lock);
        return buf_free;
}
```
I think this can also ensure that all 'used' marks remain unchanged during
the write lock process.
Anyway, use llist to manage free rmbs/sndbufs is a better choice than traverse,
and it doesn't conflict with useing or not using rw_semaphore. :)

> 
> But I agree the lgr->rmbs_lock/sndbufs_lock should be improved. Would
> you like digging into it and improve the usage of the lock here ?
> 

Maybe I can try it, I need to spend some time to read in detail the
code used in every place of this lock.

Thanks for taking the time to read this email. ;-)

-- 
Best regards,
Li Qiang
