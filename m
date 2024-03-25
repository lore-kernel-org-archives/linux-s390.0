Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731295A115;
	Mon, 25 Mar 2024 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711336552; cv=none; b=EDp+zClangH9yJvma5brYIcp7FQvp5DRL5DFinb91RJ93LaoQyUVyprxaymNQeALvYzZqmfLhJl7OFY5NXcAKj9lBQrr7M5gJFGlNow74gOMZYHXZga+/9DvElf8HDnMblCoJoYKSHd7djBsprzhBS1px7VkjiZ29vhGfpo+aUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711336552; c=relaxed/simple;
	bh=CbcpjN4HCpiEJ7vCpDTpvBClNCX2tls1gYoUGXWj3x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO+CUTh9KpRhy23FdLLuUFERzda+2acZ3hTrC1z3e8h3eNrDb40UFgEdLeYZdYxXxId7wQm+dO1xGjQZYZ0w+oqFSoFz20ouPxRQQXmaN5Q8E8EtngzynZbWo+N0w+/G1it2SVBLoJfKz1saHsGzTSneobHtSK8UX8ho3By+8pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ym5GYh4d; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ym5GYh4d"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711336547; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=EfUXtxksG1FWduRgoqNQ06QLA8l6Hw09LR3Wsv2BN+8=;
	b=Ym5GYh4dIZVG8JYLOYNrvdyvuvWjyAEcdThW6CQPJWCE2olrFKWFGwKUiC11jUMhq5QeZDfhaPBx4mBzF6JE0NZuF0rLpmltHk1BxuQrwU0FlEbI9RzYoq2X/NSXmy3JmXfwhZgd0OYxqnRXf6oMrTVnnLaLeLMGUkPp+v1E6hw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W38W0RH_1711336545;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0W38W0RH_1711336545)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 11:15:46 +0800
Date: Mon, 25 Mar 2024 11:15:43 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	wenjia@linux.ibm.com, jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH net-next] net/smc: make smc_hash_sk/smc_unhash_sk static
Message-ID: <ZgDsX8-NmJZ1KWfQ@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20240325012501.709009-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325012501.709009-1-shaozhengchao@huawei.com>

On Mon, Mar 25, 2024 at 09:25:01AM +0800, Zhengchao Shao wrote:
> smc_hash_sk and smc_unhash_sk are only used in af_smc.c, so make them
> static and remove the output symbol. They can be called under the path
> .prot->hash()/unhash().
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

This patch's good. The net-next is still closed for now. You can check
here:

	https://patchwork.hopto.org/net-next.html

Tony Lu

> ---
>  include/net/smc.h | 3 ---
>  net/smc/af_smc.c  | 6 ++----
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/smc.h b/include/net/smc.h
> index c9dcb30e3fd9..10684d0a33df 100644
> --- a/include/net/smc.h
> +++ b/include/net/smc.h
> @@ -26,9 +26,6 @@ struct smc_hashinfo {
>  	struct hlist_head ht;
>  };
>  
> -int smc_hash_sk(struct sock *sk);
> -void smc_unhash_sk(struct sock *sk);
> -
>  /* SMCD/ISM device driver interface */
>  struct smcd_dmb {
>  	u64 dmb_tok;
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 4b52b3b159c0..e8dcd28a554c 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -177,7 +177,7 @@ static struct smc_hashinfo smc_v6_hashinfo = {
>  	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
>  };
>  
> -int smc_hash_sk(struct sock *sk)
> +static int smc_hash_sk(struct sock *sk)
>  {
>  	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>  	struct hlist_head *head;
> @@ -191,9 +191,8 @@ int smc_hash_sk(struct sock *sk)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(smc_hash_sk);
>  
> -void smc_unhash_sk(struct sock *sk)
> +static void smc_unhash_sk(struct sock *sk)
>  {
>  	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
>  
> @@ -202,7 +201,6 @@ void smc_unhash_sk(struct sock *sk)
>  		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>  	write_unlock_bh(&h->lock);
>  }
> -EXPORT_SYMBOL_GPL(smc_unhash_sk);
>  
>  /* This will be called before user really release sock_lock. So do the
>   * work which we didn't do because of user hold the sock_lock in the
> -- 
> 2.34.1
