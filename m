Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719545944;
	Mon,  6 May 2024 05:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714974708; cv=none; b=PS8yDlXhTiljO3ByUzdUrQcMs/zlJZsdc2BfmaNtTKTm9S6Nd8v1ETyjt1pd+gzwkfQMGuIaUFxpGzHw/OeL2maK/N7t67HOYIEvB6Vj78vqXVjcZW+qmpmlotBZTmDciou+RYh8HpNsleou9DcgsSysoTexo+bu+Q0jjC3FyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714974708; c=relaxed/simple;
	bh=qWuxR1mmdWJZycxMqZiN1bfoIP23U3q1cvktHbZ8yCY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSi5GvRvtE1a0eSgWTTSKlDY7+gxvRWuQI6d4hy3O4wuzAyflwNNJpPW8wam9erz8kt+T1CuvH19DIa7LuCGIf114MlQaaJ5KtOSXeAyTU1+cOg6kn2LdGFLg0ZpI2cCfHDVxhorZMmxADiF56VhCDAgY5rOkqB9v11EXCfYdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hNVyQ5/H; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hNVyQ5/H"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 445NPcu5019500;
	Sun, 5 May 2024 22:51:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=0qDKAgjGvfAMrYimnj22hq
	Df2zMN4qY/aEWHAZLcpIM=; b=hNVyQ5/HHE6Rt7BVnGkBd2vD/iSb6k/tWlqTA+
	91MC7UcyBhb8HwzY5gfhU5YF9EqIb3xSvQuYZK4lEEUy9wClaa1DKRkKr5qWt26L
	dKiCV+kImbOLwtA9GzaSCVgC65RqbsjH4RyCldKbSarg3yH9jV73DyL3F2L929Ow
	xXs5afXOfqF7UZTybjIAxGWNRHG9nA3BpFNHxTF3QsSJ6SD5Hcwh0jWqS3MlQQiJ
	4gCIKRKmqA79tKmqhlqSzBNorxZXYoe+uqqL4lyaOxeFIUuRwQFMRFSi89Ombsdj
	Fp0WgJIFcrajeegVgrn3WediQNblsqmoZy8gF7ywiWm2WUsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xwmhgbhc0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 May 2024 22:51:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 5 May 2024 22:51:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 5 May 2024 22:51:24 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id AD2673F7041;
	Sun,  5 May 2024 22:51:20 -0700 (PDT)
Date: Mon, 6 May 2024 11:21:19 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Wen Gu <guwen@linux.alibaba.com>
CC: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <alibuda@linux.alibaba.com>, <tonylu@linux.alibaba.com>,
        <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net/smc: fix netdev refcnt leak in
 smc_ib_find_route()
Message-ID: <20240506055119.GA939370@maili.marvell.com>
References: <20240506015439.108739-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240506015439.108739-1-guwen@linux.alibaba.com>
X-Proofpoint-ORIG-GUID: sxacuzMeS6svxM1YrwHC2oC8Pva_seO1
X-Proofpoint-GUID: sxacuzMeS6svxM1YrwHC2oC8Pva_seO1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_02,2024-05-03_02,2023-05-22_02

On 2024-05-06 at 07:24:39, Wen Gu (guwen@linux.alibaba.com) wrote:
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
need to release it here as well ?

>  		goto out;
> -	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
> +	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);
>  	if (neigh) {
>  		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
>  		*uses_gateway = rt->rt_uses_gateway;
> +		neigh_release(neigh);
>  		return 0;
>  	}
>  out:
> --
> 2.32.0.3.g01195cf9f
>
