Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484989;
	b=ZgyZzh1R+GILZUAO01oHEHbmRDz5hw17lNrdcDrGXyLVcLA6MhiMATEcTOdsYVW7h7LN
	 uvFzo2nTSRoiEZoHtuTWwLIFLBqGhTULMrQdh5a8PHKClTipaMUZQDeXRmes2DTuxQVcN
	 tSrk9S4eMmtgtAg6vfj3qBVr8PjIUiP+v2j9uD7AboYWTzTikIdbN/qXjRM7Q8RLUoGKY
	 oSUqedKP0FbeDjZu4RAwnfNmBLwoRq3p6aJq2p0OEUHR3NkQ6srZXllbvmCGromCB1QBy
	 T6MUpGRiBZxkQVgCbqk3gviFhSWAA4bmgBgs1lZnlvWrjsmjHhs4MeDDrhKwJjbnLJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484989;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=wzDgBBLnxBUxKoWdzuHKvE4T1DwJpqTT2AjMu32XXOI=;
	b=roAzAVEy0Zpvv7SbSWtC5b/YH1oLWVR271lTLDltLlGSAyK/wOIqLs/FIQzvplbvP3GJ
	 21ZkXShKBdG84BM/I67UENnB7vhEvupYC9Opw5oyAFuTNj2olZFFBW80st4Fv0jD0aHnC
	 m/q+Aw+GXAOL8hcM+oi+pG1rYEr9sggI8nlsNGLJgdapVAO6BSpQDf4Uw6K6urVuWyCNa
	 VnyL9bd9QyiHWfUnQocGAbR7fxpZZADJpHDBfsGeg0QPa76KtMsObeyh/bNkRVVmxrnDK
	 VGu8qX2V7d5V2o6fALE1YxZNlvkJUWY7IFV6mkRbtpirLOnWc13cPBYFUylJG4E7frQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ocIxJgeY;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82161606A889;
	Thu, 12 Nov 2026 12:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82161606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ocIxJgeY
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2irYx2858550;
	Thu, 12 Nov 2026 12:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wzDgBB
	LnxBUxKoWdzuHKvE4T1DwJpqTT2AjMu32XXOI=; b=ocIxJgeYORExcuBBqma32i
	yXfifzSGZmpC6WrKIwRUVE1bKWfqHzX5FhYLZ5b9Mx4S+C3DUG/Z5jbk2jgIzVT1
	Xt7RsloeDoTXlTaKKBadGFTHgM/mqUo4wQN09HrlDcfKaJtVjueVKDED0joH5Azl
	bzWzfeIrEyyKiN2eAxbJNn7jcCYSr3waUvBF96ijt4GJY+BC3dNG5unA0UwqPu4H
	a1N9xCTgXFGFP1aEqzBMp6BpyZ63DLnSFK0bqmIXroXaVhj5LgSSkjmWVz7wYxqH
	2N+JpF46vMVBZ+xKWysvgTObTPrgLxDxwGJSWu6umgouhS58C5T3TGHRgaxuxPNQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv62ky-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:03:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACAlMqO676531;
	Thu, 12 Nov 2026 12:03:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0t87cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 12:03:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACC2wrU37552438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 12:02:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 889182006A;
	Thu, 12 Nov 2026 12:02:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AD0620078;
	Thu, 12 Nov 2026 12:02:57 +0000 (GMT)
Received: from [9.111.75.87] (unknown [9.111.75.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 12:02:56 +0000 (GMT)
Message-ID: <51827cea-52bc-4d97-8390-dfaeaae0980b@de.ibm.com>
Date: Thu, 12 Nov 2026 13:02:55 +0100
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
Subject: Re: [PATCH v6 4/5] KVM: s390: Improve unmapping of large ranges
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-5-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261105153705.208516-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0NiBTYWx0ZWRfXyjWY2EtOEb5h
 U2lNgumjTJu1+8ArqzD0LTmhSP/jPWQPRnOjMO6BVd5AyB/2OwzVzfy2swEbzVqKgx1jreLdLqp
 uHk4Fqud7e/sojdo2anBuCnY3wUOfTk=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af5aaf7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=60vse6JSkkWJpTdAYGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: phszqJHkbjyyueLFREC1BhnlQs4TJFAQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0NiBTYWx0ZWRfX89yr1GD/DmDw
 YpphCPF6ysg5fv8VxKZRIHBT65Pi+sH3BSVws7o2QHxdhJB6Iy6NGiSQ1UFN89sO0xAd2p9ZVMJ
 +P62Msfo9igR9xPbdP+w6VbqlTR9uuVJkbS+oxGpXUw5QnqXVCF7WsRrBPRfLxFCYJAueOgpDnm
 Pk/p7tupyVh3ZHM1onp9wpdsvuu34lWp/zac/xD1pkUfKkNNW5bYciJZ6hmnMEBn/ndp7Mm1dLg
 nf0MJIFWbgfDQ+Vd8igxFv73Vn+hsYse7w/nfj7ke4+gleQLsHjpfWNMP+EzJJRtaO5CacPhawm
 n1hv6wCiwLUp04gZAibcqaHai0Cj9sm06iswY+DKaxDf+CSWzhhni2P4WVTZ38pXmF0JXnOts24
 OlxloPfgkoV2m6iGw9nEEzpTy8xybUs5gRP3VzOEjTbessx1459h2wUR9l/U9KUhqYlOXsIr6UW
 5c4klKr5gXA8elI3ovg==
X-Proofpoint-ORIG-GUID: phszqJHkbjyyueLFREC1BhnlQs4TJFAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120046

Am 05.11.26 um 16:37 schrieb Claudio Imbrenda:
> When unmapping guest ranges, each individual leaf DAT entry is
> invalidated. When unmapping large ranges, this results in a very large
> amount of invalidations, which is time consuming. Moreover, since the
> unmap callback is called by KVM while holding a spinlock, this also
> leads to stall warnings.
> 
> Improve the situation by invalidating DAT entries higher in the tree,
> instead of each leaf individually.
> 
> For small invalidations (up to 1 segment = 1M of guest memory), and
> special cases (like protected VMs) regardless of the size, the old and
> slow invalidation is performed; all leaf entries are invalidated one by
> one.
> 
> For large invalidations (larger than 1M of guest memory), the new
> strategy is used:
>   - Invalidate prefixes on the whole range, extending start and end to
>     1M granularity
>   - Iterate through the page table pointed to by each pmd and unshadow
>     entries as needed
>   - Detach (invalidate) the pmd
>   - Save storage keys as needed
>   - Invalidate each (now detached) pte by simply overwriting it
>   - Reattach the old pmd to point to the updated page table

Maybe add that for large unmaps we intentionally do not transfer the CMMA
unused state? We *could* do the transfer for the pmd segments (but not for
the puds) but this is in the end just a paging opimization vs. runtime
optimization and I am fine with this.


In any case, Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>> 
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.0+
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/kvm/gmap/gmap.c | 136 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 125 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
> index 225fdae3d57c..b9d92bef5459 100644
> --- a/arch/s390/kvm/gmap/gmap.c
> +++ b/arch/s390/kvm/gmap/gmap.c
> @@ -434,17 +434,8 @@ static long _gmap_unmap_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct
>   	return 0;
>   }
>   
> -/**
> - * gmap_unmap_gfn_range() - Unmap a range of guest addresses.
> - * @gmap: The gmap to act on.
> - * @slot: The memslot in which the range is located.
> - * @start: The first gfn to unmap.
> - * @end: The gfn after the last one to unmap.
> - *
> - * Context: Called with the kvm mmu write lock held.
> - * Return: false
> - */
> -bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t start, gfn_t end)
> +static bool gmap_unmap_gfn_range_slow(struct gmap *gmap, struct kvm_memory_slot *slot,
> +				      gfn_t start, gfn_t end)
>   {
>   	const struct dat_walk_ops ops = {
>   		.pte_entry = _gmap_unmap_pte,
> @@ -462,6 +453,129 @@ bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t
>   	return false;
>   }
>   
> +static long _gmap_unmap_pud_fast(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *w)
> +{
> +	union crste old = *crstep;
> +
> +	/* We only care about large puds */
> +	if (!old.h.fc)
> +		return 0;
> +	/*
> +	 * The caller did not unmap prefixes outside the original range, which
> +	 * does not necessarily cover the whole pud.
> +	 * Since all prefixes are below 2G, the first pud covers them all;
> +	 * make sure all prefixes are unmapped whenever the first pud is being
> +	 * unmapped.
> +	 */
> +	if (!gfn)
> +		gmap_unmap_prefix(w->priv, 0, next);
> +	if (old.s.fc1.vsie_notif)
> +		gmap_handle_vsie_unshadow_event(w->priv, gfn);
> +
> +	if (machine_has_tlb_guest())
> +		idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
> +	else
> +		idte_crste(crstep, gfn, 0, w->asce, 0);
> +	*crstep = _CRSTE_EMPTY(old.h.tt);
> +
> +	return 0;
> +}
> +
> +static long _gmap_unmap_pmd_fast(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *w)
> +{
> +	union crste old = *crstep;
> +	struct page_table *pt;
> +	gfn_t first, last;
> +	unsigned int i;
> +
> +	if (old.h.fc) {
> +		if (old.s.fc1.vsie_notif)
> +			gmap_handle_vsie_unshadow_event(w->priv, gfn);
> +
> +		if (machine_has_tlb_guest())
> +			idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
> +		else
> +			idte_crste(crstep, gfn, 0, w->asce, 0);
> +		WRITE_ONCE(*crstep, _CRSTE_EMPTY(old.h.tt));
> +
> +		return 0;
> +	}
> +
> +	if (old.h.i)
> +		return 0;
> +
> +	pt = dereference_pmd(old.pmd);
> +	first = max(gfn, w->start) & (PTRS_PER_PTE - 1);
> +	last = (min(next, w->end) - 1) & (PTRS_PER_PTE - 1);
> +
> +	for (i = first; i <= last; i++)
> +		if (pte_needs_unshadow(pt->ptes[i], _PTE_EMPTY, pt->pgstes[i]))
> +			gmap_handle_vsie_unshadow_event(w->priv, gfn + i);
> +
> +	/* Detach the page table */
> +	if (machine_has_tlb_guest())
> +		idte_crste(crstep, gfn, IDTE_GUEST_ASCE, w->asce, 0);
> +	else
> +		idte_crste(crstep, gfn, 0, w->asce, 0);
> +
> +	for (i = first; i <= last; i++) {
> +		if (pte_hole(pt->ptes[i]))
> +			continue;
> +		if (!pt->ptes[i].h.i && uses_skeys(w->priv))
> +			pt->pgstes[i] = dat_save_storage_key_into_pgste(pt->ptes[i], pt->pgstes[i]);
> +		pt->ptes[i] = _PTE_EMPTY;
> +		pt->pgstes[i].vsie_notif = 0;
> +		pt->pgstes[i].vsie_gmem = 0;
> +		pt->pgstes[i].zero = 0;
> +		pt->pgstes[i].prefix_notif = 0;
> +	}
> +
> +	barrier();
> +	/* Reattach the modified page table */
> +	WRITE_ONCE(*crstep, old);
> +
> +	return 0;
> +}
> +
> +static bool gmap_unmap_gfn_range_fast(struct gmap *gmap, gfn_t start, gfn_t end)
> +{
> +	const struct dat_walk_ops ops = {
> +		.pud_entry = _gmap_unmap_pud_fast,
> +		.pmd_entry = _gmap_unmap_pmd_fast,
> +	};
> +	gfn_t aligned_start = ALIGN_DOWN(start, _PAGE_ENTRIES);
> +	gfn_t aligned_end = ALIGN(end, _PAGE_ENTRIES);
> +	bool failed;
> +
> +	lockdep_assert_held_write(&gmap->kvm->mmu_lock);
> +
> +	/* Prefixes are below 2G; if the start is above 2G, nothing to do */
> +	if (aligned_start < _PAGES_PER_REGION3)
> +		gmap_unmap_prefix(gmap, aligned_start, aligned_end);
> +
> +	failed = _dat_walk_gfn_range(start, end, gmap->asce, &ops, DAT_WALK_IGN_HOLES, gmap);
> +	KVM_BUG_ON(failed, gmap->kvm);
> +	return false;
> +}
> +
> +/**
> + * gmap_unmap_gfn_range() - Unmap a range of guest addresses.
> + * @gmap: The gmap to act on.
> + * @slot: The memslot in which the range is located.
> + * @start: The first gfn to unmap.
> + * @end: The gfn after the last one to unmap.
> + *
> + * Context: Called with the kvm mmu write lock held.
> + * Return: false
> + */
> +bool gmap_unmap_gfn_range(struct gmap *gmap, struct kvm_memory_slot *slot, gfn_t start, gfn_t end)
> +{
> +	if ((end - start <= _PAGES_PER_SEGMENT) ||
> +	    test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &gmap->flags) || is_ucontrol(gmap))
> +		return gmap_unmap_gfn_range_slow(gmap, slot, start, end);
> +	return gmap_unmap_gfn_range_fast(gmap, start, end);
> +}
> +
>   static union pgste __pte_test_and_clear_softdirty(union pte *ptep, union pgste pgste, gfn_t gfn,
>   						  struct gmap *gmap)
>   {

