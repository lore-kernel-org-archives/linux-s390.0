Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6814403E8C;
	Fri, 29 May 2026 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780070204; cv=none; b=REhrACZnU9ZR4wYmCXWq/UiQ9aGWhpKZLXp//S0i6k1C0+cLBT5VzCD8ZR8Ip75OjVdRkzzUQvpAGa+f+J4tyiEFCObCk1h2NRT+O4UGaMMRrdZOUoZaw1D7jhPEMkxy11kGHOsMfjCmRlEXQeFL7SIXDKsP50FLL5XN3oaeqNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780070204; c=relaxed/simple;
	bh=2T0IcOBvlQduoOdEXyL/k5QW4zteu4afOmlAgQcmdMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFUt0dVpURDqzATP0DDwokdQa5RKjnJckC6fdCHPUp1ywrSCji4TqyG/kwAYiO72i0Cd4yn0al+wG2QwN2N0Tbm+AOIIljDRTfrSdbpUvmMF3XBN5Vbqv/LEZN23OEmLOwKgoenvoaV7Vhe1vpI1hM8b8UUp/ZGno3cufAw4WkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VrIdGcOw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VrIdGcOw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TF4tJ11467789;
	Fri, 29 May 2026 15:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=65ZPjGgfujvTG2FNZ
	towcxEFcacc9WDSb9CSpbn8UaE=; b=VrIdGcOw2TW//fI640IuF96wP4YN7VLPU
	9ljjCj5/SUMds5oxleVfMRfIr0nwC49/syiF4xtubaH3k9gpfRx7SjgkNg3c6Hiv
	ErM0vIk+D2feXYFATvvFZ+wYjKG6lT7emiuycU1uBQANhRM/dQqjGOAAwaFXAAjK
	1ClQoEq08GG4UwxWRm8brebvLikkrC8Uab5xfbVZIRrNQ194fu+GU8nsvhgMq9GP
	LS751ORizJ3CmSK7RvAIC6ulWZ4OMCQNHaoNE/VgwA+oGnGHbwvrwVIdk1RZejzT
	NtnfOkp9FW/SeB1AwNnHM6LkBZKvkroGLHhvWje97dcpstHvIASpQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886mgjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFs7ar009677;
	Fri, 29 May 2026 15:56:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrbgkwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:56:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFuCP549349006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:56:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5051720040;
	Fri, 29 May 2026 15:56:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 023C12004B;
	Fri, 29 May 2026 15:56:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:56:11 +0000 (GMT)
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
Subject: [PATCH v1 26/26] KVM: s390: arm64: Finalize page fault handling
Date: Fri, 29 May 2026 17:55:59 +0200
Message-ID: <20260529155601.2927240-27-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: qdGqNpQsC3UYpGpvAk8HeorvrvLc47VH
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19b723 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LtHRyupC2uTP9dkk8LUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfXx3wbluWa3lB6
 rnxFykGocU5+j9Wla02dXZFABY6qgxxpQtelKlJIA1zq/r+5dkk33gFCssPqPaqmn6mm5uIOquu
 y0yEznA2FwBjT2S35mf5TMExYrEMLlCezCINd8Tk+DMPK9YhVI6SFCMDMt6aBDu3bPg3OinGneK
 CBNSR9iTAWCWJFm3VhGwd+tj7YiycPZqoLsTzhIdtPJUPJKRlNKasI5EQsHFWRKrrmDXC6dGUch
 2Jqd7BTS0acQYinl2K27BMjQy77m7IOPvqooH4hxyFFi6BhPhmozLFO0ud7+zjIAJySreoBCNmi
 ApGgsg1hZpBDsRwIsnTUDdzESnFIwwkEy87uUZ9mP0zp26ol8XhBhQD7PvR7NKl5ffIY2ijXsxm
 xR7VvXmZHugNWOg66kXF5E1ep50oIl55lKHzaNn4wKE6W0UgQpiGQ6bzse6V5T/QIxel2nRDfRL
 3HK55T8PQmmdeKORCVQ==
X-Proofpoint-ORIG-GUID: qdGqNpQsC3UYpGpvAk8HeorvrvLc47VH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Complete the page fault handling implementation by replacing temporary
error returns with proper ARM64 exception injection.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/mmu.c       | 62 ++++++++++++++++++++++-----------
 include/kvm/arm64/kvm_feature.h |  3 ++
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
index 8759cbafbaff..4224503276fb 100644
--- a/arch/s390/kvm/arm64/mmu.c
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -31,12 +31,14 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, gpa_t fault_ipa,
 	ret = kvm_s390_faultin_gfn(vcpu, NULL, &f);
 	if (ret <= 0)
 		return ret;
-	if (ret == PGM_ADDRESSING)
+	if (ret == PGM_ADDRESSING) {
 		/*
-		 * Without the relevant sysregs we cannot do anything for now.
-		 * Go back to userspace with an error. TODO sysreg handling
+		 * There is no page with the requested address. Inject size fault
+		 * which is the closest arm match to PGM-addressing
 		 */
-		return -ENOEXEC;
+		kvm_inject_size_fault(vcpu);
+		return 1;
+	}
 	KVM_BUG_ON(ret, vcpu->kvm);
 	return -EINVAL;
 }
@@ -69,6 +71,27 @@ static int kvm_handle_pic(struct kvm_vcpu *vcpu, bool *translation)
 	return 0;
 }
 
+static u32 kvm_get_pa_bits(struct kvm *kvm)
+{
+	u32 id_parange = get_idreg_field_enum(kvm, ID_AA64MMFR0_EL1, PARANGE);
+
+	switch (id_parange) {
+	case ID_AA64MMFR0_EL1_PARANGE_32: return 32;
+	case ID_AA64MMFR0_EL1_PARANGE_36: return 36;
+	case ID_AA64MMFR0_EL1_PARANGE_40: return 40;
+	case ID_AA64MMFR0_EL1_PARANGE_42: return 42;
+	case ID_AA64MMFR0_EL1_PARANGE_44: return 44;
+	case ID_AA64MMFR0_EL1_PARANGE_48: return 48;
+	case ID_AA64MMFR0_EL1_PARANGE_52: return 52;
+	case ID_AA64MMFR0_EL1_PARANGE_56: return 56;
+	}
+	/*
+	 * Future values must be higher than we know already.
+	 * See ARM DDI 0487C.a. Return a safe limit.
+	 */
+	return ID_AA64MMFR0_EL1_PARANGE_48;
+}
+
 int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 {
 	struct kvm_memory_slot *memslot;
@@ -98,16 +121,17 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	}
 
 	if (translation) {
-		/*
-		 * For both cases:
-		 * Without the relevant sysregs we cannot do anything for now.
-		 * Go back to userspace with an error. TODO sysreg handling
-		 */
-		if (fault_ipa >= BIT_ULL(get_kvm_ipa_limit()))
-			return -ENOEXEC;
+		/* Beyond sanitised PA range (which is the IPA limit) */
+		if (fault_ipa >= BIT_ULL(kvm_get_pa_bits(vcpu->kvm))) {
+			kvm_inject_size_fault(vcpu);
+			return 1;
+		}
 
-		if (fault_ipa >= kvm_phys_size(vcpu->kvm))
-			return -ENOEXEC;
+		/* Falls between the IPA range and the PA range? */
+		if (fault_ipa >= kvm_phys_size(vcpu->kvm)) {
+			fault_ipa |= kvm_vcpu_get_hfar(vcpu) & GENMASK(11, 0);
+			return kvm_inject_sea(vcpu, is_iabt, fault_ipa);
+		}
 	}
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
@@ -123,18 +147,14 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		 * The guest has put either its instructions or its page-tables
 		 * somewhere it shouldn't have. Userspace won't be able to do
 		 * anything about this (there's no syndrome for a start).
-		 *
-		 * Without the relevant sysregs we cannot do anything for now.
-		 * Go back to userspace with an error. TODO sysreg handling
 		 */
-		if (is_iabt)
+		if (is_iabt) {
+			ret = kvm_inject_sea_iabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 			goto out_unlock;
+		}
 
 		if (kvm_vcpu_abt_iss1tw(vcpu)) {
-			/*
-			 * Without the relevant sysregs we cannot do anything for now.
-			 * Go back to userspace with an error. TODO sysreg handling
-			 */
+			ret = kvm_inject_sea_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 			goto out_unlock;
 		}
 
diff --git a/include/kvm/arm64/kvm_feature.h b/include/kvm/arm64/kvm_feature.h
index 945abbbf1aa8..193c9ca7045f 100644
--- a/include/kvm/arm64/kvm_feature.h
+++ b/include/kvm/arm64/kvm_feature.h
@@ -47,6 +47,9 @@
 
 #define kvm_has_feat_enum(kvm, ...) __kvm_has_feat_enum(kvm, __VA_ARGS__)
 
+#define get_idreg_field_enum(kvm, id, fld)				\
+	SYS_FIELD_GET(id, fld, kvm_read_vm_id_reg((kvm), SYS_##id))
+
 /* Check for a given level of PAuth support */
 #define kvm_has_pauth(k, l)						\
 	({								\
-- 
2.53.0

