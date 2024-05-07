Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322815ECEB;
	Tue,  7 May 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087577; cv=none; b=p+E+xt1qPwJCuvNaMcvPc5KkY/MWjPGS4m8BPUAzRBT+27ko+ViOQUHCQUU43llSUjsx1cFIfuMsBXx+BQKy6HfsbB3uFrj5LXHX12bePUWla4Q9YRBvPJ79ISpfEgQJSr7HS3G5+ObtGGQfZoNpEX0PyHnL0X03ICPFajTRrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087577; c=relaxed/simple;
	bh=EBOR/At0quDzTks3+j9WP9mCaoWslNtogIow1+8Z/YA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LqnayPbSuPqm9pHaZpZrgWiFeqzAabm49wCEhn7Tn7veMMU4d5XJQx6GPOrcU9Z6uHYg81HhQtubCgqjPpmCZ5p3iihrGR0Kmjo61EFThHaRdStaIj+LZqEnkP3iOK7ur/YnYpcMByqezOSk9zWtuTqnGyE/FdHTcFqVP3vHBR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZnxWY7Lt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZnxWY7Lt"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447Cxpm6006481;
	Tue, 7 May 2024 13:12:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=IapXXGz7HPyomlW54PowX+1wAQC5PweuibBw3TQ2QGE=;
 b=ZnxWY7LtLn4JyWySYTTBZXUJK5Mj4xmNF1bWTtnfRoRwaSzSic4jPS4N5xy+yvILXk7R
 ECn5KYLmb+mXU/b7O0R1ncGHKKUl4v2ZLAQ4PE+5tpfV/enVugSkd3BHgGi5D0AWmVsB
 jMFAeWcGY5DP9uNWLLOtsZ9KW0G4hbGGC4zzjt5vnH7/kIsbYkl6Tvfovd7syO8McI8z
 0DIc5npW1jiU/HeGrhEjzYEfdPapuENd3+FBExlja055DTGj54TaiGRUcvIw0MOI0vOq
 2oBhX8F3b75t1fHA6CNc0ob7tuyZjRn5OBlvvf/D5Zao99taxlzB3YCdsrjepRIDchHN GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xymsqr164-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 13:12:49 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 447DCnHu028003;
	Tue, 7 May 2024 13:12:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xymsqr160-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 13:12:49 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 447BQZoV031316;
	Tue, 7 May 2024 13:12:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xwybtxgxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 May 2024 13:12:48 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 447DCjLV25166456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 May 2024 13:12:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69C0258056;
	Tue,  7 May 2024 13:12:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F27158054;
	Tue,  7 May 2024 13:12:40 +0000 (GMT)
Received: from [9.155.210.193] (unknown [9.155.210.193])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 May 2024 13:12:39 +0000 (GMT)
Message-ID: <01dd166d-ab47-415c-bf80-6dff4f2a3d2b@linux.ibm.com>
Date: Tue, 7 May 2024 15:12:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net/smc: fix neighbour and rtable leak in
 smc_ib_find_route()
Content-Language: en-GB
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: kgraul@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240507125331.2808-1-guwen@linux.alibaba.com>
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <20240507125331.2808-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kYnKrJ1A9SIntdeibKrQsx_HIVY-wSm3
X-Proofpoint-GUID: -rzwgTj8UVb-Vgt9_jcVeFHJN05HguNk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_06,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070090



On 07.05.24 14:53, Wen Gu wrote:
> In smc_ib_find_route(), the neighbour found by neigh_lookup() and rtable
> resolved by ip_route_output_flow() are not released or put before return.
> It may cause the refcount leak, so fix it.
> 
> Link: https://lore.kernel.org/r/20240506015439.108739-1-guwen@linux.alibaba.com
> Fixes: e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
> v2->v1
> - call ip_rt_put() to release rt as well.
> ---
>   net/smc/smc_ib.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/net/smc/smc_ib.c b/net/smc/smc_ib.c
> index 97704a9e84c7..9297dc20bfe2 100644
> --- a/net/smc/smc_ib.c
> +++ b/net/smc/smc_ib.c
> @@ -209,13 +209,18 @@ int smc_ib_find_route(struct net *net, __be32 saddr, __be32 daddr,
>   	if (IS_ERR(rt))
>   		goto out;
>   	if (rt->rt_uses_gateway && rt->rt_gw_family != AF_INET)
> -		goto out;
> -	neigh = rt->dst.ops->neigh_lookup(&rt->dst, NULL, &fl4.daddr);
> -	if (neigh) {
> -		memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
> -		*uses_gateway = rt->rt_uses_gateway;
> -		return 0;
> -	}
> +		goto out_rt;
> +	neigh = dst_neigh_lookup(&rt->dst, &fl4.daddr);
> +	if (!neigh)
> +		goto out_rt;
> +	memcpy(nexthop_mac, neigh->ha, ETH_ALEN);
> +	*uses_gateway = rt->rt_uses_gateway;
> +	neigh_release(neigh);
> +	ip_rt_put(rt);
> +	return 0;
> +
> +out_rt:
> +	ip_rt_put(rt);
>   out:
>   	return -ENOENT;
>   }

Thank you for fixing it!

Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
