Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DCD428822;
	Fri, 29 May 2026 15:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070212; cv=none; b=qPFS+HhNuKMiUT2YuXZohS2AvWTV+ePRwLMxbLE6TZUhn8BKKZHgtBTiLCrVRU+/vXSVO2jubAduKZ8UsX9QP554kYkLgPGpidmiQzKXvw5yL/BqFb+98zzkrpBGXw/nAaNb/5/PJAxyqZwYq/4Hs0hjpXQ25jDutigT4T31VtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070212; c=relaxed/simple;
	bh=VdJ5D4pWhUMZiuLwpLwV45/dxvUbNQ3/d1sL6gUAPCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWjfA71Wsz/3cOZEr+6f8bnEKTF6Nh5Gl9XokJ93gRS4pLs9zB+1mAUwSrX4KaHgYkJr5eyCImPC0D+NqQbKYAA5+1B1RcFQh5bndbE0OFwd3YE5WCPlp16Ihee6l7lgxsSRrfCchjGqSx/Qnt4ZH0/cumMiphcY7++gn+mO4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ahvt5PEK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ahvt5PEK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFKGCK1685956;
	Fri, 29 May 2026 15:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OB54e0sJf0qPl31od
	E4TOuJ++EZKctY7iEXbx4L5EuE=; b=ahvt5PEK3ue2LKPLeYZ0iiHkL/ub/q50A
	xss/LlZNhg0Oclokhxgcab+IqqPYeYnkfi0VJtlmn8hUvz4A2xo5g2cyO5EDRt7c
	Rv3qcSf6olqpanSAEsPiZ9s6g+egE1QtVmxtEYPq7bz8eG5vCrGoC1avcCdQrRbB
	a4V19WHkkNHVGMRttXRnDAhGq11xAICMnfa2o4imN2w9Jep9zNfD/0605OmKkTbL
	M96SV0ZtUrq/PPS535IygkfW5b/+qWjBZRsVXzz3cCDUaRBNdmgb1fiLzS02DQK1
	+KwUBX92IfoDLobvr1G/z5tJ9TzoL6UL52ymzFeaemSG9WLxI42Xg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884mh75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs5GF003169;
	Fri, 29 May 2026 15:56:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgm8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu6ac36700644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0617F20040;
	Fri, 29 May 2026 15:56:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACE432004B;
	Fri, 29 May 2026 15:56:05 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:05 +0000 (GMT)
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
Subject: [PATCH v1 10/26] KVM: arm64: Fix set_oslsr_el1 to write to OSLAR_EL1
Date: Fri, 29 May 2026 17:55:43 +0200
Message-ID: <20260529155601.2927240-11-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=fIYJG5ae c=1 sm=1 tr=0 ts=6a19b71f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=5EGiLxFwAr7VIT5rVV0A:9
X-Proofpoint-ORIG-GUID: Wgd_CA6F3seeTvf6_fbULAQn4h0wRnvg
X-Proofpoint-GUID: Wgd_CA6F3seeTvf6_fbULAQn4h0wRnvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX7ZbACSDx4jlO
 UQ8aei+lNfw7u4H6u/iIeB1Xy96QCrJaCbwREAu9McKDcUINIf2UmHhnI5TuAAiumMN8Y9/w1GX
 Hk/qtUUhPSeT9jfgzKJQtAfnoLpEsvsLLd+NBPP96SLXAcQ2jj+AhzNDaNNX293Lo8Tthn517BQ
 F8ZWheskkNTW7Q+Z95kYw2Y+5Nr+it4XHSoSiF33H/vMPe7vPY+1efXtvR+TEDxiYp94lO/yUEn
 ULyQ6JcxM6SfSfTg+kiieT00cw8rVAvCkR5CTo70JwqjEHmUpoyL+6/XnuPxBPaNbuK62tXj6JC
 bTZIAfV8hKU1jOCmsxcTbRZtdqKOOpmaWSH/3OavNWDMtp7K6Ow4raap6+9SGxG+V9E4gzZTl59
 f/fjIlkJxC599mmR8W1vXsEy5OiOiA1C3t3Qs14ahjvtPxsmBX8Kh+h36X745+1KZ0CmOqthDW9
 ErfRFOZ5KsbMvdeBpow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

From: Andreas Grapentin <gra@linux.ibm.com>

The set_oslsr_el1() function was incorrectly writing directly to the
OSLSR_EL1 register, which is architecturally a read-only status register
that reflects the state of the OS Lock.

Fix this by extracting the OSLK bit from the user-provided value and
writing it to OSLAR_EL1 (OS Lock Access Register) instead, which is the
proper control register for managing the OS Lock state. OSLSR_EL1 will
then reflect this state when read.

This ensures the implementation follows the ARM architecture
specification where OSLAR_EL1 controls the lock and OSLSR_EL1 provides
status information.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h    |  1 +
 arch/arm64/kvm/sys_regs.c            | 10 +++++++++-
 include/arch/arm64/asm/sysreg-defs.h |  1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index a8efff6ea01d..5734e93cad57 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -408,6 +408,7 @@ enum vcpu_sysreg {
 	PAR_EL1,	/* Physical Address Register */
 	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
 	OSLSR_EL1,	/* OS Lock Status Register */
+	OSLAR_EL1,	/* OS Lock Access Register */
 	DISR_EL1,	/* Deferred Interrupt Status Register */
 
 	/* Performance Monitors Registers */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 195ecdac7bd6..6522f9302967 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -822,6 +822,8 @@ static bool trap_oslsr_el1(struct kvm_vcpu *vcpu,
 static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 			 u64 val)
 {
+	u64 oslk;
+
 	/*
 	 * The only modifiable bit is the OSLK bit. Refuse the write if
 	 * userspace attempts to change any other bit in the register.
@@ -829,7 +831,13 @@ static int set_oslsr_el1(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 	if ((val ^ rd->val) & ~OSLSR_EL1_OSLK)
 		return -EINVAL;
 
-	__vcpu_assign_sys_reg(vcpu, rd->reg, val);
+	/*
+	 * Redirect the write to the proper control register.
+	 * OSLSR is read-only
+	 */
+	oslk = SYS_FIELD_GET(OSLSR_EL1, OSLK, val);
+	__vcpu_assign_sys_reg(vcpu, OSLAR_EL1,
+			      SYS_FIELD_PREP(OSLAR_EL1, OSLK, oslk));
 	return 0;
 }
 
diff --git a/include/arch/arm64/asm/sysreg-defs.h b/include/arch/arm64/asm/sysreg-defs.h
index 3e280d4156ce..c6bdb0f11e1b 100644
--- a/include/arch/arm64/asm/sysreg-defs.h
+++ b/include/arch/arm64/asm/sysreg-defs.h
@@ -129,6 +129,7 @@
 #define OSLSR_EL1_OSLM_NI		0
 #define OSLSR_EL1_OSLM_IMPLEMENTED	BIT(3)
 #define OSLSR_EL1_OSLK			BIT(1)
+#define OSLSR_EL1_OSLK_MASK             BIT(1)
 
 #define SYS_OSDLR_EL1			sys_reg(2, 0, 1, 3, 4)
 #define SYS_DBGPRCR_EL1			sys_reg(2, 0, 1, 4, 4)
-- 
2.53.0

