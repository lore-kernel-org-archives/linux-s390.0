Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD5C11CAB;
	Sun, 11 Aug 2024 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723356770; cv=none; b=mI+T9Nv93p0wBVLMMqgDIox6mouQ/PEF8rYqJW6SsxAZmK2Ifkf1PrnLVO9Mo0PuMkWeKe3nh88IdZMMnzBusN4hDsty4zkQN/WpP7jOoPdNhFItrJWtAExnMC0Cl7HoWftJaQYQVSVzgfHuH27y6Ouf1eT/gStsO/Bosn/bjEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723356770; c=relaxed/simple;
	bh=LjDROF9St23cmhsJGgRvN6jnqfu5Yrr8r2jMcOmvmC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EULE8PWCrC5PAQcFkTTHbcPowMDd2zCt9vbDPDNDV3vqrFdzMS033ZueAyo0hZRKqTm6I7JpyXEVFh7A3FsiB/602+hF3pK1hk3tgxlrcF6AnMlbFSw5lfaJzdnG3Jr88XxhnEjH6RfNIRCMKzJcg/0Nn/llpxOEfqOTe9S3Vcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZhgoSazN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZhgoSazN"
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47B5CLOF012640;
	Sun, 11 Aug 2024 06:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=J
	4eUPVlrFRN6f0/1Hfhl0KmppDF+RMmV8TnhMaJ+TTw=; b=ZhgoSazNI70HUZpeC
	kWE2UJpm1CULOqB6PcLUqmC/sxVWd3ek/3IdRVAD1NdhnMCabfJKIwLG5zXawows
	y8vN6KBqlAypCLzgQPJ9OyvAxbMNqBZrSLD83PJD/s/Z3uiP+Qxmv0mxreq9PcWF
	M5524J6qpspH1FOo1j1LEpDotPNg/GqLWCpMh175bj/rPbImI4t4MberslTL3zM8
	ddkmkc6sk4leiwmEAhN8Ge2wVo3KusJFHQ+jyJk3TjFoed8ddkSihXY9j6xRpkQw
	Qpc5t2D++/sQ+FFTPyeQuja2Nbz/5IwclziCNXUkAk3zi9h+2G5Wau4IlRCUkxQr
	Fhk4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwm7j73h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 06:12:36 +0000 (GMT)
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47B6CaMp011416;
	Sun, 11 Aug 2024 06:12:36 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwm7j73d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 06:12:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47B520g0011524;
	Sun, 11 Aug 2024 06:12:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xjhts2e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 11 Aug 2024 06:12:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47B6CVxW33161748
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 11 Aug 2024 06:12:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6CE020043;
	Sun, 11 Aug 2024 06:12:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12A762004B;
	Sun, 11 Aug 2024 06:12:31 +0000 (GMT)
Received: from [9.171.59.108] (unknown [9.171.59.108])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 11 Aug 2024 06:12:30 +0000 (GMT)
Message-ID: <8bf89095-4e5d-4111-8ae3-607e0beedd1e@linux.ibm.com>
Date: Sun, 11 Aug 2024 08:12:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] net/smc: Use static_assert() to check struct sizes
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZrVBuiqFHAORpFxE@cute>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <ZrVBuiqFHAORpFxE@cute>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5DPLcHWIEqLNKMGPjlyYFNMUgkeOygdI
X-Proofpoint-ORIG-GUID: 4YP5CNWcfWvNZtPpoJP2M5ddbXVvIimN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-11_04,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408110046



On 09/08/2024 00:07, Gustavo A. R. Silva wrote:
> Commit 9748dbc9f265 ("net/smc: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct smc_clc_v2_extension_fixed` and
> `struct smc_clc_smcd_v2_extension_fixed`. We want to ensure that when
> new members need to be added to the flexible structures, they are
> always included within these tagged structs.
> 
> So, we use `static_assert()` to ensure that the memory layout for
> both the flexible structure and the tagged struct is the same after
> any changes.

Hi Gustavo,

good catch. By reviewing it, it makes sense to me. Please let me give it 
a run with our test-suite before adding a r-b.

Thanks
- J

> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   net/smc/smc_clc.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
> index 467effb50cd6..5625fda2960b 100644
> --- a/net/smc/smc_clc.h
> +++ b/net/smc/smc_clc.h
> @@ -145,6 +145,8 @@ struct smc_clc_v2_extension {
>   	);
>   	u8 user_eids[][SMC_MAX_EID_LEN];
>   };
> +static_assert(offsetof(struct smc_clc_v2_extension, user_eids) == sizeof(struct smc_clc_v2_extension_fixed),
> +	      "struct member likely outside of struct_group_tagged()");
>   
>   struct smc_clc_msg_proposal_prefix {	/* prefix part of clc proposal message*/
>   	__be32 outgoing_subnet;	/* subnet mask */
> @@ -169,6 +171,8 @@ struct smc_clc_smcd_v2_extension {
>   	);
>   	struct smc_clc_smcd_gid_chid gidchid[];
>   };
> +static_assert(offsetof(struct smc_clc_smcd_v2_extension, gidchid) == sizeof(struct smc_clc_smcd_v2_extension_fixed),
> +	      "struct member likely outside of struct_group_tagged()");
>   
>   struct smc_clc_msg_proposal {	/* clc proposal message sent by Linux */
>   	struct smc_clc_msg_hdr hdr;
