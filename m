Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456753596F8;
	Wed, 29 Apr 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777446893; cv=none; b=SzOsKfChC4wJD/kp2nrQ67qxk+0JtuXqXCz4lbKodGZiOnOXeG27jCfJphsPG2y5IwIKpJcBAknltmLltBgbvgoH6aCQDHbQozOIdB8so7EWs1IWtEShQajjKLULckpcYGkfmI292obn/DTGAu46UMBZCK+QcR0CINcJ6W5foiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777446893; c=relaxed/simple;
	bh=b+CuE+nYTx1xnxg7RSLdCaC8as9frPUkVevmuSvnLws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3/P4ZMVO1NyNRc7KCywPHk/vU5wFZVGfpQdeYQFZmtGHCsdlQBlQUYEYIDAsufioqKKz4DTMBdsHAvM8+F9pV/uCeIvSJbp6ypmrOy+aMBXHs+wg9FjKaV7FXsWZI+fjlNzXtZ2aBCjaczsTjmba6XSdKyuNB1lLbq59aVadP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HIG9oI32; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HIG9oI32"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T2fJFv1436623;
	Wed, 29 Apr 2026 07:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xqt3Fs
	Nm6uTarKWJmdK1ZCypKWQCH0xEx/KfXVj0/+k=; b=HIG9oI32osc2ZaKXYx5WUw
	BobevTl9GqLVV1H3YWn8jT5/2K49PKu8EenSMqJV2Yd346VgSP+pw412lDD8QjTa
	IX0l8fWM1nnrGqw5ZlalLys3RunuhyW4SueiAChclyTSyaNjQpqzb89qVHNtBQEC
	O3pS6DV3ejwGCcgR8OLJjtAfA5vCTq4kE9HXExyhi+vIu5maEc+12SJwHvGegN86
	dFXHqqs7fPJ2LYoaKwHM2W8Q+isxSaLZiEPt3mb6+m4MgmITohlasdEz9HYkU3wL
	7m5K0AmOM68raNP6rTH4tv2UEfDzywYwF2ghkHMxOmBejR1ut9AIujSadg9JsJOg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44sbxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 07:14:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63T78kDV007046;
	Wed, 29 Apr 2026 07:14:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamyd1sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Apr 2026 07:14:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63T7Edvq59310448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Apr 2026 07:14:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 836C42004B;
	Wed, 29 Apr 2026 07:14:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B57120040;
	Wed, 29 Apr 2026 07:14:39 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Apr 2026 07:14:39 +0000 (GMT)
Message-ID: <5b3c3edd-4661-4e1e-8971-16eacc230f5c@linux.ibm.com>
Date: Wed, 29 Apr 2026 09:14:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
 <aeemNo-8_RByiwvP@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <aeemNo-8_RByiwvP@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kVY2i8KkxR7xoZ4qrKJ79S0U-qU_23QV
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f1afe4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Um6BkznPDwr2-xkHyM0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kVY2i8KkxR7xoZ4qrKJ79S0U-qU_23QV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA2NiBTYWx0ZWRfX/itv7p9tm7DI
 n41/rDEA9aZa7db3Yt6o4KsyNqmuXOojzyU3LirLJK26G82WNxmxwDZoz1t6T4WrTY6IrETrfDe
 anuKnuIRt3FF9e7hxj7saiYrKGcuzcY9YSwI+BAEF+zRc90vbI+DVQwXbMP3dXGtobkalJvHjgB
 TYHZPsDjVAXtscY+5L4kBV6WhBlvHkpxXhJ2uOnfRZW5xwbcFqqwQskEn3Oqrv0pg8m1u/qgIiX
 URr1juK18BXiw8T/HCbiNK9/YCGeB9aG7kCUvuNhuwTyCgfoAraAWuio7LpoXhlQ3WLMXn7Z3aC
 82LE9afHlUW/W7PqclVWvOITgMpyjWr+qbAvlO/ZiL6NqtK7wPACskBz5QpOl04KINJBPIobDxQ
 6v+VjM0Rr9cGWoFvTUvi1Yz3G4N3yOZDGSBVAffCRHzWIrqhFwT98luS50GNAL32k5NOJeJISVh
 OEXKwGC+iiOjlwSGbBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290066

On 4/21/26 18:30, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Apr 14, 2026 at 02:42:41PM +0200, Thomas Richter wrote:
>> perf test 'perf inject to convert DWARF callchains to regular ones'
>> fails on s390. It was introduced with
>> commit 92ea788d2af4 ("perf inject: Add --convert-callchain option")
>>
>> The failure comes the difference in output. Without the inject script to
>> convert DWARF the callchains is:
>>  # ./perf record -F 999 --call-graph dwarf -- perf test -w noploop
>>  # ./perf report -i perf.data --stdio --no-children -q \
>> 					 --percent-limit=1 > /tmp/111
>>  # cat /tmp/111
>>     99.30%  perf-noploop  perf               [.] noploop
>>             |
>>             ---noploop
>>                run_workload (inlined)
>>                cmd_test
>>                run_builtin (inlined)
>>                handle_internal_command
>>                run_argv (inlined)
>>                main
>>                __libc_start_call_main
>>                __libc_start_main_impl (inlined)
>>                _start
>>  #
>>
>> With the inject script step the output is:
>>  # ./perf inject -i perf.data --convert-callchain -o /tmp/perf-inject-1.out
>>  # ./perf report -i /tmp/perf-inject-1.out --stdio --no-children -q \
>> 		--percent-limit=1 > /tmp/222
>>  # cat /tmp/222
>>     99.40%  perf-noploop  perf               [.] noploop
>>             |
>>             ---noploop
>>                run_workload (inlined)
>>                cmd_test
>>                run_builtin (inlined)
>>                handle_internal_command
>>                run_argv (inlined)
>>                main
>>                _start
>>  # diff /tmp/111 /tmp/222
>>  1c1
>>  <     99.30%  perf-noploop  perf               [.] noploop
>>  ---
>>  >     99.40%  perf-noploop  perf               [.] noploop
>>  10,11d9
>>  <                __libc_start_call_main
>>  <                __libc_start_main_impl (inlined)
>>  #
>>
>> The difference are the symbols __libc_start_call_main and
>> __libc_start_main_impl.
>>
>> On x86_64, kernel and user space share a single virtual address space,
>> with the kernel mapped to the upper end of memory. The instruction
>> pointer value alone is sufficient to distinguish between user space
>> and kernel space addresses. This is not true for s390, which uses
>> separate address spaces for user and kernel. The same virtual address
>> can be valid in both address spaces, so the instruction pointer value
>> alone cannot determine whether an address belongs to the kernel or
>> user space. Instead, perf must rely on the cpumode metadata derived
>> from the processor status word (PSW) at sample time.
>>
>> In function perf_event__convert_sample_callchain() the first part
>> copies a kernel callchain and context entries, if any.
>> It then appends additional entries ignoring the address space
>> architecture. Taking that into account, the symbols at addresses
>>
>>    0x3ff970348cb __libc_start_call_main
>>    0x3ff970349c5 __libc_start_main_impl
>>
>> (located after the kernel address space on s390) are now included.
>>
>> Output before:
>>  # ./perf test 83
>>  83: perf inject to convert DWARF callchains to regular ones : FAILED!
>>
>> Output after:
>>  # ./perf test 83
>>  83: perf inject to convert DWARF callchains to regular ones : Ok
>>
>> Question to Namhyung:
>> In function perf_event__convert_sample_callchain() just before the
>> for() loop this patch modifies, the kernel callchain is copied,
>> see this comment and the next 5 lines:
>>    /* copy kernel callchain and context entries */ 
>> Then why is machine__kernel_ip() needed in the for() loop, when
>> the kernel entries have been copied just before the loop?
> 
> IIRC I wanted to make sure to have PERF_CONTEXT_* part in the raw
> callchains.
> 
>>
>> Note: This patch was tested on x86_64 virtual machine and succeeded.
>>
>> Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
>> Cc: Namhyung Kim <namhyung@kernel.org>
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks,
> Namhyung
> 

Hi Namhyung,

is there something which needs to be done on my side to get this patch picked?
It still fails on s390.

Please adviseon how to proceed.

While at looking at my backlog, what about this patch
[PATCH] perf test: probe_vfs_getname add do_getname() probing fallback 

Thanks a lot for your help

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
