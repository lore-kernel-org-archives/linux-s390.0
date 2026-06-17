Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D713DB960
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781707085; cv=none; b=UNFUgO4GW6WI1YJFEHdJPQ0aBPq5FPo4UQwhqT2tIeXuqzIvFpoXqcZt9FTMpl00uT8PbSlqYSjp67/HBSzWJLR85pSvITjiyZwyujM2YPBQ352h4tq+ImTOwOkunkWD1XYnltk19XWxUYStdY9GLpg6gQ8NY5Wxzhwiq7CuOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781707085; c=relaxed/simple;
	bh=BfjprwTHE/F1r9xhxTGKExoixxtSF9NGA2JmRYcDY2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7YTvoLeKcmQYBoAkw2wGyrK4+jVgXczqBnv0WEPIqXcHKtc15gw0PJpudfn3xv3drDdZ14NNKy1u3vphTrJDG94GHh522aspBxPRYPzYcVf3t2EWsxhOAYVWu5Ky3/MNDVKafnmpnUgl3E7wAjtJT0LsGDDdZxPnjdTxvrDdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NHirWe+3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NHirWe+3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HEIALd620440
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 14:38:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0O/nfv
	Olk7h9yCpSLxRiEBtmkUjks3RxHOIxQVbcQj8=; b=NHirWe+3hWQOkHaY8IgMYv
	FmVQnQdq0BwIBGIzGRU/Ph0lYlyHhanc4hyp19X6hHzWThGIDr56ParyAlSwsVDW
	9eGGcLRLqr/kHsPyMDqCz2/6oBjob9aJPnMbkBY/0hgwLlNCbZDFEeQ3eeAqIH8g
	KYBkOlvQQBVfq4UqLQLP8CxZLQv+I+3EOWmLRR9ho20vbDAZIKatG5VP4ueD0IjD
	QP3shgGa1SGnYk5nwMZQlSRXmJ0JH8jC+Tfi9RrJvMs7zi2hyNqVGiIkbeBkwN+x
	kqBCJe0S/q97g7lUJBtFl9VtA2K9Bz4LBY3icC//9yINrcYa1m+Lfi9I2UGuIpbA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvudv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 14:38:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HEYkmq012352
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 14:38:01 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvabk5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2026 14:38:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HEbvtU37224918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 14:37:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1BAE20040;
	Wed, 17 Jun 2026 14:37:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6845E20043;
	Wed, 17 Jun 2026 14:37:57 +0000 (GMT)
Received: from [9.111.75.23] (unknown [9.111.75.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 14:37:57 +0000 (GMT)
Message-ID: <36ffea91-aacc-4687-8a25-7c4ebe7c9b74@linux.ibm.com>
Date: Wed, 17 Jun 2026 16:37:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390/traps: Add exception statistics
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20260617123350.3220729-1-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260617123350.3220729-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEzNyBTYWx0ZWRfX1umjZQs2tSwp
 VKMAsK44r8TA3/84U8VylfdKMjWHtDOK8SxijxEnpOA3bkXKmBNgH7r5ek9sI+bXtJslBwK0esi
 uGKQpfz/4inTgVtYyqV8E7Z4r2lJc0k=
X-Proofpoint-GUID: EH8ox4NoMH4-5LL4EMIIZKHpVjutTqCo
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a32b14a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8
 a=VnNF1IyMAAAA:8 a=2VAF_Mp5FaW9MgjuowIA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: EH8ox4NoMH4-5LL4EMIIZKHpVjutTqCo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEzNyBTYWx0ZWRfX6G12espFRYVR
 ZBisa79lOuVNSr15GgeoMbmfZ0OQNRD4X3hwZgMW7DoPZJqLAg5v5iw+GfhU7l5Nq8pkntLRbm7
 s+gHd7QJaVDlT5IRC/JqkaZJUqfMaCy8T89YAO3KU6lGFiCTa0nFwNxeZT1jA4lDLPwxnC8MPPy
 J5wGSYn3oS7hme6oZATlhzKD49UzV4utMpFXuETRCGNY+Pb+lQjAzCrWD6Cb/HoOtyalwBTjv4l
 m3Bh0Gx9FN68B2BGGSPzZQojNVLywrpoNJDv+OV+ckYnqQtEZ8TzQuprWQMYgUErffgr04RMdz1
 +FVo3Xv3zu7MRAjCfAv7xIrENQMsiI7AMwi/DMq894M8Vu7W7044L4EeFC9ogf4UZE5YOn20apG
 y+DxcZtuBN0VKnbBTnKcADNx1EK71AQcAoBtOkw7U1y+/iCmcjeHwnRr/y00oixW8aluMRUOsry
 BxAsJLNTggCvIGGg9aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170137

Am 17.06.26 um 14:33 schrieb Heiko Carstens:
> From: Sven Schnelle <svens@linux.ibm.com>
> 
> Add a new debugfs file which displays the number of exceptions (program
> checks) per CPU. This is helpful for debugging purposes.
> 
> The statistics are typically available at
> /sys/kernel/debug/s390/exceptions.
> 
> [ hca@linux.ibm.com: Forward ported code, changed file location ]
> 
> Suggested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Looks good to me
Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> ---
> 
> Notes:
>      v2:
>      - Fix / remove broken iterator handling as reported by Sashiko:
>        https://sashiko.dev/#/patchset/20260617113726.2079324-1-hca@linux.ibm.com?part=1
> 
>   arch/s390/kernel/traps.c | 41 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
> index 564403496a7c..fcd8c1122ef5 100644
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -9,7 +9,9 @@
>    *    Copyright (C) 1991, 1992 Linus Torvalds
>    */
>   
> +#include <linux/capability.h>
>   #include <linux/cpufeature.h>
> +#include <linux/debugfs.h>
>   #include <linux/kprobes.h>
>   #include <linux/kdebug.h>
>   #include <linux/randomize_kstack.h>
> @@ -33,6 +35,12 @@
>   #include <asm/fault.h>
>   #include "entry.h"
>   
> +struct pgm_stat {
> +	unsigned int count[128];
> +};
> +
> +static DEFINE_PER_CPU_SHARED_ALIGNED(struct pgm_stat, pgm_stat);
> +
>   static inline void __user *get_trap_ip(struct pt_regs *regs)
>   {
>   	unsigned long address;
> @@ -332,6 +340,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>   	struct lowcore *lc = get_lowcore();
>   	bool percpu_needs_fixup;
>   	irqentry_state_t state;
> +	struct pgm_stat *stat;
>   	unsigned int trapnr;
>   	union teid teid;
>   
> @@ -339,6 +348,10 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>   	regs->int_code = lc->pgm_int_code;
>   	regs->int_parm_long = teid.val;
>   	regs->monitor_code = lc->monitor_code;
> +
> +	trapnr = regs->int_code & PGM_INT_CODE_MASK;
> +	stat = this_cpu_ptr(&pgm_stat);
> +	stat->count[trapnr]++;
>   	/*
>   	 * In case of a guest fault, short-circuit the fault handler and return.
>   	 * This way the sie64a() function will return 0; fault address and
> @@ -383,7 +396,6 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>   	if (!irqs_disabled_flags(regs->psw.mask))
>   		trace_hardirqs_on();
>   	__arch_local_irq_ssm(regs->psw.mask & ~PSW_MASK_PER);
> -	trapnr = regs->int_code & PGM_INT_CODE_MASK;
>   	if (trapnr)
>   		pgm_check_table[trapnr](regs);
>   out:
> @@ -393,6 +405,33 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
>   	percpu_exit(regs, percpu_needs_fixup);
>   }
>   
> +static int pgm_check_stat_show(struct seq_file *p, void *v)
> +{
> +	int i, cpu;
> +
> +	cpus_read_lock();
> +	seq_puts(p, "          ");
> +	for_each_online_cpu(cpu)
> +		seq_printf(p, "CPU%-8d", cpu);
> +	seq_putc(p, '\n');
> +	for (i = 0; i < 128; i++) {
> +		seq_printf(p, "%02x: ", i);
> +		for_each_online_cpu(cpu)
> +			seq_printf(p, "%10u ", per_cpu(pgm_stat, cpu).count[i]);
> +		seq_putc(p, '\n');
> +	}
> +	cpus_read_unlock();
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pgm_check_stat);
> +
> +static int __init debugfs_pgm_check_init(void)
> +{
> +	debugfs_create_file("exceptions", 0400, arch_debugfs_dir, NULL, &pgm_check_stat_fops);
> +	return 0;
> +}
> +late_initcall(debugfs_pgm_check_init);
> +
>   /*
>    * The program check table contains exactly 128 (0x00-0x7f) entries. Each
>    * line defines the function to be called corresponding to the program check

