Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981329;
	b=C7L3QOD8DWniYljliC2xb5ckPpgNq4WN3QPXD/XK7Kd//l2gWUCxAz9MlR646YXAWfWG
	 Skvc8PcZtWn5XdRSSJb/d67/fJhbD1jUBn9E7A0OlKwQDcZV3b0rJ6u87PLs028hMocWY
	 dG/lxlKgIhWA5L8HMHOGdQvCb0EzsSC2hxeWottq/BsqS7Tkm+GuWAMdp4VcTNreEMbEG
	 lpgOlT7uE5VijBViyQjU6mtNiNSwbWGCElTSwNVomTMFqaScx1KK4O2k9PwLjEPSX884L
	 wKUmDGd2a7llTnbxCnMG9/9pW5Et2XCXbee05YZYVHn14fZMCdOgSC+K+2utebyPBeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981329;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=caPXnclb0BxNGS9f/bTypgcrD2gGCBC253UOa//VNRI=;
	b=GIBQMg9Dylp4hxiks/NemFJs60cWh/UQHC/pCmNaSZ7tNg4RxsqQaZ7MHvnvaRc925vI
	 6uZQikkNyK2whQZxcRJnXeTLPUoxw1nSX6rzSA3McXLkhgJgYUOTDEfBcEVIh/z3N82Yw
	 5aRZS3rikxEqP1jFF2B34+SyZAmD1QebIb8NiNtqqzICrF8Z+txHAWN2CKQtGfByyhfC7
	 54FiaJUtjk0ycHtgDvPByYUBjueinSEIWPjb9z/aJZlhBKIp2u0RxIQ6BXx5zJOa4HZFD
	 NrRT6OGKpnrw6qD+Uomxe+e9N0gyWm1eq86vgOOygpEt7a6y/V37U+EpDHZSiSIK1Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bYo+Qrlg;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197E4606D828;
	Fri,  6 Nov 2026 16:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 197E4606D828
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bYo+Qrlg
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEG1C2656440;
	Fri, 6 Nov 2026 16:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=caPXnc
	lb0BxNGS9f/bTypgcrD2gGCBC253UOa//VNRI=; b=bYo+Qrlg6vIsKSlzByRZNR
	hxMQNa/3kLLg9z68JE9iKzDDOosfBE8XJYfvwrSePhmlnPlcxckfPDZE2IcpcC3/
	qRaTLHyAXdrBR7e/kUbWZF99X0p3kB/TRwWl8x49fTrOCcS8ewm0aHjLEK5LIjEv
	8HAkCiFkEc1QuVN3vrBOlAsXYdseWm8TAehC0nXoPh+IkPhIqx/tOkDuLkUOHRki
	KVRBt4zyPUy40tRx9PUgUv6h5g0QCx/mp8cwYiEnT2Bgs/k4aTo47UkusnyKvj+j
	+sxhf9rmi4UiogoYzR1rBFwXD4yrAo78geDIwWvK51wWdioRdAz0zMGse84CVhkQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5etn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F51QQ3617269;
	Fri, 6 Nov 2026 16:08:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ukcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8IOP49283434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E84D20063;
	Fri,  6 Nov 2026 16:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CAD42004B;
	Fri,  6 Nov 2026 16:08:18 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:17 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:44 +0100
Subject: [PATCH v3 11/23] s390: Read/write ARM system registers
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-11-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX25x7f2vbEu/j
 sBYYExNiQca29G0cmhsy131Mb4/vnZVG/JXvLY/KF9edXYOROwfeLIOMyU96CwEHorVPDOzaCit
 a4tuWnqoXlF0BkuANkQT7z5s1TWBX10=
X-Proofpoint-GUID: uFKwzL3gGWenNltY0OLaRhE2Rdeg3LkU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXzmnMyaTqOa8R
 Zgw9IJ9pfX1J9RZ0W1kpt/An9T0BxqNWRn5qV8YxET8fzuraLtGoRrDvkrm4+Y5kCUKb1fekXtg
 63FCehE/71evS4U3jR6lKaWtgomJSh9TuHAXAGvkYY4Gls2e71Sk6RNTF3jdgzCdV7l/BtQGdDr
 9ynxTirUjkbPsoHD0zgCwbneuKHCE7jwGBaaiTsZn8s4ij8skIDgSsyds5zJ3H9e18yglMVg1PE
 HOPIISAJU+rP7gF3MkbG9P0IpF2WffyGEtws+u4QeCroqELtCApfl0V6e71MD8ztf1afRW68Cwm
 ccKMix+W57JP421EbdgBhWcto1AsyTLFDPWSayxLTkUyFIKjIwOXHh60JrWgNzDkf0Sw3lj/QNB
 mcgk7OzeGqby8ZoAlDthbOzSmgw6+l3T3/fb6ae8yWgLZqJEWNEltxs8t2XA+y4sNCDE+5UkrpH
 qnv9VX9lt+zG/50Aq4g==
X-Proofpoint-ORIG-GUID: uFKwzL3gGWenNltY0OLaRhE2Rdeg3LkU
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedfb77 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=7LwJKZnqmkLqLE65SeQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Introduce Extract Arm System Register and Set Arm System Register to
enable s390 hosts to read and write system registers for arm64 guests.
The new instructions use the new RIE_H instruction format. Add assembler
macros to create instructions in RIE_H format manually. Add Support for
disassembling the new instructions.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/sae-asm.h | 45 +++++++++++++++++++++++++++
 arch/s390/include/asm/sae.h     | 67 +++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/dis.c          |  1 +
 arch/s390/tools/opcodes.txt     |  2 ++
 4 files changed, 115 insertions(+)

diff --git a/arch/s390/include/asm/sae-asm.h b/arch/s390/include/asm/sae-asm.h
new file mode 100644
index 000000000000..a1abb07b5a77
--- /dev/null
+++ b/arch/s390/include/asm/sae-asm.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_S390_SAE_ASM_H
+#define __ASM_S390_SAE_ASM_H
+
+#ifndef __ASM_S390_SAE_H
+#error only <asm/sae.h> can be included directly
+#endif
+
+#include <asm/insn-common-asm.h>
+
+#ifdef __ASSEMBLER__
+
+/*
+ * INSN_RIE_H - RIE-h instruction format
+ *
+ * RIE-h format: <insn> R1, R3, I2, M4
+ *    +--------+----+----+----+-----------------+----+--------+
+ *    | OpCode | R1 |////| R3 |        I2       | M4 | Opcode |
+ *    +--------+----+----+----+-----------------+----+--------+
+ *    0        8    12   16   20                36   40      47
+ */
+.macro	INSN_RIE_H	opc, gr1, gr3, imm2, m4
+	GR_NUM	r1, \gr1
+	GR_NUM	r3, \gr3
+	ASSERT_U16	\opc
+	ASSERT_U16	\imm2
+	ASSERT_U4	\m4
+	.byte	(\opc & 0xff00) >> 8
+	.byte	r1 << 4
+	.byte	(r3 << 4) | ((\imm2 & 0xf000) >> 12)
+	.byte	((\imm2 & 0x0ff0) >> 4)
+	.byte	((\imm2 & 0x000f) << 4) | (\m4 & 0xf)
+	.byte	\opc & 0xff
+.endm
+
+.macro	SASR	r1, r3, i2, m4
+	INSN_RIE_H 0xed99, \r1, \r3, \i2, \m4
+.endm
+
+.macro	EASR	r1, r3, i2, m4
+	INSN_RIE_H 0xed9b, \r1, \r3, \i2, \m4
+.endm
+
+#endif /* __ASSEMBLER__ */
+#endif /* __ASM_S390_SAE_ASM_H */
diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
index 26d89fae0836..cac4fbf58e88 100644
--- a/arch/s390/include/asm/sae.h
+++ b/arch/s390/include/asm/sae.h
@@ -4,6 +4,7 @@
 
 #include <linux/linkage.h>
 #include <linux/types.h>
+#include <asm/sae-asm.h>
 
 #ifndef __ASSEMBLER__
 
@@ -12,6 +13,72 @@ asmlinkage void sae(phys_addr_t sae_block_phys);
 
 #include <linux/io.h>
 #include <asm/kvm_host_arm64_types.h>
+#include <asm/insn-common-asm-emit.h>
+
+asm(".include \"asm/sae-asm.h\"\n");
+
+#define _SAE_ASR_REG_SHIFT	5
+#define SASR_FLAG_INITIALIZED  0x8
+#define EASR_FLAG_SA           0x8
+
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
+	struct kvm_sae_block *sdo = phys_to_virt(save_area->sdo);
+	u16 reg = arm_reg >> _SAE_ASR_REG_SHIFT;
+
+	/*
+	 * SASR expects an U16 for imm2 but s390 inline asm can only provide S16 values
+	 * via the K modifier. Convert i2 to unsigned by and-ing with 0xffff
+	 */
+	asm_inline volatile(
+		"	SASR	%[r1],%[r3],%[i2] & 0xffff,%[m4]\n"
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
+	struct kvm_sae_block *sdo = phys_to_virt(save_area->sdo);
+	u16 reg = arm_reg >> _SAE_ASR_REG_SHIFT;
+	u64 val;
+
+	/*
+	 * EASR expects an U16 for imm2 but s390 inline asm can only provide S16 values
+	 * via the K modifier. Convert i2 to unsigned by and-ing with 0xffff
+	 */
+	asm_inline volatile(
+		"	EASR	%[r1],%[r3],%[i2] & 0xffff,%[m4]\n"
+		: [r1] "=d" (val)
+		: "m" (*save_area),
+		  "m" (*sdo), [r3] "a" (save_area), [i2] "K" (reg), [m4] "I" (flags)
+	);
+	return val;
+}
 
 /**
  * stiasrm() - STore and Invalidate Arm System Register Multiple
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index d2d299ba8b86..065264667db3 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -208,6 +208,7 @@ static const unsigned char formats[][6] = {
 	[INSTR_RIE_RUI0]     = { R_8, I16_16, U4_12, 0, 0, 0 },
 	[INSTR_RIE_RUPI]     = { R_8, I8_32, U4_12, J16_16, 0, 0 },
 	[INSTR_RIE_RUPU]     = { R_8, U8_32, U4_12, J16_16, 0, 0 },
+	[INSTR_RIE_R0RUU]    = { R_8, R_16, U16_20, U4_36, 0, 0 },
 	[INSTR_RIL_RI]	     = { R_8, I32_16, 0, 0, 0, 0 },
 	[INSTR_RIL_RP]	     = { R_8, J32_16, 0, 0, 0, 0 },
 	[INSTR_RIL_RU]	     = { R_8, U32_16, 0, 0, 0, 0 },
diff --git a/arch/s390/tools/opcodes.txt b/arch/s390/tools/opcodes.txt
index 0e4773c94af0..22fb9c500a56 100644
--- a/arch/s390/tools/opcodes.txt
+++ b/arch/s390/tools/opcodes.txt
@@ -1255,6 +1255,8 @@ ed64	ley	RXY_FRRD
 ed65	ldy	RXY_FRRD
 ed66	stey	RXY_FRRD
 ed67	stdy	RXY_FRRD
+ed99	sasr	RIE_R0RUU
+ed9b	easr	RIE_R0RUU
 eda8	czdt	RSL_LRDFU
 eda9	czxt	RSL_LRDFU
 edaa	cdzt	RSL_LRDFU

-- 
2.56.0

