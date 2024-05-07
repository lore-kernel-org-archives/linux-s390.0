Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FDD6BB5E;
	Tue,  7 May 2024 05:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715060912; cv=none; b=AxbJM25L5+Aue2rDMfPwPvPMVsYFl++V5TlfE4UO1JkNlonRju7n06Nn0+Ji9PBD/yrezub9qiFYZtv1SRZQNDy0SvouUlqFicrA293J+D8b+ETMoutMUKzH3Gy9YG0zVKesV/aRTlMVorerYNqEVTlBtZBafJQyqpy50CBkuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715060912; c=relaxed/simple;
	bh=DE/+FQset3xrsj7V7n41nLCDbii0M8EJufuRl4Wvclk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g48fMBshY1HD6Wzl3GbNKr2oaCZmkiMO+is21Vo3ngKPA4ifZ/gqgHLakkbsReZhDtPqzBrpp6zzyMxd9JmWzCDY2o7Re43RBfdVFwkoqGI7zPSZREeSFSAfCVhHMifdKBifMmlVyGI2tOLXzRs5F49M96ii5tWSNdtbpn1ojBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WxXv84J1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WxXv84J1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4475HhBh028795;
	Tue, 7 May 2024 05:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=MxiUcbVZ+IpagCy8+kPbitRWZvYcftjrL+jTJKK50qA=;
 b=WxXv84J1wypulOR8Y4tLtOm1+pQA3TiAif3zN0HjS8k4i7F8VEzBfM/ob793fbZFlNAM
 z9kgsBoFh57JqsRKpdzynAqPp/512Rp8jUgS9m7ApVYoW2Q1Qpv8Ia8n/x56pxwwFAgs
 Gkiyc9H/TehSCIhqKCz+WE72VVCX7mjajW7BWUZ16h85xaVoeX1y0pDfRwFuo55Gne7x
 ZtRvf53nFcatIvWD+aASaGzfzh0S8t9inPDqY43io75BVDT0i1H61lXi9NcwuVvGEjvo
 uJ6cN2QO4hl0HEQRYfDeq+PNKparWs4qRuKomsLE4m8va+/QQ/IleIxEm7Vw8XLa4FqE aw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xye1382xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 05:48:26 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4475mQ9h014414;
	Tue, 7 May 2024 05:48:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xye1382x3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 05:48:26 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4474DkGR013859;
	Tue, 7 May 2024 05:26:40 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xx222utwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 05:26:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4475QbpC43975384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 05:26:39 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 664FD58063;
	Tue,  7 May 2024 05:26:37 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D8A25804B;
	Tue,  7 May 2024 05:26:35 +0000 (GMT)
Received: from [9.179.27.31] (unknown [9.179.27.31])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 05:26:35 +0000 (GMT)
Message-ID: <80aba643-60a0-4a1c-b90a-de6e0d8d7bc1@linux.ibm.com>
Date: Tue, 7 May 2024 07:26:32 +0200
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
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240506015439.108739-1-guwen@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240506015439.108739-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PLRDL5ed79G-Pr6Cevz-_ETAaD0VLTMr
X-Proofpoint-ORIG-GUID: 7a5cesJQLPVMTgJrsm4VrV-LJOcEzP0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070038



On 06.05.24 03:54, Wen Gu wrote:
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
>   unregister_netdevice: waiting for eth1 to become free. Usage count = 2
>   ref_tracker: eth%d@ffff9cabc3bf8548 has 1/1 users at
>        ___neigh_create+0x8e/0x420
>        neigh_event_ns+0x52/0xc0
>        arp_process+0x7c0/0x860
>        __netif_receive_skb_list_core+0x258/0x2c0
>        __netif_receive_skb_list+0xea/0x150
>        netif_receive_skb_list_internal+0xf2/0x1b0
>        napi_complete_done+0x73/0x1b0
>        mlx5e_napi_poll+0x161/0x5e0 [mlx5_core]
>        __napi_poll+0x2c/0x1c0
>        net_rx_action+0x2a7/0x380
>        __do_softirq+0xcd/0x2a7
> 
> It is because in smc_ib_find_route(), neigh_lookup() takes a netdev
> refcnt but does not release. So fix it.
> 
> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_ib.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 97704a9e84c7..b431bd8a5172 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -210,10 +210,11 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>   		goto out;
>   	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
>   		goto out;
> -	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
> +	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);
>   	if (neigh) {
>   		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
>   		*uses_gateway = rt->rt_uses_gateway;
> +		neigh_release(neigh);
>   		return 0;
>   	}
>   out:

Hi Wen,

Thanks for fixing that! It looks good to me and works well.
Please release rt for that condition in the next version. (Thx, @Ratheesh!)

Thanks,
Wenjia
