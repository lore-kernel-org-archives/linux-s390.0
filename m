Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62201415F3B;
	Mon, 24 Aug 2026 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581356; cv=none; b=YrEj6hbOtog6BVxDz/KvSeQFPtrFelAuQVv3MvmenCUzXgZ3ztr2WZdkLdUoViLZ4HYPaYUB7hMM3dpQlrR9VJZT/6LfhBeyRRySYzi4bhZmUz/4lP2RPZUxHiQPn/yXMmPc0Lv5PFDgzHEyxPmsQl+Hqyv04kmjXmkDAG+3Rjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581356; c=relaxed/simple;
	bh=bWsZf5Y0HVrL+n5BtQEvneAZD0GkrmcYfSHgzLZnZEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teyVeu6zf8BWMe38mkYWgZH1p5OUy7roHiLKIZo7n+zo2ywMQNlOb1xnm1FA2FuF29WkiLvfMh6xRgZ4NFB+8aLF8HMNJHR3U+b0Z6uJwlzG/8XZNNEGC5qC/nSLHOHDvSlsUkxxJnhAqWkrVjqkKk/oh+WlCnGYcDVdx6TPhg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z5ut4N4L; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z5ut4N4L"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1dUg826452;
	Mon, 24 Aug 2026 14:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/8wbJaB8w7ljMa8iNAeXyJ4NbPqJSz
	AHucY4wayjc6U=; b=Z5ut4N4LeUy6KwpxatMcMNix2SNOwCAJNs9P0Jju9Oi6Ty
	i7BT/pOgrwstaQanZ9z1MFOWapJeC1kSz7gwfycXd/xw8b6Q1gzZ3kjqwacfHsoy
	FqJNIrGyK/A4u1x6AYLx6k3Y+UAAyndXLFNlLgtJUr5ryfDEAJzeP7SkeO37ohLt
	bN6zy4JaQORNN2yvPH1WIMMK1aoPoO1xGS/pKqx5fYIkQTt3cfzHyACQmf2nBC9X
	HsFmBu9/niapAa48/Q7PtMGPqNL8qbIGiXjVR6xLbdjWs1H5kJevwLUCY9Anjl4p
	l6Cvc0AyrjbxhUFcBnJUQrEYqMCIQQrzwfyecvmg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e9x85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:22:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEBIMf007876;
	Mon, 24 Aug 2026 14:22:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3jpf3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:22:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEMTCO45351194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:22:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A09F2004B;
	Mon, 24 Aug 2026 14:22:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D57AC20043;
	Mon, 24 Aug 2026 14:22:28 +0000 (GMT)
Received: from osiris (unknown [9.111.89.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 14:22:28 +0000 (GMT)
Date: Mon, 24 Aug 2026 16:22:27 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Fix fail path in crst_table_upgrade()
Message-ID: <20260824142227.11040D30-hca@linux.ibm.com>
References: <20260811121316.2622460-1-agordeev@linux.ibm.com>
 <20260811141203.12308B7d-hca@linux.ibm.com>
 <9e707e9c-2da5-4325-9bf3-b41aefb2f8ab-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e707e9c-2da5-4325-9bf3-b41aefb2f8ab-agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c53a9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=f_ASS56VSiJkH6YHfBsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX86HgDUjQ6LNC
 MDFqXB67NTFoUmn/4vKEnK59wqizNjWP0cn+K4k/eTgtoCWqJ2RZq6Biwc4Vk/1zbqKIMQ+DVAG
 /XEIrkbWRs3repVhSVHxelmRHfW5QXA=
X-Proofpoint-GUID: D4wppAIxgbthQGz6YVYexoYHua1PVTRl
X-Proofpoint-ORIG-GUID: D4wppAIxgbthQGz6YVYexoYHua1PVTRl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfXyhXvC7rRNlmj
 8Uefb8m+A7IwxoZOhbPYzefg45DCpiMBOsFoXHnfjs5IxVqnc1eCK8Fw1IcMAG0gFnmZhDZgwgM
 gNlDC0QzRmIwRlnBgxhVGbi32C1d3jYTeTLFWo5qAWe1QAiXkl4/Fvdk/VGrWFpoyrJPtBkuvIo
 6KoyKpuKWcGc+EdXnkHq+91FN7CO/MWI9LpIMJDoS8J+oLY8b6q3DL/kLjNjIgT0G4mjq14J3kf
 Y8ZXNNHdgsdOFKVuF2fbaSYiCEvxMnY8LWrS+7l5NbyeeUkbzDXJhJn4rkSJmy1CVhJh4vK7FOI
 IlVhsTWL4H7pysrGz0/x7QS8tExz9vYti0l0t/KbJtGddhlFme5vq13Z/5IM8dzseBnPbZik/Yf
 Di1hLfLhL9EDYGDogePDs2cUhKjIMZdOgdBvihqVfOZVRfJXXic8awddCoe4o5fwC7Zso9xY/xT
 MqMf4mM3SBxyBF/8GQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118

On Wed, Aug 19, 2026 at 01:22:50PM +0200, Alexander Gordeev wrote:
> On Tue, Aug 11, 2026 at 04:12:03PM +0200, Heiko Carstens wrote:
> > Imho this makes the code even more uglier than it is/was. This is also yet
> > another bug which is/was only possible after loop unrolling happened with
> > [1]. Another bug, which would not have been possible without the rework back
> > then, is [2].
> > 
> > So I would _much_ rather prefer to go back to what we had with [1], of course
> > including the additional dtor/ctor code. But that code was much more readable
> > compared to what we have now, especially considering the additional fix which
> > is proposed now.
> 
> Frankly, to me personally the old version is more difficult to read.
> In addition, in case of 3-5 upgrade on 4-5 allocation failure it has
> (a) 4-level table leak and

Which leak? The old code never had leak where the allocated 4-level table
would become unreachable (== leaked).

> (b) useless 3-4 upgrade.

This was an intentional design choice to keep the code simple.

> Should all of those get fixed, I doubt the end result will look as
> simple as the original version. But I can try if you insist.

So "all of that" :) is at most b). But it really doesn't make any sense to do
a rollback, simply because all of this is completely irrelevant for production
kernels. Order-2 allocations can only fail with error injection, otherwise
they never fail.

Hence the partial upgrade is fine - this is not a leak, but a partial proper
upgrade of the address space size of the current task, with proper freeing of
the page table (no leak) on process exit.

Note: the below keeps the oddity that pagetable_p4d_ctor() is called in case
of only a 4-level upgrade, even though in such a case pagetable_pgd_ctor()
would be "more" correct. In a similar way we have the oddity that after a page
table upgrade on process exit for the third level pagetable_pmd_dtor() is
called, even though on process start pagetable_pgd_ctor() was called for that
level. The current common code doesn't care about this, but all of this
doesn't look nice.

Anyway, the ctor/dtor issue is something different. The below would simplify
the code to what we had before the unrolling.

---
 arch/s390/mm/pgalloc.c | 89 +++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 5a3745cf7330..787e4d5fabea 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -53,63 +53,46 @@ static void __crst_table_upgrade(void *arg)
 
 int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 {
-	unsigned long *pgd = NULL, *p4d = NULL, *__pgd;
-	unsigned long asce_limit = mm->context.asce_limit;
+	unsigned long *table, *pgd;
+	int rc, notify;
 
 	mmap_assert_write_locked(mm);
-
 	/* upgrade should only happen from 3 to 4, 3 to 5, or 4 to 5 levels */
-	VM_BUG_ON(asce_limit < _REGION2_SIZE);
-
-	if (end <= asce_limit)
-		return 0;
-
-	if (asce_limit == _REGION2_SIZE) {
-		p4d = crst_table_alloc(mm);
-		if (unlikely(!p4d))
-			goto err_p4d;
-		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
-		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
+	VM_BUG_ON(mm->context.asce_limit < _REGION2_SIZE);
+	rc = 0;
+	notify = 0;
+	while (mm->context.asce_limit < end) {
+		table = crst_table_alloc(mm);
+		if (!table) {
+			rc = -ENOMEM;
+			break;
+		}
+		spin_lock_bh(&mm->page_table_lock);
+		pgd = (unsigned long *)mm->pgd;
+		if (mm->context.asce_limit == _REGION2_SIZE) {
+			crst_table_init(table, _REGION2_ENTRY_EMPTY);
+			p4d_populate(mm, (p4d_t *)table, (pud_t *)pgd);
+			pagetable_p4d_ctor(virt_to_ptdesc(table));
+			mm->pgd = (pgd_t *)table;
+			mm->context.asce_limit = _REGION1_SIZE;
+			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+			mm_inc_nr_puds(mm);
+		} else {
+			crst_table_init(table, _REGION1_ENTRY_EMPTY);
+			pgd_populate(mm, (pgd_t *)table, (p4d_t *)pgd);
+			pagetable_pgd_ctor(virt_to_ptdesc(table));
+			mm->pgd = (pgd_t *)table;
+			mm->context.asce_limit = TASK_SIZE_MAX;
+			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
+		}
+		notify = 1;
+		spin_unlock_bh(&mm->page_table_lock);
 	}
-	if (end > _REGION1_SIZE) {
-		pgd = crst_table_alloc(mm);
-		if (unlikely(!pgd))
-			goto err_pgd;
-		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
-		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
-	}
-
-	spin_lock_bh(&mm->page_table_lock);
-
-	if (p4d) {
-		__pgd = (unsigned long *) mm->pgd;
-		p4d_populate(mm, (p4d_t *) p4d, (pud_t *) __pgd);
-		mm->pgd = (pgd_t *) p4d;
-		mm->context.asce_limit = _REGION1_SIZE;
-		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
-			_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
-		mm_inc_nr_puds(mm);
-	}
-	if (pgd) {
-		__pgd = (unsigned long *) mm->pgd;
-		pgd_populate(mm, (pgd_t *) pgd, (p4d_t *) __pgd);
-		mm->pgd = (pgd_t *) pgd;
-		mm->context.asce_limit = TASK_SIZE_MAX;
-		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
-			_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
-	}
-
-	spin_unlock_bh(&mm->page_table_lock);
-
-	on_each_cpu(__crst_table_upgrade, mm, 0);
-
-	return 0;
-
-err_pgd:
-	pagetable_dtor(virt_to_ptdesc(p4d));
-	crst_table_free(mm, p4d);
-err_p4d:
-	return -ENOMEM;
+	if (notify)
+		on_each_cpu(__crst_table_upgrade, mm, 0);
+	return rc;
 }
 
 unsigned long *page_table_alloc_noprof(struct mm_struct *mm)
-- 
2.53.0

