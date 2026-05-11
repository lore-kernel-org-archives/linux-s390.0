Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0783C2762;
	Mon, 11 May 2026 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516005; cv=none; b=g1KQ+kO1mY8WzlBX0tdPeKtoPb9HATKG2UjdyMtofSkYrYeF/SgNhK7IctrwCEXO5K78SPr2ADUvZ6nT3eFsQ6PEZO/8aTV7Ic5HwOzN4BgQBTTcEYl0nP4AdqNYR2GwBp7EUgItpLg91/7QW71i0lWJR0eHa8uO+Dqv1jWcCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516005; c=relaxed/simple;
	bh=xeyRe9IMzPMwlmfrdl2q0b0S7POsg5/6GQBoQNrkirc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c44vsqwot5gKhEBUA+yoA1uWlY0Hu6Xczyt+OJwnX0aCYmWObd2m6NwoZRWTCjxAZcCY7K260y+5tIb3Q2xQNsncj9TUDobcLcwyoUiXhW7GFZ8bKfdmSrxu5vtqy5pMdcOS/bGHfgGYm2i/l2t9ARF0C9UWG4Dg9ZmbNetrox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IddWjTy6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IddWjTy6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B4FLmQ2171729;
	Mon, 11 May 2026 16:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Z5TaKbhZcXwFj2Ql7FYh+c5RLjoEoI
	OFhZpQsZFqhRs=; b=IddWjTy6cGUFS0XOgECTEJCgV+0+Qczpe+kceIwchVV1Zw
	uBijdUM9Gx8oUJ0yl28EG43bT0/hJo34x9QUTwPBRlAJkp4ckYDSIxg87EDXYOF9
	XYbanb2ZwTwyOON3nocx34p20lQnO7VNnzNLLyPbwQ8lrwGqRXsb0XqniAh0h+Qj
	Rmpq4bRxqnlSyXKIRnvjTjYrxGpbxJ3OhsdcO54RAREnpVg26mzxN/FK0a1eV5ML
	tbXjEfc1nt7FBRGneTezD7IaDLDWI95Bi71BaoHLKwOtOk96J7Vh4SkpbxMKM9GB
	rzFdQCOKd/PzUaVEyOw8+VcYQHTThDgX2QkjLoLg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ubdrn88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:13:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BG9cJn006079;
	Mon, 11 May 2026 16:13:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hxy5s94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 May 2026 16:13:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64BGDBJZ45351282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 16:13:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 285F52004B;
	Mon, 11 May 2026 16:13:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E421720043;
	Mon, 11 May 2026 16:13:10 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.52.215.75])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 May 2026 16:13:10 +0000 (GMT)
Date: Mon, 11 May 2026 18:13:09 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org,
        david@kernel.org, mhocko@suse.com, brauner@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
        timmurray@google.com
Subject: Re: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio
 reclaim via mmu_gather
Message-ID: <d9644dab-120f-485c-9324-205282d89234-agordeev@linux.ibm.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-2-minchan@kernel.org>
 <20260505145318.97692A14-agordeev@linux.ibm.com>
 <af5cEycgIu2GUicn@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5cEycgIu2GUicn@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BezoFLt2 c=1 sm=1 tr=0 ts=6a02001a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=dO0aIYJa2u9nTzUSCSsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: C6p3qwjde6tRgWBCVLk7qSGEZWixbkUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3NCBTYWx0ZWRfXy1q93jGdVJAi
 0V4l7W/pe3DUJ/WDsWqIduR7VS+sDqJX/8BY5FTNO81r2SEoTynPkS/9k5gXe4rRuIuzZE1ewwU
 0y4sdgAA9K3+enE1jPxpCpC+6k/8fVoI6AeItKMTh6ZlJXN4reNtlWZym5QfDY+Ja2SQgl2bj5a
 DtYy6ZTP/VBDo2j369UzAE3gB62AjBlcsmH1A2MpLkTwoEHYUE79tXNPWe7eXf5R44E0j4IZMtt
 2Owzwa12XDxvqqc7tZ4qxzcq2HIOtmtzOqJTBjojI2lE7L0qmsccaaKGxXlhNuO4YCFaALPV5Rb
 4P9RWI1RlVGK+0IvBwnn3P2F+2599s53tquJXE0KT4Q26Hgd+kUXfOussFw1CSgXiNNWXc9xNAs
 AXCsAMJxCCDOk6wIpq08SX/EdBlnQxYuxj3wv2LXAbkiGhxbuYgRUYdIgW+dgbcl2XtEdqh7Bl1
 r31a/8hCuUHwQr0qyIQ==
X-Proofpoint-ORIG-GUID: I8FAFUP_109BHlu__ZTcZ34HlWDrp4tK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110174

On Fri, May 08, 2026 at 02:56:35PM -0700, Minchan Kim wrote:

Hi Minchan,

> > > +void free_pages_and_caches(struct mm_struct *mm, struct encoded_page **pages, int nr)
> > > +{
> > > +	bool try_evict_file_folios = mm_flags_test(MMF_UNSTABLE, mm);
> > > +	struct folio_batch folios;
> > > +	unsigned int refs[PAGEVEC_SIZE];
> > > +
> > > +	folio_batch_init(&folios);
> > > +	for (int i = 0; i < nr; i++) {
> > > +		struct folio *folio = page_folio(encoded_page_ptr(pages[i]));
> > > +
> > > +		if (folio_test_anon(folio))
> > > +			free_swap_cache(folio);
> > > +		else if (unlikely(try_evict_file_folios))
> > > +			free_file_cache(folio);
> > 
> > This condition is absent in free_pages_and_swap_cache().
> > What would happen with non-anon and non-evict folio?
> 
> Are you asking about mlocked pages for file?
> 
> During unmapping, munlock_vma_folio() inside __folio_remove_rmap() clears
> the PG_mlocked flag and moves the folio back to the evictable LRU list.
> 
> By the time the folios reach free_pages_and_caches(), if the folio is
> exclusive, it will be successfully evicted. However, if the folio is shared,
> mapping_evict_folio() detects it via the refcount check and skips the
> eviction.
> 
> However, I realized we miss shmem folios in the swap cache due to the new
> folio_test_anon() check we introduced. I will update the check to something
> like this:
> 
> if (folio_test_swapcache(folio))
>     free_swap_cache(folio);

This condition looks redundant, since free_swap_cache() checks it too.

> else if (unlikely(try_evict_file_folios))
>     free_file_cache(folio);
> 
> Let me know if I missed something from your point.


Thanks!

> Thank you.
