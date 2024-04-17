Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC7033CC2;
	Wed, 17 Apr 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340810; cv=none; b=i/q9tm+d8XjhgoLNLlqZpl8hLZaD6grtIVwMSEqWtbQ4EYNkKPSYwXoWGvRAuOFmEJw69aowx7pIQplnbtzq8bzFpsbMoewAdtCrqgYynanoBTqiiUvh/Gyc5zxK2y++rcklajMXf4/VC1fnIpmTquIRWnIGeWR2dbBaDlHlJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340810; c=relaxed/simple;
	bh=1d8Das0aWluPw1yvMOJaa8hAwf+veUsd5fsg+jQfw60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIBuMSkQi4JbxNoQQaFS0ceyo7cTiaSUKO6b7EcE0k0vN26p15qr5rr17wVRpBbiIry7GqCvjk50TC+FW1IqgMiiMYOCQVOhpFQSw2ze8m2M3jUKgZ4NVpUqw9cFhtVW9Hk59XZLHel8Fx3wD2ciDcMsPCpyzZZnAJ+zXt2RQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vNpMyzk5; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vNpMyzk5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713340803; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LUeR/jp3bxeHCiX5tZat99Q/kYEgiO/5uqllP4LX6T4=;
	b=vNpMyzk5G0yxht/1rMyVxFhbD8RanJHbtwtCXwfqNLDCZ5L/uAl8iWkSUi0eDrn2XehqtAVSCiOuiS5kOw0Yh+F0Rfu0cxvbDEnjSQh7WbqioMMhzrjaJuvTg7+PnpwuwzugCz0eeoegSmXw6uLiaxedTgQGg6t1fL73IkEzzBI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W4kiX3p_1713340801;
Received: from 30.221.101.43(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W4kiX3p_1713340801)
          by smtp.aliyun-inc.com;
          Wed, 17 Apr 2024 16:00:02 +0800
Message-ID: <6520c574-e1c6-49e0-8bb1-760032faaf7a@linux.alibaba.com>
Date: Wed, 17 Apr 2024 16:00:01 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix potential sleeping issue in
 smc_switch_conns
To: Zhengchao Shao <shaozhengchao@huawei.com>, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com, weiyongjun1@huawei.com,
 yuehaibing@huawei.com, tangchengchang@huawei.com
References: <20240413035150.3338977-1-shaozhengchao@huawei.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20240413035150.3338977-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/4/13 11:51, Zhengchao Shao wrote:
> Potential sleeping issue exists in the following processes:
> smc_switch_conns
>   spin_lock_bh(&conn->send_lock)
>   smc_switch_link_and_count
>     smcr_link_put
>       __smcr_link_clear
>         smc_lgr_put
>           __smc_lgr_free
>             smc_lgr_free_bufs
>               __smc_lgr_free_bufs
>                 smc_buf_free
>                   smcr_buf_free
>                     smcr_buf_unmap_link
>                       smc_ib_put_memory_region
>                         ib_dereg_mr
>                           ib_dereg_mr_user
>                             mr->device->ops.dereg_mr
> If scheduling exists when the IB driver implements .dereg_mr hook
> function, the bug "scheduling while atomic" will occur. For example,
> cxgb4 and efa driver. Use mutex lock instead of spin lock to fix it.
> 
> Fixes: 20c9398d3309 ("net/smc: Resolve the race between SMC-R link access and clear")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  net/smc/af_smc.c   |  2 +-
>  net/smc/smc.h      |  2 +-
>  net/smc/smc_cdc.c  | 14 +++++++-------
>  net/smc/smc_core.c |  8 ++++----
>  net/smc/smc_tx.c   |  8 ++++----
>  5 files changed, 17 insertions(+), 17 deletions(-)
> 

Hi Zhengchao,

I doubt whether this bug really exists, as efa supports SRD QP while SMC-R relies on RC QP,
cxgb4 is a IWARP adaptor while SMC-R relies on ROCE adaptor.

Thanks,
Guangguan Wang
