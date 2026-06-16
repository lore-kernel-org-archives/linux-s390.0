Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263C3D5656
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633319; cv=none; b=AGGUcKdF2V6npWfkTtLiSGqj4CFwr4kib1Gtr/anAN2DMsBa8O7Pg9bUu6KtuJZehWR3XWsjulryhyn7UydvEB1oIisdvh7BOO1nC0Y5XmmdxJIfiw/XGx7zvETZ4ZbKXpTodLnlkQ4WKaRWfvOlxnt2MMJ8iPkdZ56xM2G4RtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633319; c=relaxed/simple;
	bh=Gd9chpWAxslq9AskVrcWGxVGLLIFMC8UyFRU7+eb5/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvjfnCewoV4EYAcmF/dhtyw7MXwiSlYLD/NM6hui75XypaykWdBYyOUDCI7BlcPXFmyA5uPJDZT13a5T6GCn4Lm0vn4KkTqJR3GnQLgWS78WZDJ1A7wI3SMNjUig82EPEj7VCnnVLtCaqInAPJfAF2MdI2YyaWNb2qeyqJozVfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a+DcjGNt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a+DcjGNt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GHIHqJ2145018
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 18:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=smBXhn
	EzpQWYnn4iZRfwdnIZVghu6ovSO5ddniUIu5I=; b=a+DcjGNtbCKcWtiMiam4If
	WuWGbuc0xmDA6t5WQjdUgr+gzRxnDlcz7z2pMKN68eAD+T8z6pH1i0FvQstMxwR6
	9g9bBHfvnjd2DFwvIjqnaRJ/B8MAK1Y54AO+b/28JLneEF4rP5yl9ZL4iInJv2Rm
	oV7Erb6fVoxLdwHDQq3c61nRxARnOBqKb5IYDFYdCwWulVRUJoQWv5T8RxxQDwHw
	sj5tIFfaaPIWIeQJINg+z1dowOUvIMuyWEIJXE4p4HTRtm3CF1WL9F1A1TlSI2k2
	ZF2+9P2CVMb6ryRZEomKV6/Oxiujun+HiP2vnTDNMIL1t2D1Nldb+GSdY7wVxsUA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm791d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 18:08:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GI4cMI006068
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 18:08:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y4gdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2026 18:08:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GI8V6C24838488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 18:08:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A82C52004E;
	Tue, 16 Jun 2026 18:08:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C0A62004B;
	Tue, 16 Jun 2026 18:08:31 +0000 (GMT)
Received: from p-imbrenda (unknown [9.111.66.4])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 16 Jun 2026 18:08:31 +0000 (GMT)
Date: Tue, 16 Jun 2026 20:08:28 +0200
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens
 <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Use set_pmd() / set_pud() for hugetlb
 pagetable entries
Message-ID: <20260616200828.6b3536a8@p-imbrenda>
In-Reply-To: <20260616174627.1068004-1-gerald.schaefer@linux.ibm.com>
References: <20260616174627.1068004-1-gerald.schaefer@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4MiBTYWx0ZWRfX/J2uiDkEoSgR
 3Zpzwir5mXHvei21mUi8hrK3FfHtKc9ET4FP1v/4OrXxrByhNnvrtWEZtawVN2VdEj6EvouzUP/
 7SO2GgdKYn6myOG0elBgWF3oiX7AWec=
X-Proofpoint-GUID: ykaX49bqrB5By-dCKJEugqF0bnhid5cq
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a319125 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=2Y6X9A_DlZGOJ9STvNYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4MiBTYWx0ZWRfXxKTt2GEOIqRM
 RS/8NlDd9Is2eNxHWoiwRWKFGiUeOta8eFnYJ7uQSjp1c32T8hs8scDzzz2XMsOScIFvvPPDTrf
 k/lp2KlthsmhwSbCtHejkVloGLsSh9+EWmkPlg3P7YFYdzVmVRDIlD9VsmEwIPfZiT47AceOZZR
 UcFDhgmMVyljORzSb0G9e3tB4depnMSMd5USCSrKh7luw8K5mTvV6wlvVk1IbTk4zkVPYYTElx6
 KcucXt3oGHRK47d5GdOCi2aJ5eLNS3D4+vZdPzvrbkmtVmmEzxWyjJ0jA2GVkM5urZpG5iNemVZ
 fDgomatJ8B1ZQSO7mRAX4c8AMtkpRhzH6jNtwru7//UkWu3UaKyoZ3m65bM/nZAa5ynrBrPCaAo
 K0mBFm3oM4WwsfUw5nbVSAzFdw9r7syJyzfZF985u0QAP6fKovoUwwdOFzcvH5NPvGWIScmZuvO
 SS1n4HpPe4GWVZ8T2Hg==
X-Proofpoint-ORIG-GUID: ykaX49bqrB5By-dCKJEugqF0bnhid5cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160182

On Tue, 16 Jun 2026 19:46:27 +0200
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> hugetlb code is known to view all pagetable entries as PTEs, instead of
> corresponding upper levels like PMD or PUD. For s390, with different
> pagetable entry layout for different levels, this requires some
> conversion action under the hood.
> 
> The converted PMD and PUD entries are then written via set_pte()
> function, but that might add some PTE-specific modifications.
> There is no functional problem with current code, and the clearing of
> _PAGE_UNUSED in set_pte(). Avoid future problems by using the set_pmd()
> and set_pud() functions instead.
> 
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  arch/s390/include/asm/hugetlb.h |  4 ++--
>  arch/s390/mm/hugetlbpage.c      | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
> index e33a5b587ee4..02db08429b7c 100644
> --- a/arch/s390/include/asm/hugetlb.h
> +++ b/arch/s390/include/asm/hugetlb.h
> @@ -42,9 +42,9 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  				  pte_t *ptep, unsigned long sz)
>  {
>  	if ((pte_val(ptep_get(ptep)) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3)
> -		set_pte(ptep, __pte(_REGION3_ENTRY_EMPTY));
> +		set_pud((pud_t *)ptep, __pud(_REGION3_ENTRY_EMPTY));
>  	else
> -		set_pte(ptep, __pte(_SEGMENT_ENTRY_EMPTY));
> +		set_pmd((pmd_t *)ptep, __pmd(_SEGMENT_ENTRY_EMPTY));
>  }
>  
>  #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
> diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> index db35d8fe8609..f84aa9265430 100644
> --- a/arch/s390/mm/hugetlbpage.c
> +++ b/arch/s390/mm/hugetlbpage.c
> @@ -147,10 +147,12 @@ void __set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>  		if (likely(pte_present(pte)))
>  			rste |= _REGION3_ENTRY_LARGE;
>  		rste |= _REGION_ENTRY_TYPE_R3;
> -	} else if (likely(pte_present(pte)))
> -		rste |= _SEGMENT_ENTRY_LARGE;
> -
> -	set_pte(ptep, __pte(rste));
> +		set_pud((pud_t *)ptep, __pud(rste));
> +	} else {
> +		if (likely(pte_present(pte)))
> +			rste |= _SEGMENT_ENTRY_LARGE;
> +		set_pmd((pmd_t *)ptep, __pmd(rste));
> +	}
>  }
>  
>  void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,

