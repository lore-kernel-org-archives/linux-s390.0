Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65350AC1A;
	Mon, 31 Aug 2026 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788188479; cv=none; b=hBdiegEleXti0k4LhN+LdeR3RMsphiimoxZrf756zLxnUyOumlbPV8Ei+hQFEFPcXOqa+tOaMIxyfghJ07XI0cnNs1Bmp2q127gkwz67M5m2QtMS4OeFRP0F9QTZ2YS33oJhq/DDL7zgS0EL+UNoEh5L9nRAywLxChBNrvDEZ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788188479; c=relaxed/simple;
	bh=D5QICxdKEvBkss8rSPCAKBsa821Z9WuNQeAoocjU6qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltaUEbxrCFqlTc8RkD95ryN+FG+MpgHzRfxg9tlZ6toJcMbRyvORRLWyGem5Wy3N6WpHN6B83CPxSOhDarnPAgTsvLYL8Znwm2AyOKIQqXOQAmx6XMCeO3Y7zRlx5aos9J5Q79d8j9gvnDhFwAZnXuIl7gxlduGmF5L8zpa5DFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hb932vJQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hb932vJQ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ3N12525453;
	Mon, 31 Aug 2026 14:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BjAiqClbOOjrSusIM
	tli7eOwWtEtUlIhaF5UHG8RqDM=; b=Hb932vJQfHfr2BVS3xTmHl5HW6hIbhKR2
	vPGPM/zD0z2+2fUjr+mhcpa3YOzRALEK8osYd9Hll9UoCLJCZaJa8kRIbkrXbqBs
	wNUWlYRsTBiURGMen5zL+0TY1oU8Mwiuom0zJAI1d82kYQw1Sr+MNQuWiG7FgbSv
	NzOOTQRI1dK/zJrlHMe/W+yVJPvMcg4dcmKZm9OEITIgKTtg3EudjR3oCMQq8JLb
	HCAkWneUqh5Z7tim66rphTDb9/hIzoAGeor6J+jqsSlUoX0W/fbZtsVDrtijMvoA
	wDDdmtBvP1of4ZnA00r+5EXGugcOCm4XPbElJQD2Q/1aPopIcSf4w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54j0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfjKG000540;
	Mon, 31 Aug 2026 14:55:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6a9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:55:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEtglP51511660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:55:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB1F12004E;
	Mon, 31 Aug 2026 14:55:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C27B2004D;
	Mon, 31 Aug 2026 14:55:41 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:55:41 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v2 09/20] s390: Introduce read/write ARM sysreg instructions
Date: Mon, 31 Aug 2026 16:55:24 +0200
Message-ID: <20260831145536.913567-10-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831145536.913567-1-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXxYhkDYPF8ww8
 Pm54Tllo1xlltqsexEJI+7TyoYWLb/d8UDhBf7I50uQCQfUHgvSFHH6sRw/HzkLb1it76vJ22UL
 PD2pIHXOMOvs6aOsHxyE0/XS54sz71mBjeKZiuSgoPawlR7t9szs3B8BiWXZ+dVQgERIvxKtRtv
 BADSnoiMO+6+n1ItYBq6o1bPpagvmhXAToq+TEHeduz3XcBHU06hjB7qmWiZ27gbuC25PQ5mGxr
 2NAYYzdd6FkDZxEWLE8FHQ2+LUt3DQundOk6B+tOTb6zyZ4NCqBLIPTjYoR9ua3v49WW0gLmu9W
 uSuCgvN8EZoeME6t/puSIiP37xX3ST6g1zNo8mlztA/o+nE6ubF2SGF+e3m2+hsptbWuMqZ4CLk
 Ix1bA2igHB/LjdJQVH6EBuAoVNGv9fHd7NbzxVi7HQ5AnIjtZr6dnvCDm001AUOJpidwv6jms/5
 Bhd9PQkFAdRbqx8/x2g==
X-Proofpoint-ORIG-GUID: kr3pBR_CnZUNPMEhPZ4JfUw1BV9RLhs0
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9595f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=GoOEIcCEF_BdVuQDi_EA:9
X-Proofpoint-GUID: h7huTZd3PS8_qMhaace1MNhAdsxCoebX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX05g+6S5vhoDo
 /QgN7y798+9RD8MgTQAz46M/FGOD/clS50UdEp+/azFttOKDrwLlAKBLGXMkFao1E2Z6H/SXevb
 zwT6l+dEFvNhlxclV0sZcaAergTWw3E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310125

Introduce Extract Arm System Register and Store Arm System Register to
enable s390 hosts to read and write system registers for arm64 guests.
The new instructions use the new RIE_H instruction format. Add assembler
macros to create instructions in RIE_H format manually. Add Support for
disassembling the new instructions.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/sae-asm.h | 48 +++++++++++++++++++++++++++
 arch/s390/include/asm/sae.h     | 58 +++++++++++++++++++++++++++++++++
 arch/s390/kernel/dis.c          |  1 +
 arch/s390/tools/opcodes.txt     |  2 ++
 4 files changed, 109 insertions(+)
 create mode 100644 arch/s390/include/asm/sae-asm.h

diff --git a/arch/s390/include/asm/sae-asm.h b/arch/s390/include/asm/sae-asm.h
new file mode 100644
index 000000000000..d81ed89eb4ed
--- /dev/null
+++ b/arch/s390/include/asm/sae-asm.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_S390_SAE_ASM_H
+#define __ASM_S390_SAE_ASM_H
+
+#ifdef __ASSEMBLER__
+
+.macro	GPR_NUM	opd gr
+	\opd = 255
+	.irp rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \gr,%r\rs
+		\opd = \rs
+	.endif
+	.endr
+	.if \opd == 255
+		\opd = \gr
+	.endif
+.endm
+
+/*
+ * RIE_H - RIE-h instruction format
+ *
+ * RIE-h format: <insn> R1, R3, I2, M4
+ *    +--------+----+----+----+-----------------+----+--------+
+ *    | OpCode | R1 |////| R3 |        I2       | M4 | Opcode |
+ *    +--------+----+----+----+-----------------+----+--------+
+ *    0        8    12   16   20                36   40      47
+ */
+.macro RIE_H	opc, gr1, gr3, imm2, m4
+	GPR_NUM	r1, \gr1
+	GPR_NUM	r3, \gr3
+	.byte	(\opc & 0xff00) >> 8
+	.byte	r1 << 4
+	.byte	(r3 << 4) | ((\imm2 & 0xf000) >> 12)
+	.byte	((\imm2 & 0x0ff0) >> 4)
+	.byte	((\imm2 & 0x000f) << 4) | (\m4 & 0xf)
+	.byte	\opc & 0xff
+.endm
+
+.macro SASR r1, r3, i2, m4
+	RIE_H 0xed99, \r1, \r3, \i2, \m4,
+.endm
+
+.macro EASR r1, r3, i2, m4
+	RIE_H 0xed9b, \r1, \r3, \i2, \m4,
+.endm
+
+#endif /* __ASSEMBLER__ */
+#endif /* __ASM_S390_SAE_ASM_H */
diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
index 389c5ac2a36c..6580536544ee 100644
--- a/arch/s390/include/asm/sae.h
+++ b/arch/s390/include/asm/sae.h
@@ -4,6 +4,7 @@
 
 #include <linux/linkage.h>
 #include <linux/types.h>
+#include <asm/sae-asm.h>
 
 #ifndef __ASSEMBLER__
 
@@ -13,6 +14,12 @@ asmlinkage void __sae64a(phys_addr_t sae_block_phys);
 #include <linux/io.h>
 #include <asm/kvm_host_arm64_types.h>
 
+asm(".include \"asm/sae-asm.h\"\n");
+
+#define _SAE_ASR_REG_SHIFT	5
+#define SASR_FLAG_INITIALIZED  0x8
+#define EASR_FLAG_SA           0x8
+
 /**
  * __sae64a() - Start Arm Execution
  */
@@ -21,6 +28,57 @@ static inline void sae64a(struct kvm_sae_block *sae_block)
 	__sae64a(virt_to_phys(sae_block));
 }
 
+/**
+ * sasr() - Set Arm System Register
+ * @arm_reg: ARM system register identifier; compile-time constant
+ * @val: Value to set
+ * @save_area: Pointer to SAE save area
+ * @flags: Operation flags; compile-time constant
+ *
+ * Sets an ARM system register value.
+ */
+static __always_inline void sasr(unsigned int arm_reg, u64 val,
+				 struct kvm_sae_save_area *save_area,
+				 u64 flags)
+{
+	struct kvm_sae_save_area *sdo = (void *)save_area->sdo;
+	u16 reg = arm_reg >> _SAE_ASR_REG_SHIFT;
+
+	asm volatile (
+		"	SASR	%[r1],%[r3],%[i2],%[m4]\n"
+		: "+m" (*save_area), "+m" (*sdo)
+		: [r1] "d" (val),
+		  [r3] "a" (save_area), [i2] "K" (reg), [m4] "I" (flags)
+	);
+}
+
+/**
+ * easr() - Extract Arm System Register
+ * @arm_reg: ARM system register identifier; compile-time constant
+ * @save_area: Pointer to SAE save area
+ * @flags: Operation flags; compile-time constant
+ *
+ * Reads an ARM system register value.
+ *
+ * Return: Register value
+ */
+static __always_inline u64 easr(unsigned int arm_reg,
+				const struct kvm_sae_save_area *save_area,
+				u64 flags)
+{
+	struct kvm_sae_save_area *sdo = (void *)save_area->sdo;
+	u16 reg = arm_reg >> _SAE_ASR_REG_SHIFT;
+	u64 val;
+
+	asm volatile(
+		"	EASR	%[r1],%[r3],%[i2],%[m4]\n"
+		: [r1] "=d"(val)
+		: "m"(*save_area),
+		  "m"(*sdo), [r3] "a"(save_area), [i2] "K"(reg), [m4] "I"(flags)
+	);
+	return val;
+}
+
 /**
  * stiasrm() - STore and Invalidate Arm System Register Multiple
  * @save_area: Pointer to SAE save area
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 1cec93895b3a..6ff8fd09d5bc 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -208,6 +208,7 @@ static const unsigned char formats[][6] = {
 	[INSTR_RIE_RUI0]     = { R_8, I16_16, U4_12, 0, 0, 0 },
 	[INSTR_RIE_RUPI]     = { R_8, I8_32, U4_12, J16_16, 0, 0 },
 	[INSTR_RIE_RUPU]     = { R_8, U8_32, U4_12, J16_16, 0, 0 },
+	[INSTR_RIE_R0RIU]    = { R_8, R_16, U16_20, U4_36, 0, 0 },
 	[INSTR_RIL_RI]	     = { R_8, I32_16, 0, 0, 0, 0 },
 	[INSTR_RIL_RP]	     = { R_8, J32_16, 0, 0, 0, 0 },
 	[INSTR_RIL_RU]	     = { R_8, U32_16, 0, 0, 0, 0 },
diff --git a/arch/s390/tools/opcodes.txt b/arch/s390/tools/opcodes.txt
index 0e4773c94af0..18af14071290 100644
--- a/arch/s390/tools/opcodes.txt
+++ b/arch/s390/tools/opcodes.txt
@@ -1255,6 +1255,8 @@ ed64	ley	RXY_FRRD
 ed65	ldy	RXY_FRRD
 ed66	stey	RXY_FRRD
 ed67	stdy	RXY_FRRD
+ed99	sasr	RIE_R0RIU
+ed9b	easr	RIE_R0RIU
 eda8	czdt	RSL_LRDFU
 eda9	czxt	RSL_LRDFU
 edaa	cdzt	RSL_LRDFU
-- 
2.53.0

