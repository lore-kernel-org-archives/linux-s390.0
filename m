Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6390314A84;
	Mon, 13 Jul 2026 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956860; cv=none; b=ZrXbbhYkV0/9ViiJgDAONCBlKHIf/+jrTk61RPm8ezgXApuyM4Fr5MmwWou/mrl5PxDDLyQL4eWm5wFVdpD9bV0++LOYotTvNT5ponXDz3R9UsOgaB14IkpR7013bc+r3IoDjsnoTFgh+878zTGPnpZQoFlLp7joSQJPWh7/LO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956860; c=relaxed/simple;
	bh=tVsQdMUVWz3g5rnMqmjD0eXUsiuGJ9HxfeBaubOSpIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXI8Y8G47xgjQZWQNyY6Gp5iHovmjyrdRpdW6JaQmbNQ8Nx4086dzVLLMKVLyxM6xAREuvXBKurbdhnueoKOjj3ATcWiIBkmA0yhF0gFpNhZP7hhDUd2jLQ10EqO/lQOVejeG5AScFv0sbL52u3qlrqSnEV9jwRxVIUiveFSovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IgdtTuT/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IgdtTuT/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DFElqU2774398;
	Mon, 13 Jul 2026 15:34:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XCqfTJ
	zD9QBVrBP8YeASxRkjlT5LB+Y4FA1cox5D4kg=; b=IgdtTuT/fhWtLRgCdbraEG
	nikWl7vjndFAc0nMPn+pLlv0oMI2xDV2lAsmGivn8D1hx6wjPM5YJYhHKZdxuhrJ
	XsF8rxyOlnMKE8DcvWrcQeQxzkNlFesOxrA5UEuWc2H7qMB66vJGkcRzU69qfW1m
	84TSnshCq7HwURRovB5fBb/juPnzbxH+ZWiwOxkfFPmf9SWC5x2lvMNREL/l0nGd
	ZPBK+yYrz89kUcihP9ObTCm0HIPzb4r7DJHjDdQ5zyWzHuJ1VlIjD1Oq0kQ+g0ZE
	dy4ajfIxhsanFV1C6WsuRSZmE7wBI0AtplRRUzI+soAH06K9IITS4N6tZOUFDiGg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a1288-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:34:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DFK5Xh006455;
	Mon, 13 Jul 2026 15:34:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pxhg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:34:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DFYCeC49021374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:34:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99DF820043;
	Mon, 13 Jul 2026 15:34:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E708220040;
	Mon, 13 Jul 2026 15:34:11 +0000 (GMT)
Received: from [9.111.161.78] (unknown [9.111.161.78])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:34:11 +0000 (GMT)
Message-ID: <3b4603ba-1d56-4540-b927-9002605fc137@linux.ibm.com>
Date: Mon, 13 Jul 2026 17:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390/vdso: Fix GNU_EH_FRAME PHDR
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20260706151909.103539-1-jremus@linux.ibm.com>
 <20260710074600.17568Beb-hca@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20260710074600.17568Beb-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfX40+x+7G3njcU
 gWCP1YMIKvNFZJTIxL6LjF9k+aDNu5UryEWLE/NUml0FY5A63A4Lmjnb3ceekSiwtskwDqNCttC
 7avicaAp6ZqBNd8rD09oy7uahOlCAEI=
X-Proofpoint-GUID: yrN5X_LFGBoBlJwMp9Jz-VR4nSENuoGF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1OCBTYWx0ZWRfXwywzbpSE4y8q
 yDNdsYARz5iuKNuiVWiv/u0jCJgxPJHPGuBbzfs5CdgPomN7mGaex/K+V+lgVVkiBNC6G6xmRST
 wm2qVA/5+2X8jnNU+GQClE3FvmVxJ0rNoPc+Qo2VRixXnAQOTuzzGMZgdBxQhJcwm4MA8LyJl4j
 WqoSRweXWNNIXKZu8GYxeJM2CrhYpcVdiE43IVuknLGGhVaZfbrVGe1Am974Fm/bM2X5mK8YR5F
 uWenAVg8ijD0CqEthjitBYCQPzoyT9G43Cn2gy2yLUH7Fvn8lM3S6rRN1KPvBIts8SEPmS7tWnH
 7nGQ6lyQp7xwWvOiMxDXJ+xHBBZHGaGlpDSyXudBvXqzaJ7wuHM6LpbdUguGTm9yYX77haBXF1v
 vxh0tYZDw+8WAaAKrcvksu5/BFR+2VrjEWMsQFq2+CvBL+emy+f+1wZ37xTg51oN7tFyxyIZOYr
 wJEywa+Dv1Tav3hiImg==
X-Proofpoint-ORIG-GUID: yrN5X_LFGBoBlJwMp9Jz-VR4nSENuoGF
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a550579 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZQoJ5bdyw165gDN1tUYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130158

On 7/10/2026 9:46 AM, Heiko Carstens wrote:
> On Mon, Jul 06, 2026 at 05:19:07PM +0200, Jens Remus wrote:
>> Patch 1 fixes the empty GNU_EH_FRAME program table header entry to
>> enable unwinders and stacktracers to locate the .eh_frame_hdr section.
>>
>> Patch 2 uses symbolic constants for the PHDR permission flags to improve
>> readability and explicitly specifies the GNU_EH_FRAME PHDR to be read-
>> only.

...

>> Jens Remus (2):
>>   s390/vdso: Pass --eh-frame-hdr to the linker
>>   s390/vdso: Use symbolic constants for the PHDR permission flags
>>
>>  arch/s390/kernel/vdso/Makefile   |  3 ++-
>>  arch/s390/kernel/vdso/vdso.lds.S | 12 ++++++++----
>>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> This series is in limbo state. Do you plan to send a new version to
> address the very minor nits, or should it stay as is?

Sorry for the delay!  I have sent a v2.

I tried hard to figure out whether adding a proper GNU_STACK PHDR
with RW in a separate commit (similar to x86 commit 8717b02b8c03
("x86/entry/vdso: Include GNU_PROPERTY and GNU_STACK PHDRs") would
provide any benefit on s390:

Loading executables in the kernel:

- s390, unlike other archs, does not provide an arch-specific
  elf_read_implies_exec(), therefore the generic from include/linux/elf.h
  that returns false is used.
- As a consequence fs/binfmt_elf.c, load_elf_binary() does not default
  executables without GNU_STACK PHDR to executable stack.

Loading shared libraries in Glibc:

- elf/dl-load.c, _dl_map_object_from_fd() does default shared libraries
  without GNU_STACK PHDR to executable stack (see DEFAULT_STACK_PERMS).


Based on that I performed the following tests, all using an executable
with GNU_STACK RW (not RWX):

Library with GNU_STACK RWX loaded at startup: [stack] rwxp (exec=YES)
Library with GNU_STACK RW  loaded at startup: [stack] rw-p (exec=NO)
Library without GNU_STACK  loaded at startup: [stack] rwxp (exec=YES)

Library with GNU_STACK RWX loaded via dlopen: fails  *1)
Library with GNU_STACK RW  loaded via dlopen: [stack] rw-p (exec=NO)
Library without GNU_STACK  loaded via dlopen: fails  *1)

vDSO without GNU_STACK loaded via startup: [stack] rw-p (exec=NO)  *2)
vDSO without GNU_STACK loaded via dlopen : [stack] rw-p (exec=NO)  *3)


*1) dlopen fails with cannot enable executable stack as shared object
    requires: Invalid argument.  Regardless of glibc.rtld.execstack=1
    tunable.

*2) Linking against /usr/modules/.../vdso/vdso.so (won't be listed in
    ldd output though)

*3) dlopen("linux-vdso.so.1", RTLD_NOW);


Technically adding a GNU_STACK PHDR with RW seems to be the right
thing, although I could not construct a use case, where it would
really matter.

> In any case:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thanks!

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

