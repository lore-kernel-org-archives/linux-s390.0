Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981340;
	b=fj63XK0NLGaIiQyCWQDGzA6raDDdK4j3uLC3Sk5tuXASAe5OzIBipZsu8LLN2hWDfv5r
	 5i40PTRpDTNr+7/+0P1G20R15PVz/cRNRKFmHO5TebmwNLC7fdUYve56frO1mrVZW6n1g
	 n46WvJVK2k5yot1ELihFzI7EpKAdIeJCAAj0j6fCMV9DAQNW9pl5TOfn0aZ3A6FsCQCc1
	 XpcD44HOUouBv7R+rB0wP6tvyaEoI27noAn/uvB03JHIP0yc64GHITo4yBD6HsrtE9KMV
	 I7e1avBpEa9Q6NNdylD+L85hIqdsMIGwfH4iukjq8w3ib7G+Q6arC9D/bexvNhG2k0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981340;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G3yQPGZhJV5SoyjgPGf9zo7vRKeAQaK7AnXG9Hor/6w=;
	b=w8XGLg8NTMsan/5XhUZIsAkCtqAiUJXp1TeiC3WKo1SCODUwlHc+BYdJU4CkFagJ3vis
	 Bj9wWZO1NeF7Nvkn3oEmmstAFDZkYZPya6BlyOFUU/bYh9uFWDXfi1eMWhGAwt/nzNTUN
	 gekxoQUFTvRxjtBygj13zPqbgc5i3mlXci1F5Dxh48K5gvZJYLpP3UOOrPv9q8GIEyMhU
	 K8h30J5GYPJ8U/LERHu1U/Gk1YIcUsfHW6ZwLNb60r3Hc1bYkqg2ha3dh/GxEFbFmJAAc
	 8uiy1C5bn4sx8eUfMamHcx+AVUns2VxBup5rXus5RDov9705+XviGMeOnlrhv/M1LDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sbDSzPco;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E61360A2605;
	Fri,  6 Nov 2026 16:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E61360A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sbDSzPco
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEM7C1544500;
	Fri, 6 Nov 2026 16:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G3yQPG
	ZhJV5SoyjgPGf9zo7vRKeAQaK7AnXG9Hor/6w=; b=sbDSzPcoTT7UWaLVX5kjxT
	bDLrhoUA8c2hDeeXmv6ArZI/GNe8L7F4mWSW2J9L3RpJF8AEmJLv7UL0i8u1gw2s
	5/s9InicPzAF62mpJSSR440J5GA62SrpM5LGP8AQRcSdL4UK9b8/Tc1VYmpi5/Dy
	txQ1pyr0O5ORLHL5A0hvtK3d/rRLE0yWl1bdf/FHklY/2OGPLTf9AiHXqghIteJF
	S4ETQBmXHbvwdIaKuNHeBFnNME9kvNeLKBSEUD4pTnk1iXG20uS+4j6qYBiPekSJ
	oKP9d7IjGjbxYOuLPBfwqdgj5P4cEgvCP48nAWNW2Qv/CtG1pbiBc8xJCnl+nmIA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbwf0f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4vfl3538302;
	Fri, 6 Nov 2026 16:08:24 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mt4j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8Lpk32833868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FAA52004B;
	Fri,  6 Nov 2026 16:08:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95BAB2005A;
	Fri,  6 Nov 2026 16:08:20 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:20 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:50 +0100
Subject: [PATCH v3 17/23] KVM: s390: arm64: Integrate sysreg into the host
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
Message-Id: <20261106-sysreg-v3-17-75e95980fb10@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: LwuqNnuxczN-7Z3pmh3IzEUKri3MJJDG
X-Proofpoint-GUID: LwuqNnuxczN-7Z3pmh3IzEUKri3MJJDG
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedfb79 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=47U2-Vcuqj23hnRoSkAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXzaKKLYi34x52
 c8Sne2i6KuW3zR700DbaRMErQok04Ssde/I2Z8c9gPlv867J23k0ltb3By+l58MnTqAnwe1u98L
 ZLXac0a4uOnvqyskqiEE7fYj+OIyydU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX6ENXx0o2ll8O
 fh3gXtLEyqbKYGZCIkW9IWbJyeUT4KJPvTyOu9oTSp6fvpChOf/mupSoVj/mQgQ8A+p3DXu4Jph
 ysdIvFRkESMHvQ4aeze5OWOeqzQnMX06EeLjawRkaYJoGxf7K03J+fOKyUT3HT5CcBlK3c9fYco
 BWRr4330PVlbeySzoV75jyQAKxsJrsjvSnUEbo5HGAKQlv+f88sFlVxEEdvAfrjpVR7zKzEGbPn
 gRLikEI6tUphXx4krF57hTKwdHnuOn1LNvWwpHsxFrpdnQKKf7dIc0felPs1/+qD2DBICkxVeBh
 ut5IvLngpE6vpRCpsd/QVPJtI5s29/spMyyJfLTeJrTBFNJXV/W77SxWo+a/USlJy+4qjyyDme9
 NHvJ/T74pjt1dE4FWGyY/fBZeBUXYbFfvYUM3Yp3JamXkd7s2yEBKiAjnM2YpgLIJXNSHzdSHEr
 MVocZGBgTgHFTuSgChQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Integrate the previously established system register managing
infrastructure into the host. Initialize sysregs during vcpu init.
Finalize sysregs on PID change, Initialize sysreg table on kvm init,
report availability to userspace and let userspace read&modify guest system
register.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host_arm64.h |  3 +++
 arch/s390/kvm/arm64/arm.c              | 29 +++++++++++++++++++++++
 arch/s390/kvm/arm64/guest.c            | 12 ++++++----
 arch/s390/kvm/arm64/handle_exit.c      |  1 +
 arch/s390/kvm/arm64/reset.c            | 42 ++++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/sys_regs.c         |  1 +
 6 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/asm/kvm_host_arm64.h
index 35b6d8972359..44deae423ace 100644
--- a/arch/s390/include/asm/kvm_host_arm64.h
+++ b/arch/s390/include/asm/kvm_host_arm64.h
@@ -157,6 +157,9 @@ struct kvm_arch {
 
 	/* Per-VM ID register storage */
 	struct kvm_vm_id_regs id_regs;
+
+	/* The EPD as it should be on all VCPUs. */
+	u64 epd;
 };
 
 static inline bool __vcpu_has_feature(const struct kvm_arch *ka, int feature)
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index ba6235629c7d..62fd71af8968 100644
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
@@ -271,6 +280,10 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 	if (likely(READ_ONCE(vcpu->pid)))
 		return 0;
 
+	ret = kvm_vcpu_finalize_sys_regs(vcpu);
+	if (ret)
+		return ret;
+
 	scoped_guard(mutex, &kvm->arch.config_lock)
 		set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
 
@@ -477,9 +490,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
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
 
@@ -762,11 +783,19 @@ static bool __init machine_supports_arm64_kvm(void)
 
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
index e4cdce1dbf9d..0339901f5fd0 100644
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
@@ -21,6 +25,39 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu *vcpu)
 			      HCR_EL2_TIDCP | HCR_EL2_TLOR;
 }
 
+static inline void vcpu_reset_hcrx(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.hcrx_el2 = 0;
+	if (kvm_has_feat(vcpu->kvm, ID_AA64ISAR2_EL1, MOPS, IMP))
+		vcpu->arch.hcrx_el2 |= HCRX_EL2_MSCEn;
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
@@ -43,9 +80,14 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
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
diff --git a/arch/s390/kvm/arm64/sys_regs.c b/arch/s390/kvm/arm64/sys_regs.c
index b1d4335779c7..417a05ce9015 100644
--- a/arch/s390/kvm/arm64/sys_regs.c
+++ b/arch/s390/kvm/arm64/sys_regs.c
@@ -441,6 +441,7 @@ static int arch_timer_set_user(struct kvm_vcpu *vcpu,
 	case SYS_CNTPCT_EL0:
 		gpto = ptff_qagto(val);
 		vcpu->arch.sae_block.gpto = gpto;
+		vcpu->kvm->arch.epd = gpto;
 		return 0;
 	}
 

-- 
2.56.0

