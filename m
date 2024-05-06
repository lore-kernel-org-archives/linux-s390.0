Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42C3C463
	for <linux-s390@vger.kernel.org>; Mon,  6 May 2024 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714962453; cv=none; b=FekYNVZGyj1+RAbvrlw3ENZzAbbr6RdXNI0+aQB82DipDEyxHPLMB3GEYVygpSz8nNe7w356Q0eHJhSW3aaHtX6mvMPK/Aq7gdezFp2wNj1bUIuZFRvB5gKDs/i+CT1pgWDafzZ3j0n9ZOV1r8VadXZpJh1GuOshfW/Y/VlXE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714962453; c=relaxed/simple;
	bh=9SFYx28lbOjebzpeT1IaydZg7cFtpjFbVbcTaHrbfVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Suq/xVr2kKoN+XXm/b6nlISs7jCnM14v3D0q9VQIYeNM29bZb8ngpfjkOFDLyirY3QcCc0a22Vri4JHylctvXXXtx4uMe6WopBpJWCjAVdDbFqgbtTmgowtPokx2CSuotTZ3ThGe0W3RUVRlQmcuaVWSIX9hrVr1j2fQTSbFnZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2S+pwjKW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2S+pwjKW"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f45f1179c3so653285b3a.3
        for <linux-s390@vger.kernel.org>; Sun, 05 May 2024 19:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1714962451; x=1715567251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZcebAj1tOpuNxt9ewLjX4z+yHH+WF19I/SsunPNY+Q=;
        b=2S+pwjKWYlLbiuBIk3HZlOWpXEc4CXmptIS03eIOnTMcGybp8XBpbKITK9/kFRg/ic
         LbwRXnBI6CK7hAF8xFT24WlmBjb7YEHwvgMB8Ggb7SDSy0x3eu/shPeQQfnRjZw+NYA1
         kbaoiqJb4DPFSnUmhmKxZKJvK5gdq8xJbgIMFmsLTQpXTqhNB4KX37OWnqSdir8sL8Lk
         jNazIC9k+hM6cV7ysWMAa0W5ajuYP+n++sigN4uxDW11dLBcTaZ1TkFS5N1FBdrArOn4
         no+itV9cHw6eUBXvQYs3wNKVAWMIPnk2zfvrYV89CDyEGP3i5y1La5iWem9GdI0RmOpj
         9VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714962451; x=1715567251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZcebAj1tOpuNxt9ewLjX4z+yHH+WF19I/SsunPNY+Q=;
        b=uRcqBwSm+N83+Zf6bhe+bJlzYbJKCwcAi84yMNWpusDWv0kYm0lIaHEZt+NCWYQm04
         8RE0RzKybesteGDUCwCbi4vZplEKvL3WvvpIhmJPaA6OeViit/8SWYT6AYkiWKzHcwZ8
         L4FLBHRsADhchMQlrRnX2JGkQNd9Totw1NLg9mc6cIveucxw+LFfdDjlaeaWuM2FtI7i
         lSNmQkC3MGu9ZPgx9uAZ680RNqwSPCoNFcWFHMLNN5tPSX99qkmKkgo770eeS5MNNvgP
         SYoseGqigcEsSyt0RK7IVDV7+oaHNovyCA8qA9g22nPDND1tt7iBvSQvsNclTGaoqoCH
         Y+fg==
X-Forwarded-Encrypted: i=1; AJvYcCWZCvDelr3KsAGIAdzFbLIE8kUTuznPPArjagpdY0xW0vTynJI5EpILsV51MLYTf9kBQ7tfivzT2VnR6L4tH51caMgxlOWsJqXLuA==
X-Gm-Message-State: AOJu0YxZENx+uYVBcRWKSwfLyFtMAXqm380AaTQr1slwhQq7w559ppxq
	u79Mxci3H65Xbf0oEpZegoZAHnHBhNvMfyHCRUJQh28vIo9UsuFd7CYuONn4AqM=
X-Google-Smtp-Source: AGHT+IG347eCvhxwYdPwO4e9Eg21UrEgM91mcHSey1ZRxbww3HF95DvYkZM1Vz2e8uSTe7UMyQMSlg==
X-Received: by 2002:a05:6a20:d80c:b0:1af:7bbc:9f86 with SMTP id iv12-20020a056a20d80c00b001af7bbc9f86mr9359387pzb.0.1714962450620;
        Sun, 05 May 2024 19:27:30 -0700 (PDT)
Received: from [192.168.1.15] (174-21-160-85.tukw.qwest.net. [174.21.160.85])
        by smtp.gmail.com with ESMTPSA id n26-20020a63591a000000b005cf450e91d2sm6955159pgb.52.2024.05.05.19.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 19:27:30 -0700 (PDT)
Message-ID: <1d0c553c-18bb-4d0d-8358-eff0b65c6c56@davidwei.uk>
Date: Sun, 5 May 2024 19:27:29 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix netdev refcnt leak in
 smc_ib_find_route()
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
 jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240506015439.108739-1-guwen@linux.alibaba.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240506015439.108739-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-05-05 18:54, Wen Gu wrote:
> A netdev refcnt leak issue was found when unregistering netdev after
> using SMC. It can be reproduced as follows.
> 
> - run tests based on SMC.
> - unregister the net device.
> 
> The following error message can be observed.
> 
> 'unregister_netdevice: waiting for ethx to become free. Usage count = x'
> 
> With CONFIG_NET_DEV_REFCNT_TRACKER set, more detailed error message can
> be provided by refcount tracker:
> 
>  unregister_netdevice: waiting for eth1 to become free. Usage count = 2
>  ref_tracker: eth%d@ffff9cabc3bf8548 has 1/1 users at
>       ___neigh_create+0x8e/0x420
>       neigh_event_ns+0x52/0xc0
>       arp_process+0x7c0/0x860
>       __netif_receive_skb_list_core+0x258/0x2c0
>       __netif_receive_skb_list+0xea/0x150
>       netif_receive_skb_list_internal+0xf2/0x1b0
>       napi_complete_done+0x73/0x1b0
>       mlx5e_napi_poll+0x161/0x5e0 [mlx5_core]
>       __napi_poll+0x2c/0x1c0
>       net_rx_action+0x2a7/0x380
>       __do_softirq+0xcd/0x2a7
> 
> It is because in smc_ib_find_route(), neigh_lookup() takes a netdev
> refcnt but does not release. So fix it.
> 
> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>  net/smc/smc_ib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 97704a9e84c7..b431bd8a5172 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -210,10 +210,11 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>  		goto out;
>  	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
>  		goto out;
> -	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
> +	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);

Of the two implementations of neigh_lookup() I found that do not simply
return NULL, all of them increment or init struct neighbour::refcnt.

1. ipv4_neigh_lookup()
2. ip6_dst_neigh_lookup()
  a. __ipv6_neigh_lookup()
  b. neigh_create()

>  	if (neigh) {
>  		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
>  		*uses_gateway = rt->rt_uses_gateway;
> +		neigh_release(neigh);

So releasing it here looks correct.

>  		return 0;
>  	}
>  out:
