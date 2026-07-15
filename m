Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891DB331EB4;
	Wed, 15 Jul 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784115027; cv=none; b=YDzeme5dVMBH4v96VgrxGm729ZV67NdRzy/3B4IhOHkN0uvomOCtd2PW8389NkzSUNRjooQas2MaAyux21tdDMHmYQlWdpoVUkmL1vA+1gp+LCXfue9iXzOapfTV+4XzlEb7MHsTlTgkGDWOgSzizYmieFkLU6DQG8DBEX4XemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784115027; c=relaxed/simple;
	bh=nXdPLM+0VI/1PU44QgwoR5Qqx8FshCX91XsesGL+PnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tq8T2Gj2YTWV4JIHDvrJtwiiAb4EFFITU1bQO8HoVKAveuAKpxlJAt1yEWx6eabvMnwq8QagmHNx5i5eggN4QvywYoC0gCSZChd+QoLuqpvPIjSon4trYEksiI3w93YbJ+PgfHyC/+bcwmu0swgoP9svG0Kw06SKwCv+V9hgzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QaBM4Aq7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QaBM4Aq7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBBnwm008938;
	Wed, 15 Jul 2026 11:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Vj07Yp
	aTKXMzSIw8+HTsBCB73nav4hx9gl65FHKz66Y=; b=QaBM4Aq7B/axF5SV6xDiae
	L/f/pPxqAmUEuz8HrWi7blGUPUHoRzZ2SAdLu88URAzF+QtOcr7DPpRXbnV1sjUm
	rKI0xeCQbuP3fB23DpStRbvGAxHwkQjS87FcURda0qZsHFShe6sxj7r/Zrj6SiK6
	qiypzoWDZUlGVTwApAuAb9zMwZE67gGFmFDz2ws9zF0zkCDTiW5uz43gAQ8IO4LW
	HC+7XlCNQ+GHXLLfNqlnxlQA+d+WC5KIn3gkfchWBurNtHib6qOYdLD2HWr2fFw9
	pVyueK7NBpVaxQlNdPi7oEBe80VaN3zvF2b/vCBT8TE2Ibhn9pX8I5kxf88oJTMQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegtba25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 11:30:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66FBJwZp022767;
	Wed, 15 Jul 2026 11:30:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hw7v8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 11:30:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66FBUK2839190962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jul 2026 11:30:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738D020043;
	Wed, 15 Jul 2026 11:30:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AE4220040;
	Wed, 15 Jul 2026 11:30:20 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 15 Jul 2026 11:30:20 +0000 (GMT)
Date: Wed, 15 Jul 2026 13:30:19 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v5 3/4] mm/kasan: Introduce helpers for lazy MMU mode
 sanitizer
Message-ID: <8b38fa72-a069-4f9f-82b0-e591f6f8fe3d-agordeev@linux.ibm.com>
References: <cover.1783945507.git.agordeev@linux.ibm.com>
 <38a663eeccd060d961990baf65338e2f2550e580.1783945507.git.agordeev@linux.ibm.com>
 <20260713143024.5EA041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713143024.5EA041F000E9@smtp.kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rHikk3gbSO4-ukwL-fsxBkxaH1DnCmlJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDExMCBTYWx0ZWRfX4Y2+gQ8MhYjX
 TB2lzC0hO+K+tCzbzZdC+WN5vgXGW/sLL0sYB0cnvmQkvOkniIIQusyHWzlo9rpVE87D6JoAFDA
 dXhH3AXgTsMw/RPbs7mDvOz/LjJlNYs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDExMCBTYWx0ZWRfX5Bw8gaij5ff4
 z/++B6V3/9LTD0R/KaMjtpodHjbY5OS1LvB+OMDpCNgFlCvuYMv/8girXk1IbmJFIpg/e7F/2vV
 o2Qpt+Tw65PQ0BOAmJSZJVjhvbCu/dC36Pz2/7WG2oUSOiVO8GY0A9sMB8IZ9IW+w1HLclZ+BXE
 /c17PBjI1t4W0zgLHg7oGoKMqOZWawE+++e7G4ojI24gVhfLnwNXv5Rx9HpFQIAtlliTMBo5dLn
 50pNaR9Pwvl5Q7Oytahsh0Ds+kLNbwSZRQDbM9CZukAUwBgxdW2jHMi8P/MuqfW4j8gSAjKdjCc
 8wZ0pzbhoEgxAwsbXeBiZHCXos+Lp7/aiEZ3QIipFgz8s7iqWaDYQpjqsDf68CW/hsy8hIKnyT4
 van5NVx0ZAQDM2exSbfH/nN0lZEt4oUgEUPdiKIRiDHU95/COS+HJwJRrgPgpHleJkIawZyIJW2
 t1W7nhjYgJX3iM/7aOA==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a576f51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=lUPfQHfRZ_PyWXBUwmsA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: rHikk3gbSO4-ukwL-fsxBkxaH1DnCmlJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150110

On Mon, Jul 13, 2026 at 02:30:23PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] The newly introduced KASAN PTE helpers lack `EXPORT_SYMBOL`, which will cause module build failures when utilized in inline page table accessors.
> - [Medium] The generic `kasan_[un]poison_pte` API inherently conflicts with KASAN tracking requirements on architectures where `sizeof(pte_t) < KASAN_GRANULE_SIZE` (e.g., 32-bit architectures), causing WARN_ON splats and silent shadow memory corruption.
> - [Medium] KASAN poisoning of PTEs during lazy MMU mode fundamentally breaks concurrent lockless PTE readers (e.g., GUP-fast), causing false-positive KASAN splats.
> --
> 
> --- Patch [3]: [PATCH v5 3/4] mm/kasan: Introduce helpers for lazy MMU mode sanitizer ---
> commit ad7a1a1292ef9676ee173915cfe50c0da8ea27a4
> Author: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> mm/kasan: Introduce helpers for lazy MMU mode sanitizer
> 
> This commit introduces KASAN helpers to allow architectures to catch
> illegitimate direct PTE accesses while lazy MMU mode is enabled. It provides
> kasan_poison_pte() and kasan_unpoison_pte() routines, along with a new
> KASAN_LAZY_MMU_PTE shadow bug type.
> 
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index b7d05c2a6d93d..cbf68680614e5 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> [ ... ]
> > @@ -163,6 +163,16 @@ void __kasan_poison_slab(struct slab *slab)
> >  		     KASAN_SLAB_REDZONE, false);
> >  }
> >  
> > +void __kasan_poison_pte(pte_t *pte, int nr)
> > +{
> > +	kasan_poison(pte, sizeof(*pte) * nr, KASAN_LAZY_MMU_PTE, false);
> > +}
> 
> [Severity: Medium]
> Since lazy MMU mode is generally a per-thread or per-CPU state, but KASAN
> shadow memory is a globally shared mapping, will poisoning a live PTE page
> here trigger false-positive KASAN splats for concurrent legitimate lockless
> page table walkers?
> 
> For instance, if get_user_pages_fast() or handle_pte_fault() executes a
> READ_ONCE() on another CPU against this PTE, it seems they would hit the
> globally poisoned shadow memory.

Yes, and I learned it hard way. As result, ptep_get_lockless() is marked
as __no_sanitize_address on s390. That is ugly, but that is the only way
I came up with to avoid the above issue.

> [Severity: Medium]
> On 32-bit architectures where sizeof(pte_t) is 4 bytes, kasan_poison() will
> receive a size of 4 when nr is 1.
> 
> Since generic KASAN enforces an 8-byte alignment constraint, will this trigger
> the WARN_ON(size & KASAN_GRANULE_MASK) check?

I will exclude platforms with such pgtable entries altogether.

> [Severity: Medium]
> If architectures call this helper from inline page table accessors like
> ptep_get() or set_pte() in header files, will loadable modules fail to build
> with undefined symbol errors?
> 
> It looks like this function and __kasan_unpoison_pte() are missing an
> EXPORT_SYMBOL() or EXPORT_SYMBOL_GPL() declaration.
> 
> > +
> > +void __kasan_unpoison_pte(pte_t *pte, int nr)
> > +{
> > +	kasan_unpoison(pte, sizeof(*pte) * nr, false);
> > +}

Will fix.

> [Severity: Medium]
> kasan_unpoison() implicitly rounds the size up to the nearest
> KASAN_GRANULE_SIZE, which is 8 bytes.
> 
> On 32-bit architectures with 4-byte PTEs, could unpoisoning a single PTE
> inadvertently unpoison the adjacent PTE and corrupt its tracking state?
> 
> > +
> >  void __kasan_unpoison_new_object(struct kmem_cache *cache, void *object)
> >  {
> >  	kasan_unpoison(object, cache->object_size, false);

Same as for kasan_poison().

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783945507.git.agordeev@linux.ibm.com?part=3

Thanks!
