Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B503542FCB5;
	Tue, 11 Aug 2026 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786457537; cv=none; b=R32nG4V5r/hgc506PjQR7Nw0B30HooXg2HseVgPnlI6Fab0gFiV++c9N+DKYT64vQXgNrvGBm/Xx7rWYzkXi+R8Uo96Q4DtijHiMi0cWJ1swu3VPuX4eZfJq9Rfe2LkCQia6mgaTqf/RJ1fftbhBny+XxoSMV6Iktr1/yFAViWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786457537; c=relaxed/simple;
	bh=XcPWxolSOxi4hRtYGAqVcWQ0ALO4HbD7qeL5N4VuxAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoZfWHrx1e60NeDJpOZp86nU3SXdV7P28XSoMgyANh1LnEk6ljHc+X6zF17KKdxp3zOpVCMSHSt9bpvhfaYzbgvRLT0Bcq8AzdY4un/u59FA93YcIuG4kqKFnYK4R4Q0OwPt6iwNbjRctBjI8dXYtBRjxEkedweZ47EbysyJBLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kd/FA7kG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kd/FA7kG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX5L63634496;
	Tue, 11 Aug 2026 14:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Nu8DppPxspLEUGtfwKJznEJMcjgr/w
	SJWNTe2aKtGDo=; b=Kd/FA7kGCD3CEdncl7pVmV3rgHPDdZWn9CQ8D8CT1jPRIr
	x040yfqHAmizyW+/yhuj5HJ7gnwXkf1W3I+5tU3Z4ZeMcqAQihqMaZye/F1MY5hS
	yFcAmDBkrnsFKaO/hHjAjkE9ut2yBcbhQOJbuAN5uT9gvV/3p989DjGDyUdprOws
	XoAWcDaNIHiyanPX8U9BiSdyFOgR8IOd0SblhQ3MreaV7Yt89J6pnfp+Xy64G7ax
	FB/Dytfcx9Ehyjshzq9NtpfDXBALUr9zI7fcyBVEukFYYMVs9F9MBRl7Mw2WM4wN
	M1Mc0xPdfjnNxYIzfq00cJFWQrMOMwZ7fDX8Ct2w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23p1br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:12:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEBIg1016350;
	Tue, 11 Aug 2026 14:12:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w1bhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:12:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BEC4gH27984202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:12:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A209F20043;
	Tue, 11 Aug 2026 14:12:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DD8820040;
	Tue, 11 Aug 2026 14:12:04 +0000 (GMT)
Received: from osiris (unknown [9.87.143.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Aug 2026 14:12:04 +0000 (GMT)
Date: Tue, 11 Aug 2026 16:12:03 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Fix fail path in crst_table_upgrade()
Message-ID: <20260811141203.12308B7d-hca@linux.ibm.com>
References: <20260811121316.2622460-1-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811121316.2622460-1-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b2db9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=RPZ-f58JHGKQJTKQA7MA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX41J/suBnxx5p
 RJKtYn4GPAhbPy6eDZ6rqnH17UqMMY20aX2nHM/lWW2GkQeDQvDM2arrrf9rd7Gse2mbzHa7+Ko
 gAEmIUncDzqOJmFiE9ZcmFj7Hi+17oI9+lTs24hBmOU8SQIUKWgmj3SHSwi4uyr8CtG5+9riuSf
 GjIlUtIn51nLbP93U6HDD6E4vsRbJRLzxArVNMPcCkwSlrcboqHoJaeaP4xDLFnCD108MRI66N0
 5cPNeJTCMKccC4bKC4TGjTXNdFNOfyCu21csYPC+qBek4hTJ9SrUkktsckX/oZMofuZlG5gOqpG
 jewUYKd7p8IIZ4vJrMzzTqR5JEaa8PpnWdvMIZu6NsN4mRCLFur3O9KZv5AzJOBn/1RwhIErg+q
 Q2e5//6ItLAFycWy0ngC61jZ8T5ShASzAPQPvN7k2S9+4DrIK8EdSro8BaawhBdKxz12x2QjMCm
 Nl+UoJrXT4fD+Z+9slw==
X-Proofpoint-ORIG-GUID: FRgG_mWd1kqjP4CrAzwZstBYdH5zyRKR
X-Proofpoint-GUID: FRgG_mWd1kqjP4CrAzwZstBYdH5zyRKR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNyBTYWx0ZWRfX2z4NvL6iEDda
 Z4IWewp2mQh4V6+dBINyceO23i855l0L/Co5kbvwt0YW+dzHDiUnmlst9FM/9VYCzwgGOy0QQU0
 CKUpveQ2D1DszVcllnrpxb0youzdZUw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110117

On Tue, Aug 11, 2026 at 02:13:16PM +0200, Alexander Gordeev wrote:
> On a 4-to-5 level upgrade (unlike 3-to-5) p4d local variable
> stays NULL. If the pgd allocation then fails, the fault code
> path calls pagetable_dtor(virt_to_ptdesc(p4d)) with NULL.
> 
> Fixes: 502269ab98b5 ("s390/mm: add missing ctor/dtor on page table upgrade")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/mm/pgalloc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 9610770fcf6d..87a8bdb3e51e 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -69,14 +69,19 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
>  	if (asce_limit == _REGION2_SIZE) {
>  		p4d = crst_table_alloc(mm);
>  		if (unlikely(!p4d))
> -			goto err_p4d;
> +			return -ENOMEM;
>  		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
>  		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
>  	}
>  	if (end > _REGION1_SIZE) {
>  		pgd = crst_table_alloc(mm);
> -		if (unlikely(!pgd))
> -			goto err_pgd;
> +		if (unlikely(!pgd)) {
> +			if (p4d) {
> +				pagetable_dtor(virt_to_ptdesc(p4d));
> +				crst_table_free(mm, p4d);
> +			}
> +			return -ENOMEM;
> +		}
>  		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
>  		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
>  	}
> @@ -106,12 +111,6 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
>  	on_each_cpu(__crst_table_upgrade, mm, 0);
>  
>  	return 0;
> -
> -err_pgd:
> -	pagetable_dtor(virt_to_ptdesc(p4d));
> -	crst_table_free(mm, p4d);
> -err_p4d:
> -	return -ENOMEM;
>  }

Imho this makes the code even more uglier than it is/was. This is also yet
another bug which is/was only possible after loop unrolling happened with
[1]. Another bug, which would not have been possible without the rework back
then, is [2].

So I would _much_ rather prefer to go back to what we had with [1], of course
including the additional dtor/ctor code. But that code was much more readable
compared to what we have now, especially considering the additional fix which
is proposed now.

[1] 31932757c612 ("s390/mm: optimize page table upgrade routine")
[2] b5efb63acf7b ("s390/mm: Add NULL pointer check to crst_table_free() base_crst_free()")
