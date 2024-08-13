Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC560EC4;
	Tue, 13 Aug 2024 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547493; cv=none; b=POfDvRE5C67T8vAwYE405Ugwt+ARYeWFakOqgzuzIPyBd+0K2xgMQB7uScKYQuPupyDqe6rlYcqywIloObCEzjSMkfgMCE1DKkrQ6vJD/48r1BTBprBixKvAQe/hcjylT9eePtrIcy8m4uiWF2NsO7DCo8PVCobWZeOFwnBBtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547493; c=relaxed/simple;
	bh=7gkIW6rHAJWw9DpF49uh+XSuxqYO3AKEiidveWjhkbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmbmHqpswKTzk0X23wz3HrsW2iEQhil2KpwO4VIMGB5v4qEHeh78epT/5jPi7mkMqk+6xQ68n+v9LKCipF54wDC583mLexnr7aHrxIncAS1ubNdKKEC3JsbB2IfPAu05t/+xrcgTNh8zjj2aJD/bRyotppacL+BJo7LWpgNGj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D1PwmyK4; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D1PwmyK4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723547482; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i6gj0Em+nl5LJC0kbGdv/6kK5TQfE9f5EDGnM/l48K0=;
	b=D1PwmyK4Ys1lZszEBXExWhUr5Lw6ZIJwnuvX+EKrzzhHo5b86BGUmT84zd7AninjRfo+kforhB6qOSNHME2FA1a0SOUVZYx8NvT5feg7gVNfdvSRzdPE030rdQcD3xkwkdrsEtV+JsJ6n5+HhvGYLJ+LESYClDc3XQuuTfJS+T8=
Received: from 30.221.149.156(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WCovVTY_1723547480)
          by smtp.aliyun-inc.com;
          Tue, 13 Aug 2024 19:11:21 +0800
Message-ID: <a34b3973-1121-4c55-ad99-f74a755644d3@linux.alibaba.com>
Date: Tue, 13 Aug 2024 19:11:20 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net,v3] net/smc: prevent NULL pointer dereference in
 txopt_get
To: Jeongjun Park <aha310510@gmail.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, gbayer@linux.ibm.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com
Cc: davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com,
 pabeni@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
References: <20240813100722.181250-1-aha310510@gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20240813100722.181250-1-aha310510@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/24 6:07 PM, Jeongjun Park wrote:
> Since smc_inet6_prot does not initialize ipv6_pinfo_offset, inet6_create()
> copies an incorrect address value, sk + 0 (offset), to inet_sk(sk)->pinet6.
>
> In addition, since inet_sk(sk)->pinet6 and smc_sk(sk)->clcsock practically
> point to the same address, when smc_create_clcsk() stores the newly
> created clcsock in smc_sk(sk)->clcsock, inet_sk(sk)->pinet6 is corrupted
> into clcsock. This causes NULL pointer dereference and various other
> memory corruptions.
>
> To solve this, we need to add a smc6_sock structure for ipv6_pinfo_offset
> initialization and modify the smc_sock structure.
>
> Reported-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
> Tested-by: syzbot+f69bfae0a4eb29976e44@syzkaller.appspotmail.com
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>   net/smc/smc.h      | 19 ++++++++++---------
>   net/smc/smc_inet.c | 24 +++++++++++++++---------
>   2 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 34b781e463c4..f4d9338b5ed5 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -284,15 +284,6 @@ struct smc_connection {
>   
>   struct smc_sock {				/* smc sock container */
>   	struct sock		sk;
> -	struct socket		*clcsock;	/* internal tcp socket */
> -	void			(*clcsk_state_change)(struct sock *sk);
> -						/* original stat_change fct. */
> -	void			(*clcsk_data_ready)(struct sock *sk);
> -						/* original data_ready fct. */
> -	void			(*clcsk_write_space)(struct sock *sk);
> -						/* original write_space fct. */
> -	void			(*clcsk_error_report)(struct sock *sk);
> -						/* original error_report fct. */
>   	struct smc_connection	conn;		/* smc connection */
>   	struct smc_sock		*listen_smc;	/* listen parent */
>   	struct work_struct	connect_work;	/* handle non-blocking connect*/
> @@ -325,6 +316,16 @@ struct smc_sock {				/* smc sock container */
>   						/* protects clcsock of a listen
>   						 * socket
>   						 * */
> +	struct socket		*clcsock;	/* internal tcp socket */
> +	void			(*clcsk_state_change)(struct sock *sk);
> +						/* original stat_change fct. */
> +	void			(*clcsk_data_ready)(struct sock *sk);
> +						/* original data_ready fct. */
> +	void			(*clcsk_write_space)(struct sock *sk);
> +						/* original write_space fct. */
> +	void			(*clcsk_error_report)(struct sock *sk);
> +						/* original error_report fct. */
> +
>   };

Please don't send patches so frequently 🙁.

And it seems like you haven't made any changes? Those modifies still 
there? Perhaps before you issue the patch,
you should carefully check what you have written.


BTW:  Please don't send any new versions of this for at least 24 hours, 
You need to give yourself and the reviewer
some time.

>   
>   #define smc_sk(ptr) container_of_const(ptr, struct smc_sock, sk)
> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> index bece346dd8e9..25f34fd65e8d 100644
> --- a/net/smc/smc_inet.c
> +++ b/net/smc/smc_inet.c
> @@ -60,16 +60,22 @@ static struct inet_protosw smc_inet_protosw = {
>   };
>   
>   #if IS_ENABLED(CONFIG_IPV6)
> +struct smc6_sock {
> +	struct smc_sock smc;
> +	struct ipv6_pinfo np;
> +};
> +
>   static struct proto smc_inet6_prot = {
> -	.name		= "INET6_SMC",
> -	.owner		= THIS_MODULE,
> -	.init		= smc_inet_init_sock,
> -	.hash		= smc_hash_sk,
> -	.unhash		= smc_unhash_sk,
> -	.release_cb	= smc_release_cb,
> -	.obj_size	= sizeof(struct smc_sock),
> -	.h.smc_hash	= &smc_v6_hashinfo,
> -	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
> +	.name				= "INET6_SMC",
> +	.owner				= THIS_MODULE,
> +	.init				= smc_inet_init_sock,
> +	.hash				= smc_hash_sk,
> +	.unhash				= smc_unhash_sk,
> +	.release_cb			= smc_release_cb,
> +	.obj_size			= sizeof(struct smc6_sock),
> +	.h.smc_hash			= &smc_v6_hashinfo,
> +	.slab_flags			= SLAB_TYPESAFE_BY_RCU,
> +	.ipv6_pinfo_offset		= offsetof(struct smc6_sock, np),
>   };
>   
>   static const struct proto_ops smc_inet6_stream_ops = {
> --

