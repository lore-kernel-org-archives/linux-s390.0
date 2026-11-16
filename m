Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794850511;
	b=YC/jHuMaR9k7hp5xemRqKx1MKZflszg6HXXnvPX1IKzdrmVfKdGJuZM0HfUhAookkDQ3
	 jOMCqHON6nO1hnK8/2+hotXZyLqf8Kv0yS+EuJjQng4igD/wNg5CJC7o8GNaSCFu/NfRH
	 EKHvWy8RFf+pMzaWMx+IHaDKhGNFUShKFUx2xe9+2sUqVIUj7aNc6B9dF39dGTA0wAYP2
	 g1zGZJecR4+7qC/q6itXFGaui3uf/jvd2m4/Z8Bifcgd7yx4vdHJ0aW5TgZWpETjt3DHv
	 m6erRDgPrI0iaddGF8ITL73un5eB0jeiknQxa0lwy6il8B03+i1o5QOBZDGa9cK7m1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794850511;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=te7C2wbyDwcJurO4QeE1wdh3aR34pYnV9S24yGWzngk=;
	b=uDTHycdIYwIB76XC2aOKVOgfPez5Mr38subcT5of3yTAq/NmsXLNwoodQfcR/9AZjXcY
	 frC42olhU7NAvLauwLIMmW5ne7K0raLKPSLQLuyCJDEIoFzvsn45aimpjUnTzHODvPBga
	 muW+BjUodNvK2U9F1dQZBJjBsCQkV3M3PJpr5uH9CGx1RX1fkPzK6nkrSlYIOgQRiuRz9
	 9WTwQfkijl2Xepcl9tEMC/FveHuhE7yo+jdvbDdhcGUKZ6ETHQytUrF13Avx+LWxKhNjY
	 szk6NRZNm6TWlUAksb8gn0KkUTbtOgSXXyH/oHjOd1mzOt9LKBdrZWS8jwgCYfUSS8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nd2uNLnG;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5524606A31C;
	Mon, 16 Nov 2026 17:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5524606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nd2uNLnG
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGQ69T3730012;
	Mon, 16 Nov 2026 17:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=te7C2wbyDwcJurO4QeE1wdh3aR34pY
	nV9S24yGWzngk=; b=nd2uNLnGHXV2lgGyE/n+ka0e9q5Bl0NvuqhIB9AK2Aqo/g
	U+/ljqVSXk8rhEO97gHh/5sl+GSvCjDK0CQ8blJ8y8KvUt/tFXA86Q+zF16ClOyu
	2tMYWXza0lz2+ePEh6EkGb9dmPOCpUHjttTaof040BlSAp9/NFUv7fcsn/QAh0q9
	oY2VI+cwCpXs/L7V+GMwwQ3W5b9Y7E2lmmakjGOwQrnqsb3ZpY3T4omZPOrjudA6
	vjW1owOfIeZaQPXFV06VemBxcgvjQiQE9TnFraMvqxuMqf1gC9sO9kaTxHOmcv91
	OEH3/LFK6HZptafXpmG6w0pMuG7IR22PD0eUUCdg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2kxca1-1144
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 17:35:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC4tuc210487;
	Mon, 16 Nov 2026 13:47:12 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt08xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Nov 2026 13:47:11 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AGDkw8n30736644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Nov 2026 13:46:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDAEB20040;
	Mon, 16 Nov 2026 13:46:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CD1820043;
	Mon, 16 Nov 2026 13:46:57 +0000 (GMT)
Received: from osiris (unknown [9.111.42.169])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Nov 2026 13:46:57 +0000 (GMT)
Date: Mon, 16 Nov 2026 14:46:56 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/5] s390/hmcdrv: Replace page allocator calls with
 k[mz]alloc()
Message-ID: <20261116134656.125125Fdc-hca@linux.ibm.com>
References: <20261108-s390-char-ready-v1-0-3db507722530@kernel.org>
 <20261108-s390-char-ready-v1-5-3db507722530@kernel.org>
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
In-Reply-To: <20261108-s390-char-ready-v1-5-3db507722530@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afb3ec9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=QsPt8aXxvDvY35rw5ugA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 0aZFqTIu-qNzewmkibGc8dEsfnURC-Me
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX2J8YQogyuJHm
 qAvgBWiso6Sw3yV6Dnae9xhPai3cjw614XwCx/PQmHI3kBwFsd7nBMns91+QnIj0Rdohij0UaXK
 nvBA4Rz4zegBqjS4kiJ5ercE6mnYH0Y=
X-Proofpoint-ORIG-GUID: 0aZFqTIu-qNzewmkibGc8dEsfnURC-Me
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX9uu4plKdGiwv
 gQGiYTAIl7NUOdLSt32KDOXR0BJ3fABFmiyb6hkONgNeoQbfy17tX32q5eoA7MO6RYi6wDWOMEU
 KxJhyj5ymgor0s7FmNiBdUmXabGe6wWDG07BPEMAk3FqVyi7bIW6+eVZqdhgsQ57bI2iAg8D60V
 was10tiFTi7cZuk7pEidQxG39wSqE8P5I77Dvgx5xkVNx+BebF6BLMaynfG8IYz4izjbZ7v9NcS
 fftsfQbDCOJ5o6n1FmExz/Pi+aHeBqTnNh6al9NQKsEaBpKo5uTpOxpge19tB5rhl63E/DY6lyi
 FDplwSIKverwmLx6URJCPLuw0Gjs71QPMqhJNn7l2rSjBHb/CyCMgowmnLKWqTBasoB9NuoASJf
 SFnMZgbikU1eORs4kH24n6zpjt1Q5L+vyzluYdHYVJEw/VsMvL6OGQTJXkpBSDNGT9p1fhkwrKB
 YTU9xM8Zp2onPtA94fw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069

On Sun, Nov 08, 2026 at 10:49:02AM +0200, Mike Rapoport (Microsoft) wrote:
> diag_ftp_cmd() allocates the DIAGNOSE 0x2C4 parameter list used for HMC
> file transfers under z/VM, hmcdrv_ftp_probe() and hmcdrv_ftp_cmd()
> allocate the data buffers used for the transfers and
> hmcdrv_cache_startup() allocates the buffer that caches the contents of
> the last file read from the HMC drive.
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
> Replace use of get_zeroed_page() and __get_free_pages() with kzalloc()
> and kmalloc() and free_page[s]() with kfree().
> 
> Round transfer and cache buffers up to a page for the required 4K
> alignment, without rounding to a power-of-two number of pages. Reject
> unsupported sizes before rounding.
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/char/diag_ftp.c     |  5 +++--
>  drivers/s390/char/hmcdrv_cache.c | 18 +++++++++---------
>  drivers/s390/char/hmcdrv_ftp.c   | 14 +++++++-------
>  3 files changed, 19 insertions(+), 18 deletions(-)

...

>  int hmcdrv_cache_startup(size_t cachesize)
>  {
> +	if (cachesize > KMALLOC_MAX_SIZE)
> +		return -ENOMEM;

What is the reason for this check? I can see that this seems to be a
common pattern, however the buddy allocator would warn as well for
allocations larger than MAX_PAGE_ORDER if I'm not mistaken.

> +
>  	if (cachesize > 0) { /* perform caching ? */
> -		hmcdrv_cache_order = get_order(cachesize);
> +		/* the buffer must be 4k aligned, hence round up to page size */
>  		hmcdrv_cache_file.content =
> -			(void *) __get_free_pages(GFP_KERNEL | GFP_DMA,
> -						  hmcdrv_cache_order);
> +			kmalloc(round_up(cachesize, PAGE_SIZE),
> +				GFP_KERNEL | GFP_DMA);

...and that check wasn't here before.

> diff --git a/drivers/s390/char/hmcdrv_ftp.c b/drivers/s390/char/hmcdrv_ftp.c
> index 3312b2ac00a9d..e22789b532de2 100644
> --- a/drivers/s390/char/hmcdrv_ftp.c
> +++ b/drivers/s390/char/hmcdrv_ftp.c
> @@ -238,16 +238,16 @@ EXPORT_SYMBOL(hmcdrv_ftp_probe);
>  ssize_t hmcdrv_ftp_cmd(char __kernel *cmd, loff_t offset,
>  		       char __user *buf, size_t len)
>  {
> -	int order;
> -
>  	struct hmcdrv_ftp_cmdspec ftp = {.len = len, .ofs = offset};
>  	ssize_t retlen = hmcdrv_ftp_parse(cmd, &ftp);
>  
>  	if (retlen)
>  		return retlen;
>  
> -	order = get_order(ftp.len);
> -	ftp.buf = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, order);
> +	if (!ftp.len || ftp.len > KMALLOC_MAX_SIZE)
> +		return -ENOMEM;

Same here, and as far as I can tell the Sashiko finding seems to be
valid as well, even though it looks to me as if this worked only by
accident. Also, as far as I can see, the reported "delete" command is
currently not used at all from the only existing user space
application that I'm aware of. But let's not change this, please.
