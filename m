Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789448;
	b=SHGOOnzbc8lOfOs3cWpVVlcFdiiLe9+umzuq9U7Qks7Brepwrw/LuUAM1UZcQcfbhPeb
	 3dpPjoGWSy8y599f9fcFolr26tuIu15S+UPL0dcGkh/XVQ5I6SbICvIiz+0Mufc2VAzxE
	 6tJb1MxWzbONnUFHIOJXPv5x/5Py8G4EkCX6nxcxLiQB3sI1kLDvU2px90mWnUsvgM1nM
	 ljV1/hqM12LFjkqiMBZLnDND08TDViirVykDO9ihYSQq4mBJw8a8nUkFnetmdpsRTv/AQ
	 NFWrlGXUHYf2jAiCwkdORBkwBmUCR6nVQwlSR+d2SMBITtVHrR1mGJBIqeUGqA6tDuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789448;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=OOI9+qdxzwaIBiV3QCDuxZoO6ODGYcCUsZ6w/cxwluo=;
	b=dD8OdkC0Rzj+NRE5boIoWDhfLOiMnIjs6IfWHp7h/KwseUHM0L+tcoVwdZ8N7o5qq6Pv
	 q1K8RQf6cNSW6IMWo75ka29fPuMwaTg1T2TVm8k/j8NcjT/AaVK6nFsKVaujnQT7KKik0
	 7MNTgK3QYh/akuQ1pIc4zQNufTID9pcj9FVkG/W/wgjtb77g1ZYtXLiAza5KmK2UBvzxo
	 xBPbPIapD89HWQxsY7gYLjfuDdRmAD7ZEXfDgwPMrctcrLu9CmV/oE1V3qwh83gtpxHXo
	 kHWCU9Xo5g2qjbmKUWTbr0/GfGz9gTj0xpWhbN5U+dHX4/1tuafgebeVQfrQ6HIV5bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E0yVmGAz;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F96560A2604;
	Fri, 27 Nov 2026 14:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F96560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E0yVmGAz
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4Yxq1650069;
	Fri, 27 Nov 2026 14:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OOI9+q
	dxzwaIBiV3QCDuxZoO6ODGYcCUsZ6w/cxwluo=; b=E0yVmGAzSbpNpxquPfdJV5
	ElzcmNjRUZifJmBf8YB+TsV6boE43Xh9QnnoINsM4ZMSnesIwBa1Fxou0mPv08gN
	kr6T44XGQuNt3OT67Ka8ZiYatSd4yk7N+gFUucQ96ti3Pfyom4qxchAGrsXylNjq
	3VIB8wD6RUBPJMR+alz1X6noruDQqlhhT38nW06YYjVEZ1T13zQm1QJqqKN10EUz
	1ZE6zPUi2WKNhWmL+NV9Fi1Iq64vCtyqm3Ym+0NRshkTShvnDFHhZFwVPmtEaAVb
	4dENRXcBxYAeR2gSLiXK1JoCN1gId5kcDRi4oZx2E0F9OIriAf1hg17OQsaGNFWg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3p7jx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4KH73245757;
	Fri, 27 Nov 2026 14:23:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx951d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENQnq36176176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 157862004E;
	Fri, 27 Nov 2026 14:23:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C0EB2004F;
	Fri, 27 Nov 2026 14:23:25 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:25 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:27 +0100
Subject: [PATCH v4 24/25] KVM: s390: arm64: Promote PTRAUTH capability
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
Message-Id: <20261127-sysreg-v4-24-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b099263 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Z9ZwPO1K5bdhHLDsFksA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX7PFboSHWJxS7
 yzn+DJ8U9lK/iIQHNhfl2DeFFCknonhxB/u6z827UL19gzMtfOsED63MnEJXi7RSS1wFIEy9Vgj
 VT9CcK8XvzURhdCOmPwdLBuluVee/44=
X-Proofpoint-ORIG-GUID: iICTyvak-bYuqbchSkg_JBR8moYlT15X
X-Proofpoint-GUID: iICTyvak-bYuqbchSkg_JBR8moYlT15X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX8N4c4KXQjNoN
 Wczv+EAZc8F6AwulDnzOPgsrTiRe8uCno/Ev+ozQi+nrE92shC2GAYFLVsYT96NYjIPk/cnQZ/8
 4W5WevnM1VgtzTMvgEw3tTtB54ezbO/ED1cmenGZalo8QDhNMJ4+D5uSU1Rb0MmBLuk7HkozVXI
 YeD3Onl2mVAwvP4umpTaxD9xPLn5yI09PNrzx0iQAD4qys4ieITFO7qW3I3CMb4XDwG9T6PGkkc
 Oi94A/pwQ1oVEwRpH07LSQaSfKhYudqj6Ud6uXicRYrarTpUu6xg9cHCtmaldivsoUN63yJO8j6
 y+gf8b73DghmukFYKUoaGDLgedP4K06bJwuVK1pVhSxsM0oLai+MVCVqvAEFGovzNtEKlBsUXrx
 5jLPZJxkIRtDSbeEl/5/Kz5FbZUNDUgaceKPPj5OHcLPBwbF7+BBcYFWH4pcQ1CN20jDjhEhz5I
 jOcAy9uwCKkJ0JrDMvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

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
index d09ed3a211f3..a76e1bfc64bb 100644
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
@@ -173,11 +174,6 @@ struct kvm_vm_stat {
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
index b06c101ef6a9..cd59a382a70c 100644
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
index fc5b159a94b3..41c9e14784d3 100644
--- a/arch/s390/kvm/arm64/feature.c
+++ b/arch/s390/kvm/arm64/feature.c
@@ -158,3 +158,21 @@ bool system_supports_sve(void)
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
index e6916d8064c3..57c8945fb46f 100644
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
index e240efb77b9b..50979e29fec4 100644
--- a/arch/s390/kvm/arm64/sys_regs.c
+++ b/arch/s390/kvm/arm64/sys_regs.c
@@ -33,7 +33,6 @@ static u64 __ro_after_init boot_cpu_aidr_val;
 #undef __INCL_GEN_ARM_FILE
 
 DEFINE_STATIC_KEY_FALSE(broken_cntvoff_key);
-
 #define SR_INVALID 0x8badf00d8badf00d
 
 enum sr_loc_attr {
@@ -639,6 +638,14 @@ static const struct sys_reg_desc sys_reg_descs[] = {
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
@@ -647,7 +654,6 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_FAR_EL1), access_rw, reset_unknown, FAR_EL1 },
 	/* CRn = 7 */
 	{ SYS_DESC(SYS_PAR_EL1), access_rw, reset_unknown, PAR_EL1 },
-
 	{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
 	/* CRn = 10 */
 	{ SYS_DESC(SYS_MAIR_EL1), NULL, reset_unknown, MAIR_EL1 },

-- 
2.56.1

