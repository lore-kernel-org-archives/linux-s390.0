Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981339;
	b=3vg9PFNbSQihWInvSRSyNKGBJyntcK1DRaopeVTRhJNiMpWh0GdOaLPhA4aQndFrNyNZ
	 rlCPCc8ohmTat2H114oMUBHHTIPAqv5xQrC4+u9p7Cjyi/VTdrN7Ux8L6xkKRrzdTxH4r
	 2OjmP5jKo9iNbyStjtlyouNmsoH23dL/hupUELsFiPI/PimSC3ysRDMfVO2NAiXcSIDg4
	 e1zZ8AJq8EA9x0JZHANt2xD2ANqwsjVQcyKi4np98p37P78OAjwZku+g5Hf0Uf2SX8v3F
	 dVoi9ioYG4YzaSSrvQmUNgeFHLGT34mIOyP9Clh0ihCV/3xn2rfoV0098RZLSBQNDdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=NK1ncpQQ2MGpkAFk7qjO6qzN1detDKATT7WX01gV3Y8=;
	b=lJspe7u2ilTxboAYiynxG9lq6lIuDA7X+cSKVGHDrFW/Ko3GddRK4QjxcLOty2v3Zdp7
	 m9E7xm+92AIRZxHaC2M+a+9UJOi7wiiEqXAeMxJIHjGgDbDeRtH5ApL85mUNY2jEHOvy5
	 uRAkwLuitTqWaZ6xKDJK11/YPclvVm60GnVngxjAEDvxjiinsrLtJDAl4J4eXDbTX8YrL
	 PX0i4rvMsRVVRbsvKICs1B2uai3raXYQ+U7taeX4bP6AsdVYkWQlxWq2mmnwZLw3E21Mv
	 w1nTrT0txpzi+DsgnMj6lfHZvAgnLZyGB1hPdUNIVoKgAE7GWjx8gjnCq3slg1jRssw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E+GVrtkp;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D36606D804;
	Fri,  6 Nov 2026 16:08:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51D36606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E+GVrtkp
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEBDf2656377;
	Fri, 6 Nov 2026 16:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NK1ncp
	QQ2MGpkAFk7qjO6qzN1detDKATT7WX01gV3Y8=; b=E+GVrtkpS1hUnpJVyRYIG7
	8u/9C2zs9cpgy+TCJrH6jFGtjA9zRJ7sfZbZb4ftpne8G2djJ1CYhfkE8RIXVrvk
	jX8MTo36Vlt7zRjEu3rtctw6iVg/VEMwDVW0vztVzzxEIBvB3dsz7cltL0cxwZ/P
	4SY9/+CWBWPVMSowuCHqtDZ0U3Z3Xnn5JpiQe4dgTmecxx8I4ahryH0mPVQtXe0L
	uMhTCcFA++Ms7ReNyNyjNVg4uBiDZO8J5mWrJHjXRAFukeXcSqN79lgcqMFIBj2a
	YVQyxXU7+tefzxlMfflBrE0Ypo+OrltGamApVdhIMMsdvXvtz4ifYYSm14SRdWhg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc5eu4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4xo33538357;
	Fri, 6 Nov 2026 16:08:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mt4j8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8Ntd43975014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BF482005A;
	Fri,  6 Nov 2026 16:08:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3DBD2004B;
	Fri,  6 Nov 2026 16:08:22 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:22 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:55 +0100
Subject: [PATCH v3 22/23] KVM: s390: arm64: Promote PTRAUTH capability
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
Message-Id: <20261106-sysreg-v3-22-75e95980fb10@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX6A8yDMHYyeAe
 hrhC3SnsvxFHxVE/FkBFEOu/vW8HTN8Wzx6HX3OC0L2QmUCLlp5hNxX7qOlrv6ywsi0bwpW2wd2
 LjmHvGpuE8d6Kgjs7zuGyk7l0td3frw=
X-Proofpoint-GUID: ODsRC8dmwZfE-YIJ6Erp2E8XukBy9iJ2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX02HdLneLLVbp
 AthDfvA0i1Yg3RmGJmAjR1QR+wjoaGYXWcn0KWl9ceJKN58NY67bSvzyRyGCn4KcRleFfQ3+bfd
 JlFh/D2xof/YOD0+kAKQULLfBLyGZPXKBQpt07IB6e4vCziwvrbCLsZ+JNFd/KEr2B8wqyj55YV
 vxPR1zYAinkDNCbb9h0WpYd6OLZtpi5zimvaGloHmtc1DOx2yG6DyroEYPe++lxOo6BPv4riYbo
 qvJ1MXsKcQ0p3xmkSXvpPr5/8sNZ/4kwfDEnxYY5xGvlAh5gfKXTlVDX99AUEFW10S7m3bl/R14
 39BOy0SiOC2mwS+q4QzMyJDyL73HR4fVO6zYIHPmLcDeRj3UNCGtqcNqKS9lfdLCiMbmH7+N/Qp
 1OAPPg02X/pRTNHftbStisA7ZJwscdpeJ6Rs1sMufLcrwcpRlh1sXbx79DLpQPnCfmjAZhwaspv
 i6NkRoZjBVJgvmfT/zg==
X-Proofpoint-ORIG-GUID: ODsRC8dmwZfE-YIJ6Erp2E8XukBy9iJ2
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aedfb7b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Z9ZwPO1K5bdhHLDsFksA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Promote the pointer authentication capability if supported by hardware
and allow userspace to access those.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h | 12 ++++--------
 arch/s390/kvm/arm64/arm.c              | 17 +++++++++++++++++
 arch/s390/kvm/arm64/feature.c          | 18 ++++++++++++++++++
 arch/s390/kvm/arm64/feature.h          |  5 +++++
 arch/s390/kvm/arm64/sys_regs.c         | 10 ++++++++--
 5 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index f096faceb19d..5a443bba0018 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -34,8 +34,10 @@ bool cpus_have_final_cap(unsigned int num);
 #define KVM_MAX_VCPUS 1
 #define __KVM_HAVE_VCPU_RUN_PID_CHANGE
 
-#define KVM_S390_ARM64_IMPL_FEATURES (		\
-	 BIT(KVM_ARM_VCPU_SVE)			\
+#define KVM_S390_ARM64_IMPL_FEATURES (			\
+	 BIT(KVM_ARM_VCPU_PTRAUTH_ADDRESS)	|	\
+	 BIT(KVM_ARM_VCPU_PTRAUTH_GENERIC)	|	\
+	 BIT(KVM_ARM_VCPU_SVE)				\
 )
 #define KVM_HALT_POLL_NS_DEFAULT 50000
 
@@ -132,7 +134,6 @@ struct kvm_vcpu_stat {
 };
 
 #define kvm_has_mte(_kvm) false
-#define vcpu_has_ptrauth(_vcpu) false
 
 #define kvm_has_fpmr(kvm) \
 	 kvm_has_feat((kvm), ID_AA64PFR2_EL1, FPMR, IMP)
@@ -172,11 +173,6 @@ struct kvm_vm_stat {
 	struct kvm_vm_stat_generic generic;
 };
 
-static inline bool system_has_full_ptr_auth(void)
-{
-	return true;
-}
-
 #define kvm_vm_is_protected(_kvm) false
 #define vcpu_is_protected(_vcpu) false
 
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 8c2a07a96ee3..ee05d7d9f331 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -57,6 +57,10 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ARM_SVE:
 		ret = system_supports_sve();
 		break;
+	case KVM_CAP_ARM_PTRAUTH_ADDRESS:
+	case KVM_CAP_ARM_PTRAUTH_GENERIC:
+		ret = kvm_has_full_ptr_auth();
+		break;
 	default:
 		ret = 0;
 	}
@@ -227,6 +231,12 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
 }
 
+static void vcpu_set_pauth_traps(struct kvm_vcpu *vcpu)
+{
+	if (vcpu_has_ptrauth(vcpu))
+		vcpu->arch.hcr_el2 |= (HCR_EL2_API | HCR_EL2_APK);
+}
+
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	save_access_regs(&vcpu->arch.host_acrs[0]);
@@ -235,6 +245,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	lasrm(&vcpu->arch.save_area);
 
 	vcpu->arch.sae_block.gpto = vcpu->kvm->arch.epd;
+
+	vcpu_set_pauth_traps(vcpu);
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -270,6 +282,11 @@ static unsigned long system_supported_vcpu_features(struct kvm_vcpu *vcpu)
 	if (!system_supports_sve())
 		clear_bit(KVM_ARM_VCPU_SVE, &features);
 
+	if (!kvm_has_full_ptr_auth()) {
+		clear_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, &features);
+		clear_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, &features);
+	}
+
 	return features;
 }
 
diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
index 0979e0cadc66..13a56647d78c 100644
--- a/arch/s390/kvm/arm64/feature.c
+++ b/arch/s390/kvm/arm64/feature.c
@@ -168,3 +168,21 @@ bool system_supports_sve(void)
 			     read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)) ==
 		       ID_AA64PFR0_EL1_SVE_IMP;
 }
+
+bool system_has_full_ptr_auth(void)
+{
+	u64 isar1 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR1_EL1);
+	u64 isar2 = read_sanitised_ftr_reg(SYS_ID_AA64ISAR2_EL1);
+	bool address_auth;
+	bool generic_auth;
+
+	address_auth = SYS_FIELD_GET(ID_AA64ISAR1_EL1, APA, isar1) >= ID_AA64ISAR1_EL1_APA_PAuth ||
+		       SYS_FIELD_GET(ID_AA64ISAR1_EL1, API, isar1) >= ID_AA64ISAR1_EL1_API_PAuth ||
+		       SYS_FIELD_GET(ID_AA64ISAR2_EL1, APA3, isar2) >= ID_AA64ISAR2_EL1_APA3_PAuth;
+
+	generic_auth = SYS_FIELD_GET(ID_AA64ISAR1_EL1, GPA, isar1) >= ID_AA64ISAR1_EL1_GPA_IMP ||
+		       SYS_FIELD_GET(ID_AA64ISAR1_EL1, GPI, isar1) >= ID_AA64ISAR1_EL1_GPI_IMP ||
+		       SYS_FIELD_GET(ID_AA64ISAR2_EL1, GPA3, isar2) >= ID_AA64ISAR2_EL1_GPA3_IMP;
+
+	return address_auth && generic_auth;
+}
diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
index 9af6173f6b11..3ca1ce0139b0 100644
--- a/arch/s390/kvm/arm64/feature.h
+++ b/arch/s390/kvm/arm64/feature.h
@@ -89,4 +89,9 @@ static inline u64 kvm_sae_irptc(void)
 
 bool system_supports_sve(void);
 
+#define vcpu_has_ptrauth(vcpu)						\
+	 (vcpu_has_feature(vcpu, KVM_ARM_VCPU_PTRAUTH_ADDRESS) ||       \
+	  vcpu_has_feature(vcpu, KVM_ARM_VCPU_PTRAUTH_GENERIC))
+bool system_has_full_ptr_auth(void);
+
 #endif /* ARCH_S390_KVM_FEATURE_H */
diff --git a/arch/s390/kvm/arm64/sys_regs.c b/arch/s390/kvm/arm64/sys_regs.c
index 951a02d89fc5..8ee17e7fd388 100644
--- a/arch/s390/kvm/arm64/sys_regs.c
+++ b/arch/s390/kvm/arm64/sys_regs.c
@@ -32,7 +32,6 @@ static u64 __ro_after_init boot_cpu_aidr_val;
 #undef __INCL_GEN_ARM_FILE
 
 DEFINE_STATIC_KEY_FALSE(broken_cntvoff_key);
-
 #define SR_INVALID 0x8badf00d8badf00d
 
 enum sr_loc_attr {
@@ -634,6 +633,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_TTBR1_EL1), access_rw, reset_val, TTBR1_EL1, 0 },
 	{ SYS_DESC(SYS_TCR_EL1), access_rw, reset_val, TCR_EL1, 0 },
 
+	/* CRm = 1 */
+	PTRAUTH_KEY(APIA),
+	PTRAUTH_KEY(APIB),
+	/* CRm = 2 */
+	PTRAUTH_KEY(APDA),
+	PTRAUTH_KEY(APDB),
+	/* CRm = 3 */
+	PTRAUTH_KEY(APGA),
 	/* CRn = 5 */
 	{ SYS_DESC(SYS_AFSR0_EL1), access_rw, reset_unknown, AFSR0_EL1 },
 	{ SYS_DESC(SYS_AFSR1_EL1), access_rw, reset_unknown, AFSR1_EL1 },
@@ -642,7 +649,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_FAR_EL1), access_rw, reset_unknown, FAR_EL1 },
 	/* CRn = 7 */
 	{ SYS_DESC(SYS_PAR_EL1), access_rw, reset_unknown, PAR_EL1 },
-
 	{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
 	/* CRn = 10 */
 	{ SYS_DESC(SYS_MAIR_EL1), NULL, reset_unknown, MAIR_EL1 },

-- 
2.56.0

