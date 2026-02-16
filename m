Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A9D2957B6;
	Mon, 16 Feb 2026 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771236290; cv=none; b=ouXtXa/fWTyUOuJXkYNryE3LtoUAshfKjvExLdvOx07XvlalDGykZqaCqL1LWJa+rAlP7NCFUxrkq9MdYT8HZpKsWUVi1N+IGssGizccPCYrZWIvxCqfaoayhPZAczinpu2baJRulbokcHdbeztLLjcUsaLnZTltnGrl3YwFzL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771236290; c=relaxed/simple;
	bh=5KZu16JjtFzRmhVOxkUpbiDIoVXKRpeq9siIB4AjDwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Grd2yX/elC9iwOYrF3XCsx/eoCFkRxEABEomDxXgVGo23axh4d8/QgrVCIlNzxrlBn1EswlPUgj6F42//jE5jORzKDsmDJ5EnJP0vuPtZKtDV3DXl4xs8E5V6ZIz9c4JtXTFzqKvCrazcP7c3oYZvHX9CpmXeB8eghuVBX3uT/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jSyqz02l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jSyqz02l"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNHZAK3694814;
	Mon, 16 Feb 2026 10:04:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SFUyBf
	k5MJbOhOtewPB2vYDEFuGUdBaLWZjpK55C88c=; b=jSyqz02lg/2hA8lwdKWlIu
	DMshcqgtRXxB/ZegzEyaY6DVdvNlRzwigvFu2W1orjWKqOAhtB6oCz6DkQm+obeO
	rgENn+R/oZdrCHbpPTFNTDx9oz1EwpzMmvDvihZ6sxss33abCAUbTAF5Ao6oSmvi
	/rv9WATmGYu6Kl0k5/vpigCUakcXhMQcN3dSmJ18pAOcsrftVvrvLl96HmkziHIc
	kXmUnxnRxO9N2SCM9Eh9rA+5fjsd1U/9VJz9p7VB/t7z3EdkqGmaTbaex0958Dgp
	Na80km1SCyS+NCgsi/2KucXrluziI/nLsRl6uW8/VmHwAwUBt/ljR86M1K96YVmg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4k6p3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:04:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G7aiiI002849;
	Mon, 16 Feb 2026 10:04:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cb5kj4q0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 10:04:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61GA4eo530671560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 10:04:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E32402005A;
	Mon, 16 Feb 2026 10:04:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A24002004F;
	Mon, 16 Feb 2026 10:04:39 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 10:04:39 +0000 (GMT)
Message-ID: <30f598eb-4c9e-49da-a643-118b462b8b77@linux.ibm.com>
Date: Mon, 16 Feb 2026 11:04:39 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] perf parse-events: Fix big-endian 'overwrite'
 by writing correct union member
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        james.clark@linaro.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
References: <20260212125315.777356-1-tmricht@linux.ibm.com>
 <CAP-5=fWxHfGZaLyrvzuQF83K1g=LaFC4uRvg3HjM0=W9ts_yxQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fWxHfGZaLyrvzuQF83K1g=LaFC4uRvg3HjM0=W9ts_yxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA4MCBTYWx0ZWRfX59iQCskLhAT/
 AwTHv7shDb2Nqv3N6XFD46WAXu6v6ced2N0zdPWCTZWKz53cjgQF+wJVRylo/oHyFNyD3OkuTau
 RSmT18yj7Dcu4b0Na+9TTVghdW6SFvO0QrS31ZKFwUaDNG/WwI0eT/EDxActSfmyVyv26GpNDGY
 tZf0lJace0lnPYtCEn3KeZl6WzHsclcDlgpD8RV3IUlFcx9ZbfpePTbD5kXiFR2nXcSNqsg9ltx
 U8Bbe/v6FICZCdDtGesuV1VxFKZJcLA7lC8l4PX0kb+1TpfXfdgE4kwa7sLC2QeQ8E43ECSoKrM
 bHMoZvu/gpAM8fqxs9/zhpA2exZBj2+UjR0/yWLA4eJvKMjQa0ywvEk1dgIzbaBLV4PePhfpMRJ
 dpJ96O9kTOJMiaTfP7QJkAzwE69l3cnHfzzqwzenxh/QLKmVnYtsj/e+oMxhhUmkbX/4cp92chm
 6JQMHhpFl4ucRng/jOQ==
X-Proofpoint-ORIG-GUID: iztKq3XxX8NzP4OGmF2wTgYy3rP5hON-
X-Proofpoint-GUID: i0iHC08cPVNwkih3ggKOmoPU4r8PdCQl
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6992ebbd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8
 a=KKAkSRfTAAAA:8 a=1XWaLZrsAAAA:8 a=xZbbY9QGpBwAEkLlNRwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_03,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160080

On 2/12/26 19:17, Ian Rogers wrote:
> On Thu, Feb 12, 2026 at 4:53 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> The "Read backward ring buffer" test crashes on big-endian (e.g. s390x)
>> due to a NULL dereference when the backward mmap path isn't enabled.
>>
>> Reproducer:
>>   # ./perf test -F 'Read backward ring buffer'
>>   Segmentation fault (core dumped)
>>   # uname -m
>>   s390x
>>   #
>>
>> Root cause:
>> get_config_terms() stores into evsel_config_term::val.val (u64) while later
>> code reads boolean fields such as evsel_config_term::val.overwrite.
>> On big-endian the 1-byte boolean is left-aligned, so writing
>> evsel_config_term::val.val = 1 is read back as
>> evsel_config_term::val.overwrite = 0,
>> leaving backward mmap disabled and a NULL map being used.
>>
>> Store values in the union member that matches the term type, e.g.:
>>   /* for OVERWRITE */
>>   new_term->val.overwrite = 1;  /* not new_term->val.val = 1 */
>> to fix this.
>>
>> Impact:
>> Enables backward mmap on big-endian and prevents the crash.
>> No change on little-endian.
>>
>> Output after:
>>  # ./perf test -Fv 44
>>  --- start ---
>>  Using CPUID IBM,9175,705,ME1,3.8,002f
>>  mmap size 1052672B
>>  mmap size 8192B
>>  ---- end ----
>>  44: Read backward ring buffer                         : Ok
>>  #
>>
>> Fixes: 159ca97cd97c ("perf parse-events: Refactor get_config_terms() to remove macros")
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
>> Cc: James Clark <james.clark@linaro.org>
>> Cc: Ian Rogers <irogers@google.com>
>> ---
>>  tools/perf/util/parse-events.c | 49 +++++++++++++++++++++++++++++++++-
>>  1 file changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index d4647ded340f..12fe5392c832 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -1250,7 +1250,54 @@ static int get_config_terms(const struct parse_events_terms *head_config,
>>                         }
>>                         new_term->free_str = true;
>>                 } else {
>> -                       new_term->val.val = val;
>> +                       switch (new_type) {
>> +                       case EVSEL__CONFIG_TERM_PERIOD:
>> +                               new_term->val.period = val;
>> +                               break;
> 
> Thanks Thomas and sorry big endian got broken! I'm a little confused
> here as period is a u64 so I think this one can be a default case.
> 
>> +                       case EVSEL__CONFIG_TERM_FREQ:
>> +                               new_term->val.freq = val;
>> +                               break;
> 
> Also a u64.
> 
>> +                       case EVSEL__CONFIG_TERM_TIME:
>> +                               new_term->val.time = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_STACK_USER:
>> +                               new_term->val.stack_user = val;
>> +                               break;
> 
> Also a u64.

Agreed, I really don't mind. However should that type be changed (yep extremely unlikely)
we run into the same issue again.
> 
>> +                       case EVSEL__CONFIG_TERM_INHERIT:
>> +                               new_term->val.inherit = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_OVERWRITE:
>> +                               new_term->val.overwrite = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_MAX_STACK:
>> +                               new_term->val.max_stack = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_MAX_EVENTS:
>> +                               new_term->val.max_events = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_PERCORE:
>> +                               new_term->val.percore = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_AUX_OUTPUT:
>> +                               new_term->val.aux_output = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE:
>> +                               new_term->val.aux_sample_size = val;
>> +                               break;
>> +                       case EVSEL__CONFIG_TERM_CALLGRAPH:
>> +                       case EVSEL__CONFIG_TERM_DRV_CFG:
>> +                       case EVSEL__CONFIG_TERM_BRANCH:
>> +                       case EVSEL__CONFIG_TERM_AUX_ACTION:
>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG:
>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG1:
>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG2:
>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG3:
>> +                       case EVSEL__CONFIG_TERM_USR_CHG_CONFIG4:
>> +                       case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> 
> I think these cases are all assigning a str so would using str rather
> than val be cleaner?
> 
> The change looks good but it is a little inconsistent that the default
> copying is done for str values but not for u64. It would kind of be
> nice to remove the default copying so that if a new config term is
> added the switch will fail to compile due to a missing case statement.
> Then we can do the right copy for big endian. Given we've broken
> big-endian here we should probably add a comment.
> 
> Thanks,
> Ian

Yep I will send v2 later today and hopefully address your remarks completely.

> 
> I> +                       default:
>> +                               new_term->val.val = val;
>> +                               break;
>> +                       }
>>                 }
>>         }
>>         return 0;
>> --
>> 2.53.0
>>

Thanks 

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
