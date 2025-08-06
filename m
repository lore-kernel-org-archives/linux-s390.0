Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663CA2AEF5;
	Wed,  6 Aug 2025 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484419; cv=none; b=mOGmDcvUaUQOa2Vj5eX7z9DFpLQNjnWibqxUZL8h32h0UCDEL+fF2AMJOROSudT/xhK5UwvXKDIFtzDoTL9r8GOWLEvi8p1r/qx0PLi1ifMYaRi5Su7lXebzpMqB6Ca3siD2vPepsgZ6SA9RpuFfGyhTtTIzqEJa1KQS0qkXpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484419; c=relaxed/simple;
	bh=8MCflECcy4e8x5JVVtNjNDvvtcNBnoS+xd2QnTBTtHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtH9dAaBQmp0NCYmSr+W3oNQfs6DsB42v7DDtgEste/XZm6L26FxNp8vjHEoxsASFjdNDRTkhD1H7T3V5fs3WP5TyJEgrTrWiIaS+Eit55+HjqspU2peiNTIoxF6ZqGtyt+habu9EJLMObmXUwX9ulQ4PjL7l2j03J1FnXuD5A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/RvTxEa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/RvTxEa"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5766tGP1019487;
	Wed, 6 Aug 2025 12:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=T1dSRtgDFd3rpqxp+UUfdWimEpYJ/L
	qTvkYYD4B7O4k=; b=f/RvTxEau8SN2fssUaIC9F7Sh/HqM6Kiu6JNkM8obi8oLa
	UuChkgmYk1dj2Q5eSVXVjOr0H4SNoYDL+7/etP9yePdhfGy8w0qJWS1F8+45ZurL
	NYYawB4BX2dr593ELb/jIa0f8vcjufBuIXpDtj5II0rR4K51MFEnzPX3slqbcrK/
	fljI5dhROdhUW7Q200nTzNdrvyFwEEIThDEEHw0H00MyMU6ZpJqZSyMK8x1A0aXO
	2XrHbjTLQsQY+3IE6IzkfngQAUHDyvDTnFmwpwZFUNttx5PG3zxFrVdL5FqIZ+y6
	rT9uoFTsDfM88k66GKC65l3TJ+yXf9HwtC95clHQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tsfj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 12:46:51 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 576Ch8nb006741;
	Wed, 6 Aug 2025 12:46:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26tsfht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 12:46:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 576C7PeT020616;
	Wed, 6 Aug 2025 12:46:49 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwmuktn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 12:46:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 576CkjLx50397510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 12:46:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6EC820043;
	Wed,  6 Aug 2025 12:46:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2664620040;
	Wed,  6 Aug 2025 12:46:45 +0000 (GMT)
Received: from li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com (unknown [9.111.70.156])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  6 Aug 2025 12:46:45 +0000 (GMT)
Date: Wed, 6 Aug 2025 14:46:43 +0200
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2] mm: fix accounting of memmap pages for early sections
Message-ID: <aJNOs0IB1d33GSSW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
References: <20250804151328.2326642-1-sumanthk@linux.ibm.com>
 <20250806090320.wdt4zsfiambtgkvy@master>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806090320.wdt4zsfiambtgkvy@master>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QEnwZJtDuhjBjmp6iHB0OJwXK6H_odhu
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=68934ebb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=vht8kvy_zf64N8Etz0IA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: e9cBLpYsr6FVqWELpOywZJCGpor7R9pg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDA3OCBTYWx0ZWRfX39J9IwK7GjJa
 fuy4krFDha5iWSbaOR4YZiIyUFBi97WqF8mXqW8p7iZdfag2Xt7bHlq3mnsSorxzK18v+dazKS2
 xPLN6NB074jvqvq6g5pllnuiXDHBm7s6Rv1B248EKM0kunrasU5zqaQ4bU4wXJbN0gMNQdATSbv
 L0n6ECj64I5cvnFeQDLVXAIqyicyRtfZ+zfTLgrmDtFhsAyNH9rhA/A0PibOHC6rCKyZk7lWMJy
 bUEdw4N4CTaiwv2ufxaFkMKk2sXJGKSA70pYnE4wcNbuXTeucP3jxiQULtbIiUynZUbntAB9Ww6
 LjbQuisamnyMASmSgUJfE21Blm6vQmCnPOEHw/97SA8W4K7VSOjXDL3hg1NQ39Rn1psgZwl8wpO
 EvKnc2Mh++6IGa1SadLdybcEXMDW0fvNnJTnJt2I8/VdG7lYUAEGXlMPu8weRF3Z/prLNY2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=713
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060078

> The change here is reasonable. While maybe we still miss the counting at some
> other points.
> 
> For example:
> 
> a. 
> 
>   sparse_init_nid()
>     __populate_section_memmap()
> 
> If !CONFIG_SPARSEMEM_VMEMMAP, and sparse_buffer_alloc() return NULL, it
> allocate extra memory from bootmem, which looks not counted.

Currently, the accounting is done upfront in sparse_buffer_init(), where
memmap_boot_pages_add() is called for !CONFIG_SPARSEMEM_VMEMMAP.

The function sparse_buffer_alloc() can return NULL in two scenarios:

* During sparse_buffer_init(), if memmap_alloc() fails, sparsemap_buf will be NULL.
* Inside sparse_buffer_alloc(), if ptr + size exceeds sparsemap_buf_end,
  then ptr is set to NULL.

Considering this, perhaps memmap_boot_pages_add() could be moved into
__populate_section_memmap(), with the accounting done only if the
operation is successful. What do you think?

>   section_activate()
>     populate_section_memmap()
> 
> If !CONFIG_SPARSEMEM_VMEMMAP, it just call kvmalloc_node(), which looks not
> counted.

Sounds right. This means nr_memmap_pages adjustment is needed for
!CONFIG_SPARSEMEM_VMEMMAP here. I will recheck this.

Thank you
