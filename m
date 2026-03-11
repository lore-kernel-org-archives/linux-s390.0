Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB273AC0F9;
	Wed, 11 Mar 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213730; cv=none; b=P8tfGkFX02s6I+se+5rzvYZVp/g1WEJhGPAbc9961syVpCCzfNljtO9//tCZgVjzujftV2NKdHuE/R6D9VkGEI/jbADsXCznZ4ncIERwoSyth5f7iXHxC0L6iYGkZS9gZCRX05wFHrAL2C4z2TGFcSCmk5K8VlkGG2tLB5t6bdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213730; c=relaxed/simple;
	bh=PlV/dWcDAQfYGcXu3pGg7KfoPZ7tAnN1AyM0bnblzF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWb9SoWpfNunEIKHEQShLSEKi1YvwZPC9iuoqYYZ/Q+jqbe1qI38YR/U86fGajexkAzn0/yYLpwc/Khpgfb/vdCCzd/hfAluHfh/UoFwyoQ8aGEFmgISHcrpkZdwENGTCbjI2/F59wvfIKmRYgRANsrofyQzzyjGibdNETJQwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kCPONETO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kCPONETO"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AFtoqh299992;
	Wed, 11 Mar 2026 07:21:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uJ9jyO
	6vNu3OyDhgcDZZh5mZR2IaONZUW4RUmAN6Qhc=; b=kCPONETOjZip0U/EVB0T7K
	j4ApUcl1FS5t0Acy9RcciYsWVy+BQz1JEcvqJA1jmGcsFRWIOu9ZUHSfG+I6iCIg
	psABo2NqpIQwfUuVHtm7JnLLVdQIDvrtolSmAOSYBnwaxUxab5q3wlqr48pqUPLq
	rmw5TPgctsZ434Ch93h3L2oaXQS/CQsQxilNRD7FRMUrHTSAF/M7SHJKbYH6ijOI
	uXaCN6OpW2ktlGvpdyN4uyyBy3sLxHmH454d5u7Pq1xqQkteEnDLjsacO1IIwBWe
	JMK/BO5TKCvxV+rsub4zoajwiw8nDzbsPOxQc7bWeAkJ3Dt/mxqdR0Zi/VToG7dA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywenss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 07:21:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B34Ccg015771;
	Wed, 11 Mar 2026 07:21:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs12247ca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 07:21:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B7Lpen10486234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 07:21:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C86912004F;
	Wed, 11 Mar 2026 07:21:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89F4E2004B;
	Wed, 11 Mar 2026 07:21:51 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 07:21:51 +0000 (GMT)
Message-ID: <131d7e1e-701e-4f5b-961f-c85af74f1d96@linux.ibm.com>
Date: Wed, 11 Mar 2026 08:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Jan Polensky <japo@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com
References: <20260306071002.2526085-1-tmricht@linux.ibm.com>
 <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com>
 <a3b8bf7e-ec5c-460b-9ffc-ca1d2cd9e223@linux.ibm.com>
 <CAP-5=fVziHx2B8QPWafPo0T_JWm06zD4vwtR4DmcFyePV04U0Q@mail.gmail.com>
 <abEG_lty-tgMXJYx@z2>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <abEG_lty-tgMXJYx@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA1OCBTYWx0ZWRfX23XfQwMHs3OR
 B/fPEL88ao6d5x6Da+9B0AwC/LaCDI1tRnTfQU2DM+WGrabODOeAHtD3EygSRZ5ESDyMUnqGED5
 IhPNMbMq48I5oeWGCoY1VLvWUdnP7Kn+lSVeX1//OADLkKKp1U6ut/yWgBh881nNXMMraBd2Wl+
 c6UUdbe882HxAVVYpRLwux4zQQ9bAv6hGxXzY0gEmMkq1Tecz43+YZmPehYBUC/VGXMfiq2BS00
 Fl51ozSuQnUuW714O0ishuiwXOiDHIOHE8PO6rOacBwP+ywJ/hM313nllh/nH1dpi4+YMw8eq0B
 83j3BNOzIBuYZLuVwrADZIQAmqwnMDCXlsTi2xvij27YwXSJ7wghWXoviKlwMY4tg8C4A1rOlZv
 bJPSEFHPMuBAW9Z4uZnFmM2hKfyqQMx3jjQs+orv/H3ZfB/IC53vblZEAD6/Xw6GdDV4NvNpcX2
 SldRl6slj7fOtB97ICg==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b11814 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=cuj6kmj_aNiUJrLrNf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CucyPc9reZlF-nBX_aZ2FSyHDz54Uqa3
X-Proofpoint-ORIG-GUID: BisuSJe-YCM8awrOIMI4VA0EI64j1xeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110058

On 3/11/26 07:09, Namhyung Kim wrote:
> On Mon, Mar 09, 2026 at 11:18:28AM -0700, Ian Rogers wrote:
>> On Mon, Mar 9, 2026 at 5:59 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>>
>>> On 3/6/26 17:53, Ian Rogers wrote:
>>>> On Fri, Mar 6, 2026 at 7:52 AM Jan Polensky <japo@linux.ibm.com> wrote:
>>>>>
>>>>> On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
>>>>>> Perf tests
>>>>>> 120: 'perf data convert --to-ctf' command test
>>>>>> 121: 'perf data convert --to-json' command test
>>>>>> fail on s390. It is caused by selecting the default event cycles
>>>>>> which does not exist on s390 z/VM. Use software event cpu-clock
>>>>>> and specify it explicitly on the command line.
>>>>>>
>>>>>> Output before:
>>>>>> ❯ perf test 120 121
>>>>>> 120: 'perf data convert --to-ctf' command test       : FAILED!
>>>>>> 121: 'perf data convert --to-json' command test      : FAILED!
>>>>>>
>>>>>> Output after:
>>>>>> ❯ perf test 120 121
>>>>>> 120: 'perf data convert --to-ctf' command test       : Ok
>>>>>> 121: 'perf data convert --to-json' command test      : Ok
>>>>>>
>>>>>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>>>>> [snip]
>>>>> Thanks for providing this, Thomas!
>>>>> Tested-by: Jan Polensky <japo@linux.ibm.com>
>>>>> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
>>>>
>>>> Should we not fallback for the cycles as a default event?
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/builtin-record.c#n1374
>>>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/evsel.c#n3792
>>>>
>>>> Thanks,
>>>> Ian
>>>>
>>>
>>> The fallback should be cpu-clock in case hardware event cycles (or CPU_CYCLES on s390) does not exist.
>>
>> Thanks Thomas, so the change is doing:
>> ```
>> -       if ! perf record -o "$perfdata" -F 99 -g -- perf test -w noploop
>> +       if ! perf record -o "$perfdata" -e cpu-clock -F 99 -g -- perf
>> test -w noploop
>> ```
>> where the default event is cycles:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/evlist.c#n116
>> Given that cycles will fail but then fallback to cpu-clock:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/util/evsel.c#n3792
>> I wonder if the issue is that the fallback is broken. Specifically:
>> ```
>>    evsel->core.attr.type   == PERF_TYPE_HARDWARE &&
>>    evsel->core.attr.config == PERF_COUNT_HW_CPU_CYCLES) {
>> ```
>> It isn't going to work well on hybrid machines or those whose PMU's
>> sysfs events or JSON include a cycles event. I wonder if using
>> `evsel__match(evsel, HARDWARE, CYCLES)` would be better, as the
>> evsel__match code is more robust to these kind of variances. I don't
>> know if that will address the fallback problem for you.
> 
> I suspect it may return a different error code on s390.
> 
> Thanks,
> Namhyung
> 

This is interesting, further debugging revealed this:
 # ./perf record -F 99 --call-graph dwarf  -F99 -- perf test -w noploop
Error:
Failure to open event 'cpum_cf/cycles/PH' on PMU 'cpum_cf' which will be removed.
cpum_cf/cycles/PH: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
Error:
Failure to open any events for recording.
 # ./perf record -F 99 -g -- perf test -w noploop
Error:
Failure to open event 'cpum_cf/cycles/PH' on PMU 'cpum_cf' which will be removed.
cpum_cf/cycles/PH: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'
Error:
Failure to open any events for recording.
 # ./perf record -F 99  -- perf test -w noploop
[ perf record: Woken up 1 times to write data ]
Failed to open /proc/schedstat
[ perf record: Captured and wrote 0.012 MB perf.data (95 samples) ]
 # 

So the real issue is the -g / --call-graph dwarf option. s390 supports only dwarf.
But with --call-graph event 'cpum_cf/cycles/PH' is used, that is modifier H is added.
 # ./perf evlist
 cpum_cf/cycles/P
 #

Without that option modifier H is not added and all is well.

I suggest to drop the call-graph option. If that option is needed for the test
than we need a s390 change anyway.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
