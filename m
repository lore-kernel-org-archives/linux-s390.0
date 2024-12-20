Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF83197A8F;
	Fri, 20 Dec 2024 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734684170; cv=none; b=ojGOdwoqADrHZTSamuxM6lsZvPTFe5xBFMyzugRDN8mj9cdCltf75lMbBhxSYiiyWLWwpH3Y4O4rduLu+ogeuqqDII5m1IcRfp3GwES2642bf39S3vPitNRcqcU3Fjk/r9yOJR1ESdOOvYjBumkmFCika4sfN/EMeOECUyQTocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734684170; c=relaxed/simple;
	bh=2ERL0k61MjaiS+VeRSU+FHgDKZqwQ2OZOxtw+c7R0bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mlMeSj2y/pbr8vQZ6E5eZvkUiI7LKrbgrvizCAdjqD8caLJOGaxTneZ6mwjGQD+1+G6bFRE95X51MY+IGmbjIbUsGv6cepWrkizuANABXKZtnI8NhvFT4nVNGKG3IBn9atF2cDdAly8uVkbZLwzYr4AYU8vH76j/IEz3HJ2omTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CQlJXGLV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CQlJXGLV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNbFUa010362;
	Fri, 20 Dec 2024 08:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ZRSRO1+IMydt5X2E+6U7iNTI+6Ud7o
	AoHs5HZLZHBvE=; b=CQlJXGLV7nWk6F848mJVjZbx8m8Bx/ilYDO4o+It6YihXI
	NdKgpjE/b6TIAwSdICZchWxpBvWfROgOp3if4gcFO1x/E1adZSpXqUTJDI59d1KS
	UcZ5tmme/On0DfN8nccMpRH6KpKfSLMDG/jN1xTugbQdnygtHgKZDfIFtWbxInlN
	V1qw9+30CsgeEwPnVsarULOjqDHCg/FNDfqIpIEoOXMOalkjDl/2uuJ0xFFaAWy9
	10Yn3NLIr8jzZavgCFKd90LofyIewmQ8jXJUu/4KJREDvOSLUoStgTG6oIeWf5f8
	X7ASOe867RrrQ43MjggNx/5fMH35Jrk7hUwtLm6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwaahsbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 08:42:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BK8axYW007991;
	Fri, 20 Dec 2024 08:42:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwaahsbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 08:42:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK5PiS2005488;
	Fri, 20 Dec 2024 08:42:09 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hnbnhc4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 08:42:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BK8g7HM57278888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 08:42:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F01BF2004B;
	Fri, 20 Dec 2024 08:42:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68AE32004E;
	Fri, 20 Dec 2024 08:42:05 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.45.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 08:42:05 +0000 (GMT)
Date: Fri, 20 Dec 2024 09:42:03 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, tglx@linutronix.de, david@redhat.com,
        jannh@google.com, hughd@google.com, yuzhao@google.com,
        willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
        lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
        rientjes@google.com, vishal.moola@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 10/15] s390: pgtable: also move pagetable_dtor() of
 PxD to __tlb_remove_table()
Message-ID: <Z2Ut225pJFBq2wad@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1734526570.git.zhengqi.arch@bytedance.com>
 <0a6caf8305409173b5d41dccb6ecd46460cf9c1c.1734526570.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a6caf8305409173b5d41dccb6ecd46460cf9c1c.1734526570.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kmj9hT5gcmZ27lZo4Hu4ANqUpOmExIrn
X-Proofpoint-GUID: jWWgn2vamVxqyPJwznO3SnWKD7Jvt1ul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=486
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200070

On Wed, Dec 18, 2024 at 09:04:46PM +0800, Qi Zheng wrote:
> In s390, the pagetable_dtor() of PTE has long been moved to
> __tlb_remove_table().

Well, not pagetable_dtor(), but rather pagetable_pte_dtor() and
not to __tlb_remove_table(), but to pagetable_pte_dtor_free() ;)

> So similarly, also move the pagetable_dtor() of
> PMD|PUD|P4D to __tlb_remove_table(). This prevents the use-after-free
> problem where the ptlock is freed immediately but the page table pages
> is freed later via RCU.
> 
> By the way, rename pagetable_pte_dtor_free() to pagetable_dtor_free().

This is not just a random rename, but rather a result of unifying
PxD and PTE TLB free paths.

Could you please come up with a better wording concerning the above?

> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/include/asm/tlb.h |  3 ---
>  arch/s390/mm/pgalloc.c      | 14 ++++----------
>  2 files changed, 4 insertions(+), 13 deletions(-)

You also did not CC linux-s390@vger.kernel.org for other patches
that affect s390 sources. Just CC the whole series, please.

Thanks!
