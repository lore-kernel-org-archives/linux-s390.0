Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB662F49E5;
	Thu, 13 Nov 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046485; cv=none; b=STkXviCuKPJBMdPWmMJmZz9bVt8jXazMPaxXFF3ytFqG80D1c0dvgIPbLDMo+8hmhni/IDZ7dX4Az3HQXD53fdKDzYHUric/BOoY4v16x2w4OBOE3p4Vm2MPdppQYSEpAQ2sdfbZ9XjgE8Xegcmof37ZSut2GvqLh/zTB8YxDgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046485; c=relaxed/simple;
	bh=EmnZUQMXPvvLXEaViUaUWkd6yasrY+AJO0goBZt69Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS9inekSBXkAh847zHaz8TnPVJujtRFzSgVUvqGXwkcjnCMW4952ySo1xdIsfzpgAWSesWXXDloWuEU9yhaPFosNbC0Ph+WGzMBZJK68Sn35sF93vwKWTIZCCFHKHMYNOcTOchk0bL2LdNMZzvjCar+K19m8YvLF9oQLb3ZWFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NRRxOKcO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NRRxOKcO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADAg128006025;
	Thu, 13 Nov 2025 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fiUXXwvpsL5+PmQHA
	BAa8DDCwiE/hMEunK/2CeOouGE=; b=NRRxOKcOQBxLwFxFZDbCmZ86oVJ9wA10q
	EwGtlVT8RaIrzZvCr2htMJH37+ODSGlKvzkmR96Ba/f5q0yWLFgisXPXRkl4Zscg
	86tg7278SEJcwL6VrquNvl/LfVl0uxHeAbCHlYj7IxKx6yrzHEuNOy6mdZ2mBgXx
	OVwqXHGo/4xhCW43a2ZaebUHOR8jJmtvUPRB5sfasquB+zoHoy+zpMSEeObbfgEq
	mv/Le4xTf+2xJh8/iHv+xZjZgJHcV8yI5BmJRimB7764Z61yAztZiK4owwPUi6WI
	bOC90moBzBbqMGn/FaQXJycCchf/eekR9LCfnFTRe419HKv/yYNTg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgx6xh1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADCNiMH028893;
	Thu, 13 Nov 2025 15:07:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6spk9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 15:07:35 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ADF7WG518415982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 15:07:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F31620040;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B7D32004B;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Nov 2025 15:07:32 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andreas Krebbel <krebbel@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 4/8] tools: Remove s390 compat support
Date: Thu, 13 Nov 2025 16:07:26 +0100
Message-ID: <20251113150731.2697279-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251113150731.2697279-1-hca@linux.ibm.com>
References: <20251113150731.2697279-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aSJbLrM77rEZjxeNN7pisFRnnJ5z1o-N
X-Proofpoint-ORIG-GUID: aSJbLrM77rEZjxeNN7pisFRnnJ5z1o-N
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=6915f438 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=wjpo42Z0vvsa8VvJu9AA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfX5JfSHHNGlVc3
 LircE5SS1ySEJOKgPgq2hzdCF8Nlay+ZjaXO+PVqvQxcMObEW8cnTd/SJh7NxaiwBs2MgX3hi9T
 rZMCJvls9/OBNTCeVoRI5NVTU+qyCZcdYNNBccoknNe3IT+slKTYUF7FAkyKnWfJoio1X6Eghdd
 xLKSjQkbggtDkGh/UtavFi9DVvGE4Rujqw6c1dEr49St5+PHxyDtHufagaf9kLc/85XCF4BLOzM
 YFTPZYYLUUcjCB8+OgD41uis9AEJH/oJxljGRIAAs5ZMniYjVzvZ0uRzzR3xqjR34HUVhF3d++J
 V8IfEZPEKKYBLQsBp203uKBxo2EgNT6KbpaFnRb6gM13rwx3IKcevY+Mg46QVZ8RTTHjoD9C2rt
 +E/PO2xU4cG19wJAl2XFlnXoVFQV2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1011 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Remove s390 compat support from everything within tools, since s390 compat
support will be removed from the kernel.

While removing s390 compat code replace __s390__ ifdef guards with
__s390x__ everywhere. Even though this is not strictly required this
makes it easier to spot s390 compat code support leftovers.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 .../arch/s390/include/uapi/asm/bitsperlong.h  |  4 --
 tools/include/nolibc/arch-s390.h              |  5 ---
 tools/include/nolibc/arch.h                   |  2 +-
 tools/lib/bpf/libbpf.c                        |  4 --
 tools/lib/bpf/usdt.c                          |  2 -
 .../testing/selftests/nolibc/Makefile.nolibc  |  5 ---
 tools/testing/selftests/nolibc/run-tests.sh   |  6 +--
 tools/testing/selftests/rseq/rseq-s390.h      | 39 -------------------
 tools/testing/selftests/vDSO/vdso_config.h    |  4 --
 9 files changed, 2 insertions(+), 69 deletions(-)

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
diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 330e000baeb1..9416ae952e18 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -87,7 +87,6 @@ IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_riscv32    = arch/riscv/boot/Image
 IMAGE_riscv64    = arch/riscv/boot/Image
 IMAGE_s390x      = arch/s390/boot/bzImage
-IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE_sparc32    = arch/sparc/boot/image
 IMAGE_sparc64    = arch/sparc/boot/image
@@ -117,7 +116,6 @@ DEFCONFIG_riscv      = defconfig
 DEFCONFIG_riscv32    = rv32_defconfig
 DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_s390x      = defconfig
-DEFCONFIG_s390       = defconfig compat.config
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG_sparc32    = sparc32_defconfig
 DEFCONFIG_sparc64    = sparc64_defconfig
@@ -156,7 +154,6 @@ QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_riscv32    = riscv32
 QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_s390x      = s390x
-QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH_sparc32    = sparc
 QEMU_ARCH_sparc64    = sparc64
@@ -197,7 +194,6 @@ QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
 QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390x      = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_sparc32    = -M SS-5 -m 256M -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_sparc64    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -223,7 +219,6 @@ CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390x = -m64
-CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_mipsn32le = -EL -mabi=n32 -fPIC -march=mips64r2
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index e8af1fb505cf..210abe715ed9 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -23,7 +23,7 @@ all_archs=(
 	mips32le mips32be mipsn32le mipsn32be mips64le mips64be
 	ppc ppc64 ppc64le
 	riscv32 riscv64
-	s390x s390
+	s390x
 	loongarch
 	sparc32 sparc64
 	m68k
@@ -185,10 +185,6 @@ test_arch() {
 			exit 1
 	esac
 	printf '%-15s' "$arch:"
-	if [ "$arch" = "s390" ] && ([ "$llvm" = "1" ] || [ "$test_mode" = "user" ]); then
-		echo "Unsupported configuration"
-		return
-	fi
 	if [ "$arch" = "m68k" -o "$arch" = "sh4" ] && [ "$llvm" = "1" ]; then
 		echo "Unsupported configuration"
 		return
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

