Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C947939023D;
	Tue, 17 Mar 2026 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773736858; cv=none; b=ZgqhLwrL+nytSkAIsQLqO9A9766lmGRGHIQ8TGXwi+gdh1f6mOKcGMLQVFEBypjUZHhU/ezTpYXv9MwfvArRCQf0oLOOwvueByVbYV83uXrkl9UdcPNUA64G0eJ0OD3f3sZZTd0UyDAWbwBBZaa9XMf819KF+hrd2yV4vTLHm0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773736858; c=relaxed/simple;
	bh=eZUt8UK7XvIw4tpVa3cAPzKO499+HWIQ5eIZlvsbzSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWoMKNwx0EZ1QnNfRWdKcUBpWy2CiO+MPE92GC8gyEV+ocA0194CR/yGUWBRcG7tVsobc8TKTaAMyleVA8qk9EjJSh9xNJSl/hT2AqQp8CFCvdZyVEN//4uBo6vXglY48szToZ9/Pyx7tS7xQUP3GVdR7yRJQnkkUiTjvl+PzdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AxMAihbB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AxMAihbB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMvqP23853770;
	Tue, 17 Mar 2026 08:40:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Vf1hre
	HTTxpElBwuAWIccvlxILrrO4lSzKqnIcdiG0k=; b=AxMAihbB2rCVyfXT1y1HGX
	M6pvpv7JP7LxyGVOwFr/YpbeoTQFJhcuabudrZ9ZRYgV+YyhQyUaL9QRm4DWTedl
	U0vM7M/5DwVcNow32pXltED5/82oYZu+bqbHmlTddXYmQLsaDA1Q3OKIcY1BQakj
	CdZX/FAPt3FfYKtZ50ijFDddgKLmE1qnwvwCwS354LkG8WnaAYpyEbo/qYNFEVCH
	xH7DF+5cJIRnEnPFoFoatG1p+RtMSdYJY7bamdacq0smHj5AvOk5LPLNqpIKZMKQ
	wibjoP47zsqqdfjMQWF76nXw2ImwcQoRJKl8BPCBmzbjlsTiyUbn/FrL+sibyJlg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs3rws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 08:40:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62H8CeuG028455;
	Tue, 17 Mar 2026 08:40:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq182rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 08:40:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62H8emVV49414478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 08:40:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE2BF2004D;
	Tue, 17 Mar 2026 08:40:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 746CF2004B;
	Tue, 17 Mar 2026 08:40:48 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 08:40:48 +0000 (GMT)
Message-ID: <2fc33a4b-5e6a-4e60-bc8d-8494888e8106@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:40:47 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf record: Add support for arch_sdt_arg_parse_op()
 on s390
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        dapeng1.mi@linux.intel.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
        sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
References: <20260313132302.3347751-1-tmricht@linux.ibm.com>
 <CAP-5=fU1Spg+rxTkjqECZZbRjkLASPu14Q=ZyONFWHe4rwy9+g@mail.gmail.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <CAP-5=fU1Spg+rxTkjqECZZbRjkLASPu14Q=ZyONFWHe4rwy9+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b91395 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=QyXUC8HyAAAA:8 a=A_7-HmRUnHCsZpZN3REA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: mKv1pSUJclrzC1Sv3RJxCYW-YEPVHrRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDA3MSBTYWx0ZWRfX2AgC6J2iT4uO
 clxX4Etziw67+XbzdmXMxtaIigQmtgP4ZT26b8yDmnVFxlufaf611JvrGVnZ8URPxihEeLGikSD
 jOMdrtHg/GcF8XV2s3ehFe2EYNAxOl94cbMxKh0FRQgVoCNvxd54AX9WlnscWewL1f98XR7FVrl
 lMK2cO0/A6N9DGF23xoJ4Qmjp8PF7wJCUwqhHM27dfbujbGlGm/+Y6h25oiMTu8Cn4lOVKIzPDY
 xeclyjRiz9hfIWeRru8W0phztqY9BYCNt0euYhqPk8qatRONDtmxzP0EsqwbAeQTNI8PDjtfSI+
 6T/gngoIwHjViOxGe0fN0S0Y8nyFNiNiREmkoQVxPXM7CDdn2eFMP1TCu8X4CiUMxkzPl/meIp0
 SeoBosGcYjZmXBve/g7zaz8FdLfl8BWou/UPLo3o3H8vtcIlsaPN7CyOKv1uwJQiTM+2S2r6fNc
 F8Xie2Jh+bmZOywLzMQ==
X-Proofpoint-GUID: 547GzLUDXAmodTrqY-m8GM2y7n_cSOBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170071

On 3/13/26 21:50, Ian Rogers wrote:
> On Fri, Mar 13, 2026 at 6:33 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
>>
>> commit e5e66adfe45a6 ("perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function")
>> removes arch_sdt_arg_parse_op() functions. s390 support is missing.
>> The following warning is printed:
>>
>>   Unknown ELF machine 22, standard arguments parse will be skipped.
>>
>> ELF machine 22 is the EM_S390 host. This happens with command
>>   # ./perf record -v -- stress-ng -t 1s --matrix 0
>> on a z/VM system when the event is not specified.
>>
>> Add s390 specific __perf_sdt_arg_parse_op_s390() function to support
>> -architecture calls to arch_sdt_arg_parse_op() for s390.
>> The warning disappears.
>>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Tested-by: Jan Polensky <japo@linux.ibm.com>
>> ---
>>  .../perf/util/perf-regs-arch/perf_regs_s390.c | 89 +++++++++++++++++++
>>  tools/perf/util/perf_regs.c                   |  3 +
>>  tools/perf/util/perf_regs.h                   |  1 +
>>  3 files changed, 93 insertions(+)
>>
>> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_s390.c b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
>> index c61df24edf0f..c830aeae606e 100644
>> --- a/tools/perf/util/perf-regs-arch/perf_regs_s390.c
>> +++ b/tools/perf/util/perf-regs-arch/perf_regs_s390.c
>> @@ -1,7 +1,13 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>
>> +#include <errno.h>
>> +#include <regex.h>
>>  #include "../perf_regs.h"
>>  #include "../../arch/s390/include/perf_regs.h"
>> +#include "debug.h"
>> +
>> +#include <linux/zalloc.h>
>> +#include <linux/kernel.h>
>>
>>  uint64_t __perf_reg_mask_s390(bool intr __maybe_unused)
>>  {
>> @@ -95,3 +101,86 @@ uint64_t __perf_reg_sp_s390(void)
>>  {
>>         return PERF_REG_S390_R15;
>>  }
>> +
>> +/* %rXX */
>> +#define SDT_OP_REGEX1  "^%r([0-9]|1[0-5])$"
>> +/* -###(%rXX) */
>> +#define SDT_OP_REGEX2  "^(-?[0-9]+)\\(%r([0-9]|1[0-5])\\)$"
>> +static regex_t sdt_op_regex1, sdt_op_regex2;
>> +
>> +static int sdt_init_op_regex(void)
>> +{
>> +       static int initialized;
>> +       int ret = 0;
>> +
>> +       if (initialized)
>> +               return 0;
>> +
>> +       ret = regcomp(&sdt_op_regex1, SDT_OP_REGEX1, REG_EXTENDED);
>> +       if (ret)
>> +               goto error;
>> +       initialized = 1;
>> +
>> +       ret = regcomp(&sdt_op_regex2, SDT_OP_REGEX2, REG_EXTENDED);
>> +       if (ret)
>> +               goto free_regex1;
>> +       initialized = 2;
>> +
>> +       return 0;
>> +
>> +free_regex1:
>> +       regfree(&sdt_op_regex1);
>> +error:
>> +       pr_debug4("Regex compilation error, initialized %d\n", initialized);
>> +       initialized = 0;
>> +       return ret;
>> +}
>> +
>> +/*
>> + * Parse OP and convert it into uprobe format, which is, +/-NUM(%gprREG).
>> + * Possible variants of OP are:
>> + *     Format          Example
>> + *     -------------------------
>> + *     NUM(%rREG)      48(%r1)
>> + *     -NUM(%rREG)     -48(%r1)
>> + *     %rREG           %r1
>> + */
>> +int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op)
>> +{
>> +       int ret, new_len;
>> +       regmatch_t rm[6];
>> +       unsigned long i;
>> +
>> +       *new_op = NULL;
>> +       ret = sdt_init_op_regex();
>> +       if (ret < 0)
>> +               return ret;
> 
> Some AI feedback:
> 
> POSIX regcomp() returns 0 on success and a positive error code on failure
> (like REG_ESPACE). Since sdt_init_op_regex() returns this positive code,
> will ret < 0 evaluate to false on compilation failure?
> 
> If so, this would allow execution to proceed to regexec() using uninitialized
> or freed regex structs, which could crash the tool.

Thanks for the finding, you are correct.
I simply copy and pasted most part of the code. So we should also fix
util/perf-regs-arch/perf_regs_powerpc.c, line 86
util/perf-regs-arch/perf_regs_aarch64.c, line 65

Then then return code of functions  __perf_sdt_arg_parse_op_s390() should
be negative on error. Otherwise

  synthesize_sdt_probe_arg()
  +--> perf_sdt_arg_parse_op()
       +--> __perf_sdt_arg_parse_op_s390()

and synthesize_sdt_probe_arg() does not handle positive value as error:
       ret = perf_sdt_arg_parse_op(EM_HOST, op, &new_op);                    
                                                                              
        if (ret < 0)                                                          
                goto error;

>> +
>> +       if (!regexec(&sdt_op_regex1, old_op, 3, rm, 0)) {
>> +               /* Extract %rX */
>> +               new_len = 2;    /* % NULL */
>> +               new_len += (int)(rm[1].rm_eo - rm[1].rm_so);
>> +               *new_op = zalloc(new_len);
>> +               if (!*new_op)
>> +                       return -ENOMEM;
>> +
>> +               scnprintf(*new_op, new_len, "%%%.*s",
>> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so);
> 
> Does this formatting correctly preserve the 'r' prefix for s390 registers?
> The regex SDT_OP_REGEX1 is defined as ^%r([0-9]|1[0-5])$, meaning rm[1]
> captures the numeric digits, not the 'r'. So an input like %r15 will be
> formatted as %15.
> 
> However, the s390 kernel's regs_query_register_offset() strictly requires
> the register name to start with 'r', otherwise it returns -EINVAL. Will
> the kernel's parse_probe_arg() reject the uprobe definition without the
> 'r' prefix?

Ok will fix this

> 
>> +       } else if (!regexec(&sdt_op_regex2, old_op, ARRAY_SIZE(rm), rm, 0)) {
>> +               /* Extract #(%rX) */
>> +               new_len = 4;    /* (%)NULL */
>> +               for (i = 1; i < ARRAY_SIZE(rm) && rm[i].rm_so != -1; ++i)
>> +                       new_len += (int)(rm[i].rm_eo - rm[i].rm_so);
>> +               *new_op = zalloc(new_len);
>> +               if (!*new_op)
>> +                       return -ENOMEM;
>> +
>> +               scnprintf(*new_op, new_len, "%.*s(%%%.*s)",
>> +                         (int)(rm[1].rm_eo - rm[1].rm_so), old_op + rm[1].rm_so,
>> +                         (int)(rm[2].rm_eo - rm[2].rm_so), old_op + rm[2].rm_so);
> 
> Similar to the above, rm[2] isolates the digits without the 'r' prefix,
> creating an argument like 48(%15).
> 
> Additionally, does this string translation handle positive memory
> displacements correctly?
> 
> The kernel's parse_probe_arg() in kernel/trace/trace_probe.c parses memory
> dereferences by matching the case '+': or case '-': prefix switch cases.
> If an argument starts with a digit rather than a + or -, it falls through
> to the default case and is rejected with -EINVAL.
> 
> Should positive memory offsets be translated to explicitly include the +
> prefix (e.g., +48(%r15)) so they are accepted by the uprobe parser?
> 

Ok will fix this and send v2

Thanks a lot


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
