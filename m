Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41C3FDC18;
	Fri, 29 May 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070198; cv=none; b=RFcQBfarH9g6ZWtDXmw90rlFjaQKC2C9saDlZJkL2UUw3pZsFP/ksENpC3MmkNHK7q3QZ3tdIIbfd7qZBrN7PJlTHnvuMXtfVYE9U2LQwZc8I9zV3KMHHsqQT8ctGTrBNKHFL6ZHkXBB830Ev98l6QNYFEbfMHQartDQfA52hTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070198; c=relaxed/simple;
	bh=baq4cRKR9673AaG4M+ydRFk7OMtBI4huA/q4jzTaWRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GQtGm8P9gTz5Eg1P0jXQY13vMLE8xZCB+ibcjj8yELghipXEAWbUuZ+N+a5Chh6vbzWkP7hyBzSoNNVUEn+PtEXD6kSrKIIR5XitnmPdpsEhXqhT0tyQ6O6HO3Pf5W+lmtQLNNWeT2wq3CdA1XnRE4Mz5kwbN+SogxcQ6nMORtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLD7BOjw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLD7BOjw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFHRqk3217155;
	Fri, 29 May 2026 15:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jAH55rZkTvViU7aHU
	2ThlI/tFiC7U75l7lFJ0ODKt4U=; b=dLD7BOjwsNSwrTXxjLa+wXYbOoDnsCowh
	gwhdgkAFxeOL1Zs01rCC/JCEeDBOd3hKT/Kuj8pdKLTFf562oHpga5DJvTXm/CJV
	28hojkLH26TjDFFx050TXWHN5a047qjXabwmBaA5Ntyi9+Nt3DOvQDwfPEcgnQZL
	nsUT+daKGNpPoLQreYfjFHJZheR8mETgxQXh4in8Hb+//pPv2m5DocUTMHPowk/9
	x2/u9967xkTL9sJYqS+oIIAdgo8pn5e8MNN8W1tEKfaFlhYTloNuOqgQWD5vz/uZ
	+ERPJzukHyV+PI+1eUIyxShLjGGnksRacyG56sWSt883f9u/B4+CQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bm2jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7ah009677;
	Fri, 29 May 2026 15:56:12 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgkua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFu58142205502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E3DD20040;
	Fri, 29 May 2026 15:56:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBC372004B;
	Fri, 29 May 2026 15:56:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:04 +0000 (GMT)
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
Subject: [PATCH v1 08/26] KVM: arm64: Split up feature sysreg sanitisation
Date: Fri, 29 May 2026 17:55:41 +0200
Message-ID: <20260529155601.2927240-9-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX2dMs4exigRHo
 h1N3uP2ic/tjvpD55Tuk34/BiQEu2cXz6QYNyT8goHv5c+iBM0N+xrLr66gt30+wnpJ5AqoWAWA
 56xSJDB0D+km5gnSbGm2raeLrWngmw/FF2fiMcX72OtQZpqX3Pe07EAFFD3qdPWJMpNl7mMBSxM
 SJNEtb5jSvArye7Lupc9zmWd/cMoDztiNXDTAI8dXhWdb4qHES8eBEb/koZQipxLXJu4Jy8zy17
 GMyEP//LH4UpoI0WzOXFH4AXXs6//o+e9z9quiJtc+qS2VY4kNS7g2bwHOzI24YGzrh+aKCuJtH
 IqRYUJBrmbTMghz5FyX9RoVDERY8ZxJ+musOXu0/3+5cQ68ZQkntF46TAF2KuP5w01W6gpfGl+K
 xaX+eo7m12TiTZYe1jeu27ctFNGfEzdgW26qXpEEjJh0rz+IgLj8K6LL430LipdWnlcdiykL+MV
 FUeeGdqhNHS20qaAY+Q==
X-Proofpoint-ORIG-GUID: wFvicD_RSdqEi-rRAAIp92c4cgx5IjOR
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a19b71c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=r_tBfuKwx9rY2nSX5wQA:9
X-Proofpoint-GUID: wFvicD_RSdqEi-rRAAIp92c4cgx5IjOR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290156

Split ID register sanitisation into distinct stages:

1) static KVM limits (kvm_max_possible_guest_ftr_reg)
2) host-specific (kvm_sanitised_host_ftr_reg)
3) per-vcpu configuration (kvm_sanitise_vcpu_ftr_reg)

This refactoring improves code organization by separating concerns.
Static limits apply regardless of host or guest configuration. Host
capability checks handle features like GIC, GCIE, and Spectre
mitigations. Per-vcpu feature configuration manages SVE, MTE, PMU, and
similar guest-specific features. Additionally, this enables other
architectures to add different host-implementation-based sanitisation in
the future.

Remove helper functions sanitise_id_aa64{pfr0,pfr1,dfr0}_el1
in favor of organized logic.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/sys_regs.c | 291 ++++++++++++++++++++------------------
 1 file changed, 153 insertions(+), 138 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 2434bcc2d50d..b9aa892616ab 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1841,54 +1841,86 @@ static u8 pmuver_to_perfmon(u8 pmuver)
 	}
 }
 
-static u64 sanitise_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu, u64 val);
-static u64 sanitise_id_aa64pfr1_el1(const struct kvm_vcpu *vcpu, u64 val);
-static u64 sanitise_id_aa64pfr2_el1(const struct kvm_vcpu *vcpu, u64 val);
-static u64 sanitise_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val);
-
-/* Read a sanitised cpufeature ID register by sys_reg_desc */
-static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
-				       const struct sys_reg_desc *r)
+/*
+ * Sanitise based on the host implementation.
+ */
+static u64 kvm_sanitised_host_ftr_reg(u32 id)
 {
-	u32 id = reg_to_encoding(r);
-	u64 val;
-
-	if (sysreg_visible_as_raz(vcpu, r))
-		return 0;
-
-	val = read_sanitised_ftr_reg(id);
+	u64 val = read_sanitised_ftr_reg(id);
 
 	switch (id) {
-	case SYS_ID_AA64DFR0_EL1:
-		val = sanitise_id_aa64dfr0_el1(vcpu, val);
+	case SYS_ID_AA64ISAR2_EL1:
+		if (!cpus_have_final_cap(ARM64_HAS_WFXT) ||
+		    has_broken_cntvoff())
+			val &= ~ID_AA64ISAR2_EL1_WFxT;
 		break;
 	case SYS_ID_AA64PFR0_EL1:
-		val = sanitise_id_aa64pfr0_el1(vcpu, val);
+		/*
+		 * The default is to expose CSV2 == 1 if the HW isn't affected.
+		 * Although this is a per-CPU feature, we make it global because
+		 * asymmetric systems are just a nuisance.
+		 *
+		 * Userspace can override this as long as it doesn't promise
+		 * the impossible.
+		 */
+		if (arm64_get_spectre_v2_state() == SPECTRE_UNAFFECTED) {
+			val &= ~ID_AA64PFR0_EL1_CSV2_MASK;
+			val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, CSV2, IMP);
+		}
+		if (arm64_get_meltdown_state() == SPECTRE_UNAFFECTED) {
+			val &= ~ID_AA64PFR0_EL1_CSV3_MASK;
+			val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, CSV3, IMP);
+		}
+		if (vgic_host_has_gicv3()) {
+			val &= ~ID_AA64PFR0_EL1_GIC_MASK;
+			val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, GIC, IMP);
+		}
 		break;
-	case SYS_ID_AA64PFR1_EL1:
-		val = sanitise_id_aa64pfr1_el1(vcpu, val);
+	case SYS_ID_AA64PFR1_EL1: {
+		u64 pfr0_host = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+		if (!(cpus_have_final_cap(ARM64_HAS_RASV1P1_EXTN) &&
+		      SYS_FIELD_GET(ID_AA64PFR0_EL1, RAS, pfr0_host) == ID_AA64PFR0_EL1_RAS_IMP))
+			val &= ~ID_AA64PFR1_EL1_RAS_frac;
 		break;
+	}
 	case SYS_ID_AA64PFR2_EL1:
-		val = sanitise_id_aa64pfr2_el1(vcpu, val);
+		if (vgic_host_has_gicv5())
+			val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR2_EL1, GCIE, IMP);
 		break;
-	case SYS_ID_AA64ISAR1_EL1:
-		if (!vcpu_has_ptrauth(vcpu))
-			val &= ~(ID_AA64ISAR1_EL1_APA |
-				 ID_AA64ISAR1_EL1_API |
-				 ID_AA64ISAR1_EL1_GPA |
-				 ID_AA64ISAR1_EL1_GPI);
+	case SYS_ID_AA64MMFR3_EL1:
+		if (!system_supports_poe())
+			val &= ~ID_AA64MMFR3_EL1_S1POE;
+		break;
+	}
+
+	return val;
+}
+
+/*
+ * Statically sanitise the host's feature register, independent of the guest's
+ * configuration and host implementation.
+ */
+static u64 kvm_max_possible_guest_ftr_reg(u32 id, u64 val)
+{
+	switch (id) {
+	case SYS_ID_AA64DFR0_EL1:
+		val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64DFR0_EL1, DebugVer, V8P8);
+
+		/* Hide SPE from guests */
+		val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
+
+		/* Hide BRBE from guests */
+		val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
 		break;
 	case SYS_ID_AA64ISAR2_EL1:
-		if (!vcpu_has_ptrauth(vcpu))
-			val &= ~(ID_AA64ISAR2_EL1_APA3 |
-				 ID_AA64ISAR2_EL1_GPA3);
-		if (!cpus_have_final_cap(ARM64_HAS_WFXT) ||
-		    has_broken_cntvoff())
+		/* Mask WFxT field unless *both* WFET & WFIT are present. */
+		if (!id_has_feat(val, ID_AA64ISAR2_EL1, WFxT, IMP))
 			val &= ~ID_AA64ISAR2_EL1_WFxT;
 		break;
 	case SYS_ID_AA64ISAR3_EL1:
 		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_LSFE |
-			ID_AA64ISAR3_EL1_FAMINMAX | ID_AA64ISAR3_EL1_LSUI;
+		       ID_AA64ISAR3_EL1_FAMINMAX | ID_AA64ISAR3_EL1_LSUI;
 		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
@@ -1899,13 +1931,81 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 		       ID_AA64MMFR3_EL1_SCTLRX |
 		       ID_AA64MMFR3_EL1_S1POE |
 		       ID_AA64MMFR3_EL1_S1PIE;
-
-		if (!system_supports_poe())
-			val &= ~ID_AA64MMFR3_EL1_S1POE;
 		break;
 	case SYS_ID_MMFR4_EL1:
 		val &= ~ID_MMFR4_EL1_CCIDX;
 		break;
+	case SYS_ID_AA64PFR0_EL1:
+		val &= ~ID_AA64PFR0_EL1_AMU_MASK;
+		/*
+		 * MPAM is disabled by default as KVM also needs a set of PARTID to
+		 * program the MPAMVPMx_EL2 PARTID remapping registers with. But some
+		 * older kernels let the guest see the ID bit.
+		 */
+		val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
+		break;
+	case SYS_ID_AA64PFR1_EL1:
+		val &= ~ID_AA64PFR1_EL1_SME;
+		val &= ~ID_AA64PFR1_EL1_RNDR_trap;
+		val &= ~ID_AA64PFR1_EL1_NMI;
+		val &= ~ID_AA64PFR1_EL1_GCS;
+		val &= ~ID_AA64PFR1_EL1_THE;
+		val &= ~ID_AA64PFR1_EL1_MTEX;
+		val &= ~ID_AA64PFR1_EL1_PFAR;
+		val &= ~ID_AA64PFR1_EL1_MPAM_frac;
+		break;
+	case SYS_ID_AA64PFR2_EL1:
+		val &= ID_AA64PFR2_EL1_FPMR |
+		       ID_AA64PFR2_EL1_MTEFAR |
+		       ID_AA64PFR2_EL1_MTESTOREONLY;
+		break;
+	}
+
+	return val;
+}
+
+/*
+ * Sanitise based on vCPU configuration.
+ */
+static u64 kvm_sanitise_vcpu_ftr_reg(const struct kvm_vcpu *vcpu, u32 id, u64 val)
+{
+	switch (id) {
+	case SYS_ID_AA64DFR0_EL1:
+		/*
+		 * Only initialize the PMU version if the vCPU was configured with one.
+		 */
+		val &= ~ID_AA64DFR0_EL1_PMUVer_MASK;
+		if (kvm_vcpu_has_pmu(vcpu))
+			val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, PMUVer,
+					      kvm_arm_pmu_get_pmuver_limit());
+		break;
+	case SYS_ID_AA64PFR0_EL1:
+		if (!vcpu_has_sve(vcpu))
+			val &= ~ID_AA64PFR0_EL1_SVE_MASK;
+		break;
+	case SYS_ID_AA64PFR1_EL1:
+		if (!kvm_has_mte(vcpu->kvm)) {
+			val &= ~ID_AA64PFR1_EL1_MTE;
+			val &= ~ID_AA64PFR1_EL1_MTE_frac;
+		}
+		break;
+	case SYS_ID_AA64PFR2_EL1:
+		if (!kvm_has_mte(vcpu->kvm)) {
+			val &= ~ID_AA64PFR2_EL1_MTEFAR;
+			val &= ~ID_AA64PFR2_EL1_MTESTOREONLY;
+		}
+		break;
+	case SYS_ID_AA64ISAR1_EL1:
+		if (!vcpu_has_ptrauth(vcpu))
+			val &= ~(ID_AA64ISAR1_EL1_APA |
+				 ID_AA64ISAR1_EL1_API |
+				 ID_AA64ISAR1_EL1_GPA |
+				 ID_AA64ISAR1_EL1_GPI);
+		break;
+	case SYS_ID_AA64ISAR2_EL1:
+		if (!vcpu_has_ptrauth(vcpu))
+			val &= ~(ID_AA64ISAR2_EL1_APA3 |
+				 ID_AA64ISAR2_EL1_GPA3);
 	}
 
 	if (vcpu_has_nv(vcpu))
@@ -1914,6 +2014,23 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 	return val;
 }
 
+/* Read a sanitised cpufeature ID register by sys_reg_desc */
+static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
+				       const struct sys_reg_desc *r)
+{
+	u32 id = reg_to_encoding(r);
+	u64 val;
+
+	if (sysreg_visible_as_raz(vcpu, r))
+		return 0;
+
+	val = kvm_sanitised_host_ftr_reg(id);
+	val = kvm_max_possible_guest_ftr_reg(id, val);
+	val = kvm_sanitise_vcpu_ftr_reg(vcpu, id, val);
+
+	return val;
+}
+
 static u64 kvm_read_sanitised_id_reg(struct kvm_vcpu *vcpu,
 				     const struct sys_reg_desc *r)
 {
@@ -2046,108 +2163,6 @@ static unsigned int fp8_visibility(const struct kvm_vcpu *vcpu,
 	return REG_HIDDEN;
 }
 
-static u64 sanitise_id_aa64pfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
-{
-	if (!vcpu_has_sve(vcpu))
-		val &= ~ID_AA64PFR0_EL1_SVE_MASK;
-
-	/*
-	 * The default is to expose CSV2 == 1 if the HW isn't affected.
-	 * Although this is a per-CPU feature, we make it global because
-	 * asymmetric systems are just a nuisance.
-	 *
-	 * Userspace can override this as long as it doesn't promise
-	 * the impossible.
-	 */
-	if (arm64_get_spectre_v2_state() == SPECTRE_UNAFFECTED) {
-		val &= ~ID_AA64PFR0_EL1_CSV2_MASK;
-		val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, CSV2, IMP);
-	}
-	if (arm64_get_meltdown_state() == SPECTRE_UNAFFECTED) {
-		val &= ~ID_AA64PFR0_EL1_CSV3_MASK;
-		val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, CSV3, IMP);
-	}
-
-	if (vgic_host_has_gicv3()) {
-		val &= ~ID_AA64PFR0_EL1_GIC_MASK;
-		val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR0_EL1, GIC, IMP);
-	}
-
-	val &= ~ID_AA64PFR0_EL1_AMU_MASK;
-
-	/*
-	 * MPAM is disabled by default as KVM also needs a set of PARTID to
-	 * program the MPAMVPMx_EL2 PARTID remapping registers with. But some
-	 * older kernels let the guest see the ID bit.
-	 */
-	val &= ~ID_AA64PFR0_EL1_MPAM_MASK;
-
-	return val;
-}
-
-static u64 sanitise_id_aa64pfr1_el1(const struct kvm_vcpu *vcpu, u64 val)
-{
-	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
-
-	if (!kvm_has_mte(vcpu->kvm)) {
-		val &= ~ID_AA64PFR1_EL1_MTE;
-		val &= ~ID_AA64PFR1_EL1_MTE_frac;
-	}
-
-	if (!(cpus_have_final_cap(ARM64_HAS_RASV1P1_EXTN) &&
-	      SYS_FIELD_GET(ID_AA64PFR0_EL1, RAS, pfr0) == ID_AA64PFR0_EL1_RAS_IMP))
-		val &= ~ID_AA64PFR1_EL1_RAS_frac;
-
-	val &= ~ID_AA64PFR1_EL1_SME;
-	val &= ~ID_AA64PFR1_EL1_RNDR_trap;
-	val &= ~ID_AA64PFR1_EL1_NMI;
-	val &= ~ID_AA64PFR1_EL1_GCS;
-	val &= ~ID_AA64PFR1_EL1_THE;
-	val &= ~ID_AA64PFR1_EL1_MTEX;
-	val &= ~ID_AA64PFR1_EL1_PFAR;
-	val &= ~ID_AA64PFR1_EL1_MPAM_frac;
-
-	return val;
-}
-
-static u64 sanitise_id_aa64pfr2_el1(const struct kvm_vcpu *vcpu, u64 val)
-{
-	val &= ID_AA64PFR2_EL1_FPMR |
-	       ID_AA64PFR2_EL1_MTEFAR |
-	       ID_AA64PFR2_EL1_MTESTOREONLY;
-
-	if (!kvm_has_mte(vcpu->kvm)) {
-		val &= ~ID_AA64PFR2_EL1_MTEFAR;
-		val &= ~ID_AA64PFR2_EL1_MTESTOREONLY;
-	}
-
-	if (vgic_host_has_gicv5())
-		val |= SYS_FIELD_PREP_ENUM(ID_AA64PFR2_EL1, GCIE, IMP);
-
-	return val;
-}
-
-static u64 sanitise_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
-{
-	val = ID_REG_LIMIT_FIELD_ENUM(val, ID_AA64DFR0_EL1, DebugVer, V8P8);
-
-	/*
-	 * Only initialize the PMU version if the vCPU was configured with one.
-	 */
-	val &= ~ID_AA64DFR0_EL1_PMUVer_MASK;
-	if (kvm_vcpu_has_pmu(vcpu))
-		val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, PMUVer,
-				      kvm_arm_pmu_get_pmuver_limit());
-
-	/* Hide SPE from guests */
-	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
-
-	/* Hide BRBE from guests */
-	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
-
-	return val;
-}
-
 /*
  * Older versions of KVM erroneously claim support for FEAT_DoubleLock with
  * NV-enabled VMs on unsupporting hardware. Silently ignore the incorrect
-- 
2.53.0

