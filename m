Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E893614A0B2;
	Mon, 25 Mar 2024 02:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332995; cv=none; b=AEB1tRDep8EPJ+vMZ5lxrCrcEOb4UOlFcn8qtbxiD/+HFSYoUcpk+TJdhS8CNeHIHWc7b76f1GdpkLP/Zg8tCBzZMTk6nYiJURLf1Xai5k8gjInfKL0q7GDuq2/P5n3ycDZSqggEEdwOGMkPDHWhANBb+oiO6Aq+2l5grpvmICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332995; c=relaxed/simple;
	bh=VR4eOEFW5ShmHL6/Vr0s9GQA6Het597iqJLSVzfADdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7+716dqTcmFCT5++2zdHp8GufeuQj2AwPVMcCZnQ6Vjr70NuZDsGyFwYzIEPbe8pr9g2icrROUM/vMjEnLcakXpPPRwE1s0KTdcNf9FVbuw73Hhl3A2qwOvjwWwU14CH0p6BvAYqvmmkMreUGYfRZEE6rtbTlGsEhqV9QYE4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hFGNiORE; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hFGNiORE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711332990; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MkXYrKlmDfjBL44cw5UVxBAr7/tz8PrihVky5B6BZsc=;
	b=hFGNiOREjoYx3RxLx7cnAWhzzaN5tp/gsIrHMZ91ebhioO4FyczeQm/BCJ6+N6R+OztTS7DA7T8EZ5QPqCUkp48jJd7HtltAcnZeUUnK7n1jKI7sBl4z7CaDU9O4jx0dT+J1GTyCfx3TIkoBIR/IL3Os7v0ENsjklpSiIvLZ9NY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W389BL6_1711332988;
Received: from 30.221.130.215(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W389BL6_1711332988)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 10:16:30 +0800
Message-ID: <535bcbb8-c446-458b-b7d4-c13201537ad5@linux.alibaba.com>
Date: Mon, 25 Mar 2024 10:16:28 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/smc: make smc_hash_sk/smc_unhash_sk static
To: Zhengchao Shao <shaozhengchao@huawei.com>, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
References: <20240325012501.709009-1-shaozhengchao@huawei.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20240325012501.709009-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/3/25 09:25, Zhengchao Shao wrote:
> smc_hash_sk and smc_unhash_sk are only used in af_smc.c, so make them
> static and remove the output symbol. They can be called under the path
> .prot->hash()/unhash().
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

LGTM, Thank you!

Reviewed-by: Wen Gu <guwen@linux.alibaba.com>

> ---
>   include/net/smc.h | 3 ---
>   net/smc/af_smc.c  | 6 ++----
>   2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/smc.h b/include/net/smc.h
> index c9dcb30e3fd9..10684d0a33df 100644
> --- a/include/net/smc.h
> +++ b/include/net/smc.h
> @@ -26,9 +26,6 @@ struct smc_hashinfo {
>   	struct hlist_head ht;
>   };
>   
> -int smc_hash_sk(struct sock *sk);
> -void smc_unhash_sk(struct sock *sk);
> -
>   /* SMCD/ISM device driver interface */
>   struct smcd_dmb {
>   	u64 dmb_tok;
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 4b52b3b159c0..e8dcd28a554c 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -177,7 +177,7 @@ static struct smc_hashinfo smc_v6_hashinfo = {
>   	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
>   };
>   
> -int smc_hash_sk(struct sock *sk)
> +static int smc_hash_sk(struct sock *sk)
>   {
>   	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>   	struct hlist_head *head;
> @@ -191,9 +191,8 @@ int smc_hash_sk(struct sock *sk)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(smc_hash_sk);
>   
> -void smc_unhash_sk(struct sock *sk)
> +static void smc_unhash_sk(struct sock *sk)
>   {
>   	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>   
> @@ -202,7 +201,6 @@ void smc_unhash_sk(struct sock *sk)
>   		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>   	write_unlock_bh(&h->lock);
>   }
> -EXPORT_SYMBOL_GPL(smc_unhash_sk);
>   
>   /* This will be called before user really release sock_lock. So do the
>    * work which we didn't do because of user hold the sock_lock in the
