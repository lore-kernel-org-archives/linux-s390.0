Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D83451DA;
	Tue, 21 Jul 2026 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635153; cv=none; b=bJD524BtOytA3XaaH3kv4BGd8oTmirXhV5kY7ubwCD1qVMbhJXegbJJXilOuhyDphteN0SiS8YLNS7DcOELF0BBe+eQ0GcDwwcQw/vBZrypY3vF0mX2bO/l/Eor9wHRzBb2Bfho0QOq355J7vEqmQWgFMlHjwy7ALF9MpLFCSl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635153; c=relaxed/simple;
	bh=WbVf9FUbyXDtVqH2i00c4051/tOvwWdVUHG9tkQSelg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0wfEyEynPT13xL2YkTqbrVUPgy7h69kUUvAZD/C1hPjxdc6ux5Yk9rBxnO/OCqnpVuzLgQuOF1jLYxiWaNd+ZWB0YB1R5H/VKwT2q5GQm3o1oPXnOte1rbg5hFETnbXm5nYtbotXQbZd5Z9oL1XymDMzGSz6u66v4XzD/D91eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IEbaetGo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IEbaetGo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LAgAIH708138;
	Tue, 21 Jul 2026 11:58:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eNUKo+
	aIHg9q2VFlUgQvLZEiiOzznuhjacV6cS2Be6g=; b=IEbaetGo09yHPtDdCSKAUw
	SOfbGt4+WUfx8kfND8SEyL6DAqigs9CeAEOWp/nadhU48PvYsyD/+3DF9kX2zab4
	0UXKAkbNYrBrqqchtXS9iJrRpQOUgvEosxBafryfaxiv5lImHVjjWpQ7C9mWWY9A
	xkRk/L5YJcWgJClP67c5BL/DCl2vz7Tan4oi/PtzoZwZxjymFCxEhj4CvUKrtnhp
	LXISvoeRIAMcB9OMfFcwFW/OYXeRKdK3l5AbWvMiH6dRs1xuDBzKdRmX+qtd//lF
	FOaQqLz1HWlzZE6bpSh1n1jnY0ICS7W87N5eA3MqzeAJ+6pwv5cOT3mJNv6BVy0A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k40sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 11:58:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66LBncSs021738;
	Tue, 21 Jul 2026 11:58:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjt43g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 11:58:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66LBwsEf15860100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 11:58:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A34152004B;
	Tue, 21 Jul 2026 11:58:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 794E720043;
	Tue, 21 Jul 2026 11:58:54 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Jul 2026 11:58:54 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "H. Peter Anvin"
 <hpa@zytor.com>, Thomas Gleixner <tglx@kernel.org>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra
 <peterz@infradead.org>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390/syscall: Keep syscall return in extra ptregs
 member
In-Reply-To: <al9SKABzeTH8GXp9@kunlun.suse.cz>
References: <20260715133830.2619853-1-svens@linux.ibm.com>
	<20260715133830.2619853-2-svens@linux.ibm.com>
	<al9SKABzeTH8GXp9@kunlun.suse.cz>
Date: Tue, 21 Jul 2026 13:58:54 +0200
Message-ID: <yt9dik68lfk1.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5f5f03 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=HFzCc3RXmKK_JvFe6tcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEyNCBTYWx0ZWRfX/AejchYtC+BN
 +0rB5s71fXjs2rlFd5PLPNwuje2egWWVijoc0IXc+fdlXTHZ/oM3qKwJYaRg2rSVOcftEeloh37
 udHAE1eEDGqYnctYPZxaknrNpP4AhPNlDxle8jEf8f/ucxAuU3Og+jbj1RKzNw8yoisibb0QlVL
 p2xmclXRu7/lz2dRLRID1sv2ojNzxx7Xv6nJb7CetN2vmJbQoWJFz+ij4jKl5riedpDrp7gkJkh
 zb8JMKKIMpd6UXL2MzuAaczOem8G4HGniWqy0b+OcRHFod/uLv2Zp457Lap+LMFB1U82r+vfx8z
 Wwbl3oxz/bRoY2n0itfj54DMt+zUzv1/hhXeCJBWJqTBx/YIKPY0/YwVZaSaafXTq63Rtff9R7H
 vi1873E513xZuw/aOIgTA3KpYNcSGvfMd+GoAJf36dob16BpBjto763I6ob+XfOv2NWOCrDcjty
 1SS17+hIrz/CGsaBVxA==
X-Proofpoint-ORIG-GUID: JBP5OWYnSawUdEBmvMASr5bQ2cTMLbhg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEyNCBTYWx0ZWRfXxzhXZsvNnBM5
 m5tt7Cuf8zzHco3efPuJHYt98QQ8pGGdkF2j/8HjBYJHB9xtvSTpYis3GFbkECJvNmYKs33dcG2
 /6AmQBYAfW5u/lGV7c06KvSbIQjRZA0=
X-Proofpoint-GUID: JBP5OWYnSawUdEBmvMASr5bQ2cTMLbhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210124

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Wed, Jul 15, 2026 at 03:38:29PM +0200, Sven Schnelle wrote:
>> diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
>> index 75d5a3cab14e..ce244dceec6d 100644
>> --- a/arch/s390/kernel/syscall.c
>> +++ b/arch/s390/kernel/syscall.c
>> @@ -117,25 +117,16 @@ void noinstr __do_syscall(struct pt_regs *regs, in=
t per_trap)
>>  		regs->int_code |=3D nr;
>>  	}
>>  	regs->gprs[2] =3D nr;
>> +	regs->syscall_ret =3D -ENOSYS;
>>  	if (nr =3D=3D __NR_restart_syscall && !(current->restart_block.arch_da=
ta & 1)) {
>>  		regs->psw.addr =3D current->restart_block.arch_data;
>>  		current->restart_block.arch_data =3D 1;
>>  	}
>>  	nr =3D syscall_enter_from_user_mode_work(regs, nr);
>> -	/*
>> -	 * In the s390 ptrace ABI, both the syscall number and the return value
>> -	 * use gpr2. However, userspace puts the syscall number either in the
>> -	 * svc instruction itself, or uses gpr1. To make at least skipping sys=
calls
>> -	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checked he=
re
>> -	 * and if set, the syscall will be skipped.
>> -	 */
>> -	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET)))
>> -		goto out;
>> -	regs->gprs[2] =3D -ENOSYS;
>>  	if (likely(nr < NR_syscalls)) {
>>  		nr =3D array_index_nospec(nr, NR_syscalls);
>> -		regs->gprs[2] =3D sys_call_table[nr](regs);
>> +		regs->syscall_ret =3D sys_call_table[nr](regs);
>>  	}
>> -out:
>> +	regs->gprs[2] =3D regs->syscall_ret;
>>  	syscall_exit_to_user_mode(regs);
>
> Hello,
>
> I think this would break ptrace PTRACE_SETSIGINFO on syscall exit.
>
> It should use syscall_set_return_value but that now sets
> regs->syscall_ret, not regs->gprs[2]. At the same time the return value
> is in regs->gprs[2] at this point.

Thanks, Sashiko reported that already. I was thinking that syscall exit
tracing/filtering sets gpr[2] directly, but that's obviously wrong as it
uses syscall_set_return(). After trying to fix this I think I'll leave
the PIF_SYSCALL_RET_SET flag in place as it is - adding yet another
member to ptregs make it even more confusing.
