Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2348B43F8DE;
	Fri, 24 Jul 2026 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905335; cv=none; b=itvJoYRQRLr7B3uN9ltC3NCrI2hT2O5U9ojkMjzwMRWEDDzRGFwfw5YmA27YDiT/o8uw1B6KAzk7Xs7bEacdW7qpGKM5wizALNFwoR5iJOY5Km+JPV963dizqvVik09t+IhD02kjYLoFmiWHwjDnSCC8153JC3dMgP7PERyaong=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905335; c=relaxed/simple;
	bh=OJiLo8KUofVnesGqHQ+0LLZtGLzRBUwTeJX+s6uo2iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thmJ++f/cCjf7qOJVHRMCrL6FYbu27Gw/0GkiF8juGZYZTsbiWvR0Ymt6gNdAkWJoN3qh0fmWgCzSiWPwOCfko2yZMoUorzynoMf3EJdZQgOL1+dGocgFMOXrx/GqEvuhHI8S/wDTL9r4SPboUnC3z5GMeN5AzOhEoXt6dbe53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TijDT81p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TijDT81p"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODfuGv100791;
	Fri, 24 Jul 2026 15:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b1Hl13
	guGSSod1qmSNLL+sRpowvnUV/R7Ar6aN+Ocvw=; b=TijDT81pQ4WJ62dK0QbTVl
	B6w+MntJ2qSHJCSzzAQonoojkvIC8FMqtAOwCc2dt7rHtQRMr6SfIRB5RqG4MawO
	LlFdb0uIxKN9pJmCESlsRNuj1V0HbDL6FD0hyr2rygXrod4cZIfv8nH//g1oQ+GB
	NpFQaVLHBr5f0/9MA7TewBESsQOvhsbVHYl2EhkZ93XokMcgFlgz//T91crZh936
	AYnGW4LOgVaT3Vp7RdCEHitrWRCmM2go/zPFf0b+1mx57jP0SN946KgDaTcxjVLS
	XjZ7QG8gFwrCVEa1AiOmB6Ns5kcko2tVE6p+JIsCsisarCLQGjUAFF0jLk75/oTQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8gs8hhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 15:02:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OEnk5j018544;
	Fri, 24 Jul 2026 15:02:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gs76g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 15:02:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OF2BLr23462614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 15:02:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF6E258050;
	Fri, 24 Jul 2026 15:02:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F4BB58052;
	Fri, 24 Jul 2026 15:02:10 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 15:02:09 +0000 (GMT)
Message-ID: <70ec8cd3-d3c8-4eed-b204-0197de819691@linux.ibm.com>
Date: Fri, 24 Jul 2026 11:02:09 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] s390/vfio_ccw: free all memory if cp_init() fails
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-2-farman@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260723174751.1180334-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzMyBTYWx0ZWRfX3BDYFw9t2dhw
 eN1TrMSB1v0uoXQNcPXR0QCkgY/22XPFjMstKzomTViwiLIaMFRRI0Hve+cL7yllGcklHuXF3Q7
 n4YKcTwpmzRmNSI5h20GupBPBH8i/S8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzMyBTYWx0ZWRfX86SDz8oU9qCS
 rN+3ZYoMSTCN4HdpiMIq9A7q5H8GbHVEfDAk0Y73CSkiJgG8snE0pznCIaZRIT3puvK0YVNm+VD
 eHnyYKqyfaq5S+anwqxU58KeCKcRprqlcN7ZzBNoOUQmHM1CxPcDUonzHGww9X2FDYSfCku3/ac
 Q2KIOWpyK57U9/ts4zE64jOSM7h3l4TLSeFb8/obS8vf9t3E33SXJKZShCoHA2jnpHhtyjIMcF3
 9TxoZ6tdGTmraMlpftallwMjE6Lk1a9OTtFd9KYB1i8y+9c+Qibp/T1NUfssFnxrjxAoGOmSIIS
 ead2tKIT2FjQS3knmQNDIcve0fSC0ikpcoESghiKZ1ZpAalzTJJXNZQMHmYCqapKajDZsp4Z0ef
 giFAXUtbYofy//1cf0tlVbUv/pGaU+b6Je3FqEsSLaus6j8vDm/ePlTCoptr095grWbE3X6BoNQ
 mJj2+Ne/4NuX4fsLIKA==
X-Authority-Analysis: v=2.4 cv=Q9LiJY2a c=1 sm=1 tr=0 ts=6a637e75 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=BGMVehrePew0uRRqv7kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EJ50ingGunx0emQ16Zdb9vLNyn_NG4Hc
X-Proofpoint-GUID: EJ50ingGunx0emQ16Zdb9vLNyn_NG4Hc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240133

On 7/23/26 1:47 PM, Eric Farman wrote:
> The routine cp_free() is called to unpin/free any memory once an I/O
> is completed successfully, or if cp_prefetch() fails. But if cp_init()
> fails, and cp->initialized is not enabled, the same routine cannot be
> used to free all the memory.
> 
> An attempt to address this exists in ccwchain_handle_ccw(), where a
> single call to ccwchain_free() is made for the currently-processed
> CCW segment. But this will leak other segments (created as a result
> of a Transfer in Channel) that had been allocated as part of the same
> channel program.
> 
> Address this by performing the cleanup outside of the recursive
> ccwchain_handle_ccw()/ccwchain_loop_tic() logic.
> 
> Fixes: 8b515be512a2 ("vfio-ccw: Fix memory leak and don't call cp_free in cp_init")
> Cc: stable@vger.kernel.org
> Reviewed-by: Farhan Ali<alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 7561aa7d3e01..086d1b54bdb0 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
>  	/* Loop for tics on this new chain. */
>  	ret = ccwchain_loop_tic(chain, cp);
>  
> -	if (ret)
> -		ccwchain_free(chain);
> -
>  	return ret;
>  }
>  
> @@ -486,6 +483,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
>  	return 0;
>  }
>  
> +static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
> +{
> +	struct ccwchain *chain, *temp;
> +	int ret;
> +
> +	ret = ccwchain_handle_ccw(cda, cp);
> +
> +	if (ret) {
> +		/* Cleanup if an error occurred */
> +		list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
> +			ccwchain_free(chain);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int ccwchain_fetch_tic(struct ccw1 *ccw,
>  			      struct channel_program *cp)
>  {
> @@ -735,7 +749,7 @@ int cp_init(struct channel_program *cp, union orb *orb)
>  	memcpy(&cp->orb, orb, sizeof(*orb));
>  
>  	/* Build a ccwchain for the first CCW segment */
> -	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
> +	ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
>  
>  	if (!ret)
>  		cp->initialized = true;

