Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFFD2572;
	Fri,  2 Aug 2024 01:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563722; cv=none; b=LBHcGEOw0rM1TuWMkpsl6p4LY51foNsMLCIDlJUqPw7HP/cxLOlu1xIpRUKvT9EL8tDXWOjYRVerrT+wl8g+ARhxMd2/iIlGS4ITvH/zNKMhLzJAJ1juNI2rSJ4LloG1vd3iHISfpQMjPcvdMEuByj780GZbqg/jEEwDhQFlJ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563722; c=relaxed/simple;
	bh=ZCvScViQqCucMKDq2Ql0ZIV1r1VqUzOfJvh/3tJyy94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJwtZi/fE4mVpTEVKDDEo5rffi44ayf1gUudugFVC6qVlqN/p2N2w6tspngdISdYvNtPI+dmbGN0+SiOCUAHqXFmZVh1xm5iEJLnY6Pt5h8rRh8aERZqmEObGosTcL/W+f8m82A806Pl4yJgzSZnVgGO0J8HGluLEvrKQuA2Fpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IZVHZ0B2; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IZVHZ0B2"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722563717; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zsJ8qpiUqdp+eWJmsE2CmpJqsddXO5xbkozRYvCTCxs=;
	b=IZVHZ0B2peq3F01RawE9f6QpjnlKL6IGzhvtbogomUFEt01R7ycDcdEcgtwB7+E+Qcydf9oCsxyzm4Io22EzDw/bz0JssW8hLzRVRcDsm17EtUHgLH2vw8u3Uvhen8yQlqD13CG1HUfi+V7Oru1WIiyxQTN1jKGBs98ssLK6wTw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WBvTFOd_1722563707;
Received: from 30.221.130.78(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WBvTFOd_1722563707)
          by smtp.aliyun-inc.com;
          Fri, 02 Aug 2024 09:55:16 +0800
Message-ID: <dedb6046-83a6-4bda-bf1d-ae77a8cda972@linux.alibaba.com>
Date: Fri, 2 Aug 2024 09:55:06 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: delete buf_desc from buffer list under lock
 protection
To: shaozhengchao <shaozhengchao@huawei.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731093102.130154-1-guwen@linux.alibaba.com>
 <ef374ef8-a19e-7b9b-67a1-5b89fb505545@huawei.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ef374ef8-a19e-7b9b-67a1-5b89fb505545@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/7/31 18:32, shaozhengchao wrote:
> Hi Wen Gu:
>    "The operations to link group buffer list should be protected by
> sndbufs_lock or rmbs_lock" It seems that the logic is smooth. But will
> this really happen? Because no process is in use with the link group,
> does this mean that there is no concurrent scenario?
> 

Hi Zhengchao,

Yes, I am also very conflicted about whether to add lock protection.
 From the code, it appears that when __smc_lgr_free_bufs is called, the
link group has already been removed from the lgr_list, so theoretically
there should be no contention (e.g. add to buf_list). However, in order
to maintain consistency with other lgr buf_list operations and to guard
against unforeseen or future changes, I have added lock protection here
as well.

Thanks!

> Thank you
> 
> Zhengchao Shao
> 
> On 2024/7/31 17:31, Wen Gu wrote:
>> The operations to link group buffer list should be protected by
>> sndbufs_lock or rmbs_lock. So fix it.
>>
>> Fixes: 3e034725c0d8 ("net/smc: common functions for RMBs and send buffers")
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_core.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index 3b95828d9976..ecfea8c38da9 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -1368,18 +1368,24 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
>>   {
>>       struct smc_buf_desc *buf_desc, *bf_desc;
>>       struct list_head *buf_list;
>> +    struct rw_semaphore *lock;
>>       int i;
>>       for (i = 0; i < SMC_RMBE_SIZES; i++) {
>> -        if (is_rmb)
>> +        if (is_rmb) {
>>               buf_list = &lgr->rmbs[i];
>> -        else
>> +            lock = &lgr->rmbs_lock;
>> +        } else {
>>               buf_list = &lgr->sndbufs[i];
>> +            lock = &lgr->sndbufs_lock;
>> +        }
>> +        down_write(lock);
>>           list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
>>                        list) {
>>               list_del(&buf_desc->list);
>>               smc_buf_free(lgr, is_rmb, buf_desc);
>>           }
>> +        up_write(lock);
>>       }
>>   }
