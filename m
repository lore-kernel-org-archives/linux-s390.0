Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953A3603DF;
	Thu,  2 Apr 2026 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103721; cv=none; b=e+TZTu10lQyODX0/3J7F4RMk4splk9EiYL5S8azidgpgi26NVEnIkDz6TLbqTL1TSyiWvFcIRaR8LELo2CjByB397L6dzMZWyozLNYWKAJZampQKeo3yc1yATwWSXo2vEv1vMT96iQSBrDrWSxOfmpOOEOZbAq3UoTEqIX/p0qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103721; c=relaxed/simple;
	bh=N/VSvqn2JYFfBg/P+IN7v6sCIHdZ7lS9J0WyACXKEZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jdam8B0CSDR8wTNBdMYmZsif8q7uIIiDR36xyQraL2h69u/+Yzef3f7dpcmmuBGQpZxNLBwyDJlmoCcLX+YLj5Fixw2u6k8xCxqv8qMtUs+TvtlzpjyytlI2tODkZrMS0JTJtU7viQbBw3SSisSRA2LZOquVXvJwGoN76COFffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQ/OiA77; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQ/OiA77"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631KJDuN202727;
	Thu, 2 Apr 2026 04:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dKzSuHEOWIKZpSWOw
	Okk+3mV6Q3g/wNdlvSBX4J10R0=; b=qQ/OiA77nJbpICVKaK2tFPhHC5wuq4ooz
	UOhQYd8SoG18/N+xG36+sIdUtnd8A4V77XHk5sGsIyQGWdBbMn6Z3nTv8b23f787
	g9PWA8R8AuNUtsBI/CUyxp1I2nSdXRvSPP8O/B6h6N1zlMdnmjMm6zGS9vQb23L1
	zc6fPaoEXgSdzJfpJo116+oRAIwQZG+6dh2mm361+lMJqd4finKFnhL/FX9omDxN
	iKjWH/Sut8deEZ4sBPMw8qFRDnj9Z7SBrY/NF9CZBfVPh1uaCnsxsTPrmh+JFv6W
	smQStJhk4y8vw210AOtOLl12kcG6ISWB9DcCSYS+62MBIJlVYU3gQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnu7sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63218UYQ030995;
	Thu, 2 Apr 2026 04:21:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk0ee7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LVkJ52166966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1124620040;
	Thu,  2 Apr 2026 04:21:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC2452004F;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:30 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v1 13/27] KVM: arm64: Extract & share ipa size shift calculation
Date: Thu,  2 Apr 2026 06:21:09 +0200
Message-ID: <20260402042125.3948963-14-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Aqpm_17dFFJhVhS3HSEJLOS10jh5pdEa
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cdeed0 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=MB2ALdkwiJlipvWvu_wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX/HVbOUwUc316
 pSXOoYbhiSCDWHZZwzkW30Ca7QeUTOTIo+GdtAVjCWDMVkHaF2egp2rjSvvxYS6t3YX7pF2I/KZ
 wgpAUqvN5mgjpMW6v1fF6RmytDyyqeVRfrz13uonBqGOvmeDw0SLvIAViAIwN3Enff1HQgE/rw+
 8ZdP3WtRFJeZZ9lD/81N3UGF7jm71oTU255QwAeWJAMcL+37CHUcCyl2rUfT2yUX1YgMgg7RKiM
 nzLbhane0NmSJgsOnTH6wpq6/dL6cbMlqhPvoB3fWfDAiWuUs3vrOxGu1TtZJxB4y8qkv7Sw0zi
 SjHoh1cMncJeYPFVoLKi4ZceyXE0ofzlEv3sYD2A3CgbYlINHBLhVz4YQxCM5mIWjfYj0hUWYrE
 fVFUW6yHxCi59mMemfgGSR0q1m6zsm9sRJwW0fYehbSST7SUbq+XJoaISEqGteWALBR1BF29yOm
 1EWGxHurnSrDEXJK6pQ==
X-Proofpoint-ORIG-GUID: Aqpm_17dFFJhVhS3HSEJLOS10jh5pdEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020034

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
 arch/arm64/kvm/mmu.c         | 18 ++++++------------
 include/kvm/arm64/kvm_host.h |  1 +
 virt/kvm/arm64/arm.c         | 21 +++++++++++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index e19ff77b3cd5..9d71bb3627fc 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -874,27 +874,21 @@ static struct kvm_pgtable_mm_ops kvm_s2_mm_ops = {
 
 static int kvm_init_ipa_range(struct kvm_s2_mmu *mmu, unsigned long type)
 {
-	u32 kvm_ipa_limit = get_kvm_ipa_limit();
 	u64 mmfr0, mmfr1;
 	u32 phys_shift;
+	int r;
 
 	if (type & ~KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
 		return -EINVAL;
 
 	phys_shift = KVM_VM_TYPE_ARM_IPA_SIZE(type);
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
index 20b824ecf16e..8c39ec485730 100644
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

