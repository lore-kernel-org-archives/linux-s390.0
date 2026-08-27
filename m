Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EADB306775;
	Thu, 27 Aug 2026 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787817118; cv=none; b=ZbUcPVMPruwFHL5sh/4ZMu8XfXh55JAphIU33OqEpeR+n+T8dP4xFn1uNfNQlaR5ZEmHfoma9V5M9nsoRUdib8BPHj1MyjJrVk9svsGGEy8qmsF2+/zLdgakEsBhcO2XicOlam3WIb6/1/od+mxs74hWxzWHp7f/4vQFinA0c20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787817118; c=relaxed/simple;
	bh=/5+cOR1/IQnbiKdUzxbTisVu7ZjCsNfHeLvg6xwMg7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjIU2bPwurQ6jNf4zsdPE+bvyMRMWi0g3NZqh9NGpDrecDd9Wmmy3Vv8GpuGRKEnUB2ZWMMA3z+bcyCqLRz7Z0Kp5yYE7CRbASIF1UL8QJXk09Vf9ETBS5tIk1T0jyHjlvwp1fJM2kvZxkBvSXbpSqyHcrYDAcJxsm+uGXEBK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OVbz8aZY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OVbz8aZY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6WBnf2267436;
	Thu, 27 Aug 2026 07:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+Ew0giZm8BFI5WP4qn3U8FI39Hg4Ed
	NIuOhFMb3Ivgo=; b=OVbz8aZYa1m3Ig3sGdUCLWMtl3xZ+ZfIwUnaavQbH+6giD
	ltLys5qvlg9/HZ+Rwuzfx9sjmWdYckedQWHNLvXyglKYtqPZKnWfCgmlwvNknCbk
	FmoCLDObIYV6zpXmxb5FetH1ISMgVmkzrsiQVHdtNwkLvMq9/VXv0MW5B4HJURiQ
	PAnDSNzkqva30X8z+XoyNSRr3LpxuvGrx+5HCqDz/MbKnaaJgdMbFWWJlYzsoGR4
	yfzSUHqcdH6+iKVlYwRwPssQYd6msOXk7cjWgqby/Nst8tFM2pWR1BpuWNfreV2v
	zuO6A3c9TKiJCWj3UTknH3/IxYVoasHqeQO1TNvw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxkmye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 07:51:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R7fHSE030134;
	Thu, 27 Aug 2026 07:51:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragpp31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 07:51:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R7pnTB40501616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 07:51:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 513CE2004F;
	Thu, 27 Aug 2026 07:51:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107192005A;
	Thu, 27 Aug 2026 07:51:49 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.20.232])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Aug 2026 07:51:48 +0000 (GMT)
Date: Thu, 27 Aug 2026 09:51:47 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/mm: Fix fail path in crst_table_upgrade()
Message-ID: <8a959b1e-7b29-4539-a7d5-9c77cf397aed-agordeev@linux.ibm.com>
References: <20260811121316.2622460-1-agordeev@linux.ibm.com>
 <20260811141203.12308B7d-hca@linux.ibm.com>
 <9e707e9c-2da5-4325-9bf3-b41aefb2f8ab-agordeev@linux.ibm.com>
 <20260824142227.11040D30-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824142227.11040D30-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX1rja2OnhlBgu
 v5kHvWryOBzM9jxiqlnozV5BCCsn3yR8bf3tZp4k1MASlAHAlDJxMMoXVBPjVf9mAv390SbcOda
 H2OZaRDAlFQDHWUs+XtibbBy+8RbjdM=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8fec9b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=I2Cq1U3C2w4F9YOXbjMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: yDIfzNw1EtebX1OL96VQ2VY1yr5yQPFB
X-Proofpoint-GUID: yDIfzNw1EtebX1OL96VQ2VY1yr5yQPFB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX3FAgdjFv+kRF
 eB9J09FZy28Dkk8pqss2z50gKz6JnxXNJ5N+xtJ0jE8Tqtaw8YxNzIAZ407RO4363M8nR3jSZiP
 14lrQ0WKnQ5CjdRaRuYh8yR3O66kWaz6tuFuJgwYlcQ5HfTWPtn0vQlvgrCenTQ5Th5ZtQ3tHiX
 b802b4Vt3ECkhsYm9OaTL8q3lnOWtmcCOT4O/gA+R3s07e4szfy/YlHDhnBydEc1PaDivHR8dOF
 HnXFKYJfuC0SKYXAE1MjqmpZPtWB6oYjhSnx998/XFxsss8OoWpbt7rFDFlM5IscbkHPYMUkwwR
 rJDj6wbRL+8BS9Wcz5/yEmMJu/HM2QvvkngBd0EA3Kt/709X392DS02MaU3rSqHWmeQn6+qTqdb
 B+PcWYrSns63zngNYU1A5rNmFVkl9QSEpbT3lkHOZA30Vu7iHEGFxE7bqwuSLRS62grJkDzUeSt
 /T/vgPzMmdLBwUbjf7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270061

On Mon, Aug 24, 2026 at 04:22:27PM +0200, Heiko Carstens wrote:
> On Wed, Aug 19, 2026 at 01:22:50PM +0200, Alexander Gordeev wrote:
> > On Tue, Aug 11, 2026 at 04:12:03PM +0200, Heiko Carstens wrote:
> > > Imho this makes the code even more uglier than it is/was. This is also yet
> > > another bug which is/was only possible after loop unrolling happened with
> > > [1]. Another bug, which would not have been possible without the rework back
> > > then, is [2].
> > > 
> > > So I would _much_ rather prefer to go back to what we had with [1], of course
> > > including the additional dtor/ctor code. But that code was much more readable
> > > compared to what we have now, especially considering the additional fix which
> > > is proposed now.
> > 
> > Frankly, to me personally the old version is more difficult to read.
> > In addition, in case of 3-5 upgrade on 4-5 allocation failure it has
> > (a) 4-level table leak and
> 
> Which leak? The old code never had leak where the allocated 4-level table
> would become unreachable (== leaked).
> 
> > (b) useless 3-4 upgrade.
> 
> This was an intentional design choice to keep the code simple.
> 
> > Should all of those get fixed, I doubt the end result will look as
> > simple as the original version. But I can try if you insist.
> 
> So "all of that" :) is at most b). But it really doesn't make any sense to do
> a rollback, simply because all of this is completely irrelevant for production
> kernels. Order-2 allocations can only fail with error injection, otherwise
> they never fail.
> 
> Hence the partial upgrade is fine - this is not a leak, but a partial proper
> upgrade of the address space size of the current task, with proper freeing of
> the page table (no leak) on process exit.
> 
> Note: the below keeps the oddity that pagetable_p4d_ctor() is called in case
> of only a 4-level upgrade, even though in such a case pagetable_pgd_ctor()
> would be "more" correct. In a similar way we have the oddity that after a page
> table upgrade on process exit for the third level pagetable_pmd_dtor() is
> called, even though on process start pagetable_pgd_ctor() was called for that
> level. The current common code doesn't care about this, but all of this
> doesn't look nice.
> 
> Anyway, the ctor/dtor issue is something different. The below would simplify
> the code to what we had before the unrolling.

Since your version is complete, would you like to post it?
If yes, please find:

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

>  arch/s390/mm/pgalloc.c | 89 +++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 53 deletions(-)
> 
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 5a3745cf7330..787e4d5fabea 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -53,63 +53,46 @@ static void __crst_table_upgrade(void *arg)
>  
>  int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
>  {
> -	unsigned long *pgd = NULL, *p4d = NULL, *__pgd;
> -	unsigned long asce_limit = mm->context.asce_limit;
> +	unsigned long *table, *pgd;
> +	int rc, notify;
>  
>  	mmap_assert_write_locked(mm);
> -
>  	/* upgrade should only happen from 3 to 4, 3 to 5, or 4 to 5 levels */
> -	VM_BUG_ON(asce_limit < _REGION2_SIZE);
> -
> -	if (end <= asce_limit)
> -		return 0;
> -
> -	if (asce_limit == _REGION2_SIZE) {
> -		p4d = crst_table_alloc(mm);
> -		if (unlikely(!p4d))
> -			goto err_p4d;
> -		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
> -		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
> +	VM_BUG_ON(mm->context.asce_limit < _REGION2_SIZE);
> +	rc = 0;
> +	notify = 0;
> +	while (mm->context.asce_limit < end) {
> +		table = crst_table_alloc(mm);
> +		if (!table) {
> +			rc = -ENOMEM;
> +			break;
> +		}
> +		spin_lock_bh(&mm->page_table_lock);
> +		pgd = (unsigned long *)mm->pgd;
> +		if (mm->context.asce_limit == _REGION2_SIZE) {
> +			crst_table_init(table, _REGION2_ENTRY_EMPTY);
> +			p4d_populate(mm, (p4d_t *)table, (pud_t *)pgd);
> +			pagetable_p4d_ctor(virt_to_ptdesc(table));
> +			mm->pgd = (pgd_t *)table;
> +			mm->context.asce_limit = _REGION1_SIZE;
> +			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
> +				_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
> +			mm_inc_nr_puds(mm);
> +		} else {
> +			crst_table_init(table, _REGION1_ENTRY_EMPTY);
> +			pgd_populate(mm, (pgd_t *)table, (p4d_t *)pgd);
> +			pagetable_pgd_ctor(virt_to_ptdesc(table));
> +			mm->pgd = (pgd_t *)table;
> +			mm->context.asce_limit = TASK_SIZE_MAX;
> +			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
> +				_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
> +		}
> +		notify = 1;
> +		spin_unlock_bh(&mm->page_table_lock);
>  	}
> -	if (end > _REGION1_SIZE) {
> -		pgd = crst_table_alloc(mm);
> -		if (unlikely(!pgd))
> -			goto err_pgd;
> -		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
> -		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
> -	}
> -
> -	spin_lock_bh(&mm->page_table_lock);
> -
> -	if (p4d) {
> -		__pgd = (unsigned long *) mm->pgd;
> -		p4d_populate(mm, (p4d_t *) p4d, (pud_t *) __pgd);
> -		mm->pgd = (pgd_t *) p4d;
> -		mm->context.asce_limit = _REGION1_SIZE;
> -		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
> -			_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
> -		mm_inc_nr_puds(mm);
> -	}
> -	if (pgd) {
> -		__pgd = (unsigned long *) mm->pgd;
> -		pgd_populate(mm, (pgd_t *) pgd, (p4d_t *) __pgd);
> -		mm->pgd = (pgd_t *) pgd;
> -		mm->context.asce_limit = TASK_SIZE_MAX;
> -		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
> -			_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
> -	}
> -
> -	spin_unlock_bh(&mm->page_table_lock);
> -
> -	on_each_cpu(__crst_table_upgrade, mm, 0);
> -
> -	return 0;
> -
> -err_pgd:
> -	pagetable_dtor(virt_to_ptdesc(p4d));
> -	crst_table_free(mm, p4d);
> -err_p4d:
> -	return -ENOMEM;
> +	if (notify)
> +		on_each_cpu(__crst_table_upgrade, mm, 0);
> +	return rc;
>  }
>  
>  unsigned long *page_table_alloc_noprof(struct mm_struct *mm)
> -- 
> 2.53.0

Thanks!
