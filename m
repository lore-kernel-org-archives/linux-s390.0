Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539823346B4;
	Mon, 10 Nov 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762800892; cv=none; b=JDi/9nOTzDmQTWeznOmXga/zqotCMtpkCio0I0Zkkgwn0FsAcRXW+/Mkozt2Hp68rFiutpUl+wEa2Wl3VUvoKMewkW3iAkgGzWKNnWQa4U1dQZ83V2AnbneHdzJP8S9R249N7RXeQklytcSTwXl/2ropQ4kct44lses4HeYhZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762800892; c=relaxed/simple;
	bh=2Qktt4bn+wDp5DRsMvn/Km4tvsWclb0NH8EeUgN8Z5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCTV7PG9kASEXkdMLJMFh0GEGJ+izi6tH6ulthgvKizFC1uDJOCQqoS9eky7ol3twVpwl+WjS8StOjl7mYUM9YqrGCDzMXxWUJN0oXFRRgfZbCoTWc37joK+ztcX9hhw27rPa7fiSmBOopE5KNRQYWJDTIN8sKQ9yzpGFXz1uYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kYm1K8ES; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kYm1K8ES"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AADNXRn017468;
	Mon, 10 Nov 2025 18:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vBMBXPfW4uujR94z3
	NsWIktizcIddhs3Pe6HO+vXVfU=; b=kYm1K8ESSrODsEdnzudDsVivYZW5rJxoE
	MzJ1DGgqdXACrxhJESdfGhpQ69/82QjPXmYX8jJ/0p52YoQaWGQNkzlJH8Y7skMw
	jbKC+3aeZetGfIk9QFZ6PmYW0mRFzZHqoTKuS1Y69qO/wsl8CJtvNoz1og+HpMbs
	mDOGP6B/d4qfyZRKNMzMquLDwwNUEsl2lSmjGCdrYI4v5ZnPo3a/oiXgV65b+OB1
	oIlasclqGlGA815ckeb+z/hdcjCDaHIgvOBKz/f9E57t/vF80/YXq3wFIbZw73Za
	xlFMGy/9jClt7M2WVrj0g5hHGLIDrzTdIriMWMdNwd8gGSipT/48g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wk81qv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAGZCQE004748;
	Mon, 10 Nov 2025 18:54:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aagjxq89u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 18:54:45 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AAIsfnT11600350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 18:54:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92D3220040;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 654212004B;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 18:54:41 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [RFC PATCH 4/8] tools: Remove s390 compat support
Date: Mon, 10 Nov 2025 19:54:36 +0100
Message-ID: <20251110185440.2667511-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251110185440.2667511-1-hca@linux.ibm.com>
References: <20251110185440.2667511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXzGpLP27wVkLu
 nr+eqUBM9nhqZakJKTJGtcCtMZ6TfP+n7o36lnnMwwVQ7gylMw4TBZm3ZkDYhLC0XqccczRQujk
 5lTDdyJQDEDTzL9Hc0wpAqLNUjt5x0gpr/pGGBU6Jk+lif1X3Om5uv3Qx7Ew3Bw0H85/5ErpERQ
 JfOawRdm1gvQTuutP//UrTo19WhUwbyFeK67nb6l/wvJr6fF0eryOVFN2gL3OYZcEPtJafcKK3n
 /qRbWAIgm8ded3RZoEwY9zRh1RcmsWSTjp/g6R3Qd5KUOpgeVfd/FP9WuO/AJ+5H4h71QNWKGg6
 DjxyN5PVz61MHvvgjW9+Z+HuX+2WUGy0XhhVMwStrMOiuZn1uOJvweZ5HmhPWUNx9tfVVzUTJ6X
 0nqwXhgaPksV1heifQv/D2QaSPdkNA==
X-Authority-Analysis: v=2.4 cv=ZK3aWH7b c=1 sm=1 tr=0 ts=691234f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=mz6dD-u-rsT591k5OcEA:9
X-Proofpoint-ORIG-GUID: UNYN6mHYzRj_K4yn0LCsjII5x_UyYC-f
X-Proofpoint-GUID: UNYN6mHYzRj_K4yn0LCsjII5x_UyYC-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Remove s390 compat support from everything within tools, since s390 compat
support will be removed from the kernel.

While removing s390 compat code replace __s390__ ifdef guards with
__s390x__ everywhere. Even though this is not strictly required this
makes it easier to spot s390 compat code support leftovers.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 .../arch/s390/include/uapi/asm/bitsperlong.h  |  4 --
 tools/build/feature/test-bpf.c                |  2 +-
 tools/include/asm/barrier.h                   |  2 +-
 tools/include/nolibc/arch-s390.h              |  5 ---
 tools/include/nolibc/arch.h                   |  2 +-
 tools/include/uapi/asm/bitsperlong.h          |  2 +-
 tools/include/uapi/asm/bpf_perf_event.h       |  2 +-
 tools/lib/bpf/bpf.c                           |  2 +-
 tools/lib/bpf/bpf_tracing.h                   |  2 +-
 tools/lib/bpf/libbpf.c                        |  4 --
 tools/lib/bpf/usdt.c                          |  2 -
 tools/perf/util/header.c                      |  2 +-
 tools/testing/selftests/bpf/sdt.h             |  2 +-
 tools/testing/selftests/bpf/usdt.h            |  2 +-
 .../selftests/ptrace/set_syscall_info.c       |  2 +-
 tools/testing/selftests/rseq/param_test.c     |  2 +-
 tools/testing/selftests/rseq/rseq-s390.h      | 39 -------------------
 tools/testing/selftests/rseq/rseq.h           |  2 +-
 .../selftests/rseq/syscall_errors_test.c      |  2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |  4 +-
 tools/testing/selftests/vDSO/vdso_config.h    |  4 --
 21 files changed, 16 insertions(+), 74 deletions(-)

diff --git a/tools/arch/s390/include/uapi/asm/bitsperlong.h b/tools/arch/s390/include/uapi/asm/bitsperlong.h
index d2bb620119bf..a226a1686a53 100644
--- a/tools/arch/s390/include/uapi/asm/bitsperlong.h
+++ b/tools/arch/s390/include/uapi/asm/bitsperlong.h
@@ -2,11 +2,7 @@
 #ifndef __ASM_S390_BITSPERLONG_H
 #define __ASM_S390_BITSPERLONG_H
 
-#ifndef __s390x__
-#define __BITS_PER_LONG 32
-#else
 #define __BITS_PER_LONG 64
-#endif
 
 #include <asm-generic/bitsperlong.h>
 
diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
index e7a405f83af6..dcde234ea9ba 100644
--- a/tools/build/feature/test-bpf.c
+++ b/tools/build/feature/test-bpf.c
@@ -12,7 +12,7 @@
 #  define __NR_bpf 280
 # elif defined(__sparc__)
 #  define __NR_bpf 349
-# elif defined(__s390__)
+# elif defined(__s390x__)
 #  define __NR_bpf 351
 # elif defined(__mips__) && defined(_ABIO32)
 #  define __NR_bpf 4355
diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 0c21678ac5e6..c8bebfadaf74 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -10,7 +10,7 @@
 #include "../../arch/powerpc/include/asm/barrier.h"
 #elif defined(__riscv)
 #include "../../arch/riscv/include/asm/barrier.h"
-#elif defined(__s390__)
+#elif defined(__s390x__)
 #include "../../arch/s390/include/asm/barrier.h"
 #elif defined(__sh__)
 #include "../../arch/sh/include/asm/barrier.h"
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index df4c3cc713ac..0a39bee261b9 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -143,13 +143,8 @@
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-#ifdef __s390x__
 		"lgr	%r2, %r15\n"          /* save stack pointer to %r2, as arg1 of _start_c */
 		"aghi	%r15, -160\n"         /* allocate new stackframe                        */
-#else
-		"lr	%r2, %r15\n"
-		"ahi	%r15, -96\n"
-#endif
 		"xc	0(8,%r15), 0(%r15)\n" /* clear backchain                                */
 		"brasl	%r14, _start_c\n"     /* transfer to c runtime                          */
 	);
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 426c89198135..ef4743aad188 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -27,7 +27,7 @@
 #include "arch-powerpc.h"
 #elif defined(__riscv)
 #include "arch-riscv.h"
-#elif defined(__s390x__) || defined(__s390__)
+#elif defined(__s390x__)
 #include "arch-s390.h"
 #elif defined(__loongarch__)
 #include "arch-loongarch.h"
diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index c65267afc341..ca59a4fee942 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -3,7 +3,7 @@
 #include "../../../arch/x86/include/uapi/asm/bitsperlong.h"
 #elif defined(__powerpc__)
 #include "../../../arch/powerpc/include/uapi/asm/bitsperlong.h"
-#elif defined(__s390__)
+#elif defined(__s390x__)
 #include "../../../arch/s390/include/uapi/asm/bitsperlong.h"
 #elif defined(__sparc__)
 #include "../../../arch/sparc/include/uapi/asm/bitsperlong.h"
diff --git a/tools/include/uapi/asm/bpf_perf_event.h b/tools/include/uapi/asm/bpf_perf_event.h
index ff52668abf8c..7b28fa03c835 100644
--- a/tools/include/uapi/asm/bpf_perf_event.h
+++ b/tools/include/uapi/asm/bpf_perf_event.h
@@ -2,7 +2,7 @@
 #include "../../arch/arm64/include/uapi/asm/bpf_perf_event.h"
 #elif defined(__arc__)
 #include "../../arch/arc/include/uapi/asm/bpf_perf_event.h"
-#elif defined(__s390__)
+#elif defined(__s390x__)
 #include "../../arch/s390/include/uapi/asm/bpf_perf_event.h"
 #elif defined(__riscv)
 #include "../../arch/riscv/include/uapi/asm/bpf_perf_event.h"
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 339b19797237..61927c28e080 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -49,7 +49,7 @@
 #  define __NR_bpf 280
 # elif defined(__sparc__)
 #  define __NR_bpf 349
-# elif defined(__s390__)
+# elif defined(__s390x__)
 #  define __NR_bpf 351
 # elif defined(__arc__)
 #  define __NR_bpf 280
diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index dbe32a5d02cd..5facada4c5e9 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -41,7 +41,7 @@
 #if defined(__x86_64__)
 	#define bpf_target_x86
 	#define bpf_target_defined
-#elif defined(__s390__)
+#elif defined(__s390x__)
 	#define bpf_target_s390
 	#define bpf_target_defined
 #elif defined(__arm__)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index dd3b2f57082d..85abc357da31 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11325,8 +11325,6 @@ static const char *arch_specific_syscall_pfx(void)
 	return "ia32";
 #elif defined(__s390x__)
 	return "s390x";
-#elif defined(__s390__)
-	return "s390";
 #elif defined(__arm__)
 	return "arm";
 #elif defined(__aarch64__)
@@ -12113,8 +12111,6 @@ static const char *arch_specific_lib_paths(void)
 	return "/lib/i386-linux-gnu";
 #elif defined(__s390x__)
 	return "/lib/s390x-linux-gnu";
-#elif defined(__s390__)
-	return "/lib/s390-linux-gnu";
 #elif defined(__arm__) && defined(__SOFTFP__)
 	return "/lib/arm-linux-gnueabi";
 #elif defined(__arm__) && !defined(__SOFTFP__)
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index c174b4086673..d1524f6f54ae 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -1376,8 +1376,6 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
 
 #elif defined(__s390x__)
 
-/* Do not support __s390__ for now, since user_pt_regs is broken with -m31. */
-
 static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec *arg, int *arg_sz)
 {
 	unsigned int reg;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4f2a6e10ed5c..611f807ff8b8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -445,7 +445,7 @@ static int write_cpudesc(struct feat_fd *ff,
 {
 #if defined(__powerpc__) || defined(__hppa__) || defined(__sparc__)
 #define CPUINFO_PROC	{ "cpu", }
-#elif defined(__s390__)
+#elif defined(__s390x__)
 #define CPUINFO_PROC	{ "vendor_id", }
 #elif defined(__sh__)
 #define CPUINFO_PROC	{ "cpu type", }
diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
index 1fcfa5160231..2389ab0f9e48 100644
--- a/tools/testing/selftests/bpf/sdt.h
+++ b/tools/testing/selftests/bpf/sdt.h
@@ -230,7 +230,7 @@ __extension__ extern unsigned long long __sdt_unsp;
 #endif
 
 /* The ia64 and s390 nop instructions take an argument. */
-#if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
+#if defined(__ia64__) || defined(__s390x__)
 #define _SDT_NOP	nop 0
 #else
 #define _SDT_NOP	nop
diff --git a/tools/testing/selftests/bpf/usdt.h b/tools/testing/selftests/bpf/usdt.h
index 549d1f774810..2a4b756c6c43 100644
--- a/tools/testing/selftests/bpf/usdt.h
+++ b/tools/testing/selftests/bpf/usdt.h
@@ -310,7 +310,7 @@ struct usdt_sema { volatile unsigned short active; };
 #endif /* USDT_ARG_CONSTRAINT */
 
 #ifndef USDT_NOP
-#if defined(__ia64__) || defined(__s390__) || defined(__s390x__)
+#if defined(__ia64__) || defined(__s390x__)
 #define USDT_NOP			nop 0
 #else
 #define USDT_NOP			nop
diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
index 4198248ef874..2a4549c30540 100644
--- a/tools/testing/selftests/ptrace/set_syscall_info.c
+++ b/tools/testing/selftests/ptrace/set_syscall_info.c
@@ -72,7 +72,7 @@ check_psi_entry(struct __test_metadata *_metadata,
 {
 	unsigned int i;
 	int exp_nr = exp_entry->nr;
-#if defined __s390__ || defined __s390x__
+#ifdef __s390x__
 	/* s390 is the only architecture that has 16-bit syscall numbers */
 	exp_nr &= 0xffff;
 #endif
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 05d03e679e06..ce62684bc178 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -90,7 +90,7 @@ unsigned int yield_mod_cnt, nr_abort;
 	"jnz 222b\n\t" \
 	"333:\n\t"
 
-#elif defined(__s390__)
+#elif defined(__s390x__)
 
 #define RSEQ_INJECT_INPUT \
 	, [loop_cnt_1]"m"(loop_cnt[1]) \
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 33baaa9f9997..e7b858cd3736 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -28,8 +28,6 @@ do {									\
 	RSEQ_WRITE_ONCE(*(p), v);					\
 } while (0)
 
-#ifdef __s390x__
-
 #define LONG_L			"lg"
 #define LONG_S			"stg"
 #define LONG_LT_R		"ltgr"
@@ -63,43 +61,6 @@ do {									\
 		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
 		".popsection\n\t"
 
-#elif __s390__
-
-#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
-				start_ip, post_commit_offset, abort_ip)	\
-		".pushsection __rseq_cs, \"aw\"\n\t"			\
-		".balign 32\n\t"					\
-		__rseq_str(label) ":\n\t"				\
-		".long " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
-		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
-		".popsection\n\t"					\
-		".pushsection __rseq_cs_ptr_array, \"aw\"\n\t"		\
-		".long 0x0, " __rseq_str(label) "b\n\t"			\
-		".popsection\n\t"
-
-/*
- * Exit points of a rseq critical section consist of all instructions outside
- * of the critical section where a critical section can either branch to or
- * reach through the normal course of its execution. The abort IP and the
- * post-commit IP are already part of the __rseq_cs section and should not be
- * explicitly defined as additional exit points. Knowing all exit points is
- * useful to assist debuggers stepping over the critical section.
- */
-#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
-		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
-		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n\t" \
-		".popsection\n\t"
-
-#define LONG_L			"l"
-#define LONG_S			"st"
-#define LONG_LT_R		"ltr"
-#define LONG_CMP		"c"
-#define LONG_CMP_R		"cr"
-#define LONG_ADDI		"ahi"
-#define LONG_ADD_R		"ar"
-
-#endif
-
 #define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip) \
 	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
 				(post_commit_ip - start_ip), abort_ip)
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index f51a5fdb0444..342ac4957208 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -125,7 +125,7 @@ static inline struct rseq_abi *rseq_get_abi(void)
 #include <rseq-ppc.h>
 #elif defined(__mips__)
 #include <rseq-mips.h>
-#elif defined(__s390__)
+#elif defined(__s390x__)
 #include <rseq-s390.h>
 #elif defined(__riscv)
 #include <rseq-riscv.h>
diff --git a/tools/testing/selftests/rseq/syscall_errors_test.c b/tools/testing/selftests/rseq/syscall_errors_test.c
index a5d9e1f8a2dc..9c00ea750e07 100644
--- a/tools/testing/selftests/rseq/syscall_errors_test.c
+++ b/tools/testing/selftests/rseq/syscall_errors_test.c
@@ -59,7 +59,7 @@ int main(void)
 		goto error;
 
 
-#if defined(__LP64__) && (!defined(__s390__) && !defined(__s390x__))
+#if defined(__LP64__) && !defined(__s390x__)
 	/*
 	 * We haven't found a reliable way to find an invalid address when
 	 * running a 32bit userspace on a 64bit kernel, so only run this test
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 874f17763536..07bdf8580818 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -150,7 +150,7 @@ struct seccomp_data {
 #  define __NR_seccomp 338
 # elif defined(__powerpc__)
 #  define __NR_seccomp 358
-# elif defined(__s390__)
+# elif defined(__s390x__)
 #  define __NR_seccomp 348
 # elif defined(__xtensa__)
 #  define __NR_seccomp 337
@@ -1822,7 +1822,7 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 		}						\
 	} while (0)
 # define SYSCALL_RET_SET_ON_PTRACE_EXIT
-#elif defined(__s390__)
+#elif defined(__s390x__)
 # define ARCH_REGS		s390_regs
 # define SYSCALL_NUM(_regs)	(_regs).gprs[2]
 # define SYSCALL_RET_SET(_regs, _val)			\
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 5fdd0f362337..50c261005111 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -25,10 +25,6 @@
 #define VDSO_VERSION		1
 #define VDSO_NAMES		0
 #define VDSO_32BIT		1
-#elif defined (__s390__) && !defined(__s390x__)
-#define VDSO_VERSION		2
-#define VDSO_NAMES		0
-#define VDSO_32BIT		1
 #elif defined (__s390x__)
 #define VDSO_VERSION		2
 #define VDSO_NAMES		0
-- 
2.48.1

