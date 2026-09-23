Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431083AA1B6;
	Wed, 23 Sep 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155007; cv=none; b=SA/AA9TZputllgFJqXOu1eTkxCd1R5jFD4zp7wvWj0t0EwqGF3DHLtGigmedQdcoJ6RLAucBfDiFazHDsACBaCOk3aAbSNWiGl2cgkyw18nARWkl3F8lIuWd3l7wcRciZ15OTJAeJMP84mSgKp8QtPFuOsISiO98N0QS99lIsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155007; c=relaxed/simple;
	bh=G8OFvWoMXgURcjeM1++uC8ZeJrFXRbt45vAmFMc9ojw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALdA7dOn/1TLakHfQ/SOKRLTRE1p/w0iAzkln5q6kjCnGYKq7IdUcQa2/tFaHcPftRjqhDP87sffLf21Ldz6JC/Xx+OhBqvDSAdW/yfQeBqSWi4f7l97jaBYwGEstlGphAbmU51AwBjhGhvATFZWrnu2UFVk6xrzHc6omi0rC0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sKVNfad8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sKVNfad8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8aB0h2742990;
	Wed, 23 Sep 2026 09:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ekAifFySxuN7eTBzJbvVL4QqInmz0s
	yU7wQxG74F/3w=; b=sKVNfad8rEslSZrLrh5R37uv0PuoIHeATBYkluxBok5jZg
	1fqO7f3IHFqBnPBre42UYWa3F23gM3TD0DzBgqPeT2pjTMKUepKaTFHVEPzJxIH3
	dG2Wsu4vHMfKf890kDOZmbX2HjiOQbj9WDL0oHCgKyGOsNH7IpJY/FvR2+0YaLdb
	eR61QbqbEjMfOhEWfadFuUJI69oSBBGjrn4aAKsaL/8k5a+CL0BL3hcBMzuXZZl7
	V/dIhLNZ+Qkof0SL1jX28sr3xWBcLunCvQl7s6D8GuJvOtNc8m20EBs5Pq7MZUvG
	C5IDdvFu5vOr9m9ZIumj1yHayB8q4rjIWxoa+83Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1hvmv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:16:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N93E5K007936;
	Wed, 23 Sep 2026 09:16:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2r1mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 09:16:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N9GVXC53281066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 09:16:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 363BA2004D;
	Wed, 23 Sep 2026 09:16:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A4A20040;
	Wed, 23 Sep 2026 09:16:30 +0000 (GMT)
Received: from osiris (unknown [9.111.16.152])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 09:16:30 +0000 (GMT)
Date: Wed, 23 Sep 2026 11:16:29 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Helge Deller <deller@gmx.de>, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] s390/mm: Drop all pxdp_get()
Message-ID: <20260923091629.9636A36-hca@linux.ibm.com>
References: <20260923043226.331880-1-anshuman.khandual@arm.com>
 <20260923043226.331880-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923043226.331880-2-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 7ujkQ9wUog4GYrmFlvdAZP2vQuJfWomt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfX9MP1i2W+uPcB
 o+ivUKSV+Vq2/LqSXcZiildQAzWpo/xH7L8SDuJymcGFUEJURDgBMWcsqvm50UrlEl8aBrzwIZr
 v+tTtEbgZSSwEAqJwZzGLnOHeOP04QSLBGqKJIVDyDQmlkCSN0IjiBEtR3LAgbjwutwnWqM8Sh7
 AVydrT0cgXPCqQaZRJBi3YsmDwCswUDk4yj+hLG9fRqHXKXxpCCdMN06ZlIp643TfmOtztojaRa
 1Hf5rOjSblJLa+Fh5NRBUFqmPA19S6HBm5sbg+aUNyNmynogRPf1qp4h78gwIJkjCDytuNajM0U
 GpGqPLOyRqIJ3IbD4mPyctIy6IH2TsRQhFEWG574sDFVb5BcmmI1izfSEsWXlPBvq7EEkhf0KwJ
 9zCUXKFv5vvus1Z56h9QXh1UKxMpwRPTQ081ST2zZ55oV69MnjrcAPFs2YvINaM5Fi/NwKhgjEl
 fTfEHReniI367SGA0PA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab398f4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=37rDS-QxAAAA:8 a=7CQSdrXTAAAA:8 a=GzQYO_hYbK6N7GQroPMA:9
 a=CjuIK1q_8ugA:10 a=k1Nq6YrhK2t884LQW06G:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNSBTYWx0ZWRfXyqkcrymsVWtu
 8q6pxW+R1W8Q1UO2CI5cudU/0w2O8S1lkTi3BK5WkiHdPGGqhzrRUsZiDSdtTfFfMrnCIZM3KhI
 QAOCQ9xbS3xW6599hKAqSriprZP5UWk=
X-Proofpoint-GUID: QYGjgB7lKv7pPX4KPcS6XTysovFMVxZD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230035

On Wed, Sep 23, 2026 at 10:02:20AM +0530, Anshuman Khandual wrote:
> Current platform specific pxdp_get() helpers are exact same as the default
> ones defined in the generic MM header (include/linux/pgtable.h) thus making
> them redundant. Just add required forward declarations.
> 
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/s390/include/asm/pgtable.h | 35 +++++----------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index e882663a58e77..0a0b0ec42b624 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -25,6 +25,11 @@
>  #include <asm/page.h>
>  #include <asm/uv.h>
>  
> +static inline pte_t ptep_get(const pte_t *ptep);
> +static inline pud_t pudp_get(const pud_t *pudp);
> +static inline p4d_t p4dp_get(const p4d_t *p4dp);
> +static inline pgd_t pgdp_get(const pgd_t *pgdp);
> +
>  extern pgd_t swapper_pg_dir[];
>  extern pgd_t invalid_pg_dir[];
>  extern void paging_init(void);
> @@ -985,36 +990,6 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
>  	WRITE_ONCE(*ptep, pte);
>  }
>  
> -#define ptep_get ptep_get
> -static inline pte_t ptep_get(pte_t *ptep)
> -{
> -	return READ_ONCE(*ptep);
> -}

As reported by Sashiko, this results in a compile error due to conflicting
types; but I don't see too much value with this patch if a forward declaration
of the common code implementation needs to be added instead. Looks like s390
would be the only architecture which would have that.

Besides that the s390 implementation of ptep_get() will be filled with
more content "soon", when Alexander's lazy mmu work will be merged.
