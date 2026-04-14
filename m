Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEE3E5ECE;
	Tue, 14 Apr 2026 12:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170597; cv=none; b=tpj+f0wuftSdI6To+Yb5OrmCdQ/802pbKrKaffiopRJS7PDXTrvJ0UB6h6rNy+hvd+lgEra7kL/5s5HxRdlUZjplDRpGrYrlo0IE46WrZDqeIIpJmWB688ybQtCafgxLdWQTO5EuERir7gZ1XhyYxW3WRwRjDjLgBL37G4Z9yGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170597; c=relaxed/simple;
	bh=it/qezOCeo425+XT/EipAoxG1JYU7yxw++mb7UuSfgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXE26fF2O+kEs6lJNIvhNVKgAfnqzJ6fmkeBc6LwBgIh96TMQ8bPG5W9ByunShMgL3rFLPnJplSL9EhCUYBdk1Hn0N+81q9SCRtftlhHVkXr/6oSnkSI8peEjSbIieaUNfjlt/n+7Wi9J2RAYuNEEGdOG7E36jT4jQaaLwEWVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kiiowAWr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kiiowAWr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLIbtT1805234;
	Tue, 14 Apr 2026 12:43:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5TpogUAlNoj47o6kBi1T8dlKUtiDSCaPNE3Va6Uw/
	QA=; b=kiiowAWrFKdT2RKXVvZ/YjyDBTYWHI0rDNM0Wu+fttdMyX1mroQkw5pk8
	PYRaU4TbXoMkrRsSu7DZyzK+N9IOVWf0UYk5QiEYQmll2XTMJKP4Bh+8/ls2N/Xt
	OSJtT30RD8/drZVApIcDL0woMznUW5pFK1GBtZNcd2/HoP90ob/LiyO3bza2a/iE
	0pDRf2vbXi5h0kRuXnZeEbwtM1qc7yP42Yb9u5B+Wz/lc0QiDJ2Z4OpyvIjrCKfM
	d1IzYUgSTk1xvFxls991QtnfRtZCEqq29dFlRpDnD5oHawdu+eAfXNxoZYNCZT/K
	CP5cus9N+emhXvIYXp30W0qwEpWYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k2kcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 12:43:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63E9dpx2003586;
	Tue, 14 Apr 2026 12:43:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn9f96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Apr 2026 12:43:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63ECguUc9437514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 12:42:56 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99A7520040;
	Tue, 14 Apr 2026 12:42:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62FCD2004B;
	Tue, 14 Apr 2026 12:42:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Apr 2026 12:42:56 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf callchain: Handle multiple address spaces
Date: Tue, 14 Apr 2026 14:42:41 +0200
Message-ID: <20260414124241.490185-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J_Vdq4hhhe31_oFQ-ube18utN5OHRl4i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDExNSBTYWx0ZWRfX7MALl5VlDJfy
 dIdu21Oi0uGUpovGlEHwAV548lEeX/JeRtYSRvJPEshofWblQqE3Fe1iX8KY23Pu6jDhnNc4YTS
 xxfb+6tuJFs4/EwzjT4WCNFIL+E4xm/TamGQT/7OtusDwc+2lWZGl1c0eB9QQrut6LtmKbMzZDt
 FaTrOUARPgQxJ2qOOg0hXlpGd+ubaf9XOxhb1mqBjKUH30Qbw9vM3pEMkk8QAV8nOfAiH7ptnFV
 UAiiT3+/XNZse4Gil5GmSiEHjYueySRbBFusOJs/dRyPd2peAUfwgChoN5u9o2a06pK+kIA/BjU
 q6du6JdmU3qaiTl+nxPcrV7B4Hm8wke5/LxtQeAZ9EvJMva1iJNXACAsVHWv/EwIkLA5YphoU1J
 YyaWlLwiRqZUQh83TsjS5Eo4m0lwk3kDLe1QapUnNeQTscOSNE1LlbhKkvBOBHSS7IfEETP+GZj
 wW1n83CCGNNYEsBazGw==
X-Proofpoint-ORIG-GUID: J_Vdq4hhhe31_oFQ-ube18utN5OHRl4i
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69de3655 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NsMrYSxA7xTIvm2-GKQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140115

perf test 'perf inject to convert DWARF callchains to regular ones'
fails on s390. It was introduced with
commit 92ea788d2af4 ("perf inject: Add --convert-callchain option")

The failure comes the difference in output. Without the inject script to
convert DWARF the callchains is:
 # ./perf record -F 999 --call-graph dwarf -- perf test -w noploop
 # ./perf report -i perf.data --stdio --no-children -q \
					 --percent-limit=1 > /tmp/111
 # cat /tmp/111
    99.30%  perf-noploop  perf               [.] noploop
            |
            ---noploop
               run_workload (inlined)
               cmd_test
               run_builtin (inlined)
               handle_internal_command
               run_argv (inlined)
               main
               __libc_start_call_main
               __libc_start_main_impl (inlined)
               _start
 #

With the inject script step the output is:
 # ./perf inject -i perf.data --convert-callchain -o /tmp/perf-inject-1.out
 # ./perf report -i /tmp/perf-inject-1.out --stdio --no-children -q \
		--percent-limit=1 > /tmp/222
 # cat /tmp/222
    99.40%  perf-noploop  perf               [.] noploop
            |
            ---noploop
               run_workload (inlined)
               cmd_test
               run_builtin (inlined)
               handle_internal_command
               run_argv (inlined)
               main
               _start
 # diff /tmp/111 /tmp/222
 1c1
 <     99.30%  perf-noploop  perf               [.] noploop
 ---
 >     99.40%  perf-noploop  perf               [.] noploop
 10,11d9
 <                __libc_start_call_main
 <                __libc_start_main_impl (inlined)
 #

The difference are the symbols __libc_start_call_main and
__libc_start_main_impl.

On x86_64, kernel and user space share a single virtual address space,
with the kernel mapped to the upper end of memory. The instruction
pointer value alone is sufficient to distinguish between user space
and kernel space addresses. This is not true for s390, which uses
separate address spaces for user and kernel. The same virtual address
can be valid in both address spaces, so the instruction pointer value
alone cannot determine whether an address belongs to the kernel or
user space. Instead, perf must rely on the cpumode metadata derived
from the processor status word (PSW) at sample time.

In function perf_event__convert_sample_callchain() the first part
copies a kernel callchain and context entries, if any.
It then appends additional entries ignoring the address space
architecture. Taking that into account, the symbols at addresses

   0x3ff970348cb __libc_start_call_main
   0x3ff970349c5 __libc_start_main_impl

(located after the kernel address space on s390) are now included.

Output before:
 # ./perf test 83
 83: perf inject to convert DWARF callchains to regular ones : FAILED!

Output after:
 # ./perf test 83
 83: perf inject to convert DWARF callchains to regular ones : Ok

Question to Namhyung:
In function perf_event__convert_sample_callchain() just before the
for() loop this patch modifies, the kernel callchain is copied,
see this comment and the next 5 lines:
   /* copy kernel callchain and context entries */ 
Then why is machine__kernel_ip() needed in the for() loop, when
the kernel entries have been copied just before the loop?

Note: This patch was tested on x86_64 virtual machine and succeeded.

Fixes: 92ea788d2af4 ("perf inject: Add --convert-callchain option")
Cc: Namhyung Kim <namhyung@kernel.org>

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/arch/common.c    | 4 +++-
 tools/perf/builtin-inject.c | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/common.c b/tools/perf/arch/common.c
index 21836f70f231..ad0cab830a4d 100644
--- a/tools/perf/arch/common.c
+++ b/tools/perf/arch/common.c
@@ -237,5 +237,7 @@ int perf_env__lookup_objdump(struct perf_env *env, char **path)
  */
 bool perf_env__single_address_space(struct perf_env *env)
 {
-	return strcmp(perf_env__arch(env), "sparc");
+	const char *arch = perf_env__arch(env);
+
+	return strcmp(arch, "s390") && strcmp(arch, "sparc");
 }
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index f174bc69cec4..6ab20df358c4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -438,7 +438,8 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 
 	node = cursor->first;
 	for (k = 0; k < cursor->nr && i < PERF_MAX_STACK_DEPTH; k++) {
-		if (machine__kernel_ip(machine, node->ip))
+		if (machine->single_address_space &&
+		    machine__kernel_ip(machine, node->ip))
 			/* kernel IPs were added already */;
 		else if (node->ms.sym && node->ms.sym->inlined)
 			/* we can't handle inlined callchains */;
-- 
2.53.0

