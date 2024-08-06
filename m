Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6461D52B;
	Tue,  6 Aug 2024 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947005; cv=none; b=WLJOfA3j8fNoOPuNuS21cj+Zm7kgHD4FTuMFr3He2p6bags+FPzFn/cRNzyxRlZ2QSRCQL4+J9buPn3zj3jWt3cR+11xQOVa+PcuYmhfuQD8phLCoUya1mxW1i0/5ANjK4PBhjbVjpSoob3gwKPGUnCx5Mxw6lXor7ErkoQjUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947005; c=relaxed/simple;
	bh=iE3v+w7X+H3QuCcpXjbNjpyhJCKEIZz/vtYpJzTQTHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU/jqZhF+5CdWVpIk3WlJCbnmIz1TIKRU0u0PTBS8ROWGtilUQg2sZ8WcSTlvDydnuNAkhEdjPF8wLhIFa8RGuLwTpbkIRDwTNqdVR8o3oza9V0495nJ6ouJEbMu+YMIsI8k+Xw+0+HX7TtvA3s9Q1BmoCaTFcE6bRlkjGkRAKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MJE+gEWQ; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MJE+gEWQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722946993; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PbvzMj1t65Zcd3dfiP3XdKCisD7bYocW3FUMZdTjJfM=;
	b=MJE+gEWQzIqGgyVes3GZ4qZyhozZ/BMlFZzWzNnaUkzG/YKZp7XwP8twxdDzvIcYBP/upGAd0Y7U5VHSfZt/s9NG3AeZNY5f/oYVJo+cSHS87s0/vG2QVOgNugp4pjTAOXtgaC5Ca77DZBsGrXIHYGo6maq6/qOqUOdz4LcqdZk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WCFQHBI_1722946992;
Received: from 30.221.130.83(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCFQHBI_1722946992)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 20:23:13 +0800
Message-ID: <b655fdb9-1d3f-4547-98f3-178ae4027bb3@linux.alibaba.com>
Date: Tue, 6 Aug 2024 20:23:11 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net/smc: introduce statistics for allocated
 ringbufs of link group
To: Simon Horman <horms@kernel.org>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240805090551.80786-1-guwen@linux.alibaba.com>
 <20240805090551.80786-2-guwen@linux.alibaba.com>
 <20240806104925.GS2636630@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240806104925.GS2636630@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/6 18:49, Simon Horman wrote:
> On Mon, Aug 05, 2024 at 05:05:50PM +0800, Wen Gu wrote:
>> Currently we have the statistics on sndbuf/RMB sizes of all connections
>> that have ever been on the link group, namely smc_stats_memsize. However
>> these statistics are incremental and since the ringbufs of link group
>> are allowed to be reused, we cannot know the actual allocated buffers
>> through these. So here introduces the statistic on actual allocated
>> ringbufs of the link group, it will be incremented when a new ringbuf is
>> added into buf_list and decremented when it is deleted from buf_list.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   include/uapi/linux/smc.h |  4 ++++
>>   net/smc/smc_core.c       | 52 ++++++++++++++++++++++++++++++++++++----
>>   net/smc/smc_core.h       |  2 ++
>>   3 files changed, 54 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
>> index b531e3ef011a..d27b8dc50f90 100644
>> --- a/include/uapi/linux/smc.h
>> +++ b/include/uapi/linux/smc.h
>> @@ -127,6 +127,8 @@ enum {
>>   	SMC_NLA_LGR_R_NET_COOKIE,	/* u64 */
>>   	SMC_NLA_LGR_R_PAD,		/* flag */
>>   	SMC_NLA_LGR_R_BUF_TYPE,		/* u8 */
>> +	SMC_NLA_LGR_R_SNDBUF_ALLOC,	/* u64 */
>> +	SMC_NLA_LGR_R_RMB_ALLOC,	/* u64 */
>>   	__SMC_NLA_LGR_R_MAX,
>>   	SMC_NLA_LGR_R_MAX = __SMC_NLA_LGR_R_MAX - 1
>>   };
>> @@ -162,6 +164,8 @@ enum {
>>   	SMC_NLA_LGR_D_V2_COMMON,	/* nest */
>>   	SMC_NLA_LGR_D_EXT_GID,		/* u64 */
>>   	SMC_NLA_LGR_D_PEER_EXT_GID,	/* u64 */
>> +	SMC_NLA_LGR_D_SNDBUF_ALLOC,	/* u64 */
>> +	SMC_NLA_LGR_D_DMB_ALLOC,	/* u64 */
>>   	__SMC_NLA_LGR_D_MAX,
>>   	SMC_NLA_LGR_D_MAX = __SMC_NLA_LGR_D_MAX - 1
>>   };
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index 71fb334d8234..73c7999fc74f 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -221,6 +221,37 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
>>   	write_unlock_bh(&lgr->conns_lock);
>>   }
>>   
>> +/* must be called under lgr->{sndbufs|rmbs} lock */
>> +static inline void smc_lgr_buf_list_add(struct smc_link_group *lgr,
>> +					bool is_rmb,
>> +					struct list_head *buf_list,
>> +					struct smc_buf_desc *buf_desc)
> 
> Please do not use the inline keyword in .c files unless there is a
> demonstrable reason to do so, e.g. performance. Rather, please allow
> the compiler to inline functions as it sees fit.
> 
> The inline keyword in .h files is, of course, fine.
> 

Yes.. I forgot to remove 'inline' when I moved these two helpers
from .h file to .c file. I will fix this in next version.

Thank you!

>> +{
>> +	list_add(&buf_desc->list, buf_list);
>> +	if (is_rmb) {
>> +		lgr->alloc_rmbs += buf_desc->len;
>> +		lgr->alloc_rmbs +=
>> +			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
>> +	} else {
>> +		lgr->alloc_sndbufs += buf_desc->len;
>> +	}
>> +}
>> +
>> +/* must be called under lgr->{sndbufs|rmbs} lock */
>> +static inline void smc_lgr_buf_list_del(struct smc_link_group *lgr,
>> +					bool is_rmb,
>> +					struct smc_buf_desc *buf_desc)
> 
> Ditto.
> 
>> +{
>> +	list_del(&buf_desc->list);
>> +	if (is_rmb) {
>> +		lgr->alloc_rmbs -= buf_desc->len;
>> +		lgr->alloc_rmbs -=
>> +			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
>> +	} else {
>> +		lgr->alloc_sndbufs -= buf_desc->len;
>> +	}
>> +}
>> +
> 
> ...
> 
