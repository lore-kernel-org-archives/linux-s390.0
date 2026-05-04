Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B98F388E4A;
	Mon,  4 May 2026 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888585; cv=none; b=KnYhFcNj/OI9r+7GNy3AGn8evhlvTVNCgtU+etoA6Nmf9I8q3nB+rKFn8/ZJScOW7aWqQWJXu+PLnpCtbdGw2ABvyWzeDB81/R3RpHf4+QeMHuy+sbnmbpEIt7Jk9KTdeG4UYcMths+cMh9zzmUNpZ5JlkliLPboyK6bzR7gN2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888585; c=relaxed/simple;
	bh=xeX3Sm6PyGMT+SZYMbsy13FcSji0EQ8ZZPGilGn0OPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuTZwqLoWXZ1mK6II4nVTLdRJzQVei+DQC/kdJfEkGTLam/1jd9M0Ij57AwcMiWrjSNVubX5Ojze7d28YFG2GlwNLy1fduPc7RGlz+HkSkpKU9AxPwEpJ2iNkxn+AQLYmqLQe9uIxFF54LYCWNEM+GkSWkZLPvdSM2F/XnQvhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oi3+2zAM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oi3+2zAM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64477LID1590574;
	Mon, 4 May 2026 09:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ermyTP
	5WWNj6k0qobpCfQsZAKeEgtLk1je3inrCDGqE=; b=oi3+2zAMYUN0DWDtyQ3ev3
	jP6HfliIGUs1MtrNCOYXPpDTtpLUOMgstNkZpnye8txS4pF08iM+Z78Mb06B9jMl
	GEVEt39kLXAOUDe9BTONNmZpWjERegbUqo1kQR04gIVJXbMfMuEj8IgvkqQYb4KE
	jWu76l+LiZ0vrmcd7J6u/ZOoIgDjZeNqgxXQokv/BOmS8iBfsL5qOKPRBWSkbolp
	UhtPC8Mwt7RQnu8xQMb2uoX+aSo0mUcAH85og34OpSiaZ43HBuEFtNOJsa83iJ4q
	6pAnvJwvBkypjN5rMZkwXpvfEMS6+/xJl/rNnr1XeQTHsgSYNAB0SHplHCM5Y+yA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxe5rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 09:56:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6449dZUs001850;
	Mon, 4 May 2026 09:56:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvvp9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 09:56:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6449uGtp55574786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 09:56:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2AAF2004B;
	Mon,  4 May 2026 09:56:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D43520049;
	Mon,  4 May 2026 09:56:16 +0000 (GMT)
Received: from [9.111.65.141] (unknown [9.111.65.141])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 09:56:16 +0000 (GMT)
Message-ID: <56678675-cecd-4561-96d9-b1c0335dc841@linux.ibm.com>
Date: Mon, 4 May 2026 11:56:15 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf callchain: Handle multiple address spaces
To: Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, agordeev@linux.ibm.com,
        gor@linux.ibm.com, sumanthk@linux.ibm.com, hca@linux.ibm.com,
        japo@linux.ibm.com
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
 <aeemNo-8_RByiwvP@google.com>
 <5b3c3edd-4661-4e1e-8971-16eacc230f5c@linux.ibm.com>
 <afLFGZcaEY2sW0ci@google.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <afLFGZcaEY2sW0ci@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwMiBTYWx0ZWRfXwh7hOIQFLUAg
 1w7c2DwncnCYsk7S0AQ5lzk1FZbgn5Dli9jFqankSrTnLZec9cmEacRas4pIVUzhU5m7+72L40+
 QcfNdzTX+nPlzIxcmW0ko9zlJyFpMA4ovzgeoHvRalLUE65B7vmiC4JThJFpYay81XbnZwqa8KW
 SjdT1EBobRawUfN/eUJCv7B4RlGrOeO/MwNNBEwNJv9/kqOImu8d481COWyOc3EaxYMauuc12fX
 lAG5ejhU7GEC8lWDlilA/njEj95P6D9iBphYt6wSHdQgAi1WhBVc8y28uoc0iz244gjvB2yLgsL
 F5ov+YfHlhUpylZ+kiwzQxP52EVbFQ9wOHDELIAGvmpkpbS4rpZgM1Vcy+Snh9iwNqrOYn6VUZo
 YGGLGKVXnH+mdl7aYPc/kIfLX72UArmdIDptoQ7xQqU/tLzSRwPZl0H+cTQwTzjyRqU2hE7xvzf
 CHJ8HJD7C3C0UeVODMQ==
X-Proofpoint-ORIG-GUID: YnJCw6mWjnrx6zOkK06Ml2PO5PeZQMDW
X-Proofpoint-GUID: YnJCw6mWjnrx6zOkK06Ml2PO5PeZQMDW
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69f86d45 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=4lX7p3R0FWCmJ87-_lAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040102

On 4/30/26 04:57, Namhyung Kim wrote:
> On Wed, Apr 29, 2026 at 09:14:38AM +0200, Thomas Richter wrote:
>> On 4/21/26 18:30, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Tue, Apr 14, 2026 at 02:42:41PM +0200, Thomas Richter wrote:
>>>> perf test 'perf inject to convert DWARF callchains to regular ones'
>>>> fails on s390. It was introduced with
>>>> commit 92ea788d2af4 ("perf inject: Add --convert-callchain option")
>>>>
>>>> The failure comes the difference in output. Without the inject script to
>>>> convert DWARF the callchains is:
>>>>  # ./perf record -F 999 --call-graph dwarf -- perf test -w noploop
>>>>  # ./perf report -i perf.data --stdio --no-children -q \
>>>> 					 --percent-limit=1 > /tmp/111
>>>>  # cat /tmp/111
>>>>     99.30%  perf-noploop  perf               [.] noploop
>>>>             |
>>>>             ---noploop
>>>>                run_workload (inlined)
>>>>                cmd_test
>>>>                run_builtin (inlined)
>>>>                handle_internal_command
>>>>                run_argv (inlined)
>>>>                main
>>>>                __libc_start_call_main
>>>>                __libc_start_main_impl (inlined)
>>>>                _start
>>>>  #
>>>>
>>>> With the inject script step the output is:
>>>>  # ./perf inject -i perf.data --convert-callchain -o /tmp/perf-inject-1.out
>>>>  # ./perf report -i /tmp/perf-inject-1.out --stdio --no-children -q \
>>>> 		--percent-limit=1 > /tmp/222
>>>>  # cat /tmp/222
>>>>     99.40%  perf-noploop  perf               [.] noploop
>>>>             |
>>>>             ---noploop
>>>>                run_workload (inlined)
>>>>                cmd_test
>>>>                run_builtin (inlined)
>>>>                handle_internal_command
>>>>                run_argv (inlined)
>>>>                main
>>>>                _start
>>>>  # diff /tmp/111 /tmp/222
>>>>  1c1
>>>>  <     99.30%  perf-noploop  perf               [.] noploop
>>>>  ---
>>>>  >     99.40%  perf-noploop  perf               [.] noploop
>>>>  10,11d9
>>>>  <                __libc_start_call_main
>>>>  <                __libc_start_main_impl (inlined)
>>>>  #
>>>>
>>>> The difference are the symbols __libc_start_call_main and
>>>> __libc_start_main_impl.
>>>>
>>>> On x86_64, kernel and user space share a single virtual address space,
>>>> with the kernel mapped to the upper end of memory. The instruction
>>>> pointer value alone is sufficient to distinguish between user space
>>>> and kernel space addresses. This is not true for s390, which uses
>>>> separate address spaces for user and kernel. The same virtual address
>>>> can be valid in both address spaces, so the instruction pointer value
>>>> alone cannot determine whether an address belongs to the kernel or
>>>> user space. Instead, perf must rely on the cpumode metadata derived
>>>> from the processor status word (PSW) at sample time.
>>>>
>>>> In function perf_event__convert_sample_callchain() the first part
>>>> copies a kernel callchain and context entries, if any.
>>>> It then appends additional entries ignoring the address space
>>>> architecture. Taking that into account, the symbols at addresses
>>>>
>>>>    0x3ff970348cb __libc_start_call_main
>>>>    0x3ff970349c5 __libc_start_main_impl
>>>>
>>>> (located after the kernel address space on s390) are now included.
>>>>
>>>> Output before:
>>>>  # ./perf test 83
>>>>  83: perf inject to convert DWARF callchains to regular ones : FAILED!
>>>>
>>>> Output after:
>>>>  # ./perf test 83
>>>>  83: perf inject to convert DWARF callchains to regular ones : Ok
>>>>
>>>> Question to Namhyung:
>>>> In function perf_event__convert_sample_callchain() just before the
>>>> for() loop this patch modifies, the kernel callchain is copied,
>>>> see this comment and the next 5 lines:
>>>>    /* copy kernel callchain and context entries */ 
>>>> Then why is machine__kernel_ip() needed in the for() loop, when
>>>> the kernel entries have been copied just before the loop?
>>>
>>> IIRC I wanted to make sure to have PERF_CONTEXT_* part in the raw
>>> callchains.
>>>
>>>>
>>>> Note: This patch was tested on x86_64 virtual machine and succeeded.
>>>>
>>>> Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>>
>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>
>>> Acked-by: Namhyung Kim <namhyung@kernel.org>
>>>
>>> Thanks,
>>> Namhyung
>>>
>>
>> Hi Namhyung,
>>
>> is there something which needs to be done on my side to get this patch picked?
>> It still fails on s390.
>>
>> Please adviseon how to proceed.
> 
> Arnaldo will take care of 7.2 development cycle.
> 

Today we are at v7.1-rc2. Does this mean the fix won't make it into v7.1 at all
and we have to wait roughly 2 month?

Thanks.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
