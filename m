Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A533BD657
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050495; cv=none; b=FTxcqb3q6bWCgLimI8AmaS0JM8EQ0NuD8YZb4acTUfoTZS5wl2GihTc1AIXENU+JHoLcJwL/ayyS/n8gIUnsSMONZT2g1ifYvBsY1/Jgb/1cW8bAy66s1G8JIMPFspEZG5Gg1jM09j5xSwCersWQC7UZO1PjW2Q5qrvGVvT9g4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050495; c=relaxed/simple;
	bh=RzNQK7cSosl/j+oLaTPa2r8TqxQ9GXKLWQ+LqtdbYIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0DUMzJvTlEJLx96JYkKKd38At9virREqPrzDAI5OcFXXiLw4Zeo2MYyXh6wip7nlK9lHhdhnOstaVDFT8IDMFqG7dXwEXjd3UmJGG03900rt41UQeRDNymPf/Sc72VaSPVu+xj1oEDfU099gZGa2KP7xpOuS0myxE0w8/izXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AXpPvn5y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AXpPvn5y"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLlg411684630;
	Fri, 29 May 2026 10:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9/rM+g+OvQ3OG02R2XBJ7/wdplNkAD
	4PI999BDKd0IA=; b=AXpPvn5yEdl77epXK33A+pyo4bnplQvWGpaCyxykIpij/P
	WxrLs2uxRCUGSv0OPVLu0BEPNVSCa/6mTzi6rwVotG+dJ+CzKwNJRfTsZYu6DTAP
	sYd7TBibN0q/eAZG2rfXzOu39zV1O0AkAmXylOc5MmoK3pnCL4cpIqPXvqF8xMRo
	sDZSIK3/U+Q5laCNoHI8MGDdBSmrUGMJmeR7qHy8JmBV2LlozxuBgZyOimUgCtlP
	DMzKj17Zu7+QpVC4illwwUrJfgxdpsMsOii0gPAcCXDvRl30rfenprMM4AvdTICs
	wonOsbhTnEqY6w9DXLT/t5ZCeDUOGNhMtKWHL8Mg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884g3g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:28:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TAOBMh013637;
	Fri, 29 May 2026 10:28:11 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbd4jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 10:28:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TAS88N51052894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 10:28:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F4F320040;
	Fri, 29 May 2026 10:28:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A272004B;
	Fri, 29 May 2026 10:28:07 +0000 (GMT)
Received: from osiris (unknown [9.111.13.205])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 May 2026 10:28:07 +0000 (GMT)
Date: Fri, 29 May 2026 12:28:06 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/6] s390/zcrypt: replace get_zeroed_page() with kzalloc()
Message-ID: <20260529102806.26496Fb2-hca@linux.ibm.com>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-6-b7108f54d722@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528-b4-s390-drivers-v1-6-b7108f54d722@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a196a3c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=_fbNShzjlm3lxxrkr6wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: t0PvoK1yoXvmaIe0q_1OoQJJSDlmfPCN
X-Proofpoint-GUID: t0PvoK1yoXvmaIe0q_1OoQJJSDlmfPCN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMCBTYWx0ZWRfX9g3ikosxo6B8
 S3d/43cdzCs8GUQh9HA2Dvkgt3FyOJEN3On+RGoR5JSQlrA/xoctqtFUwNtCnRlYj2bNpbX4wTC
 a/JglkwXYJGuVEeyAhzBoymU+gk1e84SRWzzl54b+R2naENUZfmUjWKXWb8p4LAR3E0aGodzhGT
 GUASupepD8SqbabzLhrBYICtbGSzTTI0j0YzNSjGs/J6rL47AmkGDlEdm1gTYyiv0oMLuf9m0ch
 fvlYh60TeRxd4Ekjs7OgM+souMY+qORyJ1gjeN4p/bZlAKK16kKn5SqAri3yoNBd3lHbmH+tPAL
 tW1e3xqoaZouRAaSmoHZ6RczletgkanLWGsh//1kS1EOnR/aw3wWw1ZcjBoh6Z7yZtIGnC8vSFb
 9IQ+GraWWGc8IG3boAPSvLBcqd+1w9Tp62cSpSBn2TGwksoE2jn6ZNp4QITeJTwvlKmWKwaU5IQ
 RbcGd765BTJVR4xsE0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290100

On Thu, May 28, 2026 at 10:09:54AM +0300, Mike Rapoport (Microsoft) wrote:
> zcrypt_rng_device_add() allocates a buffer for the software random
> number generator data cache.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
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
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
