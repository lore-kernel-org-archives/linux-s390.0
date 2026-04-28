Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA343FB7D3;
	Tue, 28 Apr 2026 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392665; cv=none; b=lhBl3r6HRbzoNdiIUJMPM3Anmlx6vV9Oiw2HMdRhgA8Q7Pfv9Ez/twd7hPaT610MwLO7atOy2HbFA9iKsjGeUVxkdwElj9fRzfDvxxtd7p+DAJnKPJi9wM8tqTNyTC1IfCHZxOGFQ5hqHInP5ggRKmQnmLRmLKFc5fY5qVxs0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392665; c=relaxed/simple;
	bh=valQeZmi9TlaWS4LW5o3vQs57r5hh5keNcIAJuXbgHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhH24upx6pb/m/005VIln4c3GdogXfQl+SAHBJHmFoti775sZAXmnt1zH8MKIa+vv44UYH78i141sWoWD0ZzLzTA2gAV7gqNFZskXDfI7ekE818+IDEx1WKSAdPH/Fm9iwT/GQsIFLMJ4jeCM9U+DnXqrsmLqm43zyR99RzjRv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AKqJq5c/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AKqJq5c/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SE5m1g1914783;
	Tue, 28 Apr 2026 16:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NTbX9GOqG2HNl5sGM
	38yfCy6wy2ZOmobod/vveKpCXM=; b=AKqJq5c/Vw8pRF6DI55mIOLAFbN1UWZha
	uaB+m8iZ1Wav2hXRvftKsedcHlZmc/6PvnrlPqXhbiiP63BnLzsUSspsBx7Bp0Yg
	dm6qxLd1N4roJgl/Cc5LMMzvIUJZK5s12XwJYjFS/1ILlvdgXBt3AvWWyMeUZWz5
	gOG5VuoNQNKIERQCnVCNDR035/ynbkQs6wobo4drv9AYTotPH6KpROu8Lf8CyMHC
	6pHbQz1XEAs2Tvx2x5IvZaPm1MrB4YaXdtKi0Ab2n39kOrLQ29ndBvBEIU/fBirj
	+dECqE5JMWx6GswMpKeKDoukJzPhrdf3dAHH7Kxs6cFksyzC0pCLQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb56dp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrpoe027791;
	Tue, 28 Apr 2026 16:05:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamya6gj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5U4149742090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A865220040;
	Tue, 28 Apr 2026 16:05:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58DDA20043;
	Tue, 28 Apr 2026 16:05:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH v2 08/28] arm64: Extract pstate definitions from ptrace
Date: Tue, 28 Apr 2026 18:05:05 +0200
Message-ID: <20260428160527.1378085-9-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f0dacf cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=i1ah5YvoNV5MJ1hGTMsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX+HdyIylBHofs
 25pS8NvVOb+KzXMtiI3kJRxJ06B7COV9AzBcEFWivHRlkREaOv0jzm2LVY+p0p7W+GVwNmHC+h+
 yYqW9PjRgfrA6mYko6w8LmMm/8HtUm2mtTmmfvg3sZpQysr1tjPMnDKk8S7c7LuurZ8dBuUTAad
 bI8NeF2bK/VsJvIbI95uxxdHf4hdFbT2lfGwFp3IgrCKbifZmVd7rsPSAuRYVOS3UeUY/bt3PRj
 1DG/IDi3jPMUEKaJJj0jfmUQmd4SxrCWG0uEWs1u61aKNyxOBIhWdaho7d7p1liLbdlaDzLVhqH
 dAtiXERUMKml9k2IxPyML7fmoxGNC/6tnzk6WWBoOY0kneFehDa9JaOyIbjF1bj3RGAueUUtTlA
 wf+xhutZLuymuIdEmDb2shuf+RlQiL+ZIqzCZu0HgsXdfXJbUrP1Ud81cWLZiTuh8niZOkAm9Pm
 4nt+PjYU49NKe7dbwHg==
X-Proofpoint-GUID: yBtJCv38qsp1UVl7onaYb_PVb066TTJy
X-Proofpoint-ORIG-GUID: yBtJCv38qsp1UVl7onaYb_PVb066TTJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280151

From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Split all definitions that can be used by non-native architectures into a
separate file pstate.h. This allows other architectures using
the pstate definitions. While at it refactor SPSR related definitions
to use the BIT(n) macro and move them into sysreg-defs.h

Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/ptrace.h               | 34 +-----------
 arch/arm64/include/asm/sysreg-defs.h          | 42 +++++++++++++++
 arch/arm64/include/uapi/asm/pstate.h          | 53 +++++++++++++++++++
 arch/arm64/include/uapi/asm/ptrace.h          | 49 +----------------
 .../s390/include/uapi/arch/arm64/asm/pstate.h |  1 +
 include/arch/arm64/asm/pstate.h               | 46 ++++++++++++++++
 6 files changed, 144 insertions(+), 81 deletions(-)
 create mode 100644 arch/arm64/include/uapi/asm/pstate.h
 create mode 120000 arch/s390/include/uapi/arch/arm64/asm/pstate.h
 create mode 100644 include/arch/arm64/asm/pstate.h

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 39582511ad72..72ea0a8af960 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -9,6 +9,7 @@
 #define __ASM_PTRACE_H
 
 #include <asm/cpufeature.h>
+#include <asm/pstate.h>
 
 #include <uapi/asm/ptrace.h>
 
@@ -28,10 +29,6 @@
 
 #define GIC_PRIO_PSR_I_SET	GICV3_PRIO_PSR_I_SET
 
-/* Additional SPSR bits not exposed in the UABI */
-#define PSR_MODE_THREAD_BIT	(1 << 0)
-#define PSR_IL_BIT		(1 << 20)
-
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
 #define COMPAT_PTRACE_SETREGS		13
@@ -42,41 +39,12 @@
 #define COMPAT_PTRACE_GETHBPREGS	29
 #define COMPAT_PTRACE_SETHBPREGS	30
 
-/* SPSR_ELx bits for exceptions taken from AArch32 */
-#define PSR_AA32_MODE_MASK	0x0000001f
-#define PSR_AA32_MODE_USR	0x00000010
-#define PSR_AA32_MODE_FIQ	0x00000011
-#define PSR_AA32_MODE_IRQ	0x00000012
-#define PSR_AA32_MODE_SVC	0x00000013
-#define PSR_AA32_MODE_ABT	0x00000017
-#define PSR_AA32_MODE_HYP	0x0000001a
-#define PSR_AA32_MODE_UND	0x0000001b
-#define PSR_AA32_MODE_SYS	0x0000001f
-#define PSR_AA32_T_BIT		0x00000020
-#define PSR_AA32_F_BIT		0x00000040
-#define PSR_AA32_I_BIT		0x00000080
-#define PSR_AA32_A_BIT		0x00000100
-#define PSR_AA32_E_BIT		0x00000200
-#define PSR_AA32_PAN_BIT	0x00400000
-#define PSR_AA32_SSBS_BIT	0x00800000
-#define PSR_AA32_DIT_BIT	0x01000000
-#define PSR_AA32_Q_BIT		0x08000000
-#define PSR_AA32_V_BIT		0x10000000
-#define PSR_AA32_C_BIT		0x20000000
-#define PSR_AA32_Z_BIT		0x40000000
-#define PSR_AA32_N_BIT		0x80000000
-#define PSR_AA32_IT_MASK	0x0600fc00	/* If-Then execution state mask */
-#define PSR_AA32_GE_MASK	0x000f0000
-
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define PSR_AA32_ENDSTATE	PSR_AA32_E_BIT
 #else
 #define PSR_AA32_ENDSTATE	0
 #endif
 
-/* AArch32 CPSR bits, as seen in AArch32 */
-#define COMPAT_PSR_DIT_BIT	0x00200000
-
 /*
  * These are 'magic' values for PTRACE_PEEKUSR that return info about where a
  * process is located in memory.
diff --git a/arch/arm64/include/asm/sysreg-defs.h b/arch/arm64/include/asm/sysreg-defs.h
index 42cbf4e66507..08185c8b2f63 100644
--- a/arch/arm64/include/asm/sysreg-defs.h
+++ b/arch/arm64/include/asm/sysreg-defs.h
@@ -468,6 +468,48 @@
 #define SYS_FPEXC32_EL2			sys_reg(3, 4, 5, 3, 0)
 #define SYS_TFSR_EL2			sys_reg(3, 4, 5, 6, 0)
 
+#define SPSR_PPEND			BIT(33)
+#define SPSR_N				BIT(31)
+#define SPSR_Z				BIT(30)
+#define SPSR_C				BIT(29)
+#define SPSR_V				BIT(28)
+#define SPSR32_Q			BIT(27)
+#define SPSR32_IT_MASK			(GENMASK(26, 25) | GENMASK(15, 10))
+#define SPSR64_TCO			BIT(25)
+#define SPSR_DIT			BIT(24)
+#define SPSR64_UAO			BIT(23)
+#define SPSR32_SSBS			BIT(23)
+#define SPSR_PAN			BIT(22)
+#define SPSR_SS				BIT(21)
+#define SPSR_IL				BIT(20)
+#define SPSR32_GE_MASK			GENMASK(19, 16)
+#define SPSR64_SSBS			BIT(12)
+#define SPSR64_BTYPE_SHIFT		10
+#define SPSR64_BTYPE_MASK		(UL(3) << SPSR64_BTYPE_SHIFT)
+#define SPSR64_D			BIT(9)
+#define SPSR32_E			BIT(9)
+#define SPSR_A				BIT(8)
+#define SPSR_I				BIT(7)
+#define SPSR_F				BIT(6)
+#define SPSR32_T			BIT(5)
+#define SPSR_MODE_MASK			UL(0x1f)
+#define SPSR_MODE_32BIT			BIT(4)
+#define SPSR64_MODE_EL0			UL(0x0)
+#define SPSR64_MODE_EL1t		UL(0x4)
+#define SPSR64_MODE_EL1h		UL(0x5)
+#define SPSR64_MODE_EL2t		UL(0x8)
+#define SPSR64_MODE_EL2h		UL(0x9)
+#define SPSR64_MODE_EL3t		UL(0xc)
+#define SPSR64_MODE_EL3h		UL(0xd)
+#define SPSR32_MODE_USR			UL(0x0)
+#define SPSR32_MODE_FIQ			UL(0x1)
+#define SPSR32_MODE_IRQ			UL(0x2)
+#define SPSR32_MODE_SVC			UL(0x3)
+#define SPSR32_MODE_ABT			UL(0x7)
+#define SPSR32_MODE_HYP			UL(0xa)
+#define SPSR32_MODE_UND			UL(0xb)
+#define SPSR32_MODE_SYS			UL(0xf)
+
 #define SYS_FAR_EL2			sys_reg(3, 4, 6, 0, 0)
 #define SYS_HPFAR_EL2			sys_reg(3, 4, 6, 0, 4)
 
diff --git a/arch/arm64/include/uapi/asm/pstate.h b/arch/arm64/include/uapi/asm/pstate.h
new file mode 100644
index 000000000000..87b2acec9ac2
--- /dev/null
+++ b/arch/arm64/include/uapi/asm/pstate.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI__ASM_PSTATE_H
+#define _UAPI__ASM_PSTATE_H
+
+/*
+ * PSR bits
+ */
+#define PSR_MODE_EL0t  0x00000000
+#define PSR_MODE_EL1t  0x00000004
+#define PSR_MODE_EL1h  0x00000005
+#define PSR_MODE_EL2t  0x00000008
+#define PSR_MODE_EL2h  0x00000009
+#define PSR_MODE_EL3t  0x0000000c
+#define PSR_MODE_EL3h  0x0000000d
+#define PSR_MODE_MASK  0x0000000f
+
+/* AArch32 CPSR bits */
+#define PSR_MODE32_BIT         0x00000010
+
+/* AArch64 SPSR bits */
+#define PSR_F_BIT      0x00000040
+#define PSR_I_BIT      0x00000080
+#define PSR_A_BIT      0x00000100
+#define PSR_D_BIT      0x00000200
+#define PSR_BTYPE_MASK 0x00000c00
+#define PSR_SSBS_BIT   0x00001000
+#define PSR_PAN_BIT    0x00400000
+#define PSR_UAO_BIT    0x00800000
+#define PSR_DIT_BIT    0x01000000
+#define PSR_TCO_BIT    0x02000000
+#define PSR_V_BIT      0x10000000
+#define PSR_C_BIT      0x20000000
+#define PSR_Z_BIT      0x40000000
+#define PSR_N_BIT      0x80000000
+
+#define PSR_BTYPE_SHIFT                10
+
+/*
+ * Groups of PSR bits
+ */
+#define PSR_f          0xff000000      /* Flags                */
+#define PSR_s          0x00ff0000      /* Status               */
+#define PSR_x          0x0000ff00      /* Extension            */
+#define PSR_c          0x000000ff      /* Control              */
+
+/* Convenience names for the values of PSTATE.BTYPE */
+#define PSR_BTYPE_NONE         (0b00 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_JC           (0b01 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_C            (0b10 << PSR_BTYPE_SHIFT)
+#define PSR_BTYPE_J            (0b11 << PSR_BTYPE_SHIFT)
+
+#endif /* _UAPI__ASM_PSTATE_H */
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 6fed93fb2536..6e743eb021e8 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -24,54 +24,7 @@
 
 #include <asm/hwcap.h>
 #include <asm/sve_context.h>
-
-
-/*
- * PSR bits
- */
-#define PSR_MODE_EL0t	0x00000000
-#define PSR_MODE_EL1t	0x00000004
-#define PSR_MODE_EL1h	0x00000005
-#define PSR_MODE_EL2t	0x00000008
-#define PSR_MODE_EL2h	0x00000009
-#define PSR_MODE_EL3t	0x0000000c
-#define PSR_MODE_EL3h	0x0000000d
-#define PSR_MODE_MASK	0x0000000f
-
-/* AArch32 CPSR bits */
-#define PSR_MODE32_BIT		0x00000010
-
-/* AArch64 SPSR bits */
-#define PSR_F_BIT	0x00000040
-#define PSR_I_BIT	0x00000080
-#define PSR_A_BIT	0x00000100
-#define PSR_D_BIT	0x00000200
-#define PSR_BTYPE_MASK	0x00000c00
-#define PSR_SSBS_BIT	0x00001000
-#define PSR_PAN_BIT	0x00400000
-#define PSR_UAO_BIT	0x00800000
-#define PSR_DIT_BIT	0x01000000
-#define PSR_TCO_BIT	0x02000000
-#define PSR_V_BIT	0x10000000
-#define PSR_C_BIT	0x20000000
-#define PSR_Z_BIT	0x40000000
-#define PSR_N_BIT	0x80000000
-
-#define PSR_BTYPE_SHIFT		10
-
-/*
- * Groups of PSR bits
- */
-#define PSR_f		0xff000000	/* Flags		*/
-#define PSR_s		0x00ff0000	/* Status		*/
-#define PSR_x		0x0000ff00	/* Extension		*/
-#define PSR_c		0x000000ff	/* Control		*/
-
-/* Convenience names for the values of PSTATE.BTYPE */
-#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
-#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
-#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
-#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)
+#include <asm/pstate.h>
 
 /* syscall emulation path in ptrace */
 #define PTRACE_SYSEMU		  31
diff --git a/arch/s390/include/uapi/arch/arm64/asm/pstate.h b/arch/s390/include/uapi/arch/arm64/asm/pstate.h
new file mode 120000
index 000000000000..00d9bed36982
--- /dev/null
+++ b/arch/s390/include/uapi/arch/arm64/asm/pstate.h
@@ -0,0 +1 @@
+../../../../../../arm64/include/uapi/asm/pstate.h
\ No newline at end of file
diff --git a/include/arch/arm64/asm/pstate.h b/include/arch/arm64/asm/pstate.h
new file mode 100644
index 000000000000..5a576ad94064
--- /dev/null
+++ b/include/arch/arm64/asm/pstate.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ARM64_ASM_PSTATE_H
+#define __ARM64_ASM_PSTATE_H
+
+#include <asm/sysreg-defs.h>
+#ifdef __aarch64__
+#include <uapi/asm/pstate.h>
+#else
+#include <uapi/arch/arm64/asm/pstate.h>
+#endif /* __aarch64__ */
+
+/* Additional SPSR bits not exposed in the UABI */
+#define PSR_MODE_THREAD_BIT	BIT(0)
+#define PSR_IL_BIT		SPSR_IL
+
+/* SPSR_ELx bits for exceptions taken from AArch32 */
+#define PSR_AA32_MODE_MASK	SPSR_MODE_MASK
+#define PSR_AA32_MODE_USR	(SPSR_MODE_32BIT | SPSR32_MODE_USR)
+#define PSR_AA32_MODE_FIQ	(SPSR_MODE_32BIT | SPSR32_MODE_FIQ)
+#define PSR_AA32_MODE_IRQ	(SPSR_MODE_32BIT | SPSR32_MODE_IRQ)
+#define PSR_AA32_MODE_SVC	(SPSR_MODE_32BIT | SPSR32_MODE_SVC)
+#define PSR_AA32_MODE_ABT	(SPSR_MODE_32BIT | SPSR32_MODE_ABT)
+#define PSR_AA32_MODE_HYP	(SPSR_MODE_32BIT | SPSR32_MODE_HYP)
+#define PSR_AA32_MODE_UND	(SPSR_MODE_32BIT | SPSR32_MODE_UND)
+#define PSR_AA32_MODE_SYS	(SPSR_MODE_32BIT | SPSR32_MODE_SYS)
+#define PSR_AA32_T_BIT		SPSR32_T
+#define PSR_AA32_F_BIT		SPSR_F
+#define PSR_AA32_I_BIT		SPSR_I
+#define PSR_AA32_A_BIT		SPSR_A
+#define PSR_AA32_E_BIT		SPSR32_E
+#define PSR_AA32_PAN_BIT	SPSR_PAN
+#define PSR_AA32_SSBS_BIT	SPSR32_SSBS
+#define PSR_AA32_DIT_BIT	SPSR_DIT
+#define PSR_AA32_Q_BIT		SPSR32_Q
+#define PSR_AA32_V_BIT		SPSR_V
+#define PSR_AA32_C_BIT		SPSR_C
+#define PSR_AA32_Z_BIT		SPSR_Z
+#define PSR_AA32_N_BIT		SPSR_N
+#define PSR_AA32_IT_MASK	SPSR32_IT_MASK	/* If-Then execution state mask */
+#define PSR_AA32_GE_MASK	SPSR32_GE_MASK
+
+/* AArch32 CPSR bits, as seen in AArch32 */
+#define COMPAT_PSR_DIT_BIT	0x00200000
+
+#endif /* __ARM64_ASM_PSTATE_H */
-- 
2.51.0

