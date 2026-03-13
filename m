Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2902030596D;
	Fri, 13 Mar 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395220; cv=none; b=WXXz7Ax+gkIfL2N81sfPC5nKKWQ4HCoLSlXCyJH/I6ILmpX6HqiHIOpai47hlsplh8fThI0uf97abpck5AHCRGhTYnu/a2WFFRNzV/sh5NPWiic29OmS96O2M0ZUlvcl4AgDgQBNw57DYs+sEuEr8j3VRy3UcDHif68ghpGcSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395220; c=relaxed/simple;
	bh=GUTlRR0HaFhMGmHANRp4Y8r0KIrL0XaEiA3Oxb8UJp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/kgzQ8k++jxsf+bK0jBwuqpS9ITPO7oy7a3/ompxbiFuhj2bYVW3XM3zQv0wLm2Ij3GuJM4PaiJ/KHnvyh8MkrYfspfobYbJvxuN8tFkIBEFrSiYRlP6PfA7zcnusuqGsqcNemOPGbJSHaFE/hdJZnPkOzKMJ6w8PkUBa5rdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l/Y8KKa/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l/Y8KKa/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D6aORE2281597;
	Fri, 13 Mar 2026 09:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ATQmym
	6Oz3CkufKqSrZciv0jPpBMVlX7c4vTaK7yZKI=; b=l/Y8KKa/NLkpqNgh7cbfXO
	72hADR1I+tM+nREci1pdUOpNQYc2kD73RqFUN/GSX3HbG8IEB4SqX0GFdA8TljrJ
	LoHJ1pYmv95lh/G11TN6uGhLPliFk/u9q2lS37tHaeSsW/DtnGGlOI3/h/2QP6vR
	Xu8oUYdrumngauHdK02csGkcZw5ZGUiysUYchi1MuavN8teGx2fKtFZWyI+kxA5J
	XZcjZIN94ygjbDYKf2m20PuyIHlRTeBrl1Xa4nRo2WDbDHYOANAEtQEhvX83P5+T
	wm9RLM5EwjagY090UQh265yq4LQ/oYMN2xK22kyxVkPP6A7ZIX0qWdjClGeVmuLQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91q3jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:46:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62D4mJ0o008821;
	Fri, 13 Mar 2026 09:46:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha76457-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:46:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62D9kovL31785486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 09:46:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BAF162004F;
	Fri, 13 Mar 2026 09:46:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42E9D20065;
	Fri, 13 Mar 2026 09:46:50 +0000 (GMT)
Received: from [9.111.69.213] (unknown [9.111.69.213])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 09:46:50 +0000 (GMT)
Message-ID: <0f693db5-89d4-4346-be6f-d740b4493ad9@linux.ibm.com>
Date: Fri, 13 Mar 2026 10:46:49 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf evsel: Don't configure framepointer
 callchains on s390
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org,
        sumanthk@linux.ibm.com
References: <20260312031928.1494864-1-irogers@google.com>
 <20260312061628.1593105-1-irogers@google.com>
 <20260312061628.1593105-3-irogers@google.com>
 <05b884dc-d0bf-4767-8413-40ddb7c0f8fb@linux.ibm.com>
 <CAP-5=fXoAZ2fheQZ-kZe+JKoV=SbH=vS4mpFcVtS7OKsL5PTXQ@mail.gmail.com>
 <CAP-5=fWeicz7iFMM8vw32OCQXkBcCeWS4qA7k-iNJ6r7izpBbw@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fWeicz7iFMM8vw32OCQXkBcCeWS4qA7k-iNJ6r7izpBbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xzNQt9Urr-OnAuZNM_RXysaPnlZcwmpr
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b3dd10 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=3msShAU7VGpf1x8BKTMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA2OSBTYWx0ZWRfX9t2h+e7KLmVK
 21MlzTNozzz1yG+6ozfXGYx5zLpetnc1rhFhM46pSa7EgE/j0GM8mhG/wVZm0XmU6zJgK3SDJx1
 XXOKjEoCY+M3Ohhc3Ja71gz/8D6Ybv2r3fZFonBG3DrlwukP7SmGzBD6chB5sTL2YS4QlOIK1yb
 hFvGKApEK3UQeL0CwKtVVVlw782EEHtc5B8e8h9U6pUXgKS2buqA/hzJirRF0g++QP01B7AcutA
 RgtN5H7lHS0ZwmTg8y/s1ev6KNrGsJg98eH0VuFuRkwVzsRybjiqhMilYcNrmAyuH6komztuUi5
 Xh7zTdgPuBgw8VVFleg0OV7hTy89JD7h1gcdARdvnbXoHnrenrk2cwuLsA0YYWU2WYNsccwWMQU
 X08PFGUDDNICR+l7zyJQTtbuw9Z9c+Mx4D0iOWGkxz4KPpE3gSfGuYil2ZaReV4eTcbqLl+IW95
 2/us+xu9qviip7cBUxw==
X-Proofpoint-ORIG-GUID: h-nB9L3Fi9z-APnvyHBeSTPfh9EuG-7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130069

On 3/12/26 17:46, Ian Rogers wrote:
> On Thu, Mar 12, 2026 at 8:54 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Thu, Mar 12, 2026 at 5:45 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> On 3/12/26 07:16, Ian Rogers wrote:
>>>> Frame pointer callchains are not supported on s390. Ignore the option
>>>> and print a warning.
>>>>
>>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>>> ---
>>>> v2: Only disable user callchains as AI is telling me native "kernel"
>>>>     callchains are supported on s390.
>>>> ---
>>>>  tools/perf/util/evsel.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>> index bd14d9bbc91f..fa21b48cba86 100644
>>>> --- a/tools/perf/util/evsel.c
>>>> +++ b/tools/perf/util/evsel.c
>>>> @@ -1076,6 +1076,12 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
>>>>               attr->exclude_callchain_user = 1;
>>>>       }
>>>>
>>>> +     if (EM_HOST == EM_S390 && (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
>>>> +         !evsel->core.attr.exclude_callchain_user) {
>>>> +             pr_warning("Excluding user callchains that are not supported on s390. Try '--call-graph dwarf'\n");
>>>> +             evsel->core.attr.exclude_callchain_user = 1;
>>>> +     }
>>>> +
>>>>       if (param->defer && !attr->exclude_callchain_user)
>>>>               attr->defer_callchain = 1;
>>>>  }
>>>
>>> Ian, thanks very much.
>>> Your patch set helps a lot. However there is a small nit (which is mandatory). Please add these lines
>>>
>>>   evsel->core.attr.sample_type &= ~PERF_SAMPLE_CALLCHAIN;
>>>   evsel->core.attr.sample_type &= ~PERF_SAMPLE_REGS_USER;
>>>   evsel->core.attr.sample_type &= ~PERF_SAMPLE_STACK_USER;
>>
>> So these lines are dropping callchain from the sample_type which means
>> the kernel stack won't be sampled. AI was telling me this worked, but
>> I'm guess it was wrong. I think rather than this it is just cleaner
>> never to set the bits in the perf_event_attr, more like what v1 of the
>> patch did:
>> https://lore.kernel.org/lkml/20260312031928.1494864-3-irogers@google.com/
>>

Let me try to answer your and Namhyung questions in one reply.
s390 has many PMUs, there is one for counting (cpum_cf) and one for sampling (cpum_sf),
which are totally different hardware components.
Hardware sampling 
1. writes into a large buffer, data is timestamp and IP (instruction pointer), no registers, no PID.
2. when buffer gets full an interrupt occurs and the interrupt handler scans the
   hardware samples and converts valid samples to perf format and saves them in perf ring buffer.
This means we can not reconstruct register values for an individual sample. Current Pid is saved by
other means somewhere and added to perf data during perf ring buffer write.

For s390 when we need callchains, we always use event cpu-clock, never hardware event cycles.


>>> to the new if(EM_HOST == ...) above.
>>> The s390 CPU Measurement sampling device driver does not check on the attr.core.exclude_callchain_user
>>> member, but on the sample_type bit mask. It returns -EOPNOTSUPP when this bit PERF_SAMPLE_CALLCHAIN
>>> is set. This solves the invocation with command line flag -g as in
>>>  # ./perf record -v -e cycles  -g  -- perf test -w noploop
>>>  ...
>>>  perf record: Captured and wrote 0.183 MB perf.data ]
>>
>> Right because the callchain was removed from all the samples. We can't
>> fix old kernels (other than by using fix tags); is there a possibility
>> of adding the exclude_callchain_user to the s390 perf driver for the
>> sake of kernel callchains? It seems better than providing no
>> callchain.
>>
>>> Also I discovered that the fallback when using --call-graph dwarf command line flag still fails:
>>>  # ./perf record -v -e cycles  --call-graph dwarf -- perf test -w noploop
>>>  ...
>>>  Warning:
>>>  Trying to fall back to excluding guest samples
>>>  Error:
>>>  Failure to open event 'cycles:H' on PMU 'cpum_cf' which will be removed.
>>>  cycles:H: PMU Hardware doesn't support sampling overflow-interrupts. Try 'perf stat'
>>>  Error:
>>>  Failure to open any events for recording.
>>>
>>> The reason is in __evsel__config_callchain() which calls evsel__set_sample_bit(evsel, CALLCHAIN)
>>> and sets the PERF_SAMPLE_CALLCHAIN bit in evsel->core.attr.sample_type. It also sets the
>>> member attr->exclude_callchain_user = 1 and sets bits REGS_USER and _STACK_USER.
>>> All three bits are not supported by s390.
>>
>> I'm confused by this and your previous testing that showed the
>> `--call-graph dwarf` worked. You need the sampled registers for dwarf
>> unwinding to provide initial register values for the unwinder.
>>

Right, as explained shortly above, we have to use '-e cpu-clock --call-graph dwarf'
to get valid call chain data.

>>> I have modified your 2nd patch and appended it.
>>>
>>> I find all these bits in sample_type and the attr.exclude_XXX stuff very confusing. If there
>>> is a more consistant way of checking these feature, please let me know.
> 
> I forgot to mention, yeah the exclude thing is maddening. It takes
> about 100 lines to convert the command line modifiers to those in the
> perf_event_attr, there's a priority to them, and so on:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/parse-events.c#n1759
> Fwiw, I was thinking for patch 1 of holding onto the parsed modifiers
> so that we could reset the excludes based on them when switching to
> the software event.
> 
>> Ok, let me check it out.
> 
> So looking at the cpum_cf driver it fails events for having sampling enabled:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_cf.c#n859
> ```
> if (is_sampling_event(event)) /* No sampling support */
> ```
> and the cpum_sf driver fails for any kind of callchain:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_sf.c#n839
> ```
> static bool is_callchain_event(struct perf_event *event)
> {
> u64 sample_type = event->attr.sample_type;
> 
> return sample_type & (PERF_SAMPLE_CALLCHAIN | PERF_SAMPLE_REGS_USER |
>      PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_STACK_USER);
> }
> 
> static int cpumsf_pmu_event_init(struct perf_event *event)
> {
> int err;
> 
> /* No support for taken branch sampling */
> /* No support for callchain, stacks and registers */
> if (has_branch_stack(event) || is_callchain_event(event))
> return -EOPNOTSUPP;
> ```
> Perhaps there is an oversight in the cpum_cf driver wrt branch stacks
> (LBR on x86). The PERF_SAMPLE_CALLCHAIN bit is set for perf call-graph
> options currently:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/evsel.c#n1024
> 
> I think cpum_sf is the PMU we care about for the default cycles event?

Right this PMU does sampling on s390

> Since callchains of any flavor don't work with cpum_sf we can do a few
> things:
> 1) Disable the callchain and allow hardware sampling to continue,
> 2) Switch to a software event like cpu-clock,
> 3) Fail for the callchain option with this PMU, which is currently
> happening anyway.

@Namhyung:
It fails to open event cycles for PMU cpum_sf.

> 
> I dislike option 3 because it requires special s390 logic for many
> tests, and we lose testing coverage of hardware events. Option 1 is a
> smaller patch, an early return in __evsel__config_callchain if on
> s390. Option 2 feels most like what the user would want given they
> asked for a callchain. We could change evlist__new_default to take a
> "with callchain" boolean and on s390 that could switch the event to a
> software one. Only two non-test callers use evlist__new__default
> (record and top), so it isn't a huge change.
> 
> Wdyt Thomas, option 1 or 2?
> 
> Thanks,
> Ian

I actually prefer option 2. when call chains are requested by the user
switch to cpu-clock event.

Thanks a lot for your patience.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
