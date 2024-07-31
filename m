Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFA8161311;
	Wed, 31 Jul 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722421960; cv=none; b=nI+46LU5p0Q91r2W6L5t0J7iANZnanjMWVAB5QvUNvZZXRSCoPY3xcDFFfCdWjvlbATOGObIp4yYdpx2l3DKnrBHNj3lUVtPWP+xot86T2cYLXOsA8mD5pzMTr6MSVsgXeCC+oHc2veCREHcSkh7ByC1LdQxHIvheMCI6MLnwdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722421960; c=relaxed/simple;
	bh=dUhvKnefzAJf8BMqcx0kLvWGGyMJGELwZE3cmzTeerQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QKuJeajRfJvH7IyzmUmsBApSmMc6ylwext0tALJNx40DU+mPn5JXPYaw3xcAYnpwXFJStQOaSyg8B140rWLWJQ8fBtrkZlS9fOQ/c4m8yiMvHSfBmt4KG5Y94dgdet0r9kiXKTbd3aTB1++YGl125keWUrGGppqv56rKISuWZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYpFM5fZKzyPJk;
	Wed, 31 Jul 2024 18:27:35 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 21D06140427;
	Wed, 31 Jul 2024 18:32:34 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 18:32:33 +0800
Message-ID: <ef374ef8-a19e-7b9b-67a1-5b89fb505545@huawei.com>
Date: Wed, 31 Jul 2024 18:32:18 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] net/smc: delete buf_desc from buffer list under lock
 protection
To: Wen Gu <guwen@linux.alibaba.com>, <wenjia@linux.ibm.com>,
	<jaka@linux.ibm.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
	<linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240731093102.130154-1-guwen@linux.alibaba.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20240731093102.130154-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)

Hi Wen Gu:
   "The operations to link group buffer list should be protected by
sndbufs_lock or rmbs_lock" It seems that the logic is smooth. But will
this really happen? Because no process is in use with the link group,
does this mean that there is no concurrent scenario?

Thank you

Zhengchao Shao

On 2024/7/31 17:31, Wen Gu wrote:
> The operations to link group buffer list should be protected by
> sndbufs_lock or rmbs_lock. So fix it.
> 
> Fixes: 3e034725c0d8 ("net/smc: common functions for RMBs and send buffers")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_core.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index 3b95828d9976..ecfea8c38da9 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -1368,18 +1368,24 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
>   {
>   	struct smc_buf_desc *buf_desc, *bf_desc;
>   	struct list_head *buf_list;
> +	struct rw_semaphore *lock;
>   	int i;
>   
>   	for (i = 0; i < SMC_RMBE_SIZES; i++) {
> -		if (is_rmb)
> +		if (is_rmb) {
>   			buf_list = &lgr->rmbs[i];
> -		else
> +			lock = &lgr->rmbs_lock;
> +		} else {
>   			buf_list = &lgr->sndbufs[i];
> +			lock = &lgr->sndbufs_lock;
> +		}
> +		down_write(lock);
>   		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
>   					 list) {
>   			list_del(&buf_desc->list);
>   			smc_buf_free(lgr, is_rmb, buf_desc);
>   		}
> +		up_write(lock);
>   	}
>   }
>   
