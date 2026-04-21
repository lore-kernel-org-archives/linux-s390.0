Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862B339D6EC;
	Tue, 21 Apr 2026 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769811; cv=none; b=aonnwL/TRhl4kfo0IZI3oEQIxbhweYOsYi9an60DlcMpx9XmKk22jTLY6VPNfmgU0ibobnyebmEyZ5MwqR+8YDBM8N+UTfGxt+oJRjOQYoJ/TxO1O1gam3UahA7wcdUn5/Le+x4Tal3PmCYvjSrYVKuThAFnEz1vo5JKC8agdoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769811; c=relaxed/simple;
	bh=cPk3mES7mCJ/WDcKqXzzjVByzo8p0Ai0Pd6KZm0mkoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qoR9n7Y8ITPTHbBEZ2XoTpy6Fvrs7a7vmEW1W0srqbxAt/tVJDfE18PPAjQCWet3385tIG9zf9q9MLbEj8YZLmPBNwNDT/7Ic/T9vXTZNUJSoRq3EuYgoRLq1VMgb59EstK+1uelwPEQtC/VulwodFSynN1XW1oGzo4Pi4j017A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KjYKwrus; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KjYKwrus"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgouT1926392;
	Tue, 21 Apr 2026 11:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uCFhvG
	MWp+E2OWU0REWyRzcUCWJ8WpxUycLDtmZuVvU=; b=KjYKwrusBhJunFsgWZREHp
	tIPAvbv9q5ckhz0agqDyid1k1erwdz4nZo5vLeyKbIUg+3+BFkJF4sCZPoFL65bH
	VbXfnsq9JEqKM1pbBwucKLZRGZkz2GnIsILlKlKYmz/ar7Ib2HQO8ClYGbVeGecl
	hqT/hwTte+Q4Y+5m72qNHKYQLxug7+kh4keA7gpRkdTkbuO493CrIXfc7wH8ql9A
	HSocE9CJInyN46gHOP5R9Kjt1ymxhQ/rNRBN1PHcUKq2u+PFihKcKWwXpvw9Q/Sp
	uW4gCPI+2GvVzVEnkXxyb5TskOLsu/5eRc4gJdop6+cLqJS04QaBu1gm7Lcsu+BA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf3ykg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:10:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LB5WMe030287;
	Tue, 21 Apr 2026 11:10:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpyy06g9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 11:10:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LBA3ru46268698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 11:10:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C8052004B;
	Tue, 21 Apr 2026 11:10:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED79A2004D;
	Tue, 21 Apr 2026 11:10:02 +0000 (GMT)
Received: from [9.52.199.37] (unknown [9.52.199.37])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 11:10:02 +0000 (GMT)
Message-ID: <f00388eb-a3d9-4df2-8786-70b938e57a78@linux.ibm.com>
Date: Tue, 21 Apr 2026 13:10:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH Ping ] perf callchain: Handle multiple address spaces
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com
References: <20260414124241.490185-1-tmricht@linux.ibm.com>
Content-Language: en-US
From: Thomas Richter <tmricht@linux.ibm.com>
Organization: IBM
In-Reply-To: <20260414124241.490185-1-tmricht@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SqFu4eD-lqQ1BL7_iby81zPXIM1sxIlc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEwNyBTYWx0ZWRfX9eLBIpaXb+Yy
 HuYuDgGrv87FN44cUXNHy3i63Bv9Tq6TJjOjhOmr0D6xvA+FA0pb/0980NpWZpMPlaP3ObENTUh
 0P5OGKCv0rqrsHav22oGX9WLizoX8Cr2fCoRnxAn4o1XOKGZ7l109E1Z4xetzXYL+GxhAMV2Snm
 SYkBBNbE4HJja8k8xR+kZX4wtRdVWNMBdbbWEeuoiqdkiA5A+GsYsCkm9UEZJwdd4jU2JT/SyWX
 VcIrFs29tbQ9f7UaX51swx5pfu0GXdFHwTvLbKuwwAfrzJGiT5ENPtecgZck0ZZ/pA5xwsfbSEL
 jq/oPrEA2KTnrjXRMEjULwrHmRqDLY22aR8zEUZ3oi352xgWyBabyx8BIHvosgwZgEPQto2WLFS
 EbHF7rrPCH4IinNY7ET2tCh6II94+n6K37/ewBdFxIn/AGikNc23I8ujrZ6H+nqvuL7T+R1mjAA
 5OkhQBSjKciLvzy6Hjw==
X-Proofpoint-GUID: SqFu4eD-lqQ1BL7_iby81zPXIM1sxIlc
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e75b0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xDvo_LaBMGlJbYMeWJQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210107

Friendly ping...

On 4/14/26 14:42, Thomas Richter wrote:
> perf test 'perf inject to convert DWARF callchains to regular ones'
> fails on s390. It was introduced with
> commit 92ea788d2af4 ("perf inject: Add --convert-callchain option")
> 
> The failure comes the difference in output. Without the inject script to
> convert DWARF the callchains is:
>  # ./perf record -F 999 --call-graph dwarf -- perf test -w noploop
>  # ./perf report -i perf.data --stdio --no-children -q \
> 					 --percent-limit=1 > /tmp/111
>  # cat /tmp/111
>     99.30%  perf-noploop  perf               [.] noploop
>             |
>             ---noploop
>                run_workload (inlined)
>                cmd_test
>                run_builtin (inlined)
>                handle_internal_command
>                run_argv (inlined)
>                main
>                __libc_start_call_main
>                __libc_start_main_impl (inlined)
>                _start
>  #
> 
> With the inject script step the output is:
>  # ./perf inject -i perf.data --convert-callchain -o /tmp/perf-inject-1.out
>  # ./perf report -i /tmp/perf-inject-1.out --stdio --no-children -q \
> 		--percent-limit=1 > /tmp/222
>  # cat /tmp/222
>     99.40%  perf-noploop  perf               [.] noploop
>             |
>             ---noploop
>                run_workload (inlined)
>                cmd_test
>                run_builtin (inlined)
>                handle_internal_command
>                run_argv (inlined)
>                main
>                _start
>  # diff /tmp/111 /tmp/222
>  1c1
>  <     99.30%  perf-noploop  perf               [.] noploop
>  ---
>  >     99.40%  perf-noploop  perf               [.] noploop
>  10,11d9
>  <                __libc_start_call_main
>  <                __libc_start_main_impl (inlined)
>  #
> 
> The difference are the symbols __libc_start_call_main and
> __libc_start_main_impl.
> 
> On x86_64, kernel and user space share a single virtual address space,
> with the kernel mapped to the upper end of memory. The instruction
> pointer value alone is sufficient to distinguish between user space
> and kernel space addresses. This is not true for s390, which uses
> separate address spaces for user and kernel. The same virtual address
> can be valid in both address spaces, so the instruction pointer value
> alone cannot determine whether an address belongs to the kernel or
> user space. Instead, perf must rely on the cpumode metadata derived
> from the processor status word (PSW) at sample time.
> 
> In function perf_event__convert_sample_callchain() the first part
> copies a kernel callchain and context entries, if any.
> It then appends additional entries ignoring the address space
> architecture. Taking that into account, the symbols at addresses
> 
>    0x3ff970348cb __libc_start_call_main
>    0x3ff970349c5 __libc_start_main_impl
> 
> (located after the kernel address space on s390) are now included.
> 
> Output before:
>  # ./perf test 83
>  83: perf inject to convert DWARF callchains to regular ones : FAILED!
> 
> Output after:
>  # ./perf test 83
>  83: perf inject to convert DWARF callchains to regular ones : Ok
> 
> Question to Namhyung:
> In function perf_event__convert_sample_callchain() just before the
> for() loop this patch modifies, the kernel callchain is copied,
> see this comment and the next 5 lines:
>    /* copy kernel callchain and context entries */ 
> Then why is machine__kernel_ip() needed in the for() loop, when
> the kernel entries have been copied just before the loop?
> 
> Note: This patch was tested on x86_64 virtual machine and succeeded.
> 
> Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
> Cc: Namhyung Kim <namhyung@kernel.org>
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> ---
>  tools/perf/arch/common.c    | 4 +++-
>  tools/perf/builtin-inject.c | 3 ++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
> index 21836f70f231..ad0cab830a4d 100644
> --- a/tools/perf/arch/common.c
> +++ b/tools/perf/arch/common.c
> @@ -237,5 +237,7 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
>   */
>  bool perf_env__single_address_space(struct perf_env *env)
>  {
> -	return strcmp(perf_env__arch(env), "sparc");
> +	const char *arch = perf_env__arch(env);
> +
> +	return strcmp(arch, "s390") && strcmp(arch, "sparc");
>  }
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index f174bc69cec4..6ab20df358c4 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -438,7 +438,8 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
>  
>  	node = cursor->first;
>  	for (k = 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
> -		if (machine__kernel_ip(machine, node->ip))
> +		if (machine->single_address_space &&
> +		    machine__kernel_ip(machine, node->ip))
>  			/* kernel IPs were added already */;
>  		else if (node->ms.sym && node->ms.sym->inlined)
>  			/* we can't handle inlined callchains */;


-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
IBM Deutschland Research & Development GmbH

Vorsitzender des Aufsichtsrats: Wolfgang Wendt

Geschäftsführung: David Faller

Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
