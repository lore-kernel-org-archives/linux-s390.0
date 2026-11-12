Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482026;
	b=Wqae8KDYhmeziKggYAsPOSqiIyDbs1InoeCRYXx/SRV+umsfsVs0dBTFt7bqtwBoNdhj
	 IwE3az6vggdVOIdHs9KXPqVc1HCDFQjPlWoW0BHzgOvNEA+E2TVFV2CycZQkbrylMBa/C
	 xpuYVwK09kyeyeD18g/oxxMMLU2UKnunAl/2ttfJIJJ6VdQz+eqLHp2KAVpy4FgmTGDOP
	 rwHCANt5sercmNuy8Fs2E57TyNdOn1GcvwrTV2KEDSF3jIdAL2K0FQK7MtQy4DBg8ae29
	 oeMDiPfY4IZODI7i0wt0MDLzDQZoncR4bSv0akonrEu/rVNv4SQ5XxuM/C0rXE6tsZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482026;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fPm5qWpoTMUiXwuBUzfxdmJX/oGj7gJoI751d6rX+q0=;
	b=e4zhzKjc9voaHVZ2EOyePXZKrGlXCwLUFRxs+WRp8MHhH026NuVVIPtwKuitG1NldxNw
	 SUfaCPDOEWgiRmfQgfh3F0ahKPxUyhRAz7abl3NBqo70DKmj7vFrH4Ov4oJplApfIm1Eh
	 BGj1UdIlyDTmQbW9AI68VJb2xAbQXReWniCVAgq5MYbkBrnJSpgD54jkwA+Ue8s0UGsZ3
	 8++sym8z+lLY6U2SYht7g2RXBjCjGtoK7EbEwsM9K9dZFdWRti4sPLd76kBfVZzsMMOyO
	 HiSe1ezez2uSrRv3ieOQExWjmre54I6rFVpWPQQYn1H7zsWvC5uP3A5mSoqD/HYKJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lHiu+8xC;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3C4606A31C;
	Thu, 12 Nov 2026 11:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B3C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lHiu+8xC
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iqBh1215427;
	Thu, 12 Nov 2026 11:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fPm5qW
	poTMUiXwuBUzfxdmJX/oGj7gJoI751d6rX+q0=; b=lHiu+8xCAuMoTUGu1EXcKo
	59S8mIcXI6O5B1gj00XB34+TTZNnSq4rjQIiSb+QFYnvagMmtXZqhUqtyBvJWDMT
	SWvgUwI5guuAz2qkzB4+epIEn1t3JyTfE1LuuhPwlxaOcWIJVqSdE0vRc+EhyHDu
	eNMdAOTs406K7NXjYr2y/1CN1oZZJDxUdpK2nV4PcZQy0rIXyHhXDE4CBwRVamyv
	OVng9VARNedGl5MTFFaTqwYyfEkolKw6OY8mmKcY9LPG21T5qOGqRogK+RCgpYxb
	VvPhkrM7esBfxe4/ZwkKFBDznIRZ+6KY4BC46tZQUFz23zVPtfJPwsdOOCRnO5Qg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntf5g6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:13:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8C046053981;
	Thu, 12 Nov 2026 11:13:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv309rh3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 11:13:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACBDde751249408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 11:13:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AAE820049;
	Thu, 12 Nov 2026 11:13:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E89B820040;
	Thu, 12 Nov 2026 11:13:38 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.68.31.198])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 12 Nov 2026 11:13:38 +0000 (GMT)
Date: Thu, 12 Nov 2026 12:13:37 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-s390
 <linux-s390@vger.kernel.org>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily
 Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2] s390/mm: Allow hugepage migration for s390
Message-ID: <20261112121337.3c07acb7@thinkpad-T15>
In-Reply-To: <sashiko-outbox-209541@kernel.org>
References: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
	<sashiko-outbox-209541@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MiBTYWx0ZWRfX2lQoZGPmfves
 yyb0upySaxAKL8p2zMRFyEbxmgFoZ3+RItm+Fa2oW9j4KcCD6HszXXm8IExZpIOFNeJHVXFD2PO
 V/6aXmUeZd5B0l95lsshhzEUEiu/urMyFE+ecA6TTsaoqCBnjl9g3nKb8YAX62TEAdaBf9fwbBF
 snJ3DceWKopGiDJqjXzz5x+5DZdKEbCkkzREKSpXdNUOsYRGOC586lJiQowLOZDLIUZu8N/HOZS
 lTV1K6ycWCMpKFP4SIwjofqkLp4ovvtPIgM1lSWbo3NH86OG6AssuLMcAKwP7c9v9He/WdxQvZB
 get6rH0bidYKNRwY7TBBLDdR9QwI/oTIz2KaGn8l3Qm+1+fQEbb1jr59GfMtwoas5p80vxlLGD9
 fzYxsMnaYIIBRai7eBokiuuHuukoVjIGTYdwh6p1I4aHZL5GoPq01IgYhw1zObEmK3yQM7LrYFz
 nFPvmQ1FA5r8N88hCFQ==
X-Proofpoint-ORIG-GUID: btVzQ312fbO2SCzSrno8v8cympUxKJNh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MiBTYWx0ZWRfX4W3HdT4uU9kL
 SFkthCGCeOmFiFqFZtf0X3RZ3xRw8nNoODf38RQl8LoAKl6AnBM1AiM9g/1TgR1PZnXAHv51wxo
 8nwZzRPhyNQc+ZAnJLhMUT2jmjZoNkc=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af59f68 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cVApB3_Vmn0YrNpntUEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: btVzQ312fbO2SCzSrno8v8cympUxKJNh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120042

On Wed, 11 Nov 2026 19:14:22 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [High] s390/mm: guest storage key loss on 1M/2G hugetlbfs page
>   migration

@Claudio, could you please have a look, if this is a valid issue?

> - [Medium] s390/mm: loss of soft-dirty bit in __pte_to_rste() and
>   __rste_to_pte() on hugetlb migration

No problem, soft-dirty tracking not supported for hugetlbfs, see below.

> --
> 
> commit d03e5331e4e0b88aa75246fc7dc6aef18e7c8cdd
> Author: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> 
> s390/mm: Allow hugepage migration for s390
> 
> This commit selects ARCH_ENABLE_HUGEPAGE_MIGRATION on s390 and defines
> arch_hugetlb_migration_supported() for 1M and 2G hugepages so hugetlbfs
> pages can be migrated and allocated from ZONE_MOVABLE.
> 
> > diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> > index f84aa9265430f..2c6e94888bd06 100644
> > --- a/arch/s390/mm/hugetlbpage.c
> > +++ b/arch/s390/mm/hugetlbpage.c
> > @@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> >  	return (pte_t *) pmdp;
> >  }
> >  
> > -bool __init arch_hugetlb_valid_size(unsigned long size)
> > +static bool __hugetlb_valid_size(unsigned long size)
> >  {
> >  	if (cpu_has_edat1() && size == PMD_SIZE)
> >  		return true;
> > @@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
> >  
> >  	return 0;
> >  }
> > +
> > +bool __init arch_hugetlb_valid_size(unsigned long size)
> > +{
> > +	return __hugetlb_valid_size(size);
> > +}
> > +
> > +#if IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION)
> > +bool arch_hugetlb_migration_supported(struct hstate *h)
> > +{
> > +	return __hugetlb_valid_size(huge_page_size(h));
> > +}
> > +#endif  
> 
> [Severity: High]
> Does migrating a 1M or 2G hugetlbfs folio backing a KVM guest lose the
> guest's hardware storage keys?
> 
> For 1M and 2G mappings (KVM_CAP_S390_HPAGE_1M / KVM_CAP_S390_HPAGE_2G),
> the KVM gmap uses large leaf CRSTEs without PGSTEs, and guest storage keys
> live only in the physical page frames.  When unmap_and_move_hugetlb_folio()
> unmaps the folio via mmu_notifier_invalidate_range_start(),
> _gmap_unmap_crste() clears the large CRSTE to _CRSTE_EMPTY without saving
> or splitting the hardware storage keys:
> 
> arch/s390/kvm/gmap/gmap.c:_gmap_unmap_crste() {
> 	...
> 	if (!old.h.fc)
> 		return 0;
> 
> 	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
> 		folio = phys_to_folio(crste_origin_large(old));
> 	ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn);
> 	...
> }
> 
> folio_copy() -> copy_highpage() -> copy_page() then copies only the 4K
> page contents via mvcl and does not copy the hardware storage keys to the
> destination frames, leaving the guest with stale storage keys and causing
> guest protection exceptions or memory corruption.
> 
> [Severity: Medium]
> Does migrating a hugetlbfs page also drop its soft-dirty bit in
> __pte_to_rste() and __rste_to_pte()?
> 
> When try_to_migrate_one() installs a hugetlb migration entry, it sets
> _PAGE_SOFT_DIRTY via pte_swp_mksoft_dirty() and calls set_huge_pte_at().
> However, the swap entry branches in __pte_to_rste() and __rste_to_pte() do
> not transfer _PAGE_SOFT_DIRTY to and from _SEGMENT_ENTRY_SOFT_DIRTY:
> 
> arch/s390/mm/hugetlbpage.c:__pte_to_rste() {
> 	...
> 	} else if (!pte_none(pte)) {
> 		/* swap pte */
> 		arch_entry = __pte_to_swp_entry(pte);
> 		rste = mk_swap_rste(__swp_type(arch_entry), __swp_offset(arch_entry));
> 	...
> }
> 
> arch/s390/mm/hugetlbpage.c:__rste_to_pte() {
> 	...
> 	} else if (!none) {
> 		/* swap rste */
> 		arch_entry = __rste_to_swp_entry(rste);
> 		pte = mk_swap_pte(__swp_type_rste(arch_entry), __swp_offset_rste(arch_entry));
> 		pteval = pte_val(pte);
> 	...
> }
> 
> As a result, remove_migration_pte() reads back old_pte via huge_ptep_get()
> with pte_swp_soft_dirty(old_pte) == 0 and clears _PAGE_SOFT_DIRTY on the
> restored hugepage PTE, breaking soft-dirty tracking via /proc/pid/pagemap.

Hugetlbfs does not support soft-dirty page tracking in the kernel:
vma_wants_writenotify() in mm/vma.c explicitly excludes hugetlb VMAs from
soft-dirty tracking, clear_refs_walk_ops in fs/proc/task_mmu.c does not
implement a hugetlb_entry callback, and mm/hugetlb.c never sets or
preserves soft-dirty bits on hugetlb PTEs or migration entries.

The RSTE swap entry soft-dirty bit (bit 62) exists for THP PMD
swap/migration entries rather than hugetlbfs. Generic hugetlb migration
handling in mm/hugetlb.c (copy_hugetlb_page_range() and
hugetlb_change_protection()) also does not preserve pte_swp_soft_dirty()
when rebuilding hugetlb migration swap entries.

However, I was not aware that try_to_migrate_one() actually does set
_PAGE_SOFT_DIRTY via pte_swp_mksoft_dirty() also for hugetlbfs pages,
even though it is not being used anywhere yet. This bit is indeed lost
after __pte_to_rste() conversion from a swap PTE. But it does not break
soft-dirty tracking for hugetlbfs, because that does not exist. It also
does not conflict with or corrupt the RSTE swap type or offset calculation.

Of course, it probably would be good practice to already preserve
_PAGE_SOFT_DIRTY now, even if it is not needed yet, and further changes to
generic code would be required if it should ever be supported. Will look
into this in v3.
