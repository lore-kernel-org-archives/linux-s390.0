Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7C1C3F0A;
	Tue,  6 Aug 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722945284; cv=none; b=rLcxy7bvvMpSz04t3cc3HKIIpcWuIXQBfS5Qddb0wBEM1RYSGI2/8Iqt0FsBlJSjK71wiPTQvXQT7qphlje2fvi+Enskp4bJp9hFHN9Nu3DB9Q0J5FLQdFBVfoJpfx66NSSVmbnVT+ugCzDg1N/JiVqIUPNGZQ49IDk2DSlpWuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722945284; c=relaxed/simple;
	bh=dquRSj8dAi0AZNSeqY2lTiBuPiyyqF1+OZZfO1v8Y0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2dr9CG6Yrf3Gyup/5Mu+jzJ+cUVsOhpo4FwAPHtR0fQw2KCZ4/+uXWnNbKB67qy2JN8movw0KeNPMJEGC+TWmfU6KqLgq0NvlSJZZMG7RAZbXWM9fkv4JVkMn3U3keT/oTTymBP4Q+BZNgzJwCCfRGf58MgB7NatW8UYiTj68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z64vy3w5; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z64vy3w5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722945272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mb7gDxmMrOdd2M6qXCPPv/5QA47O1I0MfjtzHviLEmU=;
	b=Z64vy3w52ZmiH6/CPmk3pR2lhxfx5qTMGmnnoBiGnnKX5iEooSWocZGFFRCYeTtUQQe4++YobwRqjH8i+0CHiwM6HEoqvmRWwXhKH1QX11Hrmo6nBoHW9b3vQZL7J2dL9qqrUP3E/lF4IrPT41RTf0yCFXgO6UoBXkWbkdR9CKQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WCFQqrm_1722945271;
Received: from 30.221.130.83(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCFQqrm_1722945271)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 19:54:32 +0800
Message-ID: <d1650ea2-da51-41bd-8032-491d03a8df3d@linux.alibaba.com>
Date: Tue, 6 Aug 2024 19:54:30 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] net/smc: introduce ringbufs usage statistics
To: shaozhengchao <shaozhengchao@huawei.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
 <7f2decb7-3f32-1501-91db-c6b0da6baf37@huawei.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <7f2decb7-3f32-1501-91db-c6b0da6baf37@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/8/6 11:52, shaozhengchao wrote:
> Hi Wen Gu:
>     Your patchset looks fine. However, the current smc-tools tool is not
> supported, so will you update the smc-tools tool?
> 
> Thank you
> 
> Zhengchao Shao
> 

Hi, Zhengchao.

Yes, after these kernel patches are merged, I will submit the corresponding
modification to smc-tools.

Thanks!

> On 2024/8/5 17:05, Wen Gu wrote:
>> Currently, we have histograms that show the sizes of ringbufs that ever
>> used by SMC connections. However, they are always incremental and since
>> SMC allows the reuse of ringbufs, we cannot know the actual amount of
>> ringbufs being allocated or actively used.
>>
>> So this patch set introduces statistics for the amount of ringbufs that
>> actually allocated by link group and actively used by connections of a
>> certain net namespace, so that we can react based on these memory usage
>> information, e.g. active fallback to TCP.
>>
>> With appropriate adaptations of smc-tools, we can obtain these ringbufs
>> usage information:
>>
>> $ smcr -d linkgroup
>> LG-ID    : 00000500
>> LG-Role  : SERV
>> LG-Type  : ASYML
>> VLAN     : 0
>> PNET-ID  :
>> Version  : 1
>> Conns    : 0
>> Sndbuf   : 12910592 B    <-
>> RMB      : 12910592 B    <-
>>
>> or
>>
>> $ smcr -d stats
>> [...]
>> RX Stats
>>    Data transmitted (Bytes)      869225943 (869.2M)
>>    Total requests                 18494479
>>    Buffer usage  (Bytes)          12910592 (12.31M)  <-
>>    [...]
>>
>> TX Stats
>>    Data transmitted (Bytes)    12760884405 (12.76G)
>>    Total requests                 36988338
>>    Buffer usage  (Bytes)          12910592 (12.31M)  <-
>>    [...]
>> [...]
>>
>> Wen Gu (2):
>>    net/smc: introduce statistics for allocated ringbufs of link group
>>    net/smc: introduce statistics for ringbufs usage of net namespace
>>
>>   include/uapi/linux/smc.h |  6 ++++
>>   net/smc/smc_core.c       | 74 ++++++++++++++++++++++++++++++++++------
>>   net/smc/smc_core.h       |  2 ++
>>   net/smc/smc_stats.c      |  8 +++++
>>   net/smc/smc_stats.h      | 27 ++++++++++-----
>>   5 files changed, 97 insertions(+), 20 deletions(-)
>>
