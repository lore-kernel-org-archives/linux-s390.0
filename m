Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849995;
	b=yA4PI+wK2l/T7bgGZd8EbBMla+2dG0RVofrr+PpgE4uOAh6JMYwsQgors4r9sphcEsVX
	 UELRVIWd9NUPzllu0CnS8DBm5qBMqqrmrGRx00EyUpglYK93RXCdLP7desUmwotAIzdiw
	 UeltLxKxSmcrDfVmB5NhbH9Wi4AC6XERBC77qDt+5exM/FMlqvM44AjAXE9pgu8ub/RIa
	 DDju1/VbWy7lq5QOXEof2HcLObgA+u8hg+gPBCnEddn6VAKRfofiZZyvYuYu4yAYMvqFb
	 7T19U8pBxCbbBSj9XUFozA0v8kNZx/u/YCA8VWD5ATAnrCcUzvSS5sjoCk8WOEKaGnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849995;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RQbMdn8SHqzKtda3vYQik0JhRg/iCgZAw7V4X9P65uY=;
	b=rhGQVPWDppwPu5DQ7GJlBhaVE20q6bgnWCF5AXiIiUxpggRVuANYXoqfMYXQ7zjzzFMD
	 YT925zgsoDfh20/SGifNJx4up1pWhEdYMcDcGAL9mLSisZYrdb2dL0Wr90JQQXynpJ6yh
	 wWZspAb5yZWvz8lH8aM+W9O9oCfr5XAZuN7m1fvzdQuZKl8ydUjf5WsJRcjv3hRqf9m36
	 feyuJInpQyFEHa7hCpQh69X3JNToHbq3d3dXQGs/Xl35q1+FAxxCllGFB2FMMjz2MuKem
	 oiNAblqIG4gowwL7nurmKinwzvFnW++/7owkCADGnJYtLF0/mc0qS0HHci/t33cdrKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Wd9u1U/h";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23666606A8A4;
	Mon, 16 Nov 2026 17:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23666606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Wd9u1U/h
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQ3Iu3951449;
	Mon, 16 Nov 2026 17:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RQbMdn8SHqzKtda3vYQik0JhRg/iCg
	ZAw7V4X9P65uY=; b=Wd9u1U/hB7jIap2j+4KfuDChtNHFikweBJGSwtO5MH1YrT
	cq6jgWSOVQlUbkQFH8LCuU32lfTQLfDMyIZCkFAmLFDhQE7WTtOPoUzXHj4/vz3Q
	+C8r8EZHtCopU1YZ4xAmaJWBmrF97wT/B8T3Vaxu/+DU7k8hpYWqT0js07gopgY/
	oJzDahXb6wa+Y/EYhYGtwtvcXTRud5GIoQCYpoXxhseZHEbt5oVL6pfVcASrN0vM
	v23z+3QGfxE88CYMVQe+kYfn7kDXv2sFk0gSGq0iOsbITcDKuDN9qG6qA7AsCvJO
	WtxLfEcckgshlcJ9uXhUhSi/wJ53NT5Q0VX9rjwQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf566s72-104
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:26:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDGbRI005807;
	Mon, 16 Nov 2026 15:13:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02ju84p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:13:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGFCwl131785376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 15:12:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9E4C20043;
	Mon, 16 Nov 2026 15:12:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C269C20040;
	Mon, 16 Nov 2026 15:12:57 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.68.17.117])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 15:12:57 +0000 (GMT)
Date: Mon, 16 Nov 2026 16:12:56 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
 kzalloc()
Message-ID: <545cec68-2444-4dcd-987d-cea05ffe3362-agordeev@linux.ibm.com>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108-s390-sclp-ready-v1-10-3e7c90eb6676@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX9rVwg1JIUsY/
 3/nactZmoFOUKrSvSkVXJfAXi8WcXLybCEyyOzWw2tC+7ygmzRzSYs0Xxe6MYzjg+cfj+ytKu0m
 LUHCeTnyK5D/1Xkb7jrLSOB+CaELis4=
X-Proofpoint-GUID: IzPuUj88MlTXaFd3r2zGb_QHN4dbE2y7
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb3cc5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=WoHBFsDaWbmCVFpg4N8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IzPuUj88MlTXaFd3r2zGb_QHN4dbE2y7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX8O7gZy+71NrW
 Cso+cCwMatAO67UuJw3UKg3SbJG22hdn52asbop8U2y/HjwH7iSgAmF7ZVet0d1M0s4wVDWd1WF
 g2JfNsZ4x+/bTKk+olBiF/gZYJv7X8JTcRQYfYhj/xIIO0OyFGbnK1hKvXR/MlKdHZfx9qDBbV5
 vhSeeiOtzBP1ao3DVYB6HQxtqKFHARp1H8Fc54/cHTHJpymQuduiQJYQ9oynjwuH0LG6qGZaTPj
 2MgR1H4gBLoSIoKWYwVM6+ZHaioryjYmNYzqxGfaD6eejjsu5ym6aZdDYK6BLHnh5Q+0LYP65XO
 K3hOw7xlUKmea+P0F0Q6vR+m0ilAm9LprsWzRjydEEseONpfV241cBmZOGGvh1GgjKmIQt/9DpE
 /2C2o+3g/Tnuudcos1cCpxA/5ihApj4TeO/XFwlpCP2LmsoBUpwJl2Rb+5tVppupAavsnzwL//9
 YQq7WGBCrDeq5Njqk5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069

On Sun, Nov 08, 2026 at 10:58:41AM +0200, Mike Rapoport (Microsoft) wrote:
> _sclp_get_core_info(), do_chp_configure() and sclp_chp_read_info()
> allocate the SCCBs used to read the CPU information, to configure a
> channel path and to read the channel path information.
> 
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> While on it, allocate only the amount of memory the SCCB actually
> requires in _sclp_get_core_info() rather than rounding it up to the next
> power of two.

This hints that the SCCB size is less than PAGE_SIZE, which is not the case.

> An SCCB must be page aligned and kmalloc() guarantees that
> the alignment of an allocation is at least its largest power of two
> divisor, so the extended SCCB is still page aligned.

This implies that the slab size path was taken, which is also not
the case. Yes, the result is still aligned for PAGE_SIZE, but for
a different reason ;)

I would suggest removing this whole paragraph. I can do it if you agree.

> Replace use of __get_free_pages() and get_zeroed_page() with kzalloc()
> and free_page[s]() with kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/sclp_cmd.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
> index 1dc93d945be6f..6aaf1f6a3633f 100644
> --- a/drivers/s390/char/sclp_cmd.c
> +++ b/drivers/s390/char/sclp_cmd.c
> @@ -102,7 +102,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
>  		return -EOPNOTSUPP;
>  
>  	length = test_facility(140) ? EXT_SCCB_READ_CPU : PAGE_SIZE;
> -	sccb = (void *)__get_free_pages(GFP_KERNEL | GFP_DMA | __GFP_ZERO, get_order(length));
> +	sccb = kzalloc(length, GFP_KERNEL | GFP_DMA);
>  	if (!sccb)
>  		return -ENOMEM;
>  	sccb->header.length = length;
> @@ -119,7 +119,7 @@ int _sclp_get_core_info(struct sclp_core_info *info)
>  	}
>  	sclp_fill_core_info(info, sccb);
>  out:
> -	free_pages((unsigned long)sccb, get_order(length));
> +	kfree(sccb);
>  	return rc;
>  }
>  
> @@ -173,7 +173,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
>  
>  	if (!SCLP_HAS_CHP_RECONFIG)
>  		return -EOPNOTSUPP;
> -	sccb = (struct chp_cfg_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
>  	if (!sccb)
>  		return -ENOMEM;
>  	sccb->header.length = sizeof(*sccb);
> @@ -193,7 +193,7 @@ static int do_chp_configure(sclp_cmdw_t cmd)
>  		break;
>  	}
>  out:
> -	free_page((unsigned long)sccb);
> +	kfree(sccb);
>  	return rc;
>  }
>  
> @@ -236,7 +236,7 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
>  
>  	if (!SCLP_HAS_CHP_INFO)
>  		return -EOPNOTSUPP;
> -	sccb = (struct chp_info_sccb *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	sccb = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
>  	if (!sccb)
>  		return -ENOMEM;
>  	sccb->header.length = sizeof(*sccb);
> @@ -253,6 +253,6 @@ int sclp_chp_read_info(struct sclp_chp_info *info)
>  	memcpy(info->standby, sccb->standby, SCLP_CHP_INFO_MASK_SIZE);
>  	memcpy(info->configured, sccb->configured, SCLP_CHP_INFO_MASK_SIZE);
>  out:
> -	free_page((unsigned long)sccb);
> +	kfree(sccb);
>  	return rc;
>  }
> 
> -- 
> 2.53.0
> 
