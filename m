Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EA42A93;
	Wed, 17 Apr 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339133; cv=none; b=YQsMd/Y6d9B6Nw1fnIjUSSnqeIQEUyPMNQOgQRfTZ6cv/a87wGLhYugUQ7blcfLNa5Us4vyX5mf8L3g8kFaHmNg3c3iyF9tkJdJKTby9Mo/r9rAMVCaIguxIaAlHrIhd6jbZlDHORbiHVlgjdQC0pmXed89ulrXmkU0Jb3TMalE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339133; c=relaxed/simple;
	bh=EVw/Ed5zPAVSDnFiWaniJiOl38I+q/uv8b6G8VpZDRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIX3WT6qGbTssFw8Ek3wD0qsyiG3RDnYktSZ7Cfe5w9JFJt7xdgeV1/mGHLkhBOInykkN2jW/AlzDZsJyRoj5ztHmoT662Qf2FtWJ+DP1snvvRu+IDQNpXuGW469TbR/gqIbQGomY88QSW5s08WkY2HS/UmuVbVQoYpwf5WfUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F/Y1k1w5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F/Y1k1w5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713339128; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xLo8OYi1UoX+I4QYqt1VXA9tqhdb6DaD+9+18rKvBOo=;
	b=F/Y1k1w5wtGeioZ0h3fyfAXddrfiDODOnBdWPknlXyTdqNWXIAY+CM2gspAyckRyAfKOFhhvXPm8tr4LOr9aXKog7B+crnI62Ck6+UEC6ZU4gDNB8mDJo6KWqvWRRbh4OVQfin+w6Qvf4bTVO2qtsYWuq9wroxrojpmWVXFJ5yQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W4kf6IF_1713339126;
Received: from 30.221.101.43(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W4kf6IF_1713339126)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 15:32:07 +0800
Message-ID: <a94de96f-8b18-482c-90e2-7f8584528bc8@linux.alibaba.com>
Date: Wed, 17 Apr 2024 15:32:05 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
To: Paolo Abeni <pabeni@redhat.com>, Zhengchao Shao <shaozhengchao@huawei.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com, tangchengchang@huawei.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
 <b2573ccf2340a19b6cb039dac639b2d431c1404c.camel@redhat.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <b2573ccf2340a19b6cb039dac639b2d431c1404c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/4/16 20:06, Paolo Abeni wrote:
> On Sat, 2024-04-13 at 11:51 +0800, Zhengchao Shao wrote:
>> Potential sleeping issue exists in the following processes:
>> smc_switch_conns
>>   spin_lock_bh(&conn->send_lock)
>>   smc_switch_link_and_count
>>     smcr_link_put
>>       __smcr_link_clear
>>         smc_lgr_put
>>           __smc_lgr_free
>>             smc_lgr_free_bufs
>>               __smc_lgr_free_bufs
>>                 smc_buf_free
>>                   smcr_buf_free
>>                     smcr_buf_unmap_link
>>                       smc_ib_put_memory_region
>>                         ib_dereg_mr
>>                           ib_dereg_mr_user
>>                             mr->device->ops.dereg_mr
>> If scheduling exists when the IB driver implements .dereg_mr hook
>> function, the bug "scheduling while atomic" will occur. For example,
>> cxgb4 and efa driver. Use mutex lock instead of spin lock to fix it.
> 
> I tried to inspect all the lock call sites, and it *look* like they are
> all in process context, so the switch should be feasible.

There exist some calls from tasklet, where mutex lock is infeasible.
For example:
- tasklet -> smc_wr_tx_tasklet_fn -> smc_wr_tx_process_cqe -> pnd_snd.handler -> smc_cdc_tx_handler -> smc_tx_pending -> smc_tx_sndbuf_nonempty -> smcr_tx_sndbuf_nonempty -> spin_lock_bh(&conn->send_lock)
- tasklet -> smc_wr_rx_tasklet_fn -> smc_wr_rx_process_cqes -> smc_wr_rx_demultiplex -> smc_cdc_rx_handler -> smc_cdc_msg_validate -> spin_lock_bh(&conn->send_lock)

Thanks,
Guangguan Wang

> 
> Still the fact that the existing lock is a BH variant is suspect.
> Either the BH part was not needed or this can introduce subtle
> regressions/issues. 
> 
> I think this deserves at least a 3rd party testing.
> 
> Thanks,
> 
> Paolo
> 
