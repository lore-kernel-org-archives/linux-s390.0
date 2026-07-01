Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3E43E49B
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919640; cv=none; b=EeAXVnlRXvKyhJaCd6we7t8jmr5q9QlXrqQxX7ABLTVIM9WgfqwHYbFvKxQno+NY3n8cLh9g5NgYb2UIka4oecDFOF8C0W3gtklanlnVDzuvIOPImUR9+OG67IFuYfK4XoFpcTNKnaIKCqccsRI21DRAplDHn29m0/i4Q+N7hPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919640; c=relaxed/simple;
	bh=HYrbqswVMwTk4kuKtL5hvsLl3UN33eSIAa6Clnw68Po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KweYHvhI+uuebBhCQqxURvCQ/H6VDf5XHukCWZUmwUIWXQsEQc5kmd0Ve9yjWQsKLB7A7oGUzz/OmM0z5gW1BEokL6r4Y59mx67UFX9xpaNQQczvQsYaQpHaHYKMurTc051DJsjGZPCH+eiu358qNS2XCJlobkLfqTVUrovzFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNX4/XOX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiIoxfZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNX4/XOX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiIoxfZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782919637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auHUwjD5Zohk1V2S34LD+3/BNdV8kbrNPDmWnQVZGEc=;
	b=WNX4/XOXs+g2OEJiTh3jtK0qqAEVhgHUW5d+A4NwWWOB9nFUk/6RDmswY3IzFoj1YC7Ya8
	7o98bQlrOCrmhCjVBVvp4pFsSaxPgq3F58CDce+6d0sAhR2v7byZsE2Q34HQi/HN6/5eqQ
	3+GR8Xk7lJenA7/QpmeaDmrIGW93p3Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-nmpHEsslPEqCUiTKq90mTQ-1; Wed, 01 Jul 2026 11:27:16 -0400
X-MC-Unique: nmpHEsslPEqCUiTKq90mTQ-1
X-Mimecast-MFC-AGG-ID: nmpHEsslPEqCUiTKq90mTQ_1782919635
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47485fde05aso559947f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 01 Jul 2026 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782919635; x=1783524435; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=auHUwjD5Zohk1V2S34LD+3/BNdV8kbrNPDmWnQVZGEc=;
        b=EiIoxfZ4lh/9INR/6hgveLmGNx7YWbe5NVlWp8IvDO8iR81V/ayYyfsTSPdD85tNO4
         BzdaXuxPtgD7RoYJilDg/naaK3VpDOKqomf51rYfgB0OcAwopCpD9Pd9nOutvP3N5RH1
         aObLch26Bd4SDlSEVmcXN6D++2DH8/yJ+CNSPGKogq4rgAmYaafKd6NDdUjksS+cwtyl
         sa8vnmBlphvg1HIt+q5kW0U27S8pcra0L4qOIBZO8MIWcgaqHbTx6Rifm/VkBPTg0qLm
         Xw7z/tDpohszQzhGpKPf3XzBMESAsA2GG2ZTK3MuKTPOac3ehd6MxCdiKd9iQOyOEcQW
         3t0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782919635; x=1783524435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auHUwjD5Zohk1V2S34LD+3/BNdV8kbrNPDmWnQVZGEc=;
        b=gb6fbVioHbbR8vvbrkMyIsder4rcIjuXIEmEywpb58Fl+0+q8kU3LptMzcmPmOKTth
         1m1QpJIlq9N38gblS+7FlWImwPye8MDgWzUed/qi2WWbBuRfJBaDYweKzZY/4yIxR9VJ
         +GAecbu+3TrMmPOKP6kocGF73vHqACSo7fS9IiszWNyUxw2Qx4+A1rz7uefGafWICOE+
         XLLXrH1NDKdTcV1rBJ9gNauTynTk47Pzvh/rWnJnEdL71j8Fj7m2BHQI058bEyj1v29n
         uzkGR1h7dq2PLk4IPmh4NB20Hebz1/7cIVDVYdgzqf/1P1Km9XJhGvzGuT80T3BYFUu7
         6ANg==
X-Forwarded-Encrypted: i=1; AHgh+RoKK8pX+McVFtU3DmKV22p1Rc6Y9C3YNzp4Z7/G2aV87Rqii7vfiJNcO/d+JEMy7hRm7iNr8GkVij3O@vger.kernel.org
X-Gm-Message-State: AOJu0YzXp7Uj/ej1eV/6dwTaZ1AxG0Miz5bmAVcZp5B9meVm8utA7PYo
	xtvvY7Bi8rOPL3p1nVrprgUEu9c49Ray3QbZLviP5/L588ioPi277/jcIhOiVOXc0gr501WY57X
	CFiL2DGFkNgoiCG21FjYxQ2LWf+G/DueKgQAX0dunr8DoOBCGmfa2D1fOMA1IgtI=
X-Gm-Gg: AfdE7cmmUzT6fvcTtrvPaPj0yMpUE5iCBnESc9i32mKnxf4lB0k8uVLuM4vKqlUmMgO
	EThtCXFOdbtfivTw386cmKXvkdk1dlrJ9peavOPbk1lcUmWka+FTDVG7Wcld8rwY3RzlvrLmAFx
	f39dpga+QmHLScnJ16kRgc/jfadyrzQtX5BCWlT54uqtTwBJBxXyJ+8xA8Lnzz25xM5TPo1wZnD
	WG6ggqtoIIX0xB23kxbNRj9OW8Yxyg9y6AOeHjZvjy0ZILiEnpcOsXrHo1FCsI9iCIqbTYz1QXW
	NqdHZ7A0Thh4UhteGbLdTtL0yFxrtIjDfV/f0GaIzUsYBDATEggnGxSNC1attBlNxLbvg9KJFI1
	NqGpN40Rmd+g3TD3Q7zfAp6TNUK0QkKaipQJ//ZI+WYTxs4FhFTlPvfSOdRNlYkjTm4lrXYonbR
	cMBubBVATqzw==
X-Received: by 2002:a05:6000:186f:b0:475:cd6f:720a with SMTP id ffacd0b85a97d-477571cb959mr3680958f8f.1.1782919635222;
        Wed, 01 Jul 2026 08:27:15 -0700 (PDT)
X-Received: by 2002:a05:6000:186f:b0:475:cd6f:720a with SMTP id ffacd0b85a97d-477571cb959mr3680896f8f.1.1782919634784;
        Wed, 01 Jul 2026 08:27:14 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dd94ce4csm706993f8f.17.2026.07.01.08.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 08:27:13 -0700 (PDT)
Message-ID: <c222390f-96c7-4dc3-8f33-f4dd277c3639@redhat.com>
Date: Wed, 1 Jul 2026 17:27:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net/smc: fix out-of-bounds read when sk_user_data
 holds a sk_psock
To: Sechang Lim <rhkrqnwk98@gmail.com>, "D . Wythe"
 <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 Simon Horman <horms@kernel.org>, Karsten Graul <kgraul@linux.ibm.com>,
 Guvenc Gulce <guvenc@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260629095140.679754-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/29/26 11:51 AM, Sechang Lim wrote:
> A passive-open child inherits the listener's smc_clcsock_data_ready().
> sk_clone_lock() clears its sk_user_data to NULL because the listener tagged
> it SK_USER_DATA_NOCOPY. Until accept restores the callback, a BPF sock_ops
> program can add the established child to a sockmap, and sk_psock_init()
> installs a sk_psock into the NULL sk_user_data. The inherited callback then
> reads it back through smc_clcsock_user_data(), which strips only NOCOPY,
> takes the sk_psock for an smc_sock, and dereferences a clcsk_* field past
> its end:
> 
>   BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>   Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
>    <IRQ>
>    smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>    tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
>    tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>    tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
>    [...]
>    </IRQ>
> 
>   Allocated by task 67930:
>    sk_psock_init+0x142/0x740 net/core/skmsg.c:766
>    sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
>    bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
>    __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
>    tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
>    [...]
> 
> Resolve the conflict on the write path. Reserve the child's sk_user_data
> with a NULL pointer tagged SK_USER_DATA_NOCOPY so sk_psock_init() returns
> -EBUSY, and release it at accept. smc_clcsock_user_data() still strips the
> tag to NULL, so the inherited callback stays a no-op.
> 
> Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v3:
>  - reserve sk_user_data on the write path instead of the read-side check (D. Wythe)
> 
> v2:
>  - https://lore.kernel.org/netdev/20260619150342.3626224-1-rhkrqnwk98@gmail.com/
> 
> v1:
>  - https://lore.kernel.org/netdev/20260614120931.4041687-1-rhkrqnwk98@gmail.com/
> 
>  net/smc/af_smc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index b5db69073e20..78f162344fe3 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -154,7 +154,11 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  					       own_req, opt_child_init);
>  	/* child must not inherit smc or its ops */
>  	if (child) {
> -		rcu_assign_sk_user_data(child, NULL);
> +		/* reserve sk_user_data so sockmap cannot claim the slot */
> +		write_lock_bh(&child->sk_callback_lock);
> +		__rcu_assign_sk_user_data_with_flags(child, NULL,
> +						     SK_USER_DATA_NOCOPY);
> +		write_unlock_bh(&child->sk_callback_lock);
>  
>  		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
>  		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
> @@ -1773,6 +1777,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
>  	/* new clcsock has inherited the smc listen-specific sk_data_ready
>  	 * function; switch it back to the original sk_data_ready function
>  	 */
> +	write_lock_bh(&new_clcsock->sk->sk_callback_lock);
>  	new_clcsock->sk->sk_data_ready = lsmc->clcsk_data_ready;
>  
>  	/* if new clcsock has also inherited the fallback-specific callback
> @@ -1786,6 +1791,9 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
>  		if (lsmc->clcsk_error_report)
>  			new_clcsock->sk->sk_error_report = lsmc->clcsk_error_report;
>  	}
> +	/* release the slot reserved in smc_tcp_syn_recv_sock() */
> +	rcu_assign_sk_user_data(new_clcsock->sk, NULL);
> +	write_unlock_bh(&new_clcsock->sk->sk_callback_lock);

Sashiko reports that this still cause problem on fallback.

@Wythe, I understand from previous discussion that you would prefer to
address such issues separately (and thus you are fine with the patch in
the current form). Could you please confirm?

/P
>  
>  	(*new_smc)->clcsock = new_clcsock;
>  out:

