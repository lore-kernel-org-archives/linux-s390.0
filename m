Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77DA5B216;
	Tue, 22 Oct 2024 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562422; cv=none; b=bcXaiGWJvQZpT6x/qti6akK6VCYi2HY71RtkJn8Cx4tCkt/K4RwbhoWfzFrQolhEQQ3sBWoBXE10kaVVWQYc6fZmVBYdi/6ouCrWa9fue70+C7XtV0aP1AaaEpWVQaWI5e/AQYUKmDMEw9Im6WgjFzFZsNbDL6p5bFgQerB097Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562422; c=relaxed/simple;
	bh=QY3g6Qwdo5/3ZoYCID2b/TExQufL9KcYp8YD0IzX3qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K67pNNoH5L0Tnh3Ip+5ckNh1NUFNUb/pfegxsd3CPIl5h8T6V6hPXE16fOX25oVqKM1yQieIyM9DNqyuYZlSEQ5GlUs8UetLaVlXId+If3QBMCBfpDfRG7m5GRxBD/qKmS9JMRG64MseRZhw2EUDQnfZVXi7BhCNTMtUy/8ZP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yptbV/tP; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yptbV/tP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729562411; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jnB/hhMsFk72J+nzMdTPHQDhD1sA65aIl7jzVIYxuj8=;
	b=yptbV/tPfpJkhxaCVi3vC4f76jdzPs6sAh53jAz6LQJnJuTeHZtXlOZLgr34TUYfLKRuRGFPsGi6biH4M9HCLfUonCviNhKFdce0Y3OW/j9rB6RGMysnyW/0PkfQbtGCdnu8/slcxYtH8vSvhQ4m3Be8A1/T0oQdVC6V9rS2uMg=
Received: from 30.221.147.210(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WHfyQem_1729562409 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Oct 2024 10:00:10 +0800
Message-ID: <17c1f52d-e032-44c1-8f56-34d5cd8e30ac@linux.alibaba.com>
Date: Tue, 22 Oct 2024 10:00:09 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2 RESEND] resolve gtp possible deadlock warning
To: Daniel Yang <danielyangkang@gmail.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>,
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
References: <cover.1729031472.git.danielyangkang@gmail.com>
 <c2ac8e30806af319eb96f67103196b7cda22d562.1729031472.git.danielyangkang@gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <c2ac8e30806af319eb96f67103196b7cda22d562.1729031472.git.danielyangkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/24 6:48 AM, Daniel Yang wrote:
> From: Daniel Yang <danielyangkang@gmail.com>
> 
> Moved lockdep annotation to separate function for readability.
> 
> Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
> Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
> 
> ---
>   net/smc/smc_inet.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/net/smc/smc_inet.c b/net/smc/smc_inet.c
> index 7ae49ffd2..b3eedc3b0 100644
> --- a/net/smc/smc_inet.c
> +++ b/net/smc/smc_inet.c
> @@ -111,18 +111,7 @@ static struct inet_protosw smc_inet6_protosw = {
>   static struct lock_class_key smc_slock_keys[2];
>   static struct lock_class_key smc_keys[2];
>   
> -static int smc_inet_init_sock(struct sock *sk)
> -{
> -	struct net *net = sock_net(sk);
> -	int rc;
> -
> -	/* init common smc sock */
> -	smc_sk_init(net, sk, IPPROTO_SMC);
> -	/* create clcsock */
> -	rc = smc_create_clcsk(net, sk, sk->sk_family);
> -	if (rc)
> -		return rc;
> -
> +static inline void smc_inet_lockdep_annotate(struct sock *sk) {
>   	switch (sk->sk_family) {
>   		case AF_INET:
>   			sock_lock_init_class_and_name(sk, "slock-AF_INET-SMC",
> @@ -139,8 +128,21 @@ static int smc_inet_init_sock(struct sock *sk)
>   		default:
>   			WARN_ON_ONCE(1);
>   	}
> +}
>   
> -	return 0;
> +static int smc_inet_init_sock(struct sock *sk)
> +{
> +	struct net *net = sock_net(sk);
> +	int rc;
> +
> +	/* init common smc sock */
> +	smc_sk_init(net, sk, IPPROTO_SMC);
> +	/* create clcsock */
> +	rc = smc_create_clcsk(net, sk, sk->sk_family);
> +	if (!rc)
> +		smc_inet_lockdep_annotate(sk);
> +
> +	return rc;
>   }
>   
>   int __init smc_inet_init(void)

I need to check why you said Wang Cong's patch cannot fix the issue.
As soon as I reach a conclusion, I'll inform you right away.

D. Wythe
