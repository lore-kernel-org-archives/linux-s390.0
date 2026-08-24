Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35434071F3;
	Mon, 24 Aug 2026 10:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568062; cv=none; b=mEAN6S7eTmJNGuIPbpkZbNsGMctMqmEm42UkNr6z4P4Yqzx6mtErMCb1qieZvqN0+6Lwoela6q3FUYkaOgySvP+LaWRmZMxbkTmdICSKlArdq7MkXB2BbD4gnlN63v/JnyNGCqcXNNT6yMMRH0LaaATz7i9dJE2c4oX1aPF1p6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568062; c=relaxed/simple;
	bh=KGgkeNPdi53vM2GkJU8IDCr8dLz5rP5iKs6wtp+gwnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjkqVEHZpFfxnAJf+QfycLkOzZNJTLJ81LCzOkC2BjVI1Y3FR7jlTO3a3u8bVG8M5vt2GX+zjsX4T4gzpMt3So+0jJwH4930fNWOaMyL56KRVlp4WCdxLwzM9KfQ1D6Cptsg4muRoYFimimtYY4pAalAqL4F3wr91nzB/x2U/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XOZpugly; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XOZpugly"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9VgPI1464568;
	Mon, 24 Aug 2026 10:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3/T14l5efVCoI0cNX+jlXD2DWZPGJ8
	26RLHgjN99Qbw=; b=XOZpuglywHT95XDBkKH2XQOlca9MSJeRjAzN+AGZkRni0J
	GKKIyWOfrXPYglVth7B14eijjpKHCosOILho3RmiiFsnEMvIGm3L6ETwcgDpvHFU
	iw4AZYuTz6+hO9OLNw1MtIuOgE/g5QR2pOyWRpe8dtpPJ6Uqup8IaX2hWhJw1VnX
	/ybg2Se5FI9ted+4HDlTLUZ+oVV94xCJbmtSsweejythg9pM9vGPlSCuWQ8hvNuJ
	lbv6z8SczAZ9zhX82cc/Gkezik/Q6XQ3FT7iFQeS7HWmMRAXmoaoBqTEHJhKkl7H
	uACwheCeyVvXMzq79QA+0zyTaVRoXSSfgEhOLtpw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393rpe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 10:40:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OAQIXS006700;
	Mon, 24 Aug 2026 10:40:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvwebe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 10:40:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OAeouP49545566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 10:40:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7698920043;
	Mon, 24 Aug 2026 10:40:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 197B720040;
	Mon, 24 Aug 2026 10:40:50 +0000 (GMT)
Received: from osiris (unknown [9.111.89.201])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 24 Aug 2026 10:40:50 +0000 (GMT)
Date: Mon, 24 Aug 2026 12:40:48 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v7 2/4] s390/mm: Batch PTE updates in lazy MMU mode
Message-ID: <20260824104048.11040Cdc-hca@linux.ibm.com>
References: <cover.1786956464.git.agordeev@linux.ibm.com>
 <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7fd78377a7278108ef501cf76571e80caef5968.1786956464.git.agordeev@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aBBJq1sYD2QAF3RL4IeZXSVPpP4Tbh5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4OCBTYWx0ZWRfX75fqlJoYpcj3
 VuqvoN6MREkDOZWVmhgOKtEejDguKYrGKaX9WC9AmF/wtqG8x7StZnzXT4BcbYBgGA8UABHpXmJ
 6wSYvObgT69cn9Jv6xAb75oznLJq47zhjnY9977yWYApGudVgUctPn6Y7OJZjeoSPIwcU/Ea8De
 T6P/+lsJzcs/+pxENUZy4+DBpnsNlrj2KFAIUh97shE564PTUUDkneqLqxITgHTMijXVrVcO3ks
 O4TG0uke1SaDl06qgaReqwLzagGSiZCJFYDrOHd+6hLIHcFt9okYDGvg2KLD1rUAId/6e+yKooC
 6e+0p4zyRzxUjpEKWfFolIfU+3xYGIUwikgrUu6lKGTSY3giO5Ot05NH1X7pQ8tonVxYl1pmoI3
 6P4qtlRs0kAq1OfJllzCSCHmcrPeORSuWksFtBuok0CpQpGzyfLuiMfTKH3G/OTrxNJQrwNuz3V
 wwg/uL9ILC3aXn8wVNA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c1fb8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=sTYtNOhqI-yrCGmzPWoA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4OCBTYWx0ZWRfX5Hr10v06l+bM
 vkQF72efrd/jPqOK1fLCWjVi1yDhxFlUin2rVbLlo5/YRl7U4igHaW3UBmquiQAI1ENXrabks0e
 R0f3d4+bbSCHpIsuJ8aeF4sNQzlPJuA=
X-Proofpoint-ORIG-GUID: 5v_eDg43mIjksVXOeUwea4TJK2IWPwVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240088

On Mon, Aug 17, 2026 at 01:33:00PM +0200, Alexander Gordeev wrote:
> diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> index 3b3ecc647993..dba236664da9 100644
> --- a/arch/s390/include/asm/lowcore.h
> +++ b/arch/s390/include/asm/lowcore.h
> @@ -163,7 +163,7 @@ struct lowcore {
>  	__s32	preempt_count;			/* 0x03a8 */
>  	__u32	spinlock_lockval;		/* 0x03ac */
>  	__u32	spinlock_index;			/* 0x03b0 */
> -	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
> +	__s32	lazy_mmu_count;			/* 0x03b4 */

Why is this signed? Can it get negative?

> +static __always_inline bool is_lazy_mmu_active(void)
> +{
> +	if (__is_defined(__DECOMPRESSOR))
> +		return false;
> +	if (!get_lowcore()->lazy_mmu_count)
> +		return false;

I guess there is opportunity to generate better code here using an
alternative and using a flag output constraint too.

> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -77,6 +77,7 @@
>  #include <asm/maccess.h>
>  #include <asm/uv.h>
>  #include <asm/asm-offsets.h>
> +#include <asm/lazy_mmu.h>
>  #include "entry.h"
>  
>  /*
> @@ -1012,5 +1013,6 @@ void __init setup_arch(char **cmdline_p)
>  
>  void __init arch_cpu_finalize_init(void)
>  {
> +	lazy_mmu_online_boot_cpu();
>  	sclp_init();
>  }

What makes this code so special that an explicit call from
arch_cpu_finalize_init() is required? This is really the last resort if
everything else fails. To me it looks like the code can be changed to use a
new static key, and add a generic early (pre-smp) initcall to allocate
memory for cpu 0, and if that succeeds enable the static key.

> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -59,6 +59,7 @@
>  #include <asm/topology.h>
>  #include <asm/vdso.h>
>  #include <asm/maccess.h>
> +#include <asm/lazy_mmu.h>
>  #include "entry.h"
>  
>  enum {
> @@ -866,6 +867,11 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  	rc = pcpu_alloc_lowcore(pcpu, cpu);
>  	if (rc)
>  		return rc;
> +	rc = lazy_mmu_online_cpu(GFP_KERNEL, cpu);
> +	if (rc) {
> +		pcpu_free_lowcore(pcpu, cpu);
> +		return rc;
> +	}
>  	/*
>  	 * Make sure global control register contents do not change
>  	 * until new CPU has initialized control registers.
> @@ -921,6 +927,7 @@ void __cpu_die(unsigned int cpu)
>  	pcpu = per_cpu_ptr(&pcpu_devices, cpu);
>  	while (!pcpu_stopped(pcpu))
>  		cpu_relax();
> +	lazy_mmu_offline_cpu(cpu);

Same here: what makes this code so special that this needs to be open-coded
into the low level cpu hotplug code? Everybody who needs to change this
code in future will wonder why the mmu code is so special that it needs to
be directly handled here, and then needs to understand the mmu code.
And the answer is: there is no reason.

Please use a generic cpu hotplug notifier to avoid that maintenance get's
more expensive.

> +static void leave_ipte_range(void)
> +{
> +	pte_t *ptep, *start, *start_cache, *cache;
> +	unsigned long start_addr, addr;
> +	struct ipte_range *range;
> +	int start_idx;
> +
> +	if (!test_facility(13))
> +		return;
> +
> +	local_bh_disable();
> +
> +	lockdep_assert_preemption_disabled();
> +	range = this_cpu_read(ipte_range);

Why is it required to disable bottom halves? A comment would be helpful.
Or a hint in the commit message - this is not obvious.

Also at least for !PREEMPT_RT (which is always true for s390)
lockdep_assert_preemption_disabled() is quite pointless, since
local_bh_disable() just one line above disables preemption.

I guess you wanted to add that check above local_bh_disable()?
If not you could as well remove it
