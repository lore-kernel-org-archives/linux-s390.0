Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795005460;
	b=QDD0Qck79t/7J/B+KMQbinnhro+b2JU+5UMmrWYNcvhYL3H7hAJIqiwF5NPAyYnAxsbU
	 S+LF+cqnDMtevRFjEQ1oeWnkvOv4+tiYDcHW7cXSVspi9PZ7qrFfD2m2MLaN2cP3UuAGm
	 jVrSmOV/KDBOhd7NfdxAsqYvwg1lEZJgkcrsiSTYdYG+ldsUHHjH24PxS81ZQb3zRe5ab
	 oL+B5h3MwFldceFfHuBFHEU8vqPDLu/ZrwlFdY6zU0EFkXGicUQaRh4s/4dL0WFHjbIcd
	 NaNi1kIDE6pU9I7BiYANiZsUDXETse4gR0UGZqibtnbzgltbGUHGdWE2W9CWCQO4gww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005460;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6OWJ8dEM8UrE04otdmQfRprkgQwpj9yoMQvCFzDydXQ=;
	b=tCW6pU3fnZhOl6NLCAiPDoRlmQ8x0weiRcEBdlmNv7UcMp2Fcj3F5E3bEGTa7cf5eF3V
	 diPhAYboY2mgmQyo5vQ1fVGbeLNIEFKAKE5yGYFpjiyty36jM6byt0H35ehaTtz4Ox3e9
	 R7T8283Y/Ifo1HT5UfL8+gKua/+Cqj5Vw4kLHimLo1/s+aVgGWl81rHlAjtfsRSIii7Zo
	 cNN+0Afg2DA6hApORQgwafdHKShX24ph9wKyjmgRE/MlztxlNlswiBq4sIvfuci+0WDTn
	 C+mdMuqoDEDGFTxFT3zHgy85EiGX3B+I90YyB3SXsebOFplvqK5gm9Wn+nZSnXA4a3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jyqu3ty4;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F36606A31C;
	Wed, 18 Nov 2026 12:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F36606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jyqu3ty4
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBQAGU3963124;
	Wed, 18 Nov 2026 12:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6OWJ8d
	EM8UrE04otdmQfRprkgQwpj9yoMQvCFzDydXQ=; b=jyqu3ty4GnhHVXbUEs7y8c
	PiJ/PZLstq9kAtevmmMjGm1zTVvC8bTT49sUWa+GstBfdh4m2EdYlTPeo0FFLHbI
	wPFc59urmLnCKIa+ciGyfazlRL/dOj7LHAm0zp24mrzxZkcgFo0Se/K8rqwv37CX
	QSL1fAZ+KjTMvW8lyk9fTd0TuqFl77PIahosyWlBHXuIeo7uSndVfKKPRYFLk0oI
	oCYZ2QKQxziPCkFwt9NsBuQIji+XziKxykgX12SOOj1IfCmq/ANmAsWQgnM8LVSU
	AiJP6SnE0fXBbpf+zCRKlc78oLM2bXDDhervhYjfMsDb5+KWNDj8dc+6uHX3e8WA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vtb3c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 12:37:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIBK9fX3033810;
	Wed, 18 Nov 2026 12:37:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02jug52x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 12:37:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AICbXcu30474742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 12:37:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA3282004B;
	Wed, 18 Nov 2026 12:37:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA98620043;
	Wed, 18 Nov 2026 12:37:33 +0000 (GMT)
Received: from p-imbrenda (unknown [9.68.31.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 18 Nov 2026 12:37:33 +0000 (GMT)
Date: Wed, 18 Nov 2026 13:37:31 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-s390
 <linux-s390@vger.kernel.org>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Vasily
 Gorbik" <gor@linux.ibm.com>,
        "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v2] s390/mm: Allow hugepage migration for s390
Message-ID: <20261118133731.6de64cc7@p-imbrenda>
In-Reply-To: <20261112121337.3c07acb7@thinkpad-T15>
References: <20261111182944.4154805-1-gerald.schaefer@linux.ibm.com>
	<sashiko-outbox-209541@kernel.org>
	<20261112121337.3c07acb7@thinkpad-T15>
Organization: IBM
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
X-Proofpoint-GUID: U5rGeF2JlF35YHfY_mb9G7meymcUNG5q
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afd9c12 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=-U4ubaYy1ROQS3slnMUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: U5rGeF2JlF35YHfY_mb9G7meymcUNG5q
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA0OSBTYWx0ZWRfXzy0JkNaB6edM
 1Fn9Yj+X+jISo3bIR723kKXy3Q5xUBj9YShhk6UfpzcYZig78jSi45NRSGVIi7NmxW1o8rI4fIe
 72bj/tTnwj8LEYlZcFO32SwgR09EIwI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA0OSBTYWx0ZWRfXxEJFZOZuk+IT
 mM9eAru14Q9kAI7vs4jOgyCUDOjZk5genxdXfY+hH4XV0910FbM0UkMXUfmoVV99xS1eI8CofcO
 1v5xBvd/YuQdiTTzmLM1sa+NyVm/mlOaVVN0SJG38pn+uowhFczQT6mKoIfdkeE3GBRwzfAYa0Q
 EYHh7YkMD53jBFSOmAyiFV1A7rzm5zPBPXvZZECa+GH7VhOQj0I/egQduf96oUr88ppRvYaXmaE
 Ijw3Qa4z8Ft3mE+JXQKGbuTMsTfVCd7XtKBlXqhepWt8onxNnyTX+jUg5LkWiptFSjhXsMPEIGW
 t56sOX5olBbDQ7Rzg9lOWz1KmJav0o5OI6fHRUwYUPvLLMVkhVfrHxWjmfSCV39DZN1S8Poorx3
 BRy9qvUP23Vy02xgcn99oyf8eq6cxy/pgYQRoUb5EJldJIYl6q1s81Q24a1+mKW9WsAIThE3kcb
 N0PHRtbVz9DfTuOCgYw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180049

On Thu, 12 Nov 2026 12:13:37 +0100
Gerald Schaefer <gerald.schaefer@linux.ibm.com> wrote:

> On Wed, 11 Nov 2026 19:14:22 +0000
> sashiko-bot@kernel.org wrote:
> 
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issues to consider:
> > - [High] s390/mm: guest storage key loss on 1M/2G hugetlbfs page
> >   migration  
> 
> @Claudio, could you please have a look, if this is a valid issue?

yes, it's a valid issue, I was already aware of it.

it's in my pipeline, will be fixed as soon as possible

> 
> > - [Medium] s390/mm: loss of soft-dirty bit in __pte_to_rste() and
> >   __rste_to_pte() on hugetlb migration  
> 
> No problem, soft-dirty tracking not supported for hugetlbfs, see below.
> 
> > --
> > 
> > commit d03e5331e4e0b88aa75246fc7dc6aef18e7c8cdd
> > Author: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> > 
> > s390/mm: Allow hugepage migration for s390
> > 
> > This commit selects ARCH_ENABLE_HUGEPAGE_MIGRATION on s390 and defines
> > arch_hugetlb_migration_supported() for 1M and 2G hugepages so hugetlbfs
> > pages can be migrated and allocated from ZONE_MOVABLE.
> >   
> > > diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
> > > index f84aa9265430f..2c6e94888bd06 100644
> > > --- a/arch/s390/mm/hugetlbpage.c
> > > +++ b/arch/s390/mm/hugetlbpage.c
> > > @@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> > >  	return (pte_t *) pmdp;
> > >  }
> > >  
> > > -bool __init arch_hugetlb_valid_size(unsigned long size)
> > > +static bool __hugetlb_valid_size(unsigned long size)
> > >  {
> > >  	if (cpu_has_edat1() && size == PMD_SIZE)
> > >  		return true;
> > > @@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
> > >  
> > >  	return 0;
> > >  }
> > > +
> > > +bool __init arch_hugetlb_valid_size(unsigned long size)
> > > +{
> > > +	return __hugetlb_valid_size(size);
> > > +}
> > > +
> > > +#if IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION)
> > > +bool arch_hugetlb_migration_supported(struct hstate *h)
> > > +{
> > > +	return __hugetlb_valid_size(huge_page_size(h));
> > > +}
> > > +#endif    
> > 
> > [Severity: High]
> > Does migrating a 1M or 2G hugetlbfs folio backing a KVM guest lose the
> > guest's hardware storage keys?
> > 
> > For 1M and 2G mappings (KVM_CAP_S390_HPAGE_1M / KVM_CAP_S390_HPAGE_2G),
> > the KVM gmap uses large leaf CRSTEs without PGSTEs, and guest storage keys
> > live only in the physical page frames.  When unmap_and_move_hugetlb_folio()
> > unmaps the folio via mmu_notifier_invalidate_range_start(),
> > _gmap_unmap_crste() clears the large CRSTE to _CRSTE_EMPTY without saving
> > or splitting the hardware storage keys:
> > 
> > arch/s390/kvm/gmap/gmap.c:_gmap_unmap_crste() {
> > 	...
> > 	if (!old.h.fc)
> > 		return 0;
> > 
> > 	if (old.s.fc1.pr && test_bit(GMAP_FLAG_EXPORT_ON_UNMAP, &priv->gmap->flags))
> > 		folio = phys_to_folio(crste_origin_large(old));
> > 	ok = gmap_crstep_xchg_atomic(priv->gmap, crstep, old, _CRSTE_EMPTY(old.h.tt), gfn);
> > 	...
> > }
> > 
> > folio_copy() -> copy_highpage() -> copy_page() then copies only the 4K
> > page contents via mvcl and does not copy the hardware storage keys to the
> > destination frames, leaving the guest with stale storage keys and causing
> > guest protection exceptions or memory corruption.
> > 
> > [Severity: Medium]
> > Does migrating a hugetlbfs page also drop its soft-dirty bit in
> > __pte_to_rste() and __rste_to_pte()?
> > 
> > When try_to_migrate_one() installs a hugetlb migration entry, it sets
> > _PAGE_SOFT_DIRTY via pte_swp_mksoft_dirty() and calls set_huge_pte_at().
> > However, the swap entry branches in __pte_to_rste() and __rste_to_pte() do
> > not transfer _PAGE_SOFT_DIRTY to and from _SEGMENT_ENTRY_SOFT_DIRTY:
> > 
> > arch/s390/mm/hugetlbpage.c:__pte_to_rste() {
> > 	...
> > 	} else if (!pte_none(pte)) {
> > 		/* swap pte */
> > 		arch_entry = __pte_to_swp_entry(pte);
> > 		rste = mk_swap_rste(__swp_type(arch_entry), __swp_offset(arch_entry));
> > 	...
> > }
> > 
> > arch/s390/mm/hugetlbpage.c:__rste_to_pte() {
> > 	...
> > 	} else if (!none) {
> > 		/* swap rste */
> > 		arch_entry = __rste_to_swp_entry(rste);
> > 		pte = mk_swap_pte(__swp_type_rste(arch_entry), __swp_offset_rste(arch_entry));
> > 		pteval = pte_val(pte);
> > 	...
> > }
> > 
> > As a result, remove_migration_pte() reads back old_pte via huge_ptep_get()
> > with pte_swp_soft_dirty(old_pte) == 0 and clears _PAGE_SOFT_DIRTY on the
> > restored hugepage PTE, breaking soft-dirty tracking via /proc/pid/pagemap.  
> 
> Hugetlbfs does not support soft-dirty page tracking in the kernel:
> vma_wants_writenotify() in mm/vma.c explicitly excludes hugetlb VMAs from
> soft-dirty tracking, clear_refs_walk_ops in fs/proc/task_mmu.c does not
> implement a hugetlb_entry callback, and mm/hugetlb.c never sets or
> preserves soft-dirty bits on hugetlb PTEs or migration entries.
> 
> The RSTE swap entry soft-dirty bit (bit 62) exists for THP PMD
> swap/migration entries rather than hugetlbfs. Generic hugetlb migration
> handling in mm/hugetlb.c (copy_hugetlb_page_range() and
> hugetlb_change_protection()) also does not preserve pte_swp_soft_dirty()
> when rebuilding hugetlb migration swap entries.
> 
> However, I was not aware that try_to_migrate_one() actually does set
> _PAGE_SOFT_DIRTY via pte_swp_mksoft_dirty() also for hugetlbfs pages,
> even though it is not being used anywhere yet. This bit is indeed lost
> after __pte_to_rste() conversion from a swap PTE. But it does not break
> soft-dirty tracking for hugetlbfs, because that does not exist. It also
> does not conflict with or corrupt the RSTE swap type or offset calculation.
> 
> Of course, it probably would be good practice to already preserve
> _PAGE_SOFT_DIRTY now, even if it is not needed yet, and further changes to
> generic code would be required if it should ever be supported. Will look
> into this in v3.

