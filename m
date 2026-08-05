Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A56346A08;
	Wed,  5 Aug 2026 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914534; cv=none; b=RWaIxR53CSd8mc07wg41ol+9FCerPwksxaFaBvTfeKaow1NtOYfbaxCWlr8rD2zo5feet6tukHBLvi1ZQkcRydRngv1YPdtzxXlifp6JY4JHvevctZh0Ql8eYxEGlKWBOM/OTpCYGy/knFQ6lb4dluKUurBHCCl9s6FVkHP+K+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914534; c=relaxed/simple;
	bh=FRdNx5IAXzXghrX/dVqH2H7AbQFNzww4al8VmIJX3K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzVeDujLUcRpPwrKyoWr1BmU7I2ZnRf4D1WbAZYclsqRDAiVyyI9FC4ZGEPVZXYrZMNOekBBmmrmnXv5SJo7wC/nlxMxx8iA+DA8yWqnXYPXN9H/3GQYTPy00G9nODJgdzeUmQQ4+v7b9KUPFm3p5QUXmG4y1DY9YLQYAvsL7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TPqaT8pg; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TPqaT8pg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785914521; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=GroARTyECo8LN2LV8UcS/X7hR39mEv3NBDHecVCSQks=;
	b=TPqaT8pgL0K+zTbM2sGwJcZDQCqvHV934yy/kj1icOR0kNjqIz0jE/tj5a+T3wdhRzx7dVFdc7zyyF4wOw/l1WYhW8Z6qDjU2N5547+uht2QmXwCTN/BJqhBdflVJuXwu2pug7fkSKs1OCzKXsvSfP+LBm64EAxwEZuXQdiFwB4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R691e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0X8QRDav_1785914520;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0X8QRDav_1785914520 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Aug 2026 15:22:00 +0800
Date: Wed, 5 Aug 2026 15:21:59 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Sidraya Jayagond <sidraya@linux.ibm.com>,
	Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com, horms@kernel.org,
	mjambigi@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, hidayath@linux.ibm.com,
	pasic@linux.ibm.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix TOCTOU race between smc_listen_out()
 and listener close
Message-ID: <anLkl5X2xYedflyt@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20260803070701.126339-1-sidraya@linux.ibm.com>
 <anCPZl_Rvqj2B7vI@gmail.com>
 <4157b86a-e2cb-470b-a526-137a650b9d5a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4157b86a-e2cb-470b-a526-137a650b9d5a@linux.ibm.com>

On 2026-08-04 12:52:12, Sidraya Jayagond wrote:
>
>
>On 03/08/26 6:24 pm, Breno Leitao wrote:
>>> @@ -1931,11 +1931,12 @@ static void smc_listen_out(struct smc_sock *new_smc)
>>>  		atomic_dec(&lsmc->queued_smc_hs);
>>>  
>>>  	release_sock(newsmcsk); /* lock in smc_listen_work() */
>>> +	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>>>  	if (lsmc->sk.sk_state == SMC_LISTEN) {
>>> -		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
>>>  		smc_accept_enqueue(&lsmc->sk, newsmcsk);
>>>  		release_sock(&lsmc->sk);
>>>  	} else { /* no longer listening */
>>> +		release_sock(&lsmc->sk);
>>>  		smc_close_non_accepted(newsmcsk);
>>>  	}
>> 
>> Do you need to call smc_close_non_accepted() without the lock? otherwise
>> you can have the lock around the whole if/else clause.
>
>Yes, smc_close_non_accepted() calls __smc_release() in turn calls
>smc_close_active(), which in the SMC_ACTIVE case hits
>smc_close_stream_wait() a blocking wait that can sleep up to
>SMC_MAX_STREAM_WAIT_TIMEOUT (2 minutes). Holding the listener lock
>across that would stall any concurrent smc_accept(), smc_listen_out(),
>or smc_release() on the listener for the same duration.
>
>The release_sock() is intentionally placed before
>smc_close_non_accepted() to keep the critical section minimal:
>lock
>  check state
>    enqueue or not
>      unlock
>        then do the slow close work without the listener lock held.


That patch looks good to me.

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>


Two corrections to the justification though:

1. This newsmcsk sock have never been given to userspace, so
   smc_close_stream_wait() should return immediately. I think the stronger
   argument for keeping smc_close_non_accepted() outside the listener
   lock is what follows in smc_close_active()/__smc_release():
   smc_close_final() can wait up to SMC_WR_TX_WAIT_FREE_SLOT_TIME (10s)
   for a WR slot, and smc_clcsock_release() tears down the TCP
   socket.

2. SMC_MAX_STREAM_WAIT_TIMEOUT is 2 * HZ, i.e. 2 seconds, not 2 minutes.


Best regards,
Dust
