Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FDF37C11D;
	Thu, 23 Apr 2026 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941496; cv=none; b=EzfRfmDY9yEWSJD4dNYPTysYVHxyWFEPH/0wNOSVsP24uujh4mkWpRhrJTBDb9rQeMk4YfHhAAW6tcTjQsG9yWx2iHc0qIbsiZd79hAuuPcJuTkgS+PMqNZ9B3PdaJuC5s4LOyp7O16E8u0q+WRWwCj39Rqi+wXkBOSlkzoGXHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941496; c=relaxed/simple;
	bh=lwnQZYpGBnoDDLbMLd73wnOfLBl/th4TW8Kkn1gYvu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASlDxqwVLx4yGis5EZdUNndCBM5moR1a8Yi2xZudDZJNDj4UpHcNEgF6jQY0Y5SnPUafFilIQREdpL7OzA6FQNCpTwV4QKV9xg2zB2190fJ20sAsaWR7NL0+TOTYHGg/nlIKKDMDdWe0lJUYJ60pu3s3V7fLWfo+zDuYrKUR99U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ac7JLZub; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ac7JLZub"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6kvgM3514986;
	Thu, 23 Apr 2026 10:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XsmtxtZFdx4nlYYBj8GUQHCxAi452X
	GQFD1uTC6aPXM=; b=ac7JLZubFc7HudFhppE3umKLDUeEVRq+u5j8N3/SfUhs/X
	arfSYwTX4K15MDoQqdo+6rZnaeiBUxUAOW1Zqe6WMEMJLvMT3VIywZ2Fc8Omkdi4
	pTj+wiIYAnkKLFDFCtUngPmn+LxwsVBSfeD5bqc/N/5MoNd/lVhCLQCs/V/0/Q0v
	eGQRT1WyEgUmnSNItuniK9XnOS1EKQjXgGnYLMAlnIlA8d3HARBInC+NbFaTPtij
	Nk39olGaVTI1F1J6gHPCAD96YvKe6YdwIPxxzejinmvl/+pqHTvDnZrishygMkuZ
	FUGT/PVitQYvsoBzUb5SI+Y7JHT6dL9tyzJ6r7LQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28810-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 10:51:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NAZVTp023346;
	Thu, 23 Apr 2026 10:51:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxx8sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 10:51:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NApLkp51184026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 10:51:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 872DE20040;
	Thu, 23 Apr 2026 10:51:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 567892004B;
	Thu, 23 Apr 2026 10:51:21 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Apr 2026 10:51:21 +0000 (GMT)
Date: Thu, 23 Apr 2026 12:51:18 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] s390/mm: Complete ptep_get() conversion
Message-ID: <20260423105118.10371C15-hca@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <7ad766612a3095c8c8d9a253ef0f484ef98196a5.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ad766612a3095c8c8d9a253ef0f484ef98196a5.1776264097.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNyBTYWx0ZWRfX5S+wMN54K7jB
 VFAHWoUzCfcvHKec+E6tZ3plfnkS7C7o8+GjkD8wGtefXHTuT67ooXkYnLjnybkBhRRbLXH1Hns
 rgV9GmTRfEBCPrkRrV7PgmRdQ+ncYDJpCRh+d9RZZLiGeftZmTa40cU3PxnBr8EX39rORZnbUUN
 8kM9Tec+5IdkwBynjhgA+YLcbrNmTA73o3oL2Z1OH12WzCrJAZU3VFEL/mLdmSwUqI95D+IX9a+
 VkRgZThFQzz0HdBkL+eSvdUZ74qjq+iDc6dKSbFNKYtJpqmuUCRTg1vAJIHwoW3GkWo8kjVVAyQ
 RlPKp1D9mNc0q11ddqXSccSjFvT4LcL8dEZOfzOiu5Y/LCgkgUWFjICwcJO8hoCssVfD/AXA8AO
 1WEortow8GF6DtXbT5H7BkRV+QvBqyVl2iKRDuUoB4UfyX9WYgTA265r8qguNCo4zqk8LjoeDm0
 gUkc/kx7U7Ag8a66R5g==
X-Proofpoint-ORIG-GUID: Tm9jtMLTXeV_oUVbtFqu986bLquLPsUy
X-Proofpoint-GUID: Tm9jtMLTXeV_oUVbtFqu986bLquLPsUy
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e9f9ae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=6BLRMVARryNAVYdsrhYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230107

On Wed, Apr 15, 2026 at 05:01:21PM +0200, Alexander Gordeev wrote:
> Finalize commit c33c794828f2 ("mm: ptep_get() conversion") and
> replace direct page table entry dereferencing with the proper
> accessors (ptep_get(), pmdp_get(), etc.).
> 
> Override the default getter implementations even though they are
> currently identical: pud_clear(), p4d_clear(), and pgd_clear()
> require corresponding architecture-specific getters, but these
> are not yet defined. This avoids a dependency loop.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/boot/vmem.c           | 32 +++++++------
>  arch/s390/include/asm/hugetlb.h |  2 +-
>  arch/s390/include/asm/pgtable.h | 60 ++++++++++++++++++------
>  arch/s390/mm/hugetlbpage.c      | 12 ++---
>  arch/s390/mm/pageattr.c         | 42 +++++++++--------
>  arch/s390/mm/vmem.c             | 82 ++++++++++++++++++---------------
>  6 files changed, 138 insertions(+), 92 deletions(-)

Was this a manual conversion, or did you use some tooling?

I'm wondering since I can spot not converted locations, e.g. one in
__kernel_map_pages().

Besides that:
Acked-by: Heiko Carstens <hca@linux.ibm.com>
