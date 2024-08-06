Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A07F4685;
	Tue,  6 Aug 2024 13:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949675; cv=none; b=nCE9aAadCeibRUos/MSi5zb7bx06dB3ZVcL1oEI5kuDmC/8LAUtJajwwVAGyFjovjJ0PuLVPxGSnbH0RaTaHjsJYf8cn9+7xCkW5wTTQyrb3DczEJZ7lkIuAmQGYgzl/mJYRGMpXHKSoKLuOeWvrAeqcVgqOqwzVQ/tNCFGvBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949675; c=relaxed/simple;
	bh=vPqgpn35j+D1ivXq6WINxxpMn8ZzY2LTe5+6eauurno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cYlKgoRjb8yQlvcJvqYGN07OGQyoYvxYEqbhL42XMJaJ+nuvRnyViSIoSPhHE3/BC5vpnei/dVSy0op68BOIMjYk/lCvuQ5WHbWisDULDEykaJlF01y2lZXuu9IymRC2v7B6jzZqYzVK78/l9ncJcpt46wzL2FeR3TWzEG2Yyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Gsmoo4iy; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Gsmoo4iy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722949662; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xKIYgzbnnhxs/xVUtMV2v1idraQUIfCDpI74TOcWG+w=;
	b=Gsmoo4iyIe2rVXd+iS0pHvFBE6YVWpuzMc7/dHjVfHFK+6JzwYBeAD6Rzwlhw99nEoqyG3mQm56zH1HTHIOov+VszociX1LEgEieB7VatdlcV4RF9F00OsHAiqmq43uYNnGQfQT/LDWi7B9KBXUo/hx44Ni1XdMdp+c7LV1mxhA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045220184;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WCFbCQO_1722949661;
Received: from 30.221.130.83(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCFbCQO_1722949661)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 21:07:42 +0800
Message-ID: <9fbf960d-f279-4e31-90f0-0243eeb7298f@linux.alibaba.com>
Date: Tue, 6 Aug 2024 21:07:40 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net/smc: introduce statistics for ringbufs
 usage of net namespace
To: Simon Horman <horms@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
 <20240805090551.80786-3-guwen@linux.alibaba.com>
 <20240806104941.GT2636630@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240806104941.GT2636630@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/6 18:49, Simon Horman wrote:
> On Mon, Aug 05, 2024 at 05:05:51PM +0800, Wen Gu wrote:
>> The buffer size histograms in smc_stats, namely rx/tx_rmbsize, record
>> the sizes of ringbufs for all connections that have ever appeared in
>> the net namespace. They are incremental and we cannot know the actual
>> ringbufs usage from these. So here introduces statistics for current
>> ringbufs usage of existing smc connections in the net namespace into
>> smc_stats, it will be incremented when new connection uses a ringbuf
>> and decremented when the ringbuf is unused.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> 
> ...
> 
>> diff --git a/net/smc/smc_stats.h b/net/smc/smc_stats.h
> 
> ...
> 
>> @@ -135,38 +137,45 @@ do { \
>>   } \
>>   while (0)
>>   
>> -#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _len) \
>> +#define SMC_STAT_RMB_SIZE_SUB(_smc_stats, _tech, k, _is_add, _len) \
>>   do { \
>> +	typeof(_is_add) is_a = (_is_add); \
>>   	typeof(_len) _l = (_len); \
>>   	typeof(_tech) t = (_tech); \
>>   	int _pos; \
>>   	int m = SMC_BUF_MAX - 1; \
>>   	if (_l <= 0) \
>>   		break; \
>> -	_pos = fls((_l - 1) >> 13); \
>> -	_pos = (_pos <= m) ? _pos : m; \
>> -	this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
>> +	if (is_a) { \
>> +		_pos = fls((_l - 1) >> 13); \
>> +		_pos = (_pos <= m) ? _pos : m; \
>> +		this_cpu_inc((*(_smc_stats)).smc[t].k ## _rmbsize.buf[_pos]); \
>> +		this_cpu_add((*(_smc_stats)).smc[t].k ## _rmbuse, _l); \
> 
> Nit:
> 
> I see that due to the construction of the caller, SMC_STAT_RMB_SIZE(),
> it will not occur. But checkpatch warns of possible side effects
> from reuse of _smc_stats.
> 
> As great care seems to have been taken in these macros to avoid such
> problems, even if theoretical, perhaps it is worth doing so here too.
> 
> f.e. A macro-local variable could store (*(_smc_stats)).smc[t] which
>       I think would both resolve the problem mentioned, and make some
>       lines shorter (and maybe easier to read).
> 

It makes sense. I will use a macro-local variable of smc_stats. Thank you!

>> +	} else { \
>> +		this_cpu_sub((*(_smc_stats)).smc[t].k ## _rmbuse, _l); \
>> +	} \
>>   } \
>>   while (0)
>>   
>>   #define SMC_STAT_RMB_SUB(_smc_stats, type, t, key) \
>>   	this_cpu_inc((*(_smc_stats)).smc[t].rmb ## _ ## key.type ## _cnt)
>>   
>> -#define SMC_STAT_RMB_SIZE(_smc, _is_smcd, _is_rx, _len) \
>> +#define SMC_STAT_RMB_SIZE(_smc, _is_smcd, _is_rx, _is_add, _len) \
>>   do { \
>>   	struct net *_net = sock_net(&(_smc)->sk); \
>>   	struct smc_stats __percpu *_smc_stats = _net->smc.smc_stats; \
>> +	typeof(_is_add) is_add = (_is_add); \
>>   	typeof(_is_smcd) is_d = (_is_smcd); \
>>   	typeof(_is_rx) is_r = (_is_rx); \
>>   	typeof(_len) l = (_len); \
>>   	if ((is_d) && (is_r)) \
>> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, rx, l); \
>> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, rx, is_add, l); \
>>   	if ((is_d) && !(is_r)) \
>> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, tx, l); \
>> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_D, tx, is_add, l); \
>>   	if (!(is_d) && (is_r)) \
>> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, rx, l); \
>> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, rx, is_add, l); \
>>   	if (!(is_d) && !(is_r)) \
>> -		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, tx, l); \
>> +		SMC_STAT_RMB_SIZE_SUB(_smc_stats, SMC_TYPE_R, tx, is_add, l); \
>>   } \
>>   while (0)
>>   
>> -- 
>> 2.32.0.3.g01195cf9f
>>
>>
