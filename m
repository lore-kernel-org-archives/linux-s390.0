Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88066EB41;
	Wed, 17 Apr 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342603; cv=none; b=uRlpESvHXWP61J90AcfNzB4PIyUsUwz4hLL179plPwm/m0tv/Y4p+S7gZsPaX8Lh2ZRrrwGgXDyZH1s75tIf9dbCjvm7KGXnbnPmw9hl1yA4ThCtFJdZ3FYx2vNSsvStEyHsfelxx8QorV00LQhFBvCn6Y/8voL1CBDkFqRlRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342603; c=relaxed/simple;
	bh=EfYL9cZU7RrxQ7DUbJyJ74A6qUdlrFq+rgm3gzhCbhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5+hLbfAahktkiuaj19mXd9B5h9NVwjm//WsHjsIk+baMLfGYcNDEWzyN315uK2Sg6i0+rVPbCmFipweyZRHtP9+l3ha5fxkHFyIwYBMQN/h8Kn4xOUDsf+7Civ9hJJvOmePbUexr+ZjANDwQdOPM5mnRX1OH+2uQTBtFtkJtek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VKDXn2gC1ztQb5;
	Wed, 17 Apr 2024 16:27:05 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id C9ED2140447;
	Wed, 17 Apr 2024 16:29:57 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:29:57 +0800
Message-ID: <ed5f3665-43ae-cbab-b397-c97c922d26eb@huawei.com>
Date: Wed, 17 Apr 2024 16:29:56 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	<linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<tangchengchang@huawei.com>
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
 <6520c574-e1c6-49e0-8bb1-760032faaf7a@linux.alibaba.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <6520c574-e1c6-49e0-8bb1-760032faaf7a@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)


Hi Guangguan:
   Thank you for your review. When I used the hns driver, I ran into the
problem of "scheduling while atomic". But the problem was tested on the
5.10 kernel branch, and I'm still trying to reproduce it using the
mainline.

Zhengchao Shao

On 2024/4/17 16:00, Guangguan Wang wrote:
> 
> 
> On 2024/4/13 11:51, Zhengchao Shao wrote:
>> Potential sleeping issue exists in the following processes:
>> smc_switch_conns
>>    spin_lock_bh(&conn->send_lock)
>>    smc_switch_link_and_count
>>      smcr_link_put
>>        __smcr_link_clear
>>          smc_lgr_put
>>            __smc_lgr_free
>>              smc_lgr_free_bufs
>>                __smc_lgr_free_bufs
>>                  smc_buf_free
>>                    smcr_buf_free
>>                      smcr_buf_unmap_link
>>                        smc_ib_put_memory_region
>>                          ib_dereg_mr
>>                            ib_dereg_mr_user
>>                              mr->device->ops.dereg_mr
>> If scheduling exists when the IB driver implements .dereg_mr hook
>> function, the bug "scheduling while atomic" will occur. For example,
>> cxgb4 and efa driver. Use mutex lock instead of spin lock to fix it.
>>
>> Fixes: 20c9398d3309 ("net/smc: Resolve the race between SMC-R link access and clear")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   net/smc/af_smc.c   |  2 +-
>>   net/smc/smc.h      |  2 +-
>>   net/smc/smc_cdc.c  | 14 +++++++-------
>>   net/smc/smc_core.c |  8 ++++----
>>   net/smc/smc_tx.c   |  8 ++++----
>>   5 files changed, 17 insertions(+), 17 deletions(-)
>>
> 
> Hi Zhengchao,
> 
> I doubt whether this bug really exists, as efa supports SRD QP while SMC-R relies on RC QP,
> cxgb4 is a IWARP adaptor while SMC-R relies on ROCE adaptor.
> 
> Thanks,
> Guangguan Wang
