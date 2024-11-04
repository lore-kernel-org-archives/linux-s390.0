Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCB171E43;
	Mon,  4 Nov 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707997; cv=none; b=FVBj2ubzrbPtI3gUG35sM0xbJrCkQYNo1XA+53mLjHBbdPwURF0p7XFM1U6o0CHCtAYL2GlyA8HCHf49Irz74EOBS2fLWwfTXooHCuv/nB4y/j8SfZBv35/4+co/aVAJfUXtl1utrgp4B4Z2kKlMgoxCgwdxzpf9rSw/P49gPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707997; c=relaxed/simple;
	bh=Pp1Yk8ui1FRnrFGWB9FnRi3+0KB0oBKBfe2pqMXuxO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njPbg2RfbMl7A4UyE+x6v4zpJdUK9c5MsWMJCC7y/zSeACSpKnZUURGm3ag6qbzlUUiJSGGn1tIwILg6UGB8NCi52VTnD0QjlLpP/g1PWPK/MWK5mu2teadWmyuiG1+zfmQhvhdI7lPHAx6Wm0eKLNEjuNxwjjsGkHULuBH4F/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MBk/ShCH; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MBk/ShCH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730707985; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=KlHW0TjIMoMSJWtV5hCBhi4UNl5BlTIuOIRKwDcZAXU=;
	b=MBk/ShCHh+O+W7OD0lzzYjsD+p1SuDBD38+7xPIu+A46Ei9/e0y6POBaoFCQYQ2ay22zpkqp/ImGs2S1CIomNqL6JxaBMYFnvyCNT+DId8I39/k9B7wj/0cRH1LBNuyBhY3fIKvb6UbJOQoIP1V1mT3yHBymdmU+F2nXVisI0TM=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WIdFvKz_1730707984 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:13:05 +0800
Date: Mon, 4 Nov 2024 16:13:04 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Li Qiang <liqiang64@huawei.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, luanjianhai@huawei.com,
	zhangxuzhou4@huawei.com, dengguangxing@huawei.com,
	gaochao24@huawei.com, kuba@kernel.org
Subject: Re: [PATCH net-next] net/smc: Optimize the search method of reused
 buf_desc
Message-ID: <20241104081304.GB54400@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241101082342.1254-1-liqiang64@huawei.com>
 <20241101105253.GG101007@linux.alibaba.com>
 <fa7dc8fc-fc6a-5ee1-94a2-b4ad62624834@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa7dc8fc-fc6a-5ee1-94a2-b4ad62624834@huawei.com>

On 2024-11-02 14:43:52, Li Qiang wrote:
>
>
>在 2024/11/1 18:52, Dust Li 写道:
>> On 2024-11-01 16:23:42, liqiang wrote:
>>> connections based on redis-benchmark (test in smc loopback-ism mode):
>> 
>> I think you can run test wrk/nginx test with short-lived connection.
>> For example:
>> 
>> ```
>> # client
>> wrk -H "Connection: close" http://$serverIp
>> 
>> # server
>> nginx
>> ```
>
>I tested with nginx, the test command is:
># server
>smc_run nginx
>
># client
>smc_run wrk -t <2,4,8,16,32,64> -c 200 -H "Connection: close" http://127.0.0.1
>
>Requests/sec
>--------+---------------+---------------+
>req/s	| without patch	| apply patch	|
>--------+---------------+---------------+
>-t 2	|6924.18	|7456.54	|
>--------+---------------+---------------+
>-t 4	|8731.68	|9660.33	|
>--------+---------------+---------------+
>-t 8	|11363.22	|13802.08	|
>--------+---------------+---------------+
>-t 16	|12040.12	|18666.69	|
>--------+---------------+---------------+
>-t 32	|11460.82	|17017.28	|
>--------+---------------+---------------+
>-t 64	|11018.65	|14974.80	|
>--------+---------------+---------------+
>
>Transfer/sec
>--------+---------------+---------------+
>trans/s	| without patch	| apply patch	|
>--------+---------------+---------------+
>-t 2	|24.72MB	|26.62MB	|
>--------+---------------+---------------+
>-t 4	|31.18MB	|34.49MB	|
>--------+---------------+---------------+
>-t 8	|40.57MB	|49.28MB	|
>--------+---------------+---------------+
>-t 16	|42.99MB	|66.65MB	|
>--------+---------------+---------------+
>-t 32	|40.92MB	|60.76MB	|
>--------+---------------+---------------+
>-t 64	|39.34MB	|53.47MB	|
>--------+---------------+---------------+
>
>> 
>>>
>>>    1. On the current version:
>>>        [x.832733] smc_buf_get_slot cost:602 ns, walk 10 buf_descs
>>>        [x.832860] smc_buf_get_slot cost:329 ns, walk 12 buf_descs
>>>        [x.832999] smc_buf_get_slot cost:479 ns, walk 17 buf_descs
>>>        [x.833157] smc_buf_get_slot cost:679 ns, walk 13 buf_descs
>>>        ...
>>>        [x.045240] smc_buf_get_slot cost:5528 ns, walk 196 buf_descs
>>>        [x.045389] smc_buf_get_slot cost:4721 ns, walk 197 buf_descs
>>>        [x.045537] smc_buf_get_slot cost:4075 ns, walk 198 buf_descs
>>>        [x.046010] smc_buf_get_slot cost:6476 ns, walk 199 buf_descs
>>>
>>>    2. Apply this patch:
>>>        [x.180857] smc_buf_get_slot_free cost:75 ns
>>>        [x.181001] smc_buf_get_slot_free cost:147 ns
>>>        [x.181128] smc_buf_get_slot_free cost:97 ns
>>>        [x.181282] smc_buf_get_slot_free cost:132 ns
>>>        [x.181451] smc_buf_get_slot_free cost:74 ns
>>>
>>> It can be seen from the data that it takes about 5~6us to traverse 200 
>> 
>> Based on your data, I'm afraid the short-lived connection
>> test won't show much benificial. Since the time to complete a
>> SMC-R connection should be several orders of magnitude larger
>> than 100ns.
>
>Sorry, I didn't explain my test data well before.
>
>The main optimized functions of this patch are as follows:
>
>```
>struct smc_buf_desc *smc_buf_get_slot(...)
>{
>	struct smc_buf_desc *buf_slot;
>        down_read(lock);
>        list_for_each_entry(buf_slot, buf_list, list) {
>                if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
>                        up_read(lock);
>                        return buf_slot;
>                }
>        }
>        up_read(lock);
>        return NULL;
>}
>```
>The above data is the time-consuming data of this function.
>If the current system has 200 active links, then during the
>process of establishing a new SMC connection, this function
>must traverse all 200 active links, which will take 5~6us.
>If there are already 1,000 for active links, it takes about 30us.
>
>After optimization, this function takes <100ns, it has nothing
>to do with the number of active links.
>
>Moreover, the lock has been removed, which is firendly to multi-thread
>parallel scenarios.
>
>The optimized code is as follows:
>
>```
>static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
>{
>        struct smc_buf_desc *buf_free;
>        struct llist_node *llnode;
>
>        if (llist_empty(buf_llist))
>                return NULL;
>        // lock-less link list don't need an lock
         ^^^ kernel use /**/ for comments

>        llnode = llist_del_first(buf_llist);
>        buf_free = llist_entry(llnode, struct smc_buf_desc, llist);

If 2 CPU both passed the llist_empty() check, only 1 CPU can get llnode,
the other one should be NULL ?

>        WRITE_ONCE(buf_free->used, 1);
>        return buf_free;
>}
>```
>
>-- 
>Cheers,
>Li Qiang
