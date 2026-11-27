Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789450;
	b=MeE/VW5k2rcx97FfBySfQ0ZBxKRxCUSzVQhhjFuUye5b4GsX0ZrBlkPc/VdEWjIUIPGh
	 9p7E3jmzS/0az1fOiJz0oWYjv25xJySlL2pq855n2hYPHW9esnOao/OdCyPXwgE6ZncHK
	 VQLEJJ8ATAXjoR9TWdYeXWsoWQFGxtdSDz9jKU07RoETKNxbviRknzi8gO9Xz7n2QjN3g
	 YIloSdXrCqYCtVXhA+VWksLEenObGArsEsr3BG9ezWWIq4yJLg8mtsCBlVOHLN/4AZBWu
	 4BN2JG7uDwNojli0iE42NrEdo8Amr7Fcl3qvK8ZHzDM7k3Z9ZasJnqWuHBDq4yHJryA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789450;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YMX977tVKT1kMFZ9hR2HHIUzA9ctZCXTB2uOD/RANGw=;
	b=iZtJvR9d3YqQ+bszS5C1lZ4hncsYlAsf/rJhsroAMyFVMybaKjIu2AdSk+R5PbdyGlbT
	 9/oji/I2ai87KMNGwXJq7pd5LOXOEsPfZnfhWXpMiyFY/2+ssr4OnHJbs53aLBJeRaetQ
	 PCi4sEgjfXWFFRf2rqduU0zLjQ/lx7i5kbngEnw2IQqOq81R5JPHUGIx7rKZi3/VhVih3
	 FTDEFXhmII5IQ1zRbqNIo4elh7lRYJdxwRKrR9c9ecSdc6Nkztp/7JzRGK8/yWoeCMGje
	 5VIFss4pFSTln3Vixmgs0FULMqfxLvS1gq4/G7vk3lRzw1OGeHDSmQthe5W5264aYCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r7zKvhRg;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5C160A2616;
	Fri, 27 Nov 2026 14:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD5C160A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r7zKvhRg
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4VDn1649990;
	Fri, 27 Nov 2026 14:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YMX977
	tVKT1kMFZ9hR2HHIUzA9ctZCXTB2uOD/RANGw=; b=r7zKvhRgr+lWpyVOQUPKPe
	OCW6LTcDcn+49qzRqvs5JaSaeTvpvxALGkcV7kkFPO2D2WrSn+GsUKDpKFyB7Ml9
	aRY95hIBgmSDGojlAx9Q6vCU/jdfHuPTQ1MzZPjhY1LMGoI7kdm0wxxUgKoleqfm
	ugl5Cdc3AuMGBh+10fEZq7mj3sHO6m8YP8czADPNF7AgJX7tR8cRzfEy236AHBrc
	hkOmFb+MuOUnEBOuSt87QUIDaTz3nE+da/R/aVZrVXLBISKjZ56ITwMN4nLPJelM
	5InKSXLH53EK09kHTk2XXq5rqAxy5kcU7xehW2GFulM2UVbo1Qc0A9oN+1HTytrg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3p7jd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4KH43245757;
	Fri, 27 Nov 2026 14:23:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5uxx9514-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENNO749545662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4CED2006A;
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 338872006B;
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:23 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:22 +0100
Subject: [PATCH v4 19/25] KVM: s390: arm64: Integrate system registers into
 the host
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
Message-Id: <20261127-sysreg-v4-19-a6318d18aab5@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b099261 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=47U2-Vcuqj23hnRoSkAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX9fkYunKDvITS
 7JJalKT/tWXlCZnlkHDouz00q39LKIRfIgDrbI730Yv1HBQzaDkso1cmCLJDBbO6U15EVJarotP
 GKS0ETPVKtA8zTseC8FF2qa4CX9nXpY=
X-Proofpoint-ORIG-GUID: X93LnqgBqi0g1XXYcEpZQIAZM7BM5TrR
X-Proofpoint-GUID: X93LnqgBqi0g1XXYcEpZQIAZM7BM5TrR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX3KBerBeKscFz
 D6bT2BIUQEJqwn6JKGO3hK2YJlAECGt1TBk/YxHkw+Idt6S2WtMSaj4ClCnulEfnITnIY/4Ux3u
 gZZZbET49Ovkd916Wwp3NpfY/8zxsUNvMSHr5VrU9Ua77RX9L2Qd4TiO72LW8f+rIjJpWaRrbJy
 a6Q8LxpJM2/wKUAXZNTxrM+wXOLOEF1KsOcTbOCYFea/SR0f8BcP36uLthtJdJniKEl0p3lhlQ2
 3NCexHQTuDU7iRMfjzuEh5HOY3CNkDX6HcSs1/OVY66P7f/4BWuw/BXywL6km9q/FAX/T7MK4eV
 HwYuQAyDN2/NMC9pfgCD88mOje7k3j+No3ufSNYcRZexy8s7K4+myhQxnkxaObDeTscZKPgt4YH
 mHc6vP4wdkfmfJY30F4DXKcS5ME50v0+PcN/WNVXk2bXbEtBD9oiwd6P8EMlMOZ4VEPXlP46ld0
 TD6i5lEeULXLtJdYaig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

Integrate the previously established system register managing
infrastructure into the host. Initialize system registers during vcpu
init. Finalize system registers on PID change, Initialize sysreg table
on kvm init, report availability to userspace and let userspace
read&modify guest system register.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/arm64/kvm_emulate.h |  2 ++
 arch/s390/kvm/arm64/arm.c             | 35 ++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/guest.c           | 12 ++++++----
 arch/s390/kvm/arm64/handle_exit.c     |  1 +
 arch/s390/kvm/arm64/reset.c           | 43 +++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/arm64/kvm_emulate.h b/arch/s390/include/arm64/kvm_emulate.h
index 416c4f96db05..dbaef40a2ac7 100644
--- a/arch/s390/include/arm64/kvm_emulate.h
+++ b/arch/s390/include/arm64/kvm_emulate.h
@@ -125,6 +125,8 @@ static inline void kvm_reset_fpsimd(struct kvm_vcpu *vcpu)
 	vcpu->arch.sae_block.fpcr = 0;
 }
 
+void vcpu_reset_hcrx(struct kvm_vcpu *vcpu);
+
 #include <arm64/kvm_emulate-gen.h>
 
 #endif /* __S390_ARM64_KVM_EMULATE_H__ */
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index ba6235629c7d..fb9c747de64c 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -15,6 +15,7 @@
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/sysreg.h>
+#include <arm64/sys_regs.h>
 
 #include <gmap.h>
 #include <kvm_mmu.h>
@@ -50,6 +51,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		break;
 	case KVM_CAP_IOEVENTFD:
 	case KVM_CAP_PRE_FAULT_MEMORY:
+	case KVM_CAP_ONE_REG:
 		ret = 1;
 		break;
 	default:
@@ -136,6 +138,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 		goto out_err;
 	kvm->arch.mem_limit = kvm->arch.guest_phys_size;
 
+	kvm->arch.epd = ptff_qagto(0);
+
 	VM_EVENT(kvm, 3, "vm created with type %lu", type);
 	return 0;
 
@@ -193,6 +197,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	sae_block->mso = 0L;
 	sae_block->msl = vcpu->kvm->arch.mem_limit - 1;
 	sae_block->save_area = virt_to_phys(save_area);
+	sae_block->gpto = vcpu->kvm->arch.epd;
 
 	VM_EVENT(vcpu->kvm, 3,
 		 "create cpu %d at 0x%p, sae block at 0x%p, satellite at 0x%p",
@@ -207,6 +212,7 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
+	kfree(vcpu->arch.ccsidr);
 	kvm_s390_free_mmu_cache(vcpu->arch.mc);
 
 	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
@@ -218,6 +224,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vcpu->cpu = cpu;
 
 	lasrm(&vcpu->arch.save_area);
+
+	vcpu->arch.sae_block.gpto = vcpu->kvm->arch.epd;
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -261,6 +269,7 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
+	int ret;
 
 	if (!kvm_vcpu_initialized(vcpu))
 		return -ENOEXEC;
@@ -271,6 +280,16 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	if (likely(READ_ONCE(vcpu->pid)))
 		return 0;
 
+	ret = kvm_vcpu_finalize_sys_regs(vcpu);
+	if (ret)
+		return ret;
+
+	/*
+	 * This needs to happen after any restriction has been applied
+	 * to the feature set.
+	 */
+	vcpu_reset_hcrx(vcpu);
+
 	scoped_guard(mutex, &kvm->arch.config_lock)
 		set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
 
@@ -477,9 +496,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 		trace_kvm_entry(*vcpu_pc(vcpu));
 
 		adjust_pc(vcpu);
+		vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcr_el2, SYS_HCR_EL2);
+		vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcrx_el2, SYS_HCRX_EL2);
+		vcpu_write_host_sys_reg(vcpu, vcpu->arch.mpidr, SYS_VMPIDR_EL2);
+		_vcpu_write_sys_reg(vcpu, vcpu->arch.ctxt.elr_el1, SYS_ELR_EL1);
+		_vcpu_write_sys_reg(vcpu, vcpu->arch.ctxt.spsr_el1, SYS_SPSR_EL1);
 
 		arm_vcpu_enter_exit(virt_to_phys(&vcpu->arch.sae_block));
 
+		vcpu->arch.ctxt.elr_el1 = _vcpu_read_sys_reg(vcpu, SYS_ELR_EL1);
+		vcpu->arch.ctxt.spsr_el1 = _vcpu_read_sys_reg(vcpu, SYS_SPSR_EL1);
+
 		vcpu->mode = OUTSIDE_GUEST_MODE;
 		vcpu->stat.exits++;
 
@@ -762,11 +789,19 @@ static bool __init machine_supports_arm64_kvm(void)
 
 static int __init kvm_s390_arm64_init(void)
 {
+	int ret;
+
 	if (!machine_supports_arm64_kvm())
 		return -ENODEV;
 
 	kvm_init_qaaf();
 
+	ret = kvm_sys_reg_table_init();
+	if (ret) {
+		kvm_info("Error initializing system register tables\n");
+		return ret;
+	}
+
 	return kvm_init(sizeof(struct kvm_vcpu), 0, THIS_MODULE);
 }
 
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
index 8b5ee9e79a4f..047460975936 100644
--- a/arch/s390/kvm/arm64/guest.c
+++ b/arch/s390/kvm/arm64/guest.c
@@ -4,6 +4,7 @@
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
+#include <arm64/sys_regs.h>
 
 #define SVE_VQ_MIN	__SVE_VQ_MIN
 #define SVE_NUM_ZREGS	KVM_ARM64_SVE_NUM_ZREGS
@@ -60,12 +61,15 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
 		return ret;
 	uindices += ret;
 
-	return 0;
+	return kvm_arm_copy_sys_reg_indices(vcpu, uindices);
 }
 
 unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
 {
-	return num_core_regs(vcpu);
+	unsigned long num = num_core_regs(vcpu);
+
+	num += kvm_arm_num_sys_reg_descs(vcpu);
+	return num;
 }
 
 int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
@@ -78,7 +82,7 @@ int kvm_arm_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_CORE:
 		return get_core_reg(vcpu, reg);
 	default:
-		return -EINVAL;
+		return kvm_arm_sys_reg_get_reg(vcpu, reg);
 	}
 }
 
@@ -92,7 +96,7 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	case KVM_REG_ARM_CORE:
 		return set_core_reg(vcpu, reg);
 	default:
-		return -EINVAL;
+		return kvm_arm_sys_reg_set_reg(vcpu, reg);
 	}
 }
 
diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/handle_exit.c
index e0c7773c2165..1653163ed6d6 100644
--- a/arch/s390/kvm/arm64/handle_exit.c
+++ b/arch/s390/kvm/arm64/handle_exit.c
@@ -62,6 +62,7 @@ static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
 static exit_handle_fn arm_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]	= kvm_handle_unknown_ec,
 	[ESR_ELx_EC_HVC64]	= handle_hvc,
+	[ESR_ELx_EC_SYS64]	= kvm_handle_sys_reg,
 	[ESR_ELx_EC_IABT_LOW]	= kvm_handle_guest_abort,
 	[ESR_ELx_EC_DABT_LOW]	= kvm_handle_guest_abort,
 };
diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
index e4cdce1dbf9d..9fba709975e2 100644
--- a/arch/s390/kvm/arm64/reset.c
+++ b/arch/s390/kvm/arm64/reset.c
@@ -5,6 +5,10 @@
 
 #include <arm64/kvm_emulate.h>
 #include <arm64/kvm_nested.h>
+#include <arm64/sys_regs.h>
+#include <arm64/sysreg.h>
+
+#include <clocksource/arm_arch_timer.h>
 
 bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu)
 {
@@ -21,6 +25,40 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 			      HCR_EL2_TIDCP | HCR_EL2_TLOR;
 }
 
+void vcpu_reset_hcrx(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcrx_el2 = 0;
+
+	if (kvm_has_feat(vcpu->kvm, ID_AA64ISAR2_EL1, MOPS, IMP))
+		vcpu->arch.hcrx_el2 = HCRX_EL2_MSCEn;
+}
+
+static inline void vcpu_reset_cptr(struct kvm_vcpu *vcpu)
+{
+	u64 cptr;
+
+	/* we unconditionally have E2H, so disable traps to EL2 for FP and SVE, if enabled */
+	cptr = CPACR_EL1_FPEN;
+	if (vcpu_has_sve(vcpu))
+		cptr |= CPACR_EL1_ZEN;
+	vcpu_write_host_sys_reg(vcpu, cptr, SYS_CPTR_EL2);
+}
+
+static inline void vcpu_reset_cnthctl(struct kvm_vcpu *vcpu)
+{
+	u64 cnthctl;
+
+	/* we unconditionally have E2H, so disable traps to EL2 for physical timer registers */
+	cnthctl = (CNTHCTL_EL1PCEN | CNTHCTL_EL1PCTEN) << 10;
+	vcpu_write_host_sys_reg(vcpu, cnthctl, SYS_CNTHCTL_EL2);
+}
+
+static inline void vcpu_reset_icc(struct kvm_vcpu *vcpu)
+{
+	/* ensure ICC_SRE_EL2.Enable = 1 so ICC_SRE_EL1 is handled in hardware */
+	vcpu_write_host_sys_reg(vcpu, 0xf, SYS_ICC_SRE_EL2);
+}
+
 void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_reset_state reset_state;
@@ -43,9 +81,14 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		vcpu_put(vcpu);
 
 	kvm_reset_vcpu_core(vcpu);
+	kvm_reset_sys_regs(vcpu);
 
 	/* Reset special registers */
 	vcpu_reset_hcr(vcpu);
+	vcpu_reset_hcrx(vcpu);
+	vcpu_reset_cptr(vcpu);
+	vcpu_reset_cnthctl(vcpu);
+	vcpu_reset_icc(vcpu);
 
 	if (reset_state.reset) {
 		*vcpu_pc(vcpu) = reset_state.pc;

-- 
2.56.1

