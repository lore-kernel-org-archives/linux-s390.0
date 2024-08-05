Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3472E78C8D;
	Mon,  5 Aug 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850306; cv=none; b=Apgu0Rj72N4xfnz7o9no/mYi5vUJV/FbAeshmxZAzgmvjDW/7BB5nsW38WUktHLQRKZW6CuvKScQ7Mqb8P2XQ78Zv9i5Ipk7l99t4PnfeYSD5A02Rs+p8mCN2Vj35/oYtDI4V7DculgtFLZhABr+tuwgfFLYVZtyiD9aLxTFBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850306; c=relaxed/simple;
	bh=ViMlkbBmo+7tcYzwIwPmqnXP4I4BJO9NmfXvpG2LM4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1glLAyscT5/FrhxNHlOrVePCEd0HsY2fTr+vLzYe+VPZkCztlSSmdF+zUt0BEMsmuR6EMSHPp0rrukFi9QOy8JAvLWnUmZdQFrJzio2Z/dChDq2vJgmorTGuQoXB2KmIoi5gntBOEhzfsXrR3gbjqNWOonVhasSsdHEX7MwYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=embq8jYu; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="embq8jYu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722850295; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NBzq6oBAHcsHmslfkpNOLi2FmYuc3exFGZXrcXvviH0=;
	b=embq8jYuFNaMayWcZ91qnYSU51wmoeTbvQlm3mldlPvpr9FoIIMa5UkrHeZsKkput/9uy3TF7Z3To67UB74A35o6hQZ98WbstJpIux5ormE6i2/LkA1BFEE6M/0Hh2D242lMmquCwUjdbOANdgwrrtQbir2WFqVN/1v39YRuj3A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WC7j0KH_1722850293;
Received: from 30.221.129.243(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WC7j0KH_1722850293)
          by smtp.aliyun-inc.com;
          Mon, 05 Aug 2024 17:31:34 +0800
Message-ID: <b55a530a-4b22-453e-84dc-0bd5583aced6@linux.alibaba.com>
Date: Mon, 5 Aug 2024 17:31:32 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: delete buf_desc from buffer list under lock
 protection
To: Wenjia Zhang <wenjia@linux.ibm.com>,
 shaozhengchao <shaozhengchao@huawei.com>, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240731093102.130154-1-guwen@linux.alibaba.com>
 <ef374ef8-a19e-7b9b-67a1-5b89fb505545@huawei.com>
 <dedb6046-83a6-4bda-bf1d-ae77a8cda972@linux.alibaba.com>
 <800b1186-2d87-4b20-9d38-b4fecde161f0@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <800b1186-2d87-4b20-9d38-b4fecde161f0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/5 16:23, Wenjia Zhang wrote:
> 
> 
> On 02.08.24 03:55, Wen Gu wrote:
>>
>>
>> On 2024/7/31 18:32, shaozhengchao wrote:
>>> Hi Wen Gu:
>>>    "The operations to link group buffer list should be protected by
>>> sndbufs_lock or rmbs_lock" It seems that the logic is smooth. But will
>>> this really happen? Because no process is in use with the link group,
>>> does this mean that there is no concurrent scenario?
>>>
>>
>> Hi Zhengchao,
>>
>> Yes, I am also very conflicted about whether to add lock protection.
>>  From the code, it appears that when __smc_lgr_free_bufs is called, the
>> link group has already been removed from the lgr_list, so theoretically
>> there should be no contention (e.g. add to buf_list). However, in order
>> to maintain consistency with other lgr buf_list operations and to guard
>> against unforeseen or future changes, I have added lock protection here
>> as well.
>>
>> Thanks!
>>
> 
> I'm indeed in two minds about if I give you my reviewed-by especially on the reason of unforeseen bugs. However, previously the most bugs on locking we met in our code are almost because of deadlocks caused by too much different locks introduced. Thus, I don't think this patch is necessary at lease 
> for now.
> 

OK, let's handle it when it causes actual problems. Thanks!

> Thanks,
> Wenjia
