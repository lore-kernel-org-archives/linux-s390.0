Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB951422E35;
	Tue, 11 Aug 2026 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441986; cv=none; b=h8P1FQhBlf1uL1w6YFKq+ZuaQP2KrtLCJINScnqXVrCuKwMFB0TshuAHks7L3dIwnzd2nIN8/Mo4ouY4zGT9WWidsFthR3a28Zrb81XhbpSC1f/7qBvN3k3Ee2Ng209Wjcwklr/MIOlq0t7VeWZxZDXpcacms3BOajAjeVngYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441986; c=relaxed/simple;
	bh=A5NZZNNlCLUEfYk//x5Dn+vOsqCasMTeJrvc728ctzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lRZ9r4gQ6el6EmvZKWhVwqKU5esrO+/F60wvKNzEr8EsowNqOFf8QL0rfl256esq22yQhoikMb9kakqh/hVu+l0CT6YWHZqxj7ajdL8xivtsFcuQc96rRaMUXDWjXIz6j3zKZGaou25iKY46BXQzaSiG+JptIPh2/ZZndxq3pCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gtjW2UuI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gtjW2UuI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AN1a8I2999512;
	Tue, 11 Aug 2026 09:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k04nKK
	ZUcyhJq50Zoqt6B1vfdmwV1zVQZCVnWZFOHAw=; b=gtjW2UuI1Co9xqYEr+2mPj
	DrJKXYDIMIa46KvHNcrTLcL4dC0T2K6tbvSswLDvz72pFugh5lQu2iHh6Omub3A9
	p+/I8BOEmN3UXZjmiEn0nmo2e7cGQRgk9cnaKIptl/CajQBCAkATZd8ZopB63FMr
	4DyWgGxI1u0cOa3Omov62PJxVYiz+TG2FmFjIpZZGjrBh6cf2/uyel80LE5/HWha
	sQ21qJ9ZuIr239k9MypDqvgjOUWi0wNA3L6xtPVuqA71iB/80SgUmP7aiX+TnWaA
	TdH4OAZj1mFfa+MghCv1AAAfnveYGd3d1IVGGetvRaw+lPKyweKPpIXuu+i4+jAQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw3nuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 09:53:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B9fGkH003337;
	Tue, 11 Aug 2026 09:53:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g897x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 09:53:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B9quY239977240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 09:52:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A13920043;
	Tue, 11 Aug 2026 09:52:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2785A20040;
	Tue, 11 Aug 2026 09:52:56 +0000 (GMT)
Received: from [9.224.87.221] (unknown [9.224.87.221])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 09:52:56 +0000 (GMT)
Message-ID: <bfa64536-1c6a-417b-bb28-502ee25586a3@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf evsel: Improve frame pointer unwinding warning for
 s390
To: Ian Rogers <irogers@google.com>, Thomas Richter <tmricht@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260807104913.1784943-1-jremus@linux.ibm.com>
 <CAP-5=fWqtWQ+vA5-8ieARsVWqt-D3pUc1+NdwqEJ1F=jCkK86Q@mail.gmail.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <CAP-5=fWqtWQ+vA5-8ieARsVWqt-D3pUc1+NdwqEJ1F=jCkK86Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7af0fd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=TOY_8snQAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=q3QTpW0YJQ5cKGqp1_sA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1-V9h6BHp-r8_tbamw7_:22
X-Proofpoint-GUID: xZu9x7jWR4rlv61rR3nxQsFhV-oLfFPN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3OCBTYWx0ZWRfX7rN9QXBcxoCU
 HsHLBNJ0N4ONtGmPK+jEAaJtZpEy1G1/TuYZkdRzbLw3H40jkQ46o3vBYoBCgFlIvjwEEX1BifB
 ot9HmCh0pc5TgWFp73U0p0lrmln/cgj6cegWxksgrIBd4Z3xmTydvQoiAL2tvlRy5fQzLoLaFHS
 cFrwU0W7xvtVfAKFP0br4eUL2c6OYKBqwIAJ/5Vk6dZFCQ++Zkx2mKCff9Nyx6Pi/e9S9IKaX0h
 v+J/mB8N+Cp0jLVvo+DtAZtfpgInJgsgckT3SKINbqsfRutMtHriqTWzJ7ZB5NJ8PbY2VB3IB27
 +E3DDbGlgtUQ8W5aXvfACyr5V/oHBavuipsMaqNx4iMbWFH7a8f9uSvI1S1T7knvGKLAAPA3L99
 7gEN3wMsBYFtjOVYX//3q8nb9tI8awme+mJdqaj19t5ON1oSk6WJt9pKz3n4pFmhzb9/OeGrJZj
 C64/++vzIVkW7xL2PvQ==
X-Proofpoint-ORIG-GUID: qxdXCLv0v2xUUMavMHbboVjBlc8f9S9Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3OCBTYWx0ZWRfXzDJB9O+hdrDI
 aatOt8Zd8QGlMfMXarrzsmG7Fol6GKsd36AFMScf3kVYFnytkKt1Ua3RAhI4mpTxTy0haDnl+U2
 WN8JIMoxxUKv+ZruZ4by2XuePN9PeR8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110078

Hi Ian!

On 8/8/2026 6:13 AM, Ian Rogers wrote:
> On Fri, Aug 7, 2026 at 3:49 AM Jens Remus <jremus@linux.ibm.com> wrote:
>>
>> On s390 the kernel uses s390 back chain instead of frame pointers for
>> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
>> USER_STACKTRACE support").  This is because frame pointers on s390
>> cannot be used for stack tracing. [1]
>>
>> This requires user space to maintain a s390 back chain.  For instance
>> user space to be built with compiler option '-mbackchain' (instead of
>> '-fno-omit-frame-pointer' used on other architectures, which should
>> better not be used on s390 [1]).
>>
>> Only few distributions and users built user space with '-mbackchain'.
>> Therefore '--call-graph fp' may not produce the expected results.
>>
>> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
>> added a warning for s390 that wrongly claimed that "Framepointer
>> unwinding lacks kernel support".  Change the warning to hint at using
>> '--call-graph dwarf' if user space does not maintain a s390 back chain.
>>
>> Note that '--call-graph fp' may also be useful for other applications,
>> such as OpenJDK maintaining a s390 back chain (does not require JVM
>> option '-XX:+PreserveFramePointer' on s390):
>>
>>   $ perf record --call-graph fp ... -- \
>>     java -XX:+UnlockDiagnosticVMOptions -XX:+DumpPerfMapAtExit ...
>>
>> [1]: s390: Stack tracing using Frame Pointer, Back Chain, and SFrame,
>>      https://conf.gnu-tools-cauldron.org/opo25/talk/Y3CVHY/
>>
>> Fixes: ca76fb67ebdd ("perf evlist: Improve default event for s390")
>> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
>> ---
>>  tools/perf/util/evsel.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index ea9fa04429f0..c4d67d1b35f3 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1080,7 +1080,8 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
>>
>>         if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
>>                 pr_warning_once(
>> -                       "Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
>> +                       "Use '--call-graph dwarf' if user space does not maintain a s390 back chain "
>> +                       "(e.g. is not built with '-mbackchain').\n");
> 
> Thanks Jens. The text was based on:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_sf.c#n853
> ```
> static int cpumsf_pmu_event_init(struct perf_event *event)
> ...
>  /* No support for callchain, stacks and registers */
> if (has_branch_stack(event) || is_callchain_event(event))
> return -EOPNOTSUPP;
> ```

According to Thomas, the s390 HW event 'cycles' does not support
callchains.  This is because on s390 it provides aggregated historical
data, making it impossible to associate a callchain to the sampled data.
Your referenced cpumsf_pmu_event_init() code applies specifically to the
CPU Measurement Sampling Facility (CPUMSF) PMU and therefore correctly
rejects callchains for those HW events.

On s390, callchains are therefore only supported with SW events.

Since your commit ca76fb67ebdd ("perf evlist: Improve default event for
s390") callchains on s390 default to (1) the SW event 'cpu-clock' (or
'task-clock') and (2) 'dwarf'.  The kernel on s390 also supports 'fp'
callchains using s390 back chain since commit aa44433ac4ee ("s390: add
USER_STACKTRACE support").

Therefore the current warning on s390 for 'fp' is misleading.  Given
that on s390 a user must explicitly select 'fp', and that on other
architectures there is no warning about the requirement for user space
to maintain frame pointers (e.g. if they were not built with
'-fno-omit-frame-pointer' and '-mno-omoit-leaf-frame-pointer') it might
be preferable to remove the warning altogether.

We could document in the perf man pages that 'fp' on s390 relies on the
s390 back chain rather than frame pointers.

What do you think?

> The backchain option is never tested by perf or apparently in the
> kernel, but this warning is supposed to pre-warn about "not supported"
> being returned when frame pointer unwinding is requested. Of course,
> lacking an s390 I've never tested this. I can imagine the warning
> being overly broad, but my understanding is cpum_sf is the only PMU
> capable of sampling on s390.
> 
> Perhaps what is needed is additional text after the "Use '--call-graph
> dwarf'". The existing initial text at least appears to match the
> kernel code. I'm not clear how the lack of back chains would be
> reported as an error code, and this could introduce confusion as we
> have lots of stack, chain and branch related terms in the perf
> codebase.

This is analogous to frame pointers on other architectures: the absence
of a maintained s390 back chain is not reported as an error.  There is
currently no mean to determine from and ELF binary whether it was built
to maintain a s390 back chain (i.e. no ELF attribute/flag).

>>         }
>>
>>         evsel__set_sample_bit(evsel, CALLCHAIN);
>>
>> base-commit: f9a2394a23482bfd330911e9c8295b71724feacd
>> --
>> 2.53.0
Regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
jremus@de.ibm.com / jremus@linux.ibm.com

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Ehningen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/

