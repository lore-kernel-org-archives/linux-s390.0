Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751939A80E;
	Thu, 24 Sep 2026 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242824; cv=none; b=etQOCEus/pUXF5PVvONX6CGlpmPnsrzxvIx4PfJms5Z1BVg7XIeMopIBFuEfPeWcX2GLH0S985W9bymbYPp7Q52+j5GUwcUK5rbq0NThwl1ZJBMvFTqzIwqZNSr7Pn4dmBMuN+DoBsCJ+HRpWNTXC+Fr7aRV7M2YJmECeyRwixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242824; c=relaxed/simple;
	bh=HFgqjN/Zt2GRDyV6BxSbE1kvwDnOFndbEODOeXtfSEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YD//d9lDMg1Ak+H33TRpQitLQiz+69CbONcIhO3U7Jv+qF+R/ibmIUw9RbO82U6Uk8Sw2P6nit/JKcx8Lp2Xckx9bpK1TN5H/U6MCb/Ro5TgUEbiHiQSLJDl2Tub5YHzMxJrXWOpZw+B07wkJkT4gQ+y8Z5DJQc8itXkfQdPTlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qSXmi52S; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qSXmi52S"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5btXY1180006;
	Thu, 24 Sep 2026 09:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+VagH7
	UPR1+z945uZr9jkBmHbCao6/gK4R3YDirp+4o=; b=qSXmi52ScCs+B7CAROs174
	p2G9bJUQx5SqjoJAGZKEjCjdCsqUMNY8H6IzHfqBSws4+w5MKBX+DQ8ul3WUOMpj
	3JYbS++/vW1yBS7ifpnBqyvFRcUPPMtKoKFsTbteMqHXo+EdDoM0wDm/QgyNiiDT
	8bxcvKQZhtLjjXE7/b/mtKghr18rsPNahnQ+Izh720brfsvixKOF861moDaFKERk
	mTuF0QHk3JoDyJwpa5JfaHXjCWv4jntEuuUl0oUGomoPZYSvzwirceyF2Iwn6d6m
	huiU9Qxwldy0Qav6b/jUl8vNLNDDuK0L4UncN8M60NgL+lPfNrg9l8omADGPISSQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1qk65-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 09:40:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5lnBA1497550;
	Thu, 24 Sep 2026 09:40:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8vx9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 09:40:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O9eB4m49873346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 09:40:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFD882004B;
	Thu, 24 Sep 2026 09:40:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC6A20043;
	Thu, 24 Sep 2026 09:40:11 +0000 (GMT)
Received: from [9.224.77.157] (unknown [9.224.77.157])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 09:40:11 +0000 (GMT)
Message-ID: <a79daeb6-394c-434a-8896-a1bd48337f8d@linux.ibm.com>
Date: Thu, 24 Sep 2026 11:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf evsel: Improve callchain warning for s390
To: Ian Rogers <irogers@google.com>, Jens Remus <jremus@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260922144300.1217524-1-jremus@linux.ibm.com>
 <CAP-5=fUM6gb9MY9Sm=QhC+Tc4AFt2=fdLbr4tES++AMQcxryUQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fUM6gb9MY9Sm=QhC+Tc4AFt2=fdLbr4tES++AMQcxryUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: E2I2-EEENp2RFj7SPxvt6XMjzfOBX-Ri
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfX4ILntDqDWp8V
 0sW28m547Opk8LF9ewkCxENPwB0uLiJrE1O1kxaAGb7b/gxMC7izUDvEgtq/Og8hG3LJaJ/RRKY
 JXTMwO/50IkautjD/iN79D2BmwSF7bm/D9RtZH3wOCwBbAfHiCX+Dhzb1uAPUpK6reHfIQ3R/Ss
 IpmMDTHE0WyqSeMUl/+hwSNMba3jUTlHcK2tiE5JK/zpsM8yA84BrnKrlMNZiS+GavF4PrZnZ8z
 78+9dj5rbsXdZgVxV/rMe1EKO/OEgvp6KL6Ni8YmyA9PCF4wTfE1dP/axcHP0hkbLADSiTeNRHA
 eXPoHlWIq1MaB2P+kVQIoeJmAJR7tJ7bQUVbIJFYtCFCcpNmnyR7YJ5Q2fOmP4yu2TjZSxxj54D
 rCHWsLbK8aaWhMqrdaATUsum5A4PmJWTReV9tpBfM5HgW72j07WpMjxZIvY/cJBmvYKd049xnt4
 16ekZ7MSceJjB+wDCKQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab4f000 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=TOY_8snQAAAA:8
 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=5e-g9_LNG0mryHCH_esA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1-V9h6BHp-r8_tbamw7_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0MCBTYWx0ZWRfX2cYwD+4CpX1T
 O0MOvtLr00U8ZyfcDtN35A3qkOQa4gbY/Mtf92AJapb4zudOwGIYeAoydaWCuwoBSdiauUS/JIk
 6kh0zZrpxvgf+28rVm8PxBNNTEwYynQ=
X-Proofpoint-GUID: YLQNmtwLSPN2DOPea5j4BsQEg7iprLk1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240040

On 9/23/26 18:37, Ian Rogers wrote:
> On Tue, Sep 22, 2026 at 7:43 AM Jens Remus <jremus@linux.ibm.com> wrote:
>>
>> On s390 the kernel uses s390 back chain instead of frame pointers for
>> stack tracing of user space since v6.7 commit aa44433ac4ee ("s390: add
>> USER_STACKTRACE support").  This is because frame pointers on s390
>> cannot be used for stack tracing. [1]
>>
>> This requires user space to maintain a s390 back chain.  For instance
>> user space to be built with compiler option '-mbackchain' (instead of
>> '-fno-omit-frame-pointer' used on other architectures, which should
>> better not be used on s390 [1]).  Only few distributions and users build
>> user space with '-mbackchain'.  Therefore '--call-graph fp' may in
>> practice not produce the expected results.
>>
>> Commit ca76fb67ebdd ("perf evlist: Improve default event for s390")
>> changed the default '-g' option to 'dwarf' on s390 and added a warning
>> for s390 that wrongly claimed that "Framepointer unwinding lacks kernel
>> support".  This warning resulted from a misinterpretation of comments
>> in s390 cpumsf_pmu_event_init().
>>
>> The restriction in cpumsf_pmu_event_init() applies to callchain sampling
>> with the s390 CPU Measurement Sampling Facility (CPUMSF) hardware PMU.
>> CPUMSF events, such as 'cycles', do not support callchain sampling.
>> This is independent of whether perf uses the 'fp' or 'dwarf' call-graph
>> mode.  The CPUMSF PMU provides samples collected asynchronously, making
>> it impossible to associate a callchain to the historic IPs.  Therefore
>> callchains can only be used with software events on s390.
>>
>> Remove the incorrect warning.  The kernel supports the 'fp' call-graph
>> mode on s390 by walking the back chain.  Do not replace it with a
>> hint to use 'dwarf' when the resulting callchain is incomplete.  Such a
>> suggestion could imply that 'fp' is inherently inferior.  The same
>> general limitation exists on other architectures when user space is not
>> built with frame pointers (i.e. '-fno-omit-frame-pointers').
>>
>> Instead, warn on s390 when callchain sampling is requested with an event
>> provided by the CPUMCF or CPUMSF hardware PMUs, because that combination
>> is not supported.
>>
>> Update the perf record documentation to state that 'dwarf' is the
>> default call-graph mode on s390 and that 'fp' uses back chain instead
>> of frame pointers on s390.
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
> 
> Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
>> ---
>>
>> Notes (jremus):
>>     Changes in v3:
>>     - Updated warning message.
>>     - Rebased on v7.3-rc4.
>>
>>  tools/perf/Documentation/perf-record.txt | 7 ++++++-
>>  tools/perf/util/evsel.c                  | 6 +++---
>>  2 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
>> index 178f483140ed..dc72606cb25d 100644
>> --- a/tools/perf/Documentation/perf-record.txt
>> +++ b/tools/perf/Documentation/perf-record.txt
>> @@ -293,7 +293,7 @@ OPTIONS
>>
>>  --call-graph::
>>         Setup and enable call-graph (stack chain/backtrace) recording,
>> -       implies -g.  Default is "fp" (for user space).
>> +       implies -g.  Default is "fp" for user space (s390 uses "dwarf").
>>
>>         The unwinding method used for kernel space is dependent on the
>>         unwinder used by the active kernel configuration, i.e
>> @@ -329,6 +329,11 @@ OPTIONS
>>         enable deferred user callchain which will collect user-space callchains
>>         when the thread returns to the user space.
>>
>> +       On s390, the "fp" method uses back chain instead of frame pointers,
>> +       which requires user space to maintain a back chain (e.g. compiler
>> +       option -mbackchain).  Without a maintained back chain this produces
>> +       bogus call graphs.  In that case use "dwarf" instead.
>> +
>>  -q::
>>  --quiet::
>>         Don't print any warnings or messages, useful for scripting.
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index d4cb455f4a7d..55297b8dab37 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1092,9 +1092,9 @@ static void __evsel__config_callchain(struct evsel *evsel, const struct record_o
>>         bool function = evsel__is_function_event(evsel);
>>         struct perf_event_attr *attr = &evsel->core.attr;
>>
>> -       if (EM_HOST == EM_S390 && param->record_mode == CALLCHAIN_FP) {
>> -               pr_warning_once(
>> -                       "Framepointer unwinding lacks kernel support. Use '--call-graph dwarf'\n");
>> +       if (EM_HOST == EM_S390 && evsel->pmu && !perf_pmu__is_software(evsel->pmu)) {
>> +               pr_warning_once("Cannot use hardware PMU 'cpum_cf' / 'cpum_sf' event with callchain. "
>> +                               "Use a software 'cpu-clock' / 'task-clock' event.\n");
>>         }
>>
>>         evsel__set_sample_bit(evsel, CALLCHAIN);
>>
>> base-commit: 93f51579e7df248780214094418f205253383cc5
>> --
>> 2.53.0
>>

Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
