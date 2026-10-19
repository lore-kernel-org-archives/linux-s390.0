Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43464848AC;
	Mon, 19 Oct 2026 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408372; cv=none; b=gLW4obSriLVu0u9+wCrbh7aimgCSdeRl8Aq4YzKrXHLAaqa5UJQx+RP4wfIcCWcGMSBcNm2Vq5bU5qqE++LcrqwcIK3fGNA38kAsHY301xNvKnCQTMCozuDor7hN8q6YahcezRzGiQNgmENMKZoBgzFd3lDkhAyd0sKLBVlADxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408372; c=relaxed/simple;
	bh=O1JWBpYk8YogZUARYB9r+14Uz5nRUzSkE4Fr4XK8sIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HO/JiQOLfiZeHzwXIuBglDaAS7/gMkdKG5uWefIiiGk/FKr4qJn8dxJyggDUsJ7Wt85TnZqvzuJtojAuqeiklsNGHE5+FERIoRg1p0ij13eRZ2A7FjtLXZhZ9bYZgGYBSO0sdsqyl8zGjMRbCiV43YWQ0mZ8zqR1k/pbYIg0lX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePulf6/v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePulf6/v"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8iL1J1638254;
	Mon, 19 Oct 2026 11:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6ga2Xgqjl1blPP1ifmaPL+pUFA0Sro2xIt8yDTm5g
	zo=; b=ePulf6/v5pr5hMMlhc9nh/8DpKso08bffBVyou5a4ThDao7ghWfZVxfkk
	5eC5HBWePuxRBMcUADfh1tGF9YvTtgnS1TGRnc9L6rJu5TvL6VXZFZOkWDp8mERA
	Y785XX80UtqDH+kGIiShyus/Ji0KGWhxOKrb31ia+kL70PDhbfbrdKd0I7dxsPMD
	YjosGBpbfFalkQt92zEUBUXVi+/1bF8HlP6LpUP2WZoq6UmyDgflVNZTmn/znhpI
	CTd/eNZSBDjgjVzQ5xZ4TNYsxu+0akQ397dX3oWJh7j2BqdVBFLw2EQQUA4YkQfs
	YHZ6jANN/9UWpMUOL6B69D1k638qQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0ptjtcu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 11:12:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8YxUf2651693;
	Mon, 19 Oct 2026 11:12:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgw7uc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 11:12:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JBCYnb44695930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 11:12:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46BCC2004F;
	Mon, 19 Oct 2026 11:12:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 148A22004D;
	Mon, 19 Oct 2026 11:12:34 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 11:12:34 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/vdso: Implement __vdso_futex_robust_try_unlock()
Date: Mon, 19 Oct 2026 13:12:33 +0200
Message-ID: <20261019111233.3372751-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX1qfpWt1SWIaD
 0ukTgtWGCLOqAcBVt3avT5UgNSnlEB+fZUzi5Evs1T2zI1VVLrvx43USIa9P7GGA9dmes6VzKfJ
 8OQpyJK9gzhQmSmW0MKFQOrD5V32M+JGJXXreuhl/3MeB+L0qRQItzC8d24eJztadITvVrq3DiF
 NTpAioUmALLA831RDjK3XoOq62kySUGlT8xUPVRkIRbDEKQULE5ke1CUzMibNBrV/LOC0LvJtzy
 nIGdRmD+dGn5lot9V+XhevZo3V+M2SGknloAOxQbLIVDPAzskwJ5Cur7gYF4x6I/Oymql0PXled
 zZg25oMnqXBWnOjdvugAQEHC0EO2EwWd82ljaS3KGo3+WKS3kcIg0zq8LrK2socOfpkppjx9q3K
 zZ0Hh9L2tRuXep+T8HfgjEwZii6lY9A0LDWm7QZyZe5BIOHecwOH5r0U/6cbQXDda+ZN6RMBYJ1
 iqjr1TzLV5qNv4VlOzQ==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad5fb26 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=DT4mEA_OMg2hjvYhghQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX+mO3Wc6VhF72
 BrTFGxlG3gB3T256Xn9SiHTGWBgzTdXyu5oj+1Ot9cJPckaj6ScmkIShKPrVJuNTKJEOBmEyXkP
 sB8k7o2zHHfo8vM+uva4vgj0X1pUPQQ=
X-Proofpoint-GUID: jxfyg7o11sDbJXjoBKLFF1ghgOT6Xm6n
X-Proofpoint-ORIG-GUID: jxfyg7o11sDbJXjoBKLFF1ghgOT6Xm6n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190042

Provide the s390 backend for the FUTEX_ROBUST_UNLOCK fix that was
introduced for x86 with commit a2274cc0091e ("x86/vdso: Implement
__vdso_futex_robust_try_unlock()"). See that commit for details.

Note that the Fixes tag does not mean that the x86 commit is broken,
it is only helpful for backporting purposes, so required prerequisite
code is present if this commit is backported.

Cc: stable@vger.kernel.org # 7.2
Fixes: a2274cc0091e ("x86/vdso: Implement __vdso_futex_robust_try_unlock()")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---

Notes:
    This passes all robust_list selftests in
    tools/testing/selftests/futex/functional, except those listed below.
    
    wake32, wake_bitset32, unlock_pi32 fail, which seems to be kind of
    expected, since those selftests set FUTEX_ROBUST_LIST32, which doesn't seem
    to make too much sense for a 64 bit kernel without COMPAT support, since
    futex_robust_list_clear_pending() contains this:
    
            if (IS_ENABLED(CONFIG_64BIT) && size32bit)
                    return compat_robust_list_clear_pending(pop);
    
    which means that compat_robust_list_clear_pending() is guaranteed to do
    nothing except returning false for !COMPAT. Therefore this looks like a
    test case bug to me, but I could be entirely wrong.

 arch/s390/Kconfig                         |  1 +
 arch/s390/include/asm/futex_robust.h      | 25 +++++++++++++++++++++++
 arch/s390/kernel/vdso.c                   | 20 +++++++++++++++++-
 arch/s390/kernel/vdso/Makefile            |  7 ++++---
 arch/s390/kernel/vdso/gen_vdso_offsets.sh |  3 ++-
 arch/s390/kernel/vdso/vdso.lds.S          |  3 +++
 arch/s390/kernel/vdso/vfutex.S            | 22 ++++++++++++++++++++
 7 files changed, 76 insertions(+), 5 deletions(-)
 create mode 100644 arch/s390/include/asm/futex_robust.h
 create mode 100644 arch/s390/kernel/vdso/vfutex.S

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4b51bc6e8948..a58b541e06e7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -213,6 +213,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FUTEX_ROBUST_UNLOCK
 	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
diff --git a/arch/s390/include/asm/futex_robust.h b/arch/s390/include/asm/futex_robust.h
new file mode 100644
index 000000000000..6a5fb2506192
--- /dev/null
+++ b/arch/s390/include/asm/futex_robust.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_FUTEX_ROBUST_H
+#define _ASM_S390_FUTEX_ROBUST_H
+
+#include <asm/ptrace.h>
+
+#define VDSO_FUTEX_ROBUST_POP_GPR	4
+
+static __always_inline void __user *s390_futex_robust_unlock_get_pop(struct pt_regs *regs)
+{
+	/*
+	 * Within critical section of
+	 * __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
+	 *
+	 * If condition code is 0, cmpxchg succeeded, and the pending
+	 * op pointer in gpr4 needs to be returned for clearing.
+	 */
+	if (psw_bits(regs->psw).cc != 0)
+		return NULL;
+	return (void __user *)regs->gprs[VDSO_FUTEX_ROBUST_POP_GPR];
+}
+
+#define arch_futex_robust_unlock_get_pop(regs)	s390_futex_robust_unlock_get_pop(regs)
+
+#endif /* _ASM_S390_FUTEX_ROBUST_H */
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 0fe616c49fcc..efe492364a93 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -12,22 +12,39 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/futex.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/random.h>
 #include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
-#include <asm/vdso/vsyscall.h>
 #include <asm/alternative.h>
+#include <asm/vdso/vsyscall.h>
+#include <asm/vdso-symbols.h>
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
 
+static inline void vdso_futex_robust_unlock_update_ips(void)
+{
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+	unsigned long vdso = current->mm->context.vdso_base;
+	struct futex_mm_data *fd = &current->mm->futex;
+
+	futex_reset_cs_ranges(fd);
+	futex_set_vdso_cs_range(fd, 0,
+				vdso + vdso_offset___futex_list64_try_unlock_cs_start,
+				vdso + vdso_offset___futex_list64_try_unlock_cs_end,
+				false);
+#endif
+}
+
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *vma)
 {
 	current->mm->context.vdso_base = vma->vm_start;
+	vdso_futex_robust_unlock_update_ips();
 	return 0;
 }
 
@@ -74,6 +91,7 @@ static int map_vdso(unsigned long addr, unsigned long vdso_mapping_len)
 		rc = PTR_ERR(vma);
 	} else {
 		current->mm->context.vdso_base = vdso_text_start;
+		vdso_futex_robust_unlock_update_ips();
 		rc = 0;
 	}
 out:
diff --git a/arch/s390/kernel/vdso/Makefile b/arch/s390/kernel/vdso/Makefile
index 54bcf2984ca1..35e4e3dd23c7 100644
--- a/arch/s390/kernel/vdso/Makefile
+++ b/arch/s390/kernel/vdso/Makefile
@@ -3,7 +3,8 @@
 
 # Include the generic Makefile to check the built vdso.
 include $(srctree)/lib/vdso/Makefile.include
-obj-vdso = vdso_user_wrapper.o note.o vgetrandom-chacha.o
+obj-vdso-y = vdso_user_wrapper.o note.o vgetrandom-chacha.o
+obj-vdso-$(CONFIG_FUTEX_ROBUST_UNLOCK) += vfutex.o
 obj-cvdso = vdso_generic.o getcpu.o vgetrandom.o
 VDSO_CFLAGS_REMOVE := -pg $(CC_FLAGS_FTRACE) $(CC_FLAGS_EXPOLINE)
 CFLAGS_REMOVE_getcpu.o = $(VDSO_CFLAGS_REMOVE)
@@ -16,8 +17,8 @@ endif
 
 # Build rules
 
-targets := $(obj-vdso) $(obj-cvdso) vdso.so vdso.so.dbg
-obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
+targets := $(obj-vdso-y) $(obj-cvdso) vdso.so vdso.so.dbg
+obj-vdso := $(addprefix $(obj)/, $(obj-vdso-y))
 obj-cvdso := $(addprefix $(obj)/, $(obj-cvdso))
 
 KBUILD_AFLAGS_VDSO := $(KBUILD_AFLAGS) -DBUILD_VDSO
diff --git a/arch/s390/kernel/vdso/gen_vdso_offsets.sh b/arch/s390/kernel/vdso/gen_vdso_offsets.sh
index 359982fb002d..4039e6cfca51 100755
--- a/arch/s390/kernel/vdso/gen_vdso_offsets.sh
+++ b/arch/s390/kernel/vdso/gen_vdso_offsets.sh
@@ -12,4 +12,5 @@
 #
 
 LC_ALL=C
-sed -n 's/\([0-9a-f]*\) . __kernel_\(.*\)/\#define vdso_offset_\2\t0x\1/p'
+sed -n -e 's/\([0-9a-f]*\) . __kernel_\(.*\)/\#define vdso_offset_\2\t0x\1/p' \
+       -e 's/\([0-9a-f]*\) . \(__futex_.*\)/\#define vdso_offset_\2\t0x\1/p'
diff --git a/arch/s390/kernel/vdso/vdso.lds.S b/arch/s390/kernel/vdso/vdso.lds.S
index 841daeec4be2..10ea5e8fc43f 100644
--- a/arch/s390/kernel/vdso/vdso.lds.S
+++ b/arch/s390/kernel/vdso/vdso.lds.S
@@ -111,6 +111,9 @@ VERSION
 		__kernel_rt_sigreturn;
 		__kernel_sigreturn;
 		__kernel_getrandom;
+#ifdef CONFIG_FUTEX_ROBUST_UNLOCK
+		__vdso_futex_robust_list64_try_unlock;
+#endif
 	local: *;
 	};
 }
diff --git a/arch/s390/kernel/vdso/vfutex.S b/arch/s390/kernel/vdso/vfutex.S
new file mode 100644
index 000000000000..8a25bd4ecea4
--- /dev/null
+++ b/arch/s390/kernel/vdso/vfutex.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/linkage.h>
+#include <asm/dwarf.h>
+
+/*
+ * __u32 __vdso_futex_robust_list64_try_unlock(__u32 *lock, __u32 tid, __u64 *pop)
+ *
+ * Returns tid on success, or lock value on failure.
+ */
+SYM_FUNC_START(__vdso_futex_robust_list64_try_unlock)
+	CFI_STARTPROC
+	lghi	%r1,0
+	cs	%r3,%r1,0(%r2)
+__futex_list64_try_unlock_cs_start:
+	jnz	__futex_list64_try_unlock_cs_end
+__futex_list64_try_unlock_cs_success:
+	mvghi	0(%r4),0
+__futex_list64_try_unlock_cs_end:
+	llgfr	%r2,%r3
+	br	%r14
+	CFI_ENDPROC
+SYM_FUNC_END(__vdso_futex_robust_list64_try_unlock)
-- 
2.53.0

