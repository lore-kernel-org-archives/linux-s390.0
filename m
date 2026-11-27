Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785312;
	b=jh6EvzFDcOB7tPqsX7Yvmbf4yS+W5SkPts/PJ3oXZpTBF3gRRQLqKECxjh43EoYCcufI
	 LwkaWHEcQ5e912zKrcH136O/h5jJdfuj/NcFA/VlOv7FP1bDDzIbwD+BQSLVYuX9ggt8f
	 tRyBDzo5Gi/UqJ0siakJBvNZxRNDrqLJRxkb0nk+n04RPryTOL4F9fJnQlKE5qekOQkrD
	 urhf1gXqceT/aeMl8VFfeBp9xQDi4LgfuCgAgX4h1piO8EED6iAlujBwq8qhwakpmjolA
	 lfZsb1jNLecklrZJYN6R6Sgk+ONVIZ5SpVdRIEIXNJkVcOhxTKNKAUOkbE7rS6Hl+XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785312;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=g9Ph1lEpYYg+Jn1hnAK3NFg3pmxAgdYKSsFE1n9J8BI=;
	b=jymsQkNI10fY6YKf49sNM9r6O/ANdNbrhtQ1ZkiZubg1gyYUvqG4NLoi7T1GcodBcr1v
	 SzvfOsnc1DbwdB9gH0OJSTX47RPgV3XT1pa7PwtwzZOlJWG6wxaM4uxe2FTS4+DwLA5vv
	 Bzfvcb72SQIU8uUd8hk+D96nEYDaa8q/a30P57STBCsLKKO0bzVIfChPuM1zTBU+b4SFf
	 2Vjq/o6oSlZt+ppXl9Ys7/vv60cks0ITRoe5GMePfqX2Y8MsAkOKIy0KG1xPUdx421k6c
	 GNtSFZXbdDGuT1SEghhpYOFItw7bsbidTvlgocgXtXCtfMPWIdLkj0eInwA3bzrVKwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oIrIDIY+;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68266606A321;
	Fri, 27 Nov 2026 13:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68266606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oIrIDIY+
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARD54K13148909;
	Fri, 27 Nov 2026 13:14:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=g9Ph1l
	EpYYg+Jn1hnAK3NFg3pmxAgdYKSsFE1n9J8BI=; b=oIrIDIY+xLHHlcm1zb69fv
	GMNWR7eBTAkNWPKYQKDsLDzgEhaP8so7NShzKMhCBrmlqzxv843BWjGiM4oql7d9
	xVAWm4K/zc5slnQTEeaY3sstLQMf+w1DPccfeyD+NZ9F0qT0r/Aq7eZvVwBQq9iR
	tUvH5Dl/e01EVGw1lQiaNOi+nFwaT4W357ico7tZmpVLZqpv+ikgFFIsyuUEJ4lv
	E+f+D+KoxmOPZ0eKLiRXJaDAG2PeyoicwbdTsRY9040adK0jXIkYfM57Kl4U12j7
	HfG5Xu0+kU2GsMsVxd8d9N2OOsJlaaKaI7Uq7hJaIgDqJDGC4UNYwdwm2wc41CQQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1n5ts-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 13:14:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARCnDol1100426;
	Fri, 27 Nov 2026 13:14:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6rhckb0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 13:14:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARDEZ1a30278294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 13:14:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 219DA2004D;
	Fri, 27 Nov 2026 13:14:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DFB92004E;
	Fri, 27 Nov 2026 13:14:33 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.111.82.22])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Fri, 27 Nov 2026 13:14:33 +0000 (GMT)
Date: Fri, 27 Nov 2026 14:14:31 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@kernel.org>,
        Baolin Wang
 <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <liam@infradead.org>,
        Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev
 Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang
 <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
        Kiryl Shutsemau
 <kas@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        Rik van Riel
 <riel@surriel.com>, Vlastimil Babka <vbabka@kernel.org>,
        Harry Yoo
 <harry@kernel.org>, Jann Horn <jannh@google.com>,
        Kyle Zeng
 <kylebot@openai.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        linux-s390@vger.kernel.org, Jason Gunthorpe
 <jgg@ziepe.ca>
Subject: Re: [PATCH for 7.4-rc2+ 4/7] s390/mm: always clear
 _SEGMENT_ENTRY_READ in pmdp_invalidate()
Message-ID: <20261127141431.4c3c2b2b@thinkpad-T15>
In-Reply-To: <20261015-anon_vma_uaf_fix-v1-4-7b977303b42b@nvidia.com>
References: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
	<20261015-anon_vma_uaf_fix-v1-4-7b977303b42b@nvidia.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FeLowTyogOlHUnJfBR_xou9lqiAF_CMx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MiBTYWx0ZWRfX4M209SkPbL/+
 k08Lj+ZiToxKEUtkfQyo5s/KDbFjbNj1bTKYgyAbu+miQQlryq5UfjuQvbq11JyfaWzhyzgUhq8
 H9c1T0ulS11ryjHb1Kybw3/eQh8f8qQ=
X-Proofpoint-GUID: vhiax2KLb9rM44fc03ndO3pMxE3yegDi
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b098240 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Ikd4Dj_1AAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=jawjUyVw3NHo_kiyCjgA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MiBTYWx0ZWRfX3t/itx/F+v7t
 h/ee1jM5erlFfsjIU6YSrmIguY6Ayym1x1uIVW2Y8711jl72iFE/5ayGtoMq5hd2nBrjV0idY3s
 0JsLLeCeQW6STOu760KEXuf49Vp3nnM1kelrDvCncmdnZ2pjIvXmjENMA4kPH36xyV43purtLzg
 dGKcR4W3Eq0l2MUxLwnReQuxI+3ecMPPGc90hpPo+xL9hnDdu7Vn4WYvlhhup+5eUHhOfzr5oO+
 LykciOx9XF+CHLLWWJLbJDGTLUk9q4T9os2GCrIaYgIXfACd4CrzYto5bs+4aQP6u5czPhjv0I/
 zw1Iefdi1sMKavdPAEWIv0W3cJdXoVY78eu/y4o6KMp9LOiTYCVdjJYFwfk2PxOvku7nZsFS+Ah
 qZUNU6pronN79Bu0g1JNdQ+whX+H84qd13cjuqz87nrtwjmAChgZBgw4DWh5tW0LUUGpLWrmXfc
 fMzM6pIqloGyImQDDsQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270052

On Thu, 15 Oct 2026 14:13:04 -0400
Zi Yan <ziy@nvidia.com> wrote:

> pmdp_invalidate() sets _SEGMENT_ENTRY_INVALID, but on s390 that bit
> alone also marks an old (not young) PMD, which is still a valid mapping
> that GUP-fast follows. Without CONFIG_PAGE_TABLE_CHECK, an invalidated
> PMD is therefore not pmd_protnone(), so GUP-fast can grab a reference on
> the folio and, as the PMD value doesn't change until the caller
> finishes, the recheck after taking the reference passes too.
> 
> Code that invalidates a PMD and then decides, from the folio refcount,
> whether it may drop the mapping relies on GUP-fast backing off from an
> invalidated PMD, like it does from a cleared one. x86, arm64 and powerpc
> already make GUP-fast reject invalidated PMDs.
> 
> With CONFIG_PAGE_TABLE_CHECK, pmdp_invalidate() already clears
> _SEGMENT_ENTRY_READ, which makes the entry pmd_protnone(), so GUP-fast
> does not follow it. Do that unconditionally. As noted in commit
> 7b4dde5e40ad6 ("s390/pgtable: Add s390 support for page table check"),
> an invalidated PMD that is pmd_protnone() is fine for the remaining
> pmd_protnone() users, which run under the page table lock or are
> lockless walkers that should not follow it anyway.
> 
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> To: Alexander Gordeev <agordeev@linux.ibm.com>
> To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> To: Heiko Carstens <hca@linux.ibm.com>
> To: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/s390/include/asm/pgtable.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 2d5c2ab06de98..fe1ba746203ab 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1781,10 +1781,14 @@ static inline pmd_t pmdp_invalidate(struct vm_area_struct *vma,
>  	pmd_t pmd = *pmdp;
>  
>  	VM_WARN_ON_ONCE(!pmd_present(pmd));
> +	/*
> +	 * _SEGMENT_ENTRY_INVALID alone also marks an old (not young) entry,
> +	 * which lockless walkers like GUP-fast may follow. Clear
> +	 * _SEGMENT_ENTRY_READ too, so the invalidated entry is pmd_protnone()
> +	 * and is not followed, and page table check does not count it.
> +	 */
>  	pmd = set_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_INVALID));
> -#ifdef CONFIG_PAGE_TABLE_CHECK
>  	pmd = clear_pmd_bit(pmd, __pgprot(_SEGMENT_ENTRY_READ));
> -#endif
>  	page_table_check_pmd_set(vma->vm_mm, addr, pmdp, pmd);
>  	pmd = pmdp_xchg_direct(vma->vm_mm, addr, pmdp, pmd);
>  	return pmd;

Thanks, looks good to me, and I especially like the comment. As David said,
pmdp_invalidate() does not have reasonable semantics, and I think this makes
it a bit more clear, at least for s390.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
