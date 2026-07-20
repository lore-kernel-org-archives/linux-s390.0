Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0C4430CFD;
	Mon, 20 Jul 2026 21:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784584114; cv=none; b=hPGx0yEB/uEQD5qKKWJ+ij9vyrnT2pe6wUbuZ1TupDK/aCuft5d0vhYxeq1bRdc2iCTkti1bMuVAyM5ACYLTABKQ4YD0ch928jYSaU9csNQ/BV+t+M7jmfi9EQbqx3f5vB8/c2OrZjGAopKYIfn0cILMQZsP5znt4hHr89tDEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784584114; c=relaxed/simple;
	bh=T3ovAt55A22O1KjU1qY+ppGa+qpeOdFrnXEXhzSkMNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWDjpYEfca9ZZwAnFBomEHK4PQvMXJFzUVr/9J3dcksFRY8ad/AQqC4hlx8q+LmN15HTLZVSxQ3h2ERtNrmJZO0fXQtRPgu8+v/Rga8khJftWxxuFLxq+S+1y7dU1V/fjgaJcv6APT8b7T/QVU8Ue4jP7ejS7AFJS76h7MUvhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gmgvIyFF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gmgvIyFF"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJg7bq3129666;
	Mon, 20 Jul 2026 21:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VscOjs
	kHbZzOYEiC+JC4a4/RAMVF0HubI1QgH+rs70k=; b=gmgvIyFFDO3dAHRG9aoDkt
	q1Nse0/jiUAOOXfb5lsqbK9X+v6ncwdXaMbycszvWHH+OG0K7w2BShAz05nhfwzD
	gUCouQs6J7+UWcqGVhm5B2tOgo4DQMfIvO0YToAIwIKAkRTvP7u08q4pe4NVdybu
	fMt5VTyyWQtLIJsZk10kV/M1VJU2PDZvZwLwa8zRcpRpTJfufYUpVe4jddehmBKY
	1uJYHnBVm2MRdg/A9vY5TtIlvLsMnOBGkAenxPXVXcrstyxQgO0zhyqjsMsECHQg
	LJyijslvzSSdNkuYExp9lJt/GlFJXAUbV3yXl26fvfs/08reHzXT+RBkVEYy8BJQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah1a5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 21:48:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KLYZE0012101;
	Mon, 20 Jul 2026 21:48:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy775c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 21:48:27 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KLmPnc31523566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 21:48:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBEBD58065;
	Mon, 20 Jul 2026 21:48:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D44ED58055;
	Mon, 20 Jul 2026 21:48:24 +0000 (GMT)
Received: from [9.61.255.134] (unknown [9.61.255.134])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 21:48:24 +0000 (GMT)
Message-ID: <74b5de0b-b52f-40a8-8fca-9876bb12ac48@linux.ibm.com>
Date: Mon, 20 Jul 2026 14:48:24 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] s390/vfio_ccw: free all memory if cp_init() fails
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260720201931.976660-1-farman@linux.ibm.com>
 <20260720201931.976660-2-farman@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260720201931.976660-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xj5j8ABTRqGKgo5hDMGmx-NQytJnYyY8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIzNSBTYWx0ZWRfXyh1cARZe9Rte
 Bbc791uQ1ynOHkpsXFb0+CKeZEXQ1CKS0cUbiHT5/0SPEueYy0xTrdULQxGC0Noo+0flbzdRcpL
 92oKTV3KKjUES3Fu8KR5mXHNrLyJwlTHGIwNQ+ks0j79sBLOLY8yW0OrZVwwFkBORnQ5m8lDVyp
 neC7RyWpJunYrodAHac9ppkkjzEkqRiX+JFH9095IAoCTmSCtxUp7PMKKpnVGvCRRtU3v+OckIv
 F4mhVb666rafReCFcGGpzOl25/+9X5FPHXF5/0w+f9vYrH2M4Dx4/V4d+wGAyReF89TVTYc3rt9
 xA059NsqrQj/U001894cuy2xk2J0GWvFNqgTOGMuGRwrm5AWFnaKCeYwwDAW0JUj6JZbxlDaBXb
 pFbh87L2ZdIgopHq3rUK9zA7a5srN00/LHzJ/DOcCcTzi6nmnOyfjOMDtq2huAZYzc6p1PPgzOI
 z+5dCoaQw15lK+m0plw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIzNSBTYWx0ZWRfX5KJcqoJo0kd6
 sKePsUN6PpayyxPdRm8k5sjWP19ylLmiGFjo3surkaBzioRzozaiQvtsNavZ9H3MwxRIsZXj0sj
 9BlvBXnsz6yduc8AxxXA8u2X0NU09Es=
X-Proofpoint-GUID: xj5j8ABTRqGKgo5hDMGmx-NQytJnYyY8
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5e97ac cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=BGMVehrePew0uRRqv7kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200235


On 7/20/2026 1:19 PM, Eric Farman wrote:
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
> Cc: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   drivers/s390/cio/vfio_ccw_cp.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
> index 7561aa7d3e01..086d1b54bdb0 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -455,9 +455,6 @@ static int ccwchain_handle_ccw(dma32_t cda, struct channel_program *cp)
>   	/* Loop for tics on this new chain. */
>   	ret = ccwchain_loop_tic(chain, cp);
>   
> -	if (ret)
> -		ccwchain_free(chain);
> -
>   	return ret;
>   }
>   
> @@ -486,6 +483,23 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
>   	return 0;
>   }
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
>   static int ccwchain_fetch_tic(struct ccw1 *ccw,
>   			      struct channel_program *cp)
>   {
> @@ -735,7 +749,7 @@ int cp_init(struct channel_program *cp, union orb *orb)
>   	memcpy(&cp->orb, orb, sizeof(*orb));
>   
>   	/* Build a ccwchain for the first CCW segment */
> -	ret = ccwchain_handle_ccw(orb->cmd.cpa, cp);
> +	ret = ccwchain_build_ccws(orb->cmd.cpa, cp);
>   
>   	if (!ret)
>   		cp->initialized = true;

The fix looks correct to me and I don't think Sashiko found any issues 
with this patch (issues identified as pre-existing and i think something 
this series is trying to fix).

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>

Thanks

Farhan



