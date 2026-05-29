Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409403FE674;
	Fri, 29 May 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070200; cv=none; b=r6X8YHr7CCPCARouJaDLD4te9+hJrRM56QSyPkuqnZ6mmWa0QYZoagJxQEY24DjzaVXxmgpW5jCSQR2rDKMouhajLyfyVqgJ0JkdWzBM02jdFqE+6iPS3FfRuiLCNEqZuWhm0/k4kv7T+ocImNQxuvcAD7jormlGYj5Q901uGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070200; c=relaxed/simple;
	bh=U1dkFh5tJ6ZwojqCHKxfmLBh/yZMgZ9RKDQJgDpgC7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUGhjQHxlxKQt2wU/jjY4lLUJh8oD3hYuHgV4w/6khk5z7dAx3WAQL7gzyCcvFlhrVGHGUxvAQKSsg7zIeIcNw2NiexqE3L027s8ZBpk6QMjvLW8fMYQIIstp4otLmq/xDmBcSDEyoGTAdb6H+/DIvWhn6dm3/H5xsA2kvNuwvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h3Ro1jA7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h3Ro1jA7"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFg2LN2776549;
	Fri, 29 May 2026 15:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WnQHAGFKd6DchrlP6
	Ju4P8YPOX1SBDsgwJ6yTF6AD1E=; b=h3Ro1jA76JxVqbaXxvN/d730zt/FvXxUZ
	uZlQD5UmaK9LrRFXBt60ZkjvDjmWOYQ33xtPfmgBrppsD8CxLCayRuzznQqs4cY9
	cc/GMc8rbCSyQzBUgk3ndsTqXO4cc1aTFKZdCpcHb3MYtqVQocsatGznf/dl5wjM
	UCt+bvTF6hw/WudSF8ePa1RP4+qBzqlQnGo3cdMRziz+qUrzqKWBRss6YBZs52LP
	nPpLEpFigApiZRI7xZSgy1nfesB9KFo0i8PWedHKW0t0gh+Q7WRFMA6Qh6CqqFDa
	BL7PcLHYVroCzYPso9ZjDHAMbszZnaF5/EHW+Ide2hOM+4twRxhog==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889m2ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs816023079;
	Fri, 29 May 2026 15:56:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc0k2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu78p50004432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:07 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B17E20040;
	Fri, 29 May 2026 15:56:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDFB22004E;
	Fri, 29 May 2026 15:56:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:06 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v1 13/26] s390: Introduce read/write ARM sysreg instructions
Date: Fri, 29 May 2026 17:55:46 +0200
Message-ID: <20260529155601.2927240-14-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155601.2927240-1-seiden@linux.ibm.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NYwQLjch8AAYoUDuGJ9-iOYn8u_3SwZM
X-Proofpoint-GUID: NYwQLjch8AAYoUDuGJ9-iOYn8u_3SwZM
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a19b71e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=GoOEIcCEF_BdVuQDi_EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX9/++cki3jljI
 f83bnBX/m3d72SamK5XaOFICAAVHg5ycoBac3FAfpNjOFDMmV674fElxYVUFLpx23BtZMlsWxP0
 6zkbWx8mQAxfV+k/By+++ntdMPv7vtX5jUVvhk5rnY9jvcn0jxkHrY0mxho3Vj+P4WOWIWRi51o
 IQtwLfLWQ0C9OC8pF6IyzP+jLn7tP/JlByrzPy5nu3yt1on1JHFpQurpnvVtugEi3KSWKiNpBlQ
 897F5BnM2AgEuTFwn8wAcYMpvy6rDEiXwkhrqLE9CXIrLOVX8OzhKzCdCvTriJ7yuSxVmfZ6amz
 FrDugEah/QsgKKzTRAQ5t6jfGd8LFXQNALEkjClfjFctL2JzGfnMjYjAWs6iZvQ/rLKRS8E6/X3
 7HlSf/X7U39wNRNXxaJR/QFb1l3EspxXDNipGX4hapcr1xnEb4T+cbVfXyLxk6ACX/Iwby4Cdmb
 S2SMQ5fI0prTSW41Yiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

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
index fe010a1a7729..1d9a16b91b23 100644
--- a/arch/s390/include/asm/sae.h
+++ b/arch/s390/include/asm/sae.h
@@ -4,6 +4,7 @@
 
 #include "linux/linkage.h"
 #include <linux/types.h>
+#include <asm/sae-asm.h>
 
 /* defined in arch/s390/kernel/entry.S */
 asmlinkage int __sae64a(phys_addr_t sae_block_phys);
@@ -12,6 +13,12 @@ asmlinkage int __sae64a(phys_addr_t sae_block_phys);
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
@@ -20,6 +27,57 @@ static inline void sae64a(struct kvm_sae_block *sae_block)
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

