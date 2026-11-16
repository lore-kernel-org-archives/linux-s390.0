Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849876;
	b=qsXkpsaFJSd04hzhcMaOYCAIO2eS3I6u6bz2Kn+Aikks1z9m6/AzfQA48iPNlw9Y2PZ9
	 N4yDeNNsgek8BCSYXMXovVIUioQAW9BViGagxpdHcI3HUXQbsqGgAqvzvvdkHwGVghd14
	 AKH3LH3U5OdcECHHhj8avKjQxKBmrhdqwRX9Qqjt9kwnui7IXUrap+VL1bVrQMhgHmex7
	 hFfl6hPZJVTnjGvpiwn9FbgoaK9odfne16wmPwVSz5xvMgzlB5duXX8VPcD5dJmC3/sTD
	 4mucLekrjph1Vj+S65yhoWdxG9cTExW+3j0Pbrqrvb5kHIeLaCNPkQo2iW85pWU6c9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849876;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dEx5D78mD3JLl04XVy0Lx8vy3qVm1Ne+25ZFs32wW/8=;
	b=jSIly8h5EkclBceSfFAjMXGiXXZ6zz7maS34csvZjkVH63jHN3gdWWFGD9YbZVWf8mYk
	 QBdw7jT3hEusT42K+A19w3BVYVNZb07WPOqXbr7pYpn/YDwM9lNftoojx/wU2umQVKUti
	 NdqCIceF2sxN3zj5dDdOBsSZEvPZNfY2/2pW8NLfcDimjA9Qea/GozUNQhJb2alPawkOB
	 DiVZHf6ux7pZdXVkTgzTP7dVp0I/L3tgxAEs/t1iGowuAkVdrKv8nZJdLyTAZ7oFwh00r
	 pQHwEC1nkfD5ZK4wq+vFFdvPrGn6U5c1LPT6LzT6jC1eGfjIXNFbPGPaijc/D1LlMlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H7cBltWa;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD09606A322;
	Mon, 16 Nov 2026 17:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DD09606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H7cBltWa
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQIR33952496;
	Mon, 16 Nov 2026 17:24:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dEx5D78mD3JLl04XVy0Lx8vy3qVm1N
	e+25ZFs32wW/8=; b=H7cBltWapocpfh5ET9BzUPRMtQ7SO+VjNYPp3n70wHcU1o
	Q2mTJ2KnFL/SnXQpbZglrAvu01FSlv6Uzu+K2JxGxSTMBeXmuzWWUlhw0cViuvMI
	xRCa0z/zFzKxYzyiO+ccbp/sPEjk+sT5UP18qGWMNBMsRBOgRQ+Ww4m6AT1S3FUB
	XTz/HQWxtQlJzKu1CzowgINKLxDtPzfIbGAfW754o8/4NcS/eMkyjZZOSDKtdXOS
	TKmZpPxslVoQwzbAiS2+MYhM5dAjZeV6SfedxjXiK0UKfZERTT3IFtPOi7HA6jmm
	/0khABj+Vl+YGbhp+sx/hON4D+O4A4S6MbkV/Sgg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxf566s75-44
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:24:30 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGDH6xb006236;
	Mon, 16 Nov 2026 15:22:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02ju84xe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 15:22:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGFMIYv38470036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 15:22:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9184B2004B;
	Mon, 16 Nov 2026 15:22:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3444F20043;
	Mon, 16 Nov 2026 15:22:18 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 15:22:18 +0000 (GMT)
Date: Mon, 16 Nov 2026 16:22:16 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/14] s390/sclp_cmd: Replace page allocator calls with
 kzalloc()
Message-ID: <20261116152216.165348Aa5-hca@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfX+2O5PVOBGRm4
 FWIhneTChQLXoZ2kIFlgINqRwVfxwlG1aOUmR54AO5jxUjfFeRpvjfs/bg1ZR6wS3v8KVfZXa7S
 DKcTlz5BUBFqHvFz9msLEubK1Kp9Bvg=
X-Proofpoint-GUID: f0uxqCT8GrkzDgYIakB12Bhvko1PUInj
X-Authority-Analysis: v=2.4 cv=ROImjIi+ c=1 sm=1 tr=0 ts=6afb3c4e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=oZZkxJ__kemSVIr8SkYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: f0uxqCT8GrkzDgYIakB12Bhvko1PUInj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NyBTYWx0ZWRfXwkwVlvTf4uTT
 12kAiApmGoF+kNpkbSzOVu/+Xk8rrCIsFmh6Z7k+ube2a+BXMt5GJX2316O6yaRb5HycaV0wTk+
 8do/yExt/pAj/feV2lTtD8TfcpmwK01VO6BzQCz4DWLXrKj/pfCzIUlMPRkKNUG+ORry7iYM7Ka
 47eEUdIqT2315BGgDXp+r5FqOm8rsZGnPoY+zXIIHGm4zJtN0T9v0RVloa5zzh6sIijCRVHQ0yM
 VbtAta+uH+vA/WY78IgUdyoL7sMgujABnwIEe0GQCg4KHT0sqlEgKqhvJ2sBke2R4KAaEwbdpFj
 2AdA1Gk9ysYsArMj2vj42UsM/w9319ZcAs6k5gQEYYWNx8btnEUp2zq9b6lkD5K1G9D5WaK7RXa
 8Ab8CeybvxSuwqDfLjKJdIGjTI6FwkUE43fwcdc39if464BaWeEzsCDsPy3HWBsvcZgSwysoyGw
 YtMlfKJTeRZvGz754/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160067

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
> power of two. An SCCB must be page aligned and kmalloc() guarantees that
> the alignment of an allocation is at least its largest power of two
> divisor, so the extended SCCB is still page aligned.
> 
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

It is a bit subtle that this really works. EXT_SCCB_READ_CPU is 3 * PAGE_SIZE,
so we end up with a guaranteed 4k alignment from the slab cache, which is
indeed sufficient here. But this is really not obvious, and not as stable as
before, IMHO.

I'd prefer to have this changed to:

	sccb = kzalloc(PAGE_SIZE << get_order(length), GFP_KERNEL | GFP_DMA);

which comes with the same alignment guarantees as before.
