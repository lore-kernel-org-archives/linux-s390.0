Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108893BD643;
	Tue,  5 May 2026 05:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960258; cv=none; b=kVZD8JZVp1e6n3+dAk21azHtWr9dM7nGQfeKdADfsMWcmeyISbEJMQtM1OqoZdFlpA659X+N+m+Z21drn8VE0CZO0vCk4tDlylnDmsKl9qDm1/RlK1iAkMPs7D6z5+aEaJrSK/3fZk1FDS+RdtlX4q7zrjml6/YMKfl4jiUzZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960258; c=relaxed/simple;
	bh=1h1Imgv640ifBXtrd+y+H9E6RFUTd99d4CwkCxGXbYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Enx7e5HTsmG7veZzD6Olr27bQfRrBaukDASLZqH6Pk6ljOqAxuRZxTq9aH0GSBfOYl6dgOBXFXD82JO3geixuWyUE6+XWRCcx92sqmOO1tzAW5uImFTApztir8cbG2gEO03yj6osn9ZT8m8hKW+B5U3vl9/odLMozaPBm7y1cc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qkEmj3Kg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qkEmj3Kg"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644FNnr83464145;
	Tue, 5 May 2026 05:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=67XDh5
	/PQqC8WBC9U8Q4i7lTh59IJadyaZq3mpGjTBY=; b=qkEmj3KgBjkPHyN9MiIY1q
	B0OX6nOu1bHQbCzl7MdkuEEomFfGcZlxZ8tRw+iReTAuFicF6X2os4sL6cwp1gr4
	vYFebWHYsXJvrpNidMu/kgB1ivOstWVz/a38CTKH72LNf52Ch2ku1FnV9ze+49Dm
	5Rz2eHi5/IprchGZb4yaqJc+AAct73YRBHzePs3z8IT4+/rQcevo69S/XP6frL6c
	5PalX2ULBsfDaXdfznyYnkJnXsQCxzOqK5TyDGEWUAEX2TtlXwZQ1ukvZOSMI18s
	HU+hnt/Rc2wtE7Hgl8GxNX+KEc44dFBh0XFnsDRldLNNxttv+oHvKTKt36mE0fYg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7a5n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 05:50:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6455dTVh009515;
	Tue, 5 May 2026 05:50:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwukq8cxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 05:50:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6455oo4D14221822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 05:50:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E342520040;
	Tue,  5 May 2026 05:50:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5CAD2004B;
	Tue,  5 May 2026 05:50:49 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 05:50:49 +0000 (GMT)
Message-ID: <79649f94-1ba5-44c7-a4c7-dcda8ae58b56@linux.ibm.com>
Date: Tue, 5 May 2026 07:50:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
 <aeemNo-8_RByiwvP@google.com>
 <5b3c3edd-4661-4e1e-8971-16eacc230f5c@linux.ibm.com>
 <afLFGZcaEY2sW0ci@google.com>
 <56678675-cecd-4561-96d9-b1c0335dc841@linux.ibm.com>
 <afkwVAXmhApn5z_I@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <afkwVAXmhApn5z_I@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA0OSBTYWx0ZWRfX/8C+5jpdTMnb
 CaMWxHrZoM4yxhY4IdQDiYl+BfS4qYIA41bDDpNkfoT3FAXM4H01X0xcQQV+6BGxXbVws8FDpTq
 ctYtIzBrw5Avaz4b9DERirDc9VVoRVyOK3XZqRK7r2lo/fm1BgxcQraT00KWFwQAMtubThm8tSv
 1Mzy9gt+wA76CVLn7PUf2UW3Ez+mg8Q9azShWYJQMgelQttdFnDynhdMF1D68/fLqkG6D/5k9JP
 M0fIEACcRtBLwN1gmUAmzDQx1UoLy1uAIMUCf3cM5pXoblcAqtZNDhaiwWCkzJ9mKZB0LVy1gFF
 5S5D3GWtceQQiSRILQ4SqYHzBJBL5qtRr0jE0O8mFi6Cv2kyXFsjPFGscDMkE1yH0OLLqf8a5k5
 0dj8ehEAP7ns9MYzkJU02gRnw6Br5KQif4Ufkl1eLDvY9+ZOwRW9fkVSN8nB/Jr6C9xJB2kRzLM
 5hi2E09FRD82ykc5KCg==
X-Proofpoint-GUID: PljmQjvZxk3jqUBH0-0zxNe7liZHlKG_
X-Proofpoint-ORIG-GUID: PljmQjvZxk3jqUBH0-0zxNe7liZHlKG_
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69f9853e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DLm-R2jRA0AhwLrLVMoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050049

On 5/5/26 01:48, Namhyung Kim wrote:
> On Mon, May 04, 2026 at 11:56:15AM +0200, Thomas Richter wrote:
>> On 4/30/26 04:57, Namhyung Kim wrote:
>>> On Wed, Apr 29, 2026 at 09:14:38AM +0200, Thomas Richter wrote:
>>>> On 4/21/26 18:30, Namhyung Kim wrote:
>>>>> Hello,
>>>>>
>>>>> On Tue, Apr 14, 2026 at 02:42:41PM +0200, Thomas Richter wrote:
>>>>>> perf test 'perf inject to convert DWARF callchains to regular ones'
>>>>>> fails on s390. It was introduced with
>>>>>> commit 92ea788d2af4 ("perf inject: Add --convert-callchain option")
>>>>>>
>>>>>> The failure comes the difference in output. Without the inject script to
>>>>>> convert DWARF the callchains is:
>>>>>>  # ./perf record -F 999 --call-graph dwarf -- perf test -w noploop
>>>>>>  # ./perf report -i perf.data --stdio --no-children -q \
>>>>>> 					 --percent-limit=1 > /tmp/111
>>>>>>  # cat /tmp/111
>>>>>>     99.30%  perf-noploop  perf               [.] noploop
>>>>>>             |
>>>>>>             ---noploop
>>>>>>                run_workload (inlined)
>>>>>>                cmd_test
>>>>>>                run_builtin (inlined)
>>>>>>                handle_internal_command
>>>>>>                run_argv (inlined)
>>>>>>                main
>>>>>>                __libc_start_call_main
>>>>>>                __libc_start_main_impl (inlined)
>>>>>>                _start
>>>>>>  #
>>>>>>
>>>>>> With the inject script step the output is:
>>>>>>  # ./perf inject -i perf.data --convert-callchain -o /tmp/perf-inject-1.out
>>>>>>  # ./perf report -i /tmp/perf-inject-1.out --stdio --no-children -q \
>>>>>> 		--percent-limit=1 > /tmp/222
>>>>>>  # cat /tmp/222
>>>>>>     99.40%  perf-noploop  perf               [.] noploop
>>>>>>             |
>>>>>>             ---noploop
>>>>>>                run_workload (inlined)
>>>>>>                cmd_test
>>>>>>                run_builtin (inlined)
>>>>>>                handle_internal_command
>>>>>>                run_argv (inlined)
>>>>>>                main
>>>>>>                _start
>>>>>>  # diff /tmp/111 /tmp/222
>>>>>>  1c1
>>>>>>  <     99.30%  perf-noploop  perf               [.] noploop
>>>>>>  ---
>>>>>>  >     99.40%  perf-noploop  perf               [.] noploop
>>>>>>  10,11d9
>>>>>>  <                __libc_start_call_main
>>>>>>  <                __libc_start_main_impl (inlined)
>>>>>>  #
>>>>>>
>>>>>> The difference are the symbols __libc_start_call_main and
>>>>>> __libc_start_main_impl.
>>>>>>
>>>>>> On x86_64, kernel and user space share a single virtual address space,
>>>>>> with the kernel mapped to the upper end of memory. The instruction
>>>>>> pointer value alone is sufficient to distinguish between user space
>>>>>> and kernel space addresses. This is not true for s390, which uses
>>>>>> separate address spaces for user and kernel. The same virtual address
>>>>>> can be valid in both address spaces, so the instruction pointer value
>>>>>> alone cannot determine whether an address belongs to the kernel or
>>>>>> user space. Instead, perf must rely on the cpumode metadata derived
>>>>>> from the processor status word (PSW) at sample time.
>>>>>>
>>>>>> In function perf_event__convert_sample_callchain() the first part
>>>>>> copies a kernel callchain and context entries, if any.
>>>>>> It then appends additional entries ignoring the address space
>>>>>> architecture. Taking that into account, the symbols at addresses
>>>>>>
>>>>>>    0x3ff970348cb __libc_start_call_main
>>>>>>    0x3ff970349c5 __libc_start_main_impl
>>>>>>
>>>>>> (located after the kernel address space on s390) are now included.
>>>>>>
>>>>>> Output before:
>>>>>>  # ./perf test 83
>>>>>>  83: perf inject to convert DWARF callchains to regular ones : FAILED!
>>>>>>
>>>>>> Output after:
>>>>>>  # ./perf test 83
>>>>>>  83: perf inject to convert DWARF callchains to regular ones : Ok
>>>>>>
>>>>>> Question to Namhyung:
>>>>>> In function perf_event__convert_sample_callchain() just before the
>>>>>> for() loop this patch modifies, the kernel callchain is copied,
>>>>>> see this comment and the next 5 lines:
>>>>>>    /* copy kernel callchain and context entries */ 
>>>>>> Then why is machine__kernel_ip() needed in the for() loop, when
>>>>>> the kernel entries have been copied just before the loop?
>>>>>
>>>>> IIRC I wanted to make sure to have PERF_CONTEXT_* part in the raw
>>>>> callchains.
>>>>>
>>>>>>
>>>>>> Note: This patch was tested on x86_64 virtual machine and succeeded.
>>>>>>
>>>>>> Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
>>>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>>>>
>>>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>>>
>>>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>>>>
>>>>> Thanks,
>>>>> Namhyung
>>>>>
>>>>
>>>> Hi Namhyung,
>>>>
>>>> is there something which needs to be done on my side to get this patch picked?
>>>> It still fails on s390.
>>>>
>>>> Please adviseon how to proceed.
>>>
>>> Arnaldo will take care of 7.2 development cycle.
>>>
>>
>> Today we are at v7.1-rc2. Does this mean the fix won't make it into v7.1 at all
>> and we have to wait roughly 2 month?
> 
> Just out of curiousity, do you plan to use v7.1 for this feature
> specifically or just for test failures?  Probably better to use v7.2
> series (i.e. perf-tools-next) instead?

Right now I just care for failing test features. I am fine with 7.2
as long as it gets picked.

Thanks.
-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
