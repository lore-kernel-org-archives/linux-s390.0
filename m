Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492654;
	b=E3QJYCC99BBoTI8YIOY+FrEJAwMDHfzwvmOBohw/EAjbsGsMZRHfOV1FHOAQvSYhB805
	 ugnoekXcNx+nGHldZsCRVZQfhseDSTmD3V0KiTpcGFQrdPbg2Cf/xBLmmsU74q2mNaTEB
	 fl0Xr9ooip9VSpDftqTfg1m/GnpHICZdoD2kmKnAsBdnmF6xx7Vq2eh+SLhEUQ0WXAyQD
	 Bu6kOE+vki4YsqfoCObCakSHX8APIlvM1/lAC0PRCH8jHdOymcO+Ve56yS1WIGrrMWfMj
	 uzHuycMM/tJNU/VEiwkUHUys/b2yTPpKh8bzy6P7hD/RlszDe4XeLXtgB3oThfG/1PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492654;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=y8LtVMgdBu3BRtlUo0WEuwRsBfw6KOHlQGQFw7HpiRo=;
	b=XT7kLL2PQNv7E2eO0oAEb2Dej7UtERWTXb3dbDFug7YEmSK57q9UO84Im5bLuEPzlc+1
	 zAeE966xLyEG979WQGUl6XQ6LywpV4ud7lkGiS1YbPUK1g/XMzDK0UksJVzx/eZDEtlIg
	 YeV4ljmyXdyWiklbjsOgRCTnzQ0LJqYX61QAQHNRB+JZX4AcOZybkuQlSGCEeeXOZU+S5
	 HfYu5/EJ9IIJtdLHSnKw3dvhmdBmKKXlpj/9XbHn7QfTB9P49vYWPRGyNKtsvs9FFvLfp
	 OXozraYUu9LtDJONvZ/+xksZbtqiJC/1oFJG2MYdr4UbvAYO0YBMYzEKi+b6WVR/3oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NGk+mxXq;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257CB606A330;
	Thu, 12 Nov 2026 14:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 257CB606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NGk+mxXq
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ibWG2858007;
	Thu, 12 Nov 2026 14:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y8LtVM
	gdBu3BRtlUo0WEuwRsBfw6KOHlQGQFw7HpiRo=; b=NGk+mxXqf8NrWp7oCUHeTU
	dHrnO0mRSLa1VEpLKf4rZSX7SFSP3VdvgpqNQ4ti+/FqKmz7Klc2qNlR7LvuGXj2
	dOXHGFHMf+4kwMpj51JyIf6mcSKkvRzYT2mpCukc1lh0HDQJosAhCl8o4U9a7piP
	aBM1OuWbTsHuxYQOlRNWYX/7wUsk8nVLzDIP2yCVmT36TLbrx3DgCefUEwKaFxqO
	ZrMqcURc/6DWMnVScZeooxEAr6N8icmEglKbuCe8bjrBrfTDRayQ5mv4C6EtX3yG
	RIgIb59sVBHpCFGw5J2M4pp5nmdhXlzgby4BXWKxb+HjenjoPVy2cdVfRlGAsn4g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv6jvn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 14:10:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACCB7h9669730;
	Thu, 12 Nov 2026 14:10:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd858cfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 14:10:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACEAiKW27787688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 14:10:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C07642004F;
	Thu, 12 Nov 2026 14:10:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 418922004E;
	Thu, 12 Nov 2026 14:10:43 +0000 (GMT)
Received: from [9.111.75.87] (unknown [9.111.75.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 14:10:43 +0000 (GMT)
Message-ID: <ab6581e5-6344-4b5a-8126-5d6d9cf6ccfe@de.ibm.com>
Date: Thu, 12 Nov 2026 15:10:42 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] KVM: s390: Fix UCONTROL inconsistencies
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261105153705.208516-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfX4/sb4Mv7y+H8
 LCBBMFO/kpu6TnoKOIpLiLF6JhozhzVxoH2XJKAticMDtfWY8GmP7in5s8ozKm4QnDmKA920Igo
 g2Ro4VNHMXPtGBGSgsyF9CNE71IiFbE=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af5c8e9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Lq7HJeEGbxt70aPTqbMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bElnMRzKlSTYnPY2ZN8oT-2BmJCX8Kl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1NCBTYWx0ZWRfXyMUPpEXCPJ2s
 zHNYChMHxNk1eBHOMmotRCbTXcm3jGYG5Uaa+WZG8qQqfc8pOw3vGez45PBOX3VHVsahOHIXeTr
 3XL7Fh+jlARBuWKLxxPDXYDsMFnl9CgW2Q5rDtpoir9bPnFac29eYB0qJIYSs+DqO5tQko9BZLE
 Ttcv5theT0TXyyETD1U9v8t5xCYRLEGauglaupQ97a8gljiczyMlvGGG3JNRl8cpcg6uxhQ3gCj
 NNpDWDEyfrL6jpLZQzZtB6dpeTLq/sUYqImGS2OpYsp7JgHYjH69f3eAOosJTjHc049dX7zbyx7
 /F4e3g/O6F3O10o+kcfBj2xN3nbQfVqEbs1fYqN/ZL6aWbyluEYpiziw5Q1pnrNBtVbNIc//4Re
 OwKUKsgdk+ATOjLk5pUMgbu1QA6yFXhl/sFfNS9qwFpYOy8eJ80isv341aZXbwEZvEDyzByigbp
 SwNLpWJNDA5QcgFeVYA==
X-Proofpoint-ORIG-GUID: bElnMRzKlSTYnPY2ZN8oT-2BmJCX8Kl9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120054

Am 05.11.26 um 16:37 schrieb Claudio Imbrenda:
> For UCONTROL VMs, when a vCPU segment entry is mapped but unallocated,
> the tl field was set to 1. This collides with the present bit, which
> means that other parts of gmap would mistake the entry for a present
> one.
> 
> Refactor the code to use a different combination of flags to indicate a
> mapped but unallocated segment.
> 
> The new flags combination will result in several functions returning
> -EFAULT when used on UCONTROL guests. This is fine, since those
> interfaces should not be used for UCONTROL guests to begin with.
> 
> Proper fencing of the interfaces that are not allowed for UCONTROL
> guests is outside the scope of this patch.
> 
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

as far as I can deduct, the sashiko report should not happen.


> Cc: stable@vger.kernel.org # 7.0+
> ---
>   arch/s390/kvm/gmap/dat.h  | 22 +++++++++++++++-
>   arch/s390/kvm/gmap/gmap.c | 54 +++++++++++++++++++--------------------
>   2 files changed, 47 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> index 90389d47ba4e..e6215c0b571f 100644
> --- a/arch/s390/kvm/gmap/dat.h
> +++ b/arch/s390/kvm/gmap/dat.h
> @@ -109,6 +109,8 @@ union pte {
>   #define _REGION3_FR_MASK	(_REGION3_MASK >> PAGE_SHIFT)
>   #define _PAGES_PER_SEGMENT	_PAGE_ENTRIES
>   #define _PAGES_PER_REGION3	(_PAGES_PER_SEGMENT * _CRST_ENTRIES)
> +#define _UCAS_ENTRY_LENGTH	0
> +#define _UCAS_ENTRY_OFFSET	3
>   
>   /* Soft dirty, needed as macro for atomic operations on ptes */
>   #define _PAGE_SD 0x002
> @@ -421,6 +423,23 @@ static inline union crste _crste_fc0(kvm_pfn_t pfn, int tt)
>   	return res;
>   }
>   
> +static inline union crste _crste_ucas(kvm_pfn_t pfn)
> +{
> +	union crste res = { .val = PFN_PHYS(pfn) };
> +
> +	res.h.i = 1;
> +	res.h.tt = TABLE_TYPE_SEGMENT;
> +	/*
> +	 * Segment entries do not have a TF or TL field; reuse those bits to
> +	 * indicate that this is a special mappped-but-not-allocated UCAS
> +	 * entry. Setting TL to 0 ensures that the entry will always be
> +	 * considered not present.
> +	 */
> +	res.h.fc0.tl = _UCAS_ENTRY_LENGTH;
> +	res.h.fc0.tf = _UCAS_ENTRY_OFFSET;
> +	return res;
> +}
> +
>   /**
>    * _crste() - Useful constructor for union crste with FC=1
>    * @pfn: the pfn this pte should point to.
> @@ -985,7 +1004,8 @@ static inline int dat_create_slot(struct kvm_s390_mmu_cache *mc, union asce asce
>   
>   static inline bool crste_is_ucas(union crste crste)
>   {
> -	return is_pmd(crste) && crste.h.i && crste.h.fc0.tl == 1 && crste.h.fc == 0;
> +	return is_pmd(crste) && crste.h.i && !crste.h.fc &&
> +	       crste.h.fc0.tl == _UCAS_ENTRY_LENGTH && crste.h.fc0.tf == _UCAS_ENTRY_OFFSET;
>   }
>   
>   #endif /* ARCH_KVM_GMAP_DAT_H */
> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index bf91e3d5013b..225fdae3d57c 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -777,16 +777,14 @@ static int gmap_ucas_map_one(struct kvm_s390_mmu_cache *mc, struct gmap *gmap,
>   	if (rc)
>   		return rc;
>   	if (!ptep) {
> -		newcrste = _crste_fc0(p_gfn, TABLE_TYPE_SEGMENT);
> -		newcrste.h.i = 1;
> -		newcrste.h.fc0.tl = 1;
> +		newcrste = _crste_ucas(p_gfn);
>   	} else {
>   		pt = pte_table_start(ptep);
>   		dat_set_ptval(pt, PTVAL_VMADDR, p_gfn >> (_SEGMENT_SHIFT - PAGE_SHIFT));
>   		newcrste = _crste_fc0(virt_to_pfn(pt), TABLE_TYPE_SEGMENT);
>   	}
> -	rc = dat_entry_walk(mc, c_gfn, gmap->asce, DAT_WALK_ALLOC, TABLE_TYPE_SEGMENT,
> -			    &crstep, &ptep);
> +	rc = dat_entry_walk(mc, c_gfn, gmap->asce, DAT_WALK_ALLOC | DAT_WALK_IGN_HOLES,
> +			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
>   	if (rc)
>   		return rc;
>   	do {
> @@ -802,8 +800,9 @@ static int gmap_ucas_translate_simple(struct gmap *gmap, gpa_t *gaddr, union crs
>   	union pte *ptep;
>   	int rc;
>   
> -	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->asce, DAT_WALK_CONTINUE,
> -			    TABLE_TYPE_SEGMENT, crstepp, &ptep);
> +	rc = dat_entry_walk(NULL, gpa_to_gfn(*gaddr), gmap->asce,
> +			    DAT_WALK_IGN_HOLES | DAT_WALK_ANY,
> +			    TABLE_TYPE_PAGE_TABLE, crstepp, &ptep);
>   	if (rc || (!ptep && !crste_is_ucas(**crstepp)))
>   		return -EREMOTE;
>   	if (!ptep)
> @@ -840,26 +839,24 @@ int gmap_ucas_translate(struct kvm_s390_mmu_cache *mc, struct gmap *gmap, gpa_t
>   		if (rc <= 0)
>   			return rc;
>   	}
> -	do {
> -		scoped_guard(write_lock, &gmap->kvm->mmu_lock) {
> -			rc = gmap_ucas_translate_simple(gmap, gaddr, &crstep);
> -			if (rc <= 0)
> -				return rc;
> -			translated_address = (*gaddr & ~_SEGMENT_MASK) |
> -					     (crstep->val & _SEGMENT_MASK);
> -			rc = gmap_ucas_map_one(mc, gmap, gpa_to_gfn(translated_address), gfn, true);
> -		}
> -		if (!rc) {
> -			*gaddr = translated_address;
> -			return 0;
> -		}
> -		if (rc != -ENOMEM)
> -			return -EREMOTE;
> -		rc = kvm_s390_mmu_cache_topup(mc);
> -		if (rc)
> +	rc = kvm_s390_mmu_cache_topup(mc);
> +	if (rc)
> +		return rc;
> +
> +	scoped_guard(write_lock, &gmap->kvm->mmu_lock) {
> +		rc = gmap_ucas_translate_simple(gmap, gaddr, &crstep);
> +		if (rc <= 0)
>   			return rc;
> -	} while (1);
> -	return 0;
> +		translated_address = (*gaddr & ~_SEGMENT_MASK) |
> +				     (crstep->val & _SEGMENT_MASK);
> +		rc = gmap_ucas_map_one(mc, gmap, gpa_to_gfn(translated_address), gfn, true);
> +	}
> +
> +	if (!rc)
> +		*gaddr = translated_address;
> +	if (!rc || rc == -ENOMEM)
> +		return rc;
> +	return -EREMOTE;
>   }
>   
>   int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gfn_t c_gfn, unsigned long count)
> @@ -896,8 +893,9 @@ static void gmap_ucas_unmap_one(struct gmap *gmap, gfn_t c_gfn)
>   	union pte *ptep;
>   	int rc;
>   
> -	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, 0, TABLE_TYPE_SEGMENT, &crstep, &ptep);
> -	if (rc)
> +	rc = dat_entry_walk(NULL, c_gfn, gmap->asce, DAT_WALK_IGN_HOLES,
> +			    TABLE_TYPE_SEGMENT, &crstep, &ptep);
> +	if (rc || !is_pmd(*crstep))
>   		return;
>   	while (!dat_crstep_xchg_atomic(crstep, READ_ONCE(*crstep), _PMD_EMPTY, c_gfn, gmap->asce))
>   		;

