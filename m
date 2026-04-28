Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4307C44CF5E;
	Tue, 28 Apr 2026 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391830; cv=none; b=JKZu6h0JWMSqmduLvHRuNw76h40c52R1poKwonKPiKlqH3MergdHkSMmG2BRHS/OMgSHtrTKkPpLDqdHpqJ5CRk4gd/1PzILYfIIUCPF5kXWhfNsDMkeAEs8zCBu80vlxEyJgE4OkZDYRGE+ESLG6sN6urOqTzmfUPTi/LShmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391830; c=relaxed/simple;
	bh=tTxMQlcFwCZw4gfE/IFBFc6ogoORlKvs6KQS6XC/Rqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj0BoOtCHlocj1V6pPZwYikeqeMaLRhIVs/hHkdhlWVAUsQjheaSWy5TzCkv/9o+e+alRNDRvc3Nc6i4MsX0J2yhMEGCc2GIZgFqvw584jeK48t7OH4N4zCYHOlaL9RP3j0LqmYZQDtoH+VGfoy/vZn2y4UFUxpLupNjMyC4i0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sch4CFOL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sch4CFOL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S5S0js2930935;
	Tue, 28 Apr 2026 15:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gpkwpjmEOahBklIHg
	JpYekLcfvR2iJqFKR0bzut9rQw=; b=sch4CFOLFnLrvq8Lc1Nuk7UX6Yv/8q9yY
	VtMJst4kXs1NIoEPrhJ0q8/KYS7GJst9hdv+GG9LuWZa66uRAM+/59GgTxSiECjR
	P5CW3Jx+QXHH7Dsl6KYZxYBBjAIY3gEi8YGE5yOZjGv6weW9RKljqu6CK8TOKbEL
	NId3oqcuu7LXhokNYY7S05iFyTGYEIOSULRwblkGCxD/mlu/Oj7cO9tT3m6K6p1J
	aCRtX0Jfpq72mWDX1d7jM3QeNQ7436SC7X3RpE8d133WT3N55oPhylcB3rDYcswy
	idiGJ4lQtWBsMaannkxdwyA74bgYVKlN4pTt5JpZ6Kb6R/fnktF5w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r6c9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrpV1015573;
	Tue, 28 Apr 2026 15:56:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avtg1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuSKF50921904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E87120040;
	Tue, 28 Apr 2026 15:56:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B88CE2004B;
	Tue, 28 Apr 2026 15:56:27 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:27 +0000 (GMT)
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
Subject: [PATCH v2 13/28] KVM: arm64: Extract & share ipa size shift calculation
Date: Tue, 28 Apr 2026 17:56:05 +0200
Message-ID: <20260428155622.1361364-14-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428155622.1361364-1-seiden@linux.ibm.com>
References: <20260428155622.1361364-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ICtvLpBow4uNZ5nBldPC2INt3bM21t59
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX9yyWt+gujThE
 3MIoyrtmWWXuEmqcRpWRDG+wJEu/sea8vbQyXGGduOj0+Xouun8V/OloBluriC6csyzR08aDUiv
 X3Mwc3TcvKRpm4r0UOTOBtaXopBHbENqVQbHXoBUh5vBw3cD7m6sRyWzFpCGU/0UrftKmqRrXwN
 IzxhgSamVoEPv0QYryoZJd15hboN3r/h3wOdruqeLoQll0gQ5nhcv0CoyRWUxV/jUPnBsnRDsdp
 Gnyzilb/Iyfikv3V2/DDAQqAsz4JHWKJaBmkc504AxWTNsCsz3ooQ/UFwLfKqB+n2GQj4osLNiR
 m2EIEBtGA0fzMGTEndLP/h67W9qb7UrH9v7SKWBHdJ6/ZnS+lSLuAOn4Ybo8v5IyiVQ/uGVFvmu
 z+zqD7bDpMXLWg5GOq7NlgZcVG+vaVKYehuq1X/8oGYsIkByWiKQ9XyWTZM8I1H//zNQR4Xixsf
 E/MRwknSSi/HIAHwSOA==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0d8b1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MB2ALdkwiJlipvWvu_wA:9
X-Proofpoint-ORIG-GUID: ICtvLpBow4uNZ5nBldPC2INt3bM21t59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

Extract the ipa shift calculation from kvm_init_ipa_range into its own
function kvm_vm_type_ipa_size_shift to be shared across architectures.

User space passes a type parameter to the VM creation ioctl, indicating
the physical size of the VM. Therefore extract the ipa shift calculation
from kvm_init_ipa_range into its own function kvm_vm_type_ipa_size_shift,
so all implementers of arm64 KVM can make use of it for VM creation.

Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/kvm/mmu.c         | 19 ++++++-------------
 include/kvm/arm64/kvm_host.h |  1 +
 virt/kvm/arm64/arm.c         | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index e19ff77b3cd5..bec52291bc0c 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -874,27 +874,20 @@ static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
 
 static int kvm_init_ipa_range(struct kvm_s2_mmu *mmu, unsigned long type)
 {
-	u32 kvm_ipa_limit = get_kvm_ipa_limit();
 	u64 mmfr0, mmfr1;
 	u32 phys_shift;
+	int r;
 
 	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 		return -EINVAL;
 
-	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
 	if (is_protected_kvm_enabled()) {
-		phys_shift = kvm_ipa_limit;
-	} else if (phys_shift) {
-		if (phys_shift > kvm_ipa_limit ||
-		    phys_shift < ARM64_MIN_PARANGE_BITS)
-			return -EINVAL;
+		phys_shift = get_kvm_ipa_limit();
 	} else {
-		phys_shift = KVM_PHYS_SHIFT;
-		if (phys_shift > kvm_ipa_limit) {
-			pr_warn_once("%s using unsupported default IPA limit, upgrade your VMM\n",
-				     current->comm);
-			return -EINVAL;
-		}
+		r = kvm_vm_type_ipa_size_shift(type);
+		if (r < 0)
+			return r;
+		phys_shift = r;
 	}
 
 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
diff --git a/include/kvm/arm64/kvm_host.h b/include/kvm/arm64/kvm_host.h
index d36ebea4d60f..8bf399508757 100644
--- a/include/kvm/arm64/kvm_host.h
+++ b/include/kvm/arm64/kvm_host.h
@@ -33,6 +33,7 @@ int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
 				 const struct kvm_vcpu_init *init);
 bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
 			   const struct kvm_vcpu_init *init);
+int kvm_vm_type_ipa_size_shift(unsigned long type);
 
 /* MMIO helpers */
 void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
diff --git a/virt/kvm/arm64/arm.c b/virt/kvm/arm64/arm.c
index b47adef65e5f..0bbfbe63e558 100644
--- a/virt/kvm/arm64/arm.c
+++ b/virt/kvm/arm64/arm.c
@@ -52,3 +52,24 @@ bool kvm_vcpu_init_changed(struct kvm_vcpu *vcpu,
 	return !bitmap_equal(vcpu->kvm->arch.vcpu_features, &features,
 			     KVM_VCPU_MAX_FEATURES);
 }
+
+int kvm_vm_type_ipa_size_shift(unsigned long type)
+{
+	int phys_shift;
+
+	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
+	if (phys_shift) {
+		if (phys_shift > get_kvm_ipa_limit() ||
+		    phys_shift < ARM64_MIN_PARANGE_BITS)
+			return -EINVAL;
+	} else {
+		phys_shift = KVM_PHYS_SHIFT;
+		if (phys_shift > get_kvm_ipa_limit()) {
+			pr_warn_once("%s using unsupported default IPA limit, upgrade your VMM\n",
+				     current->comm);
+			return -EINVAL;
+		}
+	}
+
+	return phys_shift;
+}
-- 
2.51.0

