Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFE31E848;
	Thu,  6 Aug 2026 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041531; cv=none; b=DOyXwk09SdPXX7wGx0S4Gs9k9a6vUNpzPsl7kTUuPXQxnhiA9XI/uvQEtIg4jhbKUwn2LDHBAAXNL0hIp40difhNB90kGnQgt5yltmrP3S/Q7hyZdYf5Kzg2VBuuoL8yO8y0NiEW/Ssivu3CvEzMLpDDz1IQk5x4btFtraQd+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041531; c=relaxed/simple;
	bh=rA1bH14cinXGItdpTk4zAr+H5fF+btaCFoBNhAI73Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGJzBkIkykJ3Wi1gA1VaQvMpZmbxJfUa7SG6bRlv+uej9Jv77jxlDD6WH3lG8d6JsbNEGR9ao78qzPyKFVuEdmrzvsyhn6uRsvdETXtKcgX0o7PTXHAppGD5R6qIatP5VucbO27rCNTFxEHLzOt+dBb/auA87feVxc/egk1cKb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c1871wLm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c1871wLm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHp7i3420962;
	Thu, 6 Aug 2026 18:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uk86EM
	wbBoBgtArvUof2Fk1GrPCoAbvQrP5V+A0xZ3U=; b=c1871wLmajucT4RMSYlLii
	G2yjuQrEZVcCH0wIJsLr1Fava1/3ktZSWxdEaX/804zI/YoX3WWw9WYT3EZnUiCC
	bF68mItQWDwAcgNEvbeFe4JDwXGuktAtXqMUS9zgT0n8y5BMZFLcWvaw28pyNSGZ
	6KCnWn0d1b2LV2ic3PoAPiUvPJqOajNZalJLaWflbxyLnBN4Asf3c4ZhQWBHf85X
	mtmhKovPq2biRpEXz2e8oVrP6o0FDbPMy59/Royks+1BO7+DzaCvdwrJD0a1VhuK
	4kIFjY/1ui1Sj0pZmDa5/r9PNVR8IDgGYaPjg5B8ibt41J9jr2Oj+ye3MLjpWBaA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyr80q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:38:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676IQNEf001161;
	Thu, 6 Aug 2026 18:38:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhmdkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 18:38:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676IchpI45416844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 18:38:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B494B20040;
	Thu,  6 Aug 2026 18:38:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67DB02004F;
	Thu,  6 Aug 2026 18:38:43 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.90.112])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 18:38:43 +0000 (GMT)
Message-ID: <a176a089-c6bf-4dfe-9595-f4f2f2f7066c@linux.ibm.com>
Date: Thu, 6 Aug 2026 20:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/irqflags: add out-of-line definitions of
 arch_local_irq_*() for KMSAN
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20260806100038.3163298-1-iii@linux.ibm.com>
 <20260806101931.53AC31F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806101931.53AC31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a74d4b9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=6Cs8bk-RoXXzb5uR4IQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MyBTYWx0ZWRfX7rJQXbdABdH7
 KCihCJ02hz6ZYDaDntSpA5BXsP4sUwIP1OcxntQNb1ZJ3LEweYeWizibyTHkLkVaaieZUkY4jOU
 BT2jpbcc0KAS7gsg9P0uKAq6UUWOcQc=
X-Proofpoint-ORIG-GUID: NFiO8tl36tEGeJwsPxW1YlGuwhgeXAZH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MyBTYWx0ZWRfX+L29dgeVnwi0
 dRL+okH/azYLJp0GhViwC+N5HGMfFg9bI3Ma8hP+71c9GPXbTI/5bk2rn0yAIA9tqKhe1TCgBV2
 XcefdWbauPIfHe7E9dixuq2cyxGXEGWjRcJzz0tAaf5VrNuggkF873niSKbLF0sx/EX2c1dwdL/
 wbrBENmOLcchioujHH2ECj0zEOuNXsrBblZAKOiCGF6Frr/8vDGLDlL8HwtR9YE0eTvZTs208p5
 SfCMRYE8gkmwBPziYOyFs9T5Fa+mSObkIWoDnybOp88LFrlwYlEW4QPewxRc3Cax3tEVjxzt1ZM
 csMYlkD4VypylwV1LMVcwqSClkEwIDYdYtYVjVSgjhqP9oJotJwjkBo+er8YPqZppU27P15cmtD
 4a2QZnnb8yI4EMK1HiAQOelUq4GXNPzlKZ5dD10MGw6D/GjxmO2Vupv9HnukfqiKpFoFVOspKFb
 kzuQj07FyhCkFfLlqsg==
X-Proofpoint-GUID: NFiO8tl36tEGeJwsPxW1YlGuwhgeXAZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060143



On 8/6/26 12:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Missing KMSAN attributes on the `extern` declarations of `arch_local_save_flags` and `arch_local_irq_save` will cause spurious use-of-uninitialized-value reports.

[...]

>> -#ifdef CONFIG_KMSAN
>> -#define arch_local_irq_attributes noinline notrace __no_sanitize_memory __maybe_unused
>> +#if defined(CONFIG_KMSAN) && !defined(__DECOMPRESSOR)
>> +extern unsigned long arch_local_save_flags(void);
>> +extern unsigned long arch_local_irq_save(void);
> 
> [Severity: High]
> Since these extern declarations lack KMSAN attributes, will instrumented
> callers expect a populated return value shadow in __msan_retval_tls?
> 
> When arch_local_save_flags() and arch_local_irq_save() are called from
> instrumented code, the caller reads __msan_retval_tls. However, because the
> corresponding definitions are marked noinstr:
> 
> arch/s390/kernel/irqflags.c:
> noinstr unsigned long arch_local_save_flags(void)
> {
> 	return __arch_local_save_flags();
> }
> 
> instrumentation is skipped, and __msan_retval_tls is never populated before
> returning to the caller.
> 
> Could this result in spurious use-of-uninitialized-value reports on every
> IRQ state check or lock operation (like spin_lock_irqsave) when the kernel
> is built with CONFIG_KMSAN?

This is a known issue that affects many other places.
It can be resolved by compiling with KMSAN_CHECK_PARAM_RETVAL:


lib/Kconfig.kmsan:
------------------
Disabling KMSAN_CHECK_PARAM_RETVAL will result in tracking shadow for
function parameters and return values across function borders. This
is a more relaxed mode, but it generates more instrumentation code and
may potentially report errors in corner cases when non-instrumented
functions call instrumented ones.


LLVM refers to this as "EagerChecks" internally.

[...]
