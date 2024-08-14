Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670D679D2;
	Wed, 14 Aug 2024 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641114; cv=none; b=YCqed1+xDfTL7k4pmi6XOOdSOSZHlyNcc9ihTseI4CvXUoeG+a5ZqJOVkq3K8XyIZlNq2NM5K3yHP4G8iojRjdWsqeDmhrKesli3vpmqoWxttvQXOIP3nB8lAM8+GmK5l6khsu1o9SRFaTSe9E9sHMC7Wj5R5pNhEdFxHh7GBh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641114; c=relaxed/simple;
	bh=sXKfyRW/bbUdXqvy1nBiAljMCPznDd1/ncx/XW4psWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6nOcD2teHj1+ihX/APoRl7Y7A7pwJEr8sAjLZUJdbIBTCTVgEAEtKoWHBHf+w9ped4m8WPG+jdGITMj7immtnNTzonGu9fKD1yLNMF6jhtioWudcoAUT1Y52RkVRgzTd9Jx2sjzEoHkOUwJLvBVlWB7DA6QdoF0eodrCuu6Qa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BNP4VepI; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BNP4VepI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723641108; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=MJxfdv6IGm1spoOm9lhqUgWbinvAVNUc+DfFSJSCxcg=;
	b=BNP4VepILGSbZjPAet1Vikc+iNDHF1fJtt6wzGJH+V5HAFyAHKppoHS0dRrla4tzitaVcIpmDLpuhEgCmnu2W7JaXwM8qeOASTX4QVtHSXywiQDZXysWo85hZNmgf0p79lWPfdUsCdHpxAJFC3KdTItjg2NsVF0QRycpaZ80W2o=
Received: from 192.168.50.173(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCt0vzC_1723641107)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 21:11:48 +0800
Message-ID: <e2d56814-0664-4c3a-9d5f-3f32dc15ccd4@linux.alibaba.com>
Date: Wed, 14 Aug 2024 21:11:46 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v4] net/smc: prevent NULL pointer dereference in
 txopt_get
To: Jeongjun Park <aha310510@gmail.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 gbayer@linux.ibm.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dust.li@linux.alibaba.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240814104910.243859-1-aha310510@gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240814104910.243859-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/24 6:49 PM, Jeongjun Park wrote:
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.
>
> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
>
> To solve this, we need to add smc6_sock structure, initialize
> .ipv6_pinfo_offset, and modify smc_sock structure.
>
> [  278.629552][T28696] ==================================================================
> [  278.631367][T28696] BUG: KASAN: null-ptr-deref in txopt_get+0x102/0x430
> [  278.632724][T28696] Read of size 4 at addr 0000000000000200 by task syz.0.2965/28696
> [  278.634802][T28696]
> [  278.635236][T28696] CPU: 0 UID: 0 PID: 28696 Comm: syz.0.2965 Not tainted 6.11.0-rc2 #3
> [  278.637458][T28696] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [  278.639426][T28696] Call Trace:
> [  278.639833][T28696]  <TASK>
> [  278.640190][T28696]  dump_stack_lvl+0x116/0x1b0
> [  278.640844][T28696]  ? txopt_get+0x102/0x430
> [  278.641620][T28696]  kasan_report+0xbd/0xf0
> [  278.642440][T28696]  ? txopt_get+0x102/0x430
> [  278.643291][T28696]  kasan_check_range+0xf4/0x1a0
> [  278.644163][T28696]  txopt_get+0x102/0x430
> [  278.644940][T28696]  ? __pfx_txopt_get+0x10/0x10
> [  278.645877][T28696]  ? selinux_netlbl_socket_setsockopt+0x1d0/0x420
> [  278.646972][T28696]  calipso_sock_getattr+0xc6/0x3e0
> [  278.647630][T28696]  calipso_sock_getattr+0x4b/0x80
> [  278.648349][T28696]  netlbl_sock_getattr+0x63/0xc0
> [  278.649318][T28696]  selinux_netlbl_socket_setsockopt+0x1db/0x420
> [  278.650471][T28696]  ? __pfx_selinux_netlbl_socket_setsockopt+0x10/0x10
> [  278.652217][T28696]  ? find_held_lock+0x2d/0x120
> [  278.652231][T28696]  selinux_socket_setsockopt+0x66/0x90
> [  278.652247][T28696]  security_socket_setsockopt+0x57/0xb0
> [  278.652278][T28696]  do_sock_setsockopt+0xf2/0x480
> [  278.652289][T28696]  ? __pfx_do_sock_setsockopt+0x10/0x10
> [  278.652298][T28696]  ? __fget_files+0x24b/0x4a0
> [  278.652308][T28696]  ? __fget_light+0x177/0x210
> [  278.652316][T28696]  __sys_setsockopt+0x1a6/0x270
> [  278.652328][T28696]  ? __pfx___sys_setsockopt+0x10/0x10
> [  278.661787][T28696]  ? xfd_validate_state+0x5d/0x180
> [  278.662821][T28696]  __x64_sys_setsockopt+0xbd/0x160
> [  278.663719][T28696]  ? lockdep_hardirqs_on+0x7c/0x110
> [  278.664690][T28696]  do_syscall_64+0xcb/0x250
> [  278.665507][T28696]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  278.666618][T28696] RIP: 0033:0x7fe87ed9712d
> [  278.667236][T28696] Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8
> ff ff ff f7 d8 64 89 01 48
> [  278.670801][T28696] RSP: 002b:00007fe87faa4fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
> [  278.671832][T28696] RAX: ffffffffffffffda RBX: 00007fe87ef35f80 RCX: 00007fe87ed9712d
> [  278.672806][T28696] RDX: 0000000000000036 RSI: 0000000000000029 RDI: 0000000000000003
> [  278.674263][T28696] RBP: 00007fe87ee1bd8a R08: 0000000000000018 R09: 0000000000000000
> [  278.675967][T28696] R10: 0000000020000000 R11: 0000000000000246 R12: 0000000000000000
> [  278.677953][T28696] R13: 000000000000000b R14: 00007fe87ef35f80 R15: 00007fe87fa85000
> [  278.679321][T28696]  </TASK>
> [  278.679917][T28696] ==================================================================
>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   net/smc/smc.h      | 5 ++++-
>   net/smc/smc_inet.c | 8 +++++++-
>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 34b781e463c4..0d67a02a6ab1 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -283,7 +283,10 @@ struct smc_connection {
>   };
>   
>   struct smc_sock {				/* smc sock container */
> -	struct sock		sk;
> +	union {
> +		struct sock		sk;
> +		struct inet_sock	inet;
> +	};
>   	struct socket		*clcsock;	/* internal tcp socket */
>   	void			(*clcsk_state_change)(struct sock *sk);
>   						/* original stat_change fct. */
> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> index bece346dd8e9..9e5eff8f5226 100644
> --- a/net/smc/smc_inet.c
> +++ b/net/smc/smc_inet.c
> @@ -60,6 +60,11 @@ static struct inet_protosw smc_inet_protosw = {
>   };
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> +struct smc6_sock {
> +	struct smc_sock smc;
> +	struct ipv6_pinfo inet6;
> +};
> +
>   static struct proto smc_inet6_prot = {
>   	.name		= "INET6_SMC",
>   	.owner		= THIS_MODULE,
> @@ -67,9 +72,10 @@ static struct proto smc_inet6_prot = {
>   	.hash		= smc_hash_sk,
>   	.unhash		= smc_unhash_sk,
>   	.release_cb	= smc_release_cb,
> -	.obj_size	= sizeof(struct smc_sock),
> +	.obj_size	= sizeof(struct smc6_sock),
>   	.h.smc_hash	= &smc_v6_hashinfo,
>   	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
> +	.ipv6_pinfo_offset	= offsetof(struct smc6_sock, inet6),
>   };
>   
>   static const struct proto_ops smc_inet6_stream_ops = {
> --

Hi Jeongjun,


Thanks for you efforts, it makes sense to me now. But I still need some 
time to test it
entirely before adding a r-by.

I will appreciate for your patience.


Thanks,
D. Wythe



