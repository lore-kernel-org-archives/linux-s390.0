Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A513EFF3;
	Thu, 23 Jan 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651096; cv=none; b=XvGJ5Qt8XSoeNI71X4g90N6FljebuxcoHvOxRzEIHUFGoGWRw/rvOUgBCQi9yNGoWH3EG42CqBDLFdLc2mIxJeR6Y0Ho5aILuSw/M2xbloab+A4JZGSunZLdihB3pUYNP//8M+QiQugt18u6KXVg6rqF6F4Yy2HrkWtA4eK/aAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651096; c=relaxed/simple;
	bh=DFaduKWU7VYI0Y7AW+VOvvpoHX2vW2fn3yulvDYBHyo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibv4ylRJMfcYNdNoaid28VTY50MziyQhlw7Gu0SYMzB4e22vmowCY8LzfO1ACTpMrRPslXwAJ72t7IF6doSwUMCv5t8tQM4uWeN795zKRQe55ordh8ntT4fdhPxleqb4N4Xwy+y6kdVDa7jPFD0EvloVtSWvsPZ8ffqnzly3RP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Z4z+dH68; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Z4z+dH68"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NCP5cR020970;
	Thu, 23 Jan 2025 16:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CWWHnl
	JRw0cVfjePevnNcyxun8+eLFDlFqd7I3sHbgw=; b=Z4z+dH68/3nA73wW7LDAMX
	GOfuzM/mKU3xLhNQuD+n2C3VF5Me5LHUFYvvNidGzNG9BaSTi5qDssa4AsUZgcS3
	d/RY5C1ORQRE34xMHXgg4jHrjSxbvsSoXgmYjBFhPqzUE3q6s53BMeyoiHJvHv6f
	ztFHfo08ciJMKFD0ZKwrtFDbMmVrku+IGWDW95mq+C4UFCcpW047hdq7VaEPW+6H
	KJAILoXotZ+rAmKePzWo3UaAMlvFfuEISJaHM3Vhxedxp9RuUlhnnlEPojL0zCIK
	F1TuporU5syZfbAT/RJpKuoVeWT0tiZB0xm6JOogPaAwhZRUtrPA84N5WcnjyMmw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu9c66h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 16:51:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDx2co019218;
	Thu, 23 Jan 2025 16:51:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmspn1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 16:51:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NGpBH452232614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 16:51:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 385222005A;
	Thu, 23 Jan 2025 16:51:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2E6F20040;
	Thu, 23 Jan 2025 16:51:10 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.152.212.238])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 16:51:10 +0000 (GMT)
Date: Thu, 23 Jan 2025 17:51:09 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
        Qi Zheng
 <zhengqi.arch@bytedance.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] s390/mm: Add missing ctor/dtor on page table upgrade
Message-ID: <20250123175109.294d7b4e@thinkpad-T15>
In-Reply-To: <20250123160349.200154-1-agordeev@linux.ibm.com>
References: <20250123160349.200154-1-agordeev@linux.ibm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IfKiNrKGv5ac1G9_wmbyaK86EmOJnqLw
X-Proofpoint-ORIG-GUID: IfKiNrKGv5ac1G9_wmbyaK86EmOJnqLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=931
 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230122

On Thu, 23 Jan 2025 17:03:49 +0100
Alexander Gordeev <agordeev@linux.ibm.com> wrote:

> Commit 78966b550289 ("s390: pgtable: add statistics for PUD and P4D
> level page table") misses the call to pagetable_p4d_ctor() against
> a newly allocated P4D table in crst_table_upgrade();
> 
> Commit 68c601de75d8 ("mm: introduce ctor/dtor at PGD level") misses
> the call to pagetable_pgd_ctor() against a newly allocated PGD and
> the call to pagetable_dtor() against a newly allocated P4D that is
> about to be freed on crst_table_upgrade() PGD upgrade fail path.
> 
> The missed constructors and destructor break (at least) the page
> table accounting when a process memory space is upgraded.
> 
> Reported-by: Heiko Carstens <hca@linux.ibm.com>
> Closes: https://lore.kernel.org/all/20250122074954.8685-A-hca@linux.ibm.com/
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Fixes: 78966b550289 ("s390: pgtable: add statistics for PUD and P4D level page table")
> Fixes: 68c601de75d8 ("mm: introduce ctor/dtor at PGD level")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
> The patch is against:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git	next-20250123
>   git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm			mm-stable
> ---
>  arch/s390/mm/pgalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index a4e761902093..d33f55b7ee98 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -88,12 +88,14 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
>  		if (unlikely(!p4d))
>  			goto err_p4d;
>  		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
> +		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
>  	}
>  	if (end > _REGION1_SIZE) {
>  		pgd = crst_table_alloc(mm);
>  		if (unlikely(!pgd))
>  			goto err_pgd;
>  		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
> +		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
>  	}
>  
>  	spin_lock_bh(&mm->page_table_lock);
> @@ -130,6 +132,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
>  	return 0;
>  
>  err_pgd:
> +	pagetable_dtor(virt_to_ptdesc(p4d));
>  	crst_table_free(mm, p4d);
>  err_p4d:
>  	return -ENOMEM;

Thanks, looks good, and nice catch.

Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
