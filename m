Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E384611E1;
	Tue, 28 Apr 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391836; cv=none; b=UqAFuE/cjdQWd2ON89aM1f/ybXc5ehE6UFzBKcIEFdmT7ZrPS4X0Pj3qMH3v/ONQrffZvwzrPDHMFc74ggZ+mJ6/utZSovu+CnB7VQHWLop72bCg2a6uNIq0Syk6xaj/cR+ZakmSvgkYZlNsAHlJUM2KEQgg3KCu2hLQtTP1+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391836; c=relaxed/simple;
	bh=CVAlkRWSrDxHq191L+WAvRUSzWu4N0ZnpaBkJtwIumU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=altXCx71nbJvPptYjMNicnK0o2BFcuNwUSo9HPCfZY4YHfMrksplmAbrSWDci0ffcfE0QiT08T9qp+IWxTMxTDqVEvXrIHxwTREfso6Vt4wym527bgxHRl+NMRQba40y8SKt55DZW6pNZ+3dOVLtkj8EPP2g0YzmC4z4hjWaLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qj516ngC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qj516ngC"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6SoAF2655803;
	Tue, 28 Apr 2026 15:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Lqu8yDZOIB2XPsq12
	shZu88OGfY+ewFjRdnTWU6jZyU=; b=qj516ngC/ehcTvYVc8rL1eI91DyKNoEOw
	cONyla4XNguE2jh/RVsfJAH+oMJfHOVv7rRiUFI2L/wGeq/0aUkCKw4rsyWujEF+
	o2H01FhZDF8iJV3nuJB/CFb8l50tDV91MlBlDEyb+9v2KLvxj0hrZIH94K7arOAX
	Y43AuZVxCup+ThsQ5KG+q5V/vZxOiVoq70qi4gvQcMjrcimrkwqwZ/21H39WQr0I
	gC6xXpC/+yOnocaueWf8iS5xFpquo6k5I2sOFm6FdQVFpvvvz8/I2n5GM+cmZRhH
	zpMRDhJSsepJeTL1yAEaY2XBvoH4GwXLQPDb2iA49MbasI4dh8YFw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vd4qr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrmQd006510;
	Tue, 28 Apr 2026 15:56:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqagye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 15:56:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SFuVbJ56885518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 15:56:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A470B2004B;
	Tue, 28 Apr 2026 15:56:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52F9720043;
	Tue, 28 Apr 2026 15:56:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 15:56:31 +0000 (GMT)
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
Subject: [PATCH v2 23/28] KVM: s390: Add basic arm64 kvm module
Date: Tue, 28 Apr 2026 17:56:15 +0200
Message-ID: <20260428155622.1361364-24-seiden@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f0d8b4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=36xwF7fJQ_K8JzKkrRgA:9
X-Proofpoint-ORIG-GUID: IJByZjDWkrZjCkhnjmEOqz5RqHxlNk1U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX0mhyMfKxhQcm
 FPv+sYm094BRo0pSp6IlZAGJgMwL3eSPSfxuq+KHytdSldDTiz1dNj5ost6K+gijYUq4tn0jH2x
 ePHtx7ZQHinVwXj/lyVmSLJw8MuTlzlRqZ+aneKylBjl79d+eBSSIwFMtfL3pnLcxrgL1m8Q1Fw
 e2QECH1igDJRaKx46dKYOTIxjOjwkTwDVAsb712iyrqRafSVnrcyIPvApkUbf7yjPnRZAEzTSRV
 HA+vRIpFABQs00OfPYN3a7Iemce3jZgDjmJa9SE9C7IXGWAR9VFvwv4Gaso0m9Gj5WkSRxI/PJZ
 zyMXWLTc24apZsVslsYy7VbQptsyIRj4rjYWu3qJNcXdHNErspcGFufsUzs8UzNEHJcMrudR8EZ
 IH5sthPnIE+Gdwe+5xSSs/1jbvRsQGSDxjpJLB8w8I1JUZgoLfMGwijMg/perVqFizCTv7VqCR3
 9ItM5JnKar4ZotgrLhw==
X-Proofpoint-GUID: IJByZjDWkrZjCkhnjmEOqz5RqHxlNk1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

Add basic code for the new arm64 on s390 KVM implementation.
Add kernel module boilerplate code and trivial functions.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c   | 182 ++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/arm.h   |   7 ++
 arch/s390/kvm/arm64/guest.c |  95 +++++++++++++++++++
 arch/s390/kvm/arm64/guest.h |  10 ++
 4 files changed, 294 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/arm.c
 create mode 100644 arch/s390/kvm/arm64/arm.h
 create mode 100644 arch/s390/kvm/arm64/guest.c
 create mode 100644 arch/s390/kvm/arm64/guest.h

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
new file mode 100644
index 000000000000..8f94eb8fe288
--- /dev/null
+++ b/arch/s390/kvm/arm64/arm.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define KMSG_COMPONENT "kvm-s390-arm64"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/miscdevice.h>
+#include <linux/kvm.h>
+#include <linux/kvm_types.h>
+#include <linux/kvm_host.h>
+
+#include "arm.h"
+
+int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
+{
+	int ret;
+
+	switch (ext) {
+	case KVM_CAP_NR_VCPUS:
+	case KVM_CAP_MAX_VCPUS:
+	case KVM_CAP_MAX_VCPU_ID:
+		ret = KVM_MAX_VCPUS;
+		break;
+	case KVM_CAP_ARM_VM_IPA_SIZE:
+		ret = get_kvm_ipa_limit();
+		break;
+	default:
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static u64 kvm_max_guest_address(void)
+{
+	u64 max_addr;
+
+	if (sclp.hamax == U64_MAX)
+		max_addr = TASK_SIZE_MAX;
+	else
+		max_addr = min_t(u64, TASK_SIZE_MAX, sclp.hamax);
+	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;
+}
+
+vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
+{
+	return VM_FAULT_SIGBUS;
+}
+
+long kvm_arch_dev_ioctl(struct file *filp,
+			unsigned int ioctl, unsigned long arg)
+{
+	return -EINVAL;
+}
+
+u32 get_kvm_ipa_limit(void)
+{
+	return fls64(kvm_max_guest_address() + 1) - 1;
+}
+
+int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
+{
+	return 0;
+}
+
+void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
+{
+}
+
+void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu)
+{
+}
+
+void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu)
+{
+}
+
+int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
+				    struct kvm_mp_state *mp_state)
+{
+	*mp_state = READ_ONCE(vcpu->arch.mp_state);
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
+				    struct kvm_mp_state *mp_state)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
+{
+	return 0;
+}
+
+unsigned long system_supported_vcpu_features(void)
+{
+	return KVM_VCPU_VALID_FEATURES;
+}
+
+int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct kvm_irq_level *irq_level,
+			  bool line_status)
+{
+	return 0;
+}
+
+void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
+					     struct kvm_memory_slot *slot,
+					     gfn_t gfn_offset,
+					     unsigned long mask)
+{
+}
+
+bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
+{
+	return false;
+}
+
+void kvm_arch_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+}
+
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
+{
+}
+
+int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e,
+		struct kvm *kvm, int irq_source_id,
+		int level, bool line_status)
+{
+	return -EINVAL;
+}
+
+int kvm_set_routing_entry(struct kvm *kvm,
+			  struct kvm_kernel_irq_routing_entry *e,
+			  const struct kvm_irq_routing_entry *ue)
+{
+	return -EINVAL;
+}
+
+void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
+				   struct kvm_memory_slot *slot)
+{
+}
+
+void kvm_arch_flush_shadow_all(struct kvm *kvm)
+{
+}
+
+int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+#ifdef CONFIG_HAVE_KVM_NO_POLL
+__weak bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+#endif
+
+long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
+				  unsigned long arg)
+{
+	return -ENOIOCTLCMD;
+}
+
+static __init int kvm_s390_arm64_init(void)
+{
+	if (!sclp.has_aef)
+		return -ENXIO;
+
+	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
+				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
+}
+
+static __exit void kvm_s390_arm64_exit(void)
+{
+	kvm_exit();
+}
+
+module_init(kvm_s390_arm64_init);
+module_exit(kvm_s390_arm64_exit);
diff --git a/arch/s390/kvm/arm64/arm.h b/arch/s390/kvm/arm64/arm.h
new file mode 100644
index 000000000000..a3db254462c0
--- /dev/null
+++ b/arch/s390/kvm/arm64/arm.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_S390_KVM_ARM64_H
+#define ARCH_S390_KVM_ARM64_H
+
+#define KVM_DEV_NAME "kvm-arm64"
+
+#endif /* ARCH_S390_KVM_ARM64_H */
diff --git a/arch/s390/kvm/arm64/guest.c b/arch/s390/kvm/arm64/guest.c
new file mode 100644
index 000000000000..00886755accf
--- /dev/null
+++ b/arch/s390/kvm/arm64/guest.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+
+#include "guest.h"
+
+const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
+	KVM_GENERIC_VM_STATS()
+};
+
+const struct kvm_stats_header kvm_vm_stats_header = {
+	.name_size = KVM_STATS_NAME_SIZE,
+	.num_desc = ARRAY_SIZE(kvm_vm_stats_desc),
+	.id_offset =  sizeof(struct kvm_stats_header),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_NAME_SIZE,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_NAME_SIZE +
+		       sizeof(kvm_vm_stats_desc),
+};
+
+const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
+	KVM_GENERIC_VCPU_STATS(),
+	/* ARM64 stats */
+	STATS_DESC_COUNTER(VCPU, hvc_exit_stat),
+	STATS_DESC_COUNTER(VCPU, wfe_exit_stat),
+	STATS_DESC_COUNTER(VCPU, wfi_exit_stat),
+	STATS_DESC_COUNTER(VCPU, mmio_exit_user),
+	STATS_DESC_COUNTER(VCPU, mmio_exit_kernel),
+	STATS_DESC_COUNTER(VCPU, signal_exits),
+	STATS_DESC_COUNTER(VCPU, exits),
+	/* GMAP stats */
+	STATS_DESC_COUNTER(VCPU, pfault_sync),
+};
+
+const struct kvm_stats_header kvm_vcpu_stats_header = {
+	.name_size = KVM_STATS_NAME_SIZE,
+	.num_desc = ARRAY_SIZE(kvm_vcpu_stats_desc),
+	.id_offset = sizeof(struct kvm_stats_header),
+	.desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_NAME_SIZE,
+	.data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_NAME_SIZE +
+		       sizeof(kvm_vcpu_stats_desc),
+};
+
+int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
+{
+	return copy_core_reg_indices(vcpu, uindices);
+}
+
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
+{
+	return num_core_regs(vcpu);
+}
+
+int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+				  struct kvm_sregs *sregs)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
+				  struct kvm_translation *tr)
+{
+	return -EINVAL;
+}
+
+int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
+					struct kvm_guest_debug *dbg)
+{
+	return -EINVAL;
+}
diff --git a/arch/s390/kvm/arm64/guest.h b/arch/s390/kvm/arm64/guest.h
new file mode 100644
index 000000000000..db635d513c2c
--- /dev/null
+++ b/arch/s390/kvm/arm64/guest.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef KVM_ARM_GUEST_H
+#define KVM_ARM_GUEST_H
+
+#include <linux/kvm_host.h>
+#include <kvm/arm64/guest.h>
+
+unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu);
+
+#endif /* KVM_ARM_GUEST_H */
-- 
2.51.0

