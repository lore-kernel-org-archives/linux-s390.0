Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DA48A8BB;
	Fri, 21 Aug 2026 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787317159; cv=none; b=rcP778WvR8x7NXbLv43JedEtkWc/ZZ3zeGnh+WuSG4WM/kbbNH4TjOV2dVVlFXWAT870IMYL2ajGWGNs5TWTc5h2BrWpKzTy+cSftAQoHUXZpG2gvB8sr9tCRfAQzvQrw/a368NzT6c28xOTSQupXarsnTqOklFJ3d3yM7PZQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787317159; c=relaxed/simple;
	bh=lEytShccGGraZlOTEDMzD99k1D5qX7g3n+WqckqV7cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtoqmLxutboPwT2Njg3ErKPx+aujgabtuxgAI55enIIrW1b8784TgysmOVvEoegfRdSG5Kjxv0LUAN1MIeXt/ZAyBIcl4fOWpmEXDXeO/fTRKifTbZhKn1DwCxBtBKwY/7qfxk0l7/4zSSxOzgQ6yEej9n7ZmXJ3CEx39J/MOfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZgXf4hgB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZgXf4hgB"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1Zp31446804;
	Fri, 21 Aug 2026 12:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q8V61M
	pj3JeMlefx6feopEoS2UzPPhlnNgVrZi7Mgrc=; b=ZgXf4hgBLFVG00kHXUpm+L
	/JTWf1ccciUVdMQWC3/Wis+SQjzPUEaD1O7I3dhYCZGqJ6+WyCndZ1MDK4dejqKc
	nDA0zgmjdVzzR4ymNnu4+aJwKXPoIaRdEYNyrlDiWNam9erqj5RSDlc+PUz3eyBV
	j/palgJ9PoF7/507pm5ZEawAsyVKiGapCtVmThXmtO4sPJx/rIdCvFsfIcEIXX5P
	3l0Ks3KB3nOVldUbFPnub0bOmbQhaTxEjsGuZgeGygG/89AAy6MkzaoFLKp9o034
	tPpKrBLiu2XWGL0cniasAIwqMWy1ItB34chETDNEY/ZJB+TOlfYqwX2DZrc7rbvw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0smf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:59:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCulhb010238;
	Fri, 21 Aug 2026 12:59:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekmq87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:59:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCx67f29098722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:59:06 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C27742004B;
	Fri, 21 Aug 2026 12:59:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33BE220043;
	Fri, 21 Aug 2026 12:59:06 +0000 (GMT)
Received: from [9.111.132.152] (unknown [9.111.132.152])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 12:59:06 +0000 (GMT)
Message-ID: <02ef8f98-faba-4eee-95db-6a86d9d65b07@linux.ibm.com>
Date: Fri, 21 Aug 2026 14:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf evsel: Improve frame pointer unwinding warning for
 s390
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Jan Polensky
 <japo@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260807104913.1784943-1-jremus@linux.ibm.com>
 <CAP-5=fWqtWQ+vA5-8ieARsVWqt-D3pUc1+NdwqEJ1F=jCkK86Q@mail.gmail.com>
 <bfa64536-1c6a-417b-bb28-502ee25586a3@linux.ibm.com>
 <CAP-5=fWa9iCadXAh4nU3XHRT7wS4BNbW6i+St-5a3pdVPzUx+Q@mail.gmail.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <CAP-5=fWa9iCadXAh4nU3XHRT7wS4BNbW6i+St-5a3pdVPzUx+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a884ba0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=TOY_8snQAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=hsBI31qVrJQsU1L2GVwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1-V9h6BHp-r8_tbamw7_:22
X-Proofpoint-ORIG-GUID: kn4-zQKvCzcklSqW4qAF8vcDR3GfLeT1
X-Proofpoint-GUID: FMtbsgNUi-5YBsSOJ74brRt8zycw_xFA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX1RNNaWlglgvP
 70/R+QxaShkWYrb+x5dQJuueOIXYq0yKDb+uCzE/SWyUVhVheeZCchzACkPPdpaxCAnRhW75kKa
 wHrajE9m2/986ymFDmFkSeRZzWH56KY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX0xyTwFcneXAE
 ssGoUkej739QbciSUw/BBhryTwkbCVmaImQvohPcw2ORkZP9HHJOgVxa9wyW5dWkKWr1+KYB9VF
 OCPR22jMm3hKFNoTm8RYpB8GUksgGknelIVNnBeU77/SVmVLynuZgJY+Dte0dc/YhTxA+9hn4DF
 jzp5rzL7efbPrK3m85LGsCOEhP0mIS3yYREtW5jG2XNhjMItQlLVnjhobY5lGn1zwU+6CBouAYu
 8auPeTcHjlg7xlXRAop/UjA0sv8jiL2n6FLli/t+hba0mWqMOzYXQjKPyHVxeDhTT3DA5tZiWRJ
 sEMa5rxofl0a8Qt8cC9fUtY68Md2Q6neM/wWj+14dkUPZo4DYQphFf5oqT8cX7HkmpXpa+mvzwS
 Z11d6rGpATIFZY02qfZuNzacorbQG3kfR4Pmn5eSOwXZV5NYlfiaTXdf8HnIGBcByZmHzhzXv2b
 4+K5DIBqZPlfmUWll0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

Hi Ian!

On 8/14/2026 7:43 PM, Ian Rogers wrote:
> On Tue, Aug 11, 2026 at 2:53 AM Jens Remus <jremus@linux.ibm.com> wrote:
>> On 8/8/2026 6:13 AM, Ian Rogers wrote:
>>> On Fri, Aug 7, 2026 at 3:49 AM Jens Remus <jremus@linux.ibm.com> wrote:
>>>>
>>>> On s390 the kernel uses s390 back chain instead of frame pointers for
>>>> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
>>>> USER_STACKTRACE support").  This is because frame pointers on s390
>>>> cannot be used for stack tracing. [1]
>>>>
>>>> This requires user space to maintain a s390 back chain.  For instance
>>>> user space to be built with compiler option '-mbackchain' (instead of
>>>> '-fno-omit-frame-pointer' used on other architectures, which should
>>>> better not be used on s390 [1]).
>>>>
>>>> Only few distributions and users built user space with '-mbackchain'.
>>>> Therefore '--call-graph fp' may not produce the expected results.
>>>>
>>>> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
>>>> added a warning for s390 that wrongly claimed that "Framepointer
>>>> unwinding lacks kernel support".  Change the warning to hint at using
>>>> '--call-graph dwarf' if user space does not maintain a s390 back chain.
>>>>
>>>> Note that '--call-graph fp' may also be useful for other applications,
>>>> such as OpenJDK maintaining a s390 back chain (does not require JVM
>>>> option '-XX:+PreserveFramePointer' on s390):
>>>>
>>>>   $ perf record --call-graph fp ... -- \
>>>>     java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...
>>>>
>>>> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
>>>>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
>>>>
>>>> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
>>>> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
>>>> ---
>>>>  tools/perf/util/evsel.c | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>>> index ea9fa04429f0..c4d67d1b35f3 100644
>>>> --- a/tools/perf/util/evsel.c
>>>> +++ b/tools/perf/util/evsel.c
>>>> @@ -1080,7 +1080,8 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
>>>>
>>>>         if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
>>>>                 pr_warning_once(
>>>> -                       "Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
>>>> +                       "Use '--call-graph dwarf' if user space does not maintain a s390 back chain "
>>>> +                       "(e.g. is not built with '-mbackchain').\n");
>>>
>>> Thanks Jens. The text was based on:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_sf.c#n853
>>> ```
>>> static int cpumsf_pmu_event_init(struct perf_event *event)
>>> ...
>>>  /* No support for callchain, stacks and registers */
>>> if (has_branch_stack(event) || is_callchain_event(event))
>>> return -EOPNOTSUPP;
>>> ```
>>
>> According to Thomas, the s390 HW event 'cycles' does not support
>> callchains.  This is because on s390 it provides aggregated historical
>> data, making it impossible to associate a callchain to the sampled data.
>> Your referenced cpumsf_pmu_event_init() code applies specifically to the
>> CPU Measurement Sampling Facility (CPUMSF) PMU and therefore correctly
>> rejects callchains for those HW events.
>>
>> On s390, callchains are therefore only supported with SW events.
>>
>> Since your commit ca76fb67ebdd ("perf evlist: Improve default event for
>> s390") callchains on s390 default to (1) the SW event 'cpu-clock' (or
>> 'task-clock') and (2) 'dwarf'.  The kernel on s390 also supports 'fp'
>> callchains using s390 back chain since commit aa44433ac4ee ("s390: add
>> USER_STACKTRACE support").
>>
>> Therefore the current warning on s390 for 'fp' is misleading.  Given
>> that on s390 a user must explicitly select 'fp', and that on other
>> architectures there is no warning about the requirement for user space
>> to maintain frame pointers (e.g. if they were not built with
>> '-fno-omit-frame-pointer' and '-mno-omoit-leaf-frame-pointer') it might
>> be preferable to remove the warning altogether.
>>
>> We could document in the perf man pages that 'fp' on s390 relies on the
>> s390 back chain rather than frame pointers.
>>
>> What do you think?
> 
> So firstly, sorry for the misleading message and thanks for trying to
> fix it! Also, sorry for the delay in responding and dealing with some
> hospital things. Man page documentation sounds good to me, and having
> a good warning also sounds good. Since this is for s390 you guys are
> much smarter about what to do than I am. Since the function generating
> the warning has an evsel, we can get the PMU from the evsel and check
> things like:
> ```
> if (evsel->pmu && perf_pmu__is_software(evsel->pmu))
> ```
> By which I mean we can provide different warnings for hardware and
> software events. That said, as a hardware event will fail in the
> perf_event_open I'm not sure it is a useful distinction.

Thanks for the hint!  After discussion with Thomas I have opted to
remove the warning to use 'dwarf' instead of 'fp' as it could misguide
users to assume 'fp' is inferior in general.

>>> The backchain option is never tested by perf or apparently in the
>>> kernel, but this warning is supposed to pre-warn about "not supported"
>>> being returned when frame pointer unwinding is requested. Of course,
>>> lacking an s390 I've never tested this. I can imagine the warning
>>> being overly broad, but my understanding is cpum_sf is the only PMU
>>> capable of sampling on s390.
>>>
>>> Perhaps what is needed is additional text after the "Use '--call-graph
>>> dwarf'". The existing initial text at least appears to match the
>>> kernel code. I'm not clear how the lack of back chains would be
>>> reported as an error code, and this could introduce confusion as we
>>> have lots of stack, chain and branch related terms in the perf
>>> codebase.
>>
>> This is analogous to frame pointers on other architectures: the absence
>> of a maintained s390 back chain is not reported as an error.  There is
>> currently no mean to determine from and ELF binary whether it was built
>> to maintain a s390 back chain (i.e. no ELF attribute/flag).
> 
> Thanks for the clarification! I think given this I'm happy to add my tag:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Do you want the maintainers to move forward with this change, or would
> you prefer to add something to the man pages, etc. ?

I have sent a v2.

Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

