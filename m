Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E24772BB;
	Wed, 12 Aug 2026 15:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549056; cv=none; b=bB2f+tJf3+kabaF4B5gU2757y88ZuPYtjM33YFIyZeFFdepUWZe5HR5GceQJaAt/T1OMZJphLiU8MS4sJR2nvLlE6lN653caorAmxmiZ99F8NFWp3I4nM9uDU4t2LUnBvD0nMFhgtYCyWWk/T9ZdEsY/XlVCCK4KvRovitcmGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549056; c=relaxed/simple;
	bh=QeN/dVsBYu1PpvTDcnbwL/bgoYazhHgGwQfqHM85wMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFh/54nigSt0G2Ez5g0QRet270YaJjT4WFy27SPgy1M8vK3UdRbVq7DDJGfNE30klo5SkRDYXs/FnyuYy8Hexf1XRnvztrPjZjkxL9uWS7LjA5fxhVwLsNLWXH5/rz5NIQWNP/v1Owtfat0E8nT5QhdnB5fAuvYKHNKPGlQrO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qlixo0pq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qlixo0pq"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1wv03594490;
	Wed, 12 Aug 2026 15:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GKbbFOvINxKNwNvuj
	FCoMbtxWQXvW5tCYzYMDrhF8e8=; b=Qlixo0pqzko/a33eTxhdZ+GARM4eBIDgI
	udk3Ew2M1FJnNMxvXw40gYtwPiw4rH0oJWP6Nh+qJMbrBmjixnvdvqn98B8XBHXx
	/o5HAm5AsXizaWQHUOuelrdvC1CHn6h7COWakppYLBzLtYB0WctUYVhvrjlQVFDy
	8eN48BOSM98YYGxfCMn5CEGq6V5G0Q3BHqm5hO8MZmC2dY8th1FUcp9FB68ZxSoH
	JOX4t0R+p7Qc9aUFfLZtigC5V7SCpGKlYfpeAYcc5gDv3BTLVZIbN9Y3CAhEQwUk
	C3/21J2rykYyUvZKZ/yKjxfUgz5MTVpYGqpCVUxFEGN2aK1RQDOHw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp32e27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CFQH7u024770;
	Wed, 12 Aug 2026 15:36:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjxpk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 15:36:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CFagJ932833898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 15:36:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC6B520040;
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73B1820049;
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 15:36:42 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v6 28/33] KVM: s390: Add basic arm64 kvm module
Date: Wed, 12 Aug 2026 17:36:24 +0200
Message-ID: <20260812153631.3376090-29-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812153631.3376090-1-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7c9310 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=36xwF7fJQ_K8JzKkrRgA:9
X-Proofpoint-GUID: MSmZkIEocjEidJm8N0KUnoXrF6kkrnCR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfXwZVGjy4mRb5O
 vkWHDNIaVrhss64moXW/jilc576cU4xCEBcVZC+gmgjS4+bN+1vncsekIP2jOhgXmTY6GtMh1Rl
 4lWzXr31mMnYxSY8CJBnpjceXpSSM8hvb66OMLpbGJojDNmgdIIOf0LQIxMJuRPpRW+PDUWDWsR
 1UOAgZ/PY70b5yODENtzL43a0UBS8VkGtqZFJrioFdpCFm4oHauvw+K4aw2HeSzX5tj7WNFMIRM
 iuYcKoFHnVbAyj79/nyUOYJDycFFYRk7cZRkMgnAHwHD4DMTU/m6vHJ56tN2kjOlHEvdUCNDz1y
 kuUu/llSoZQ08+3emdo8OeI3ththpOAx6k5SxcT0C7LOn6HwQWT09+oUbeKaDSMxMMmn6wmUWa9
 v0iRpHZ/8+AWv/m6L1dYp+lKPiS8XtFZxZpHYT9UJzCnDyCI05q3/+jfIfzsNfDggN6Id2wrFWh
 Bp74dUoBOz2bdJJ50xA==
X-Proofpoint-ORIG-GUID: afF--hPW_zm3t0TumRqGkqvCyBqklH6W
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyNiBTYWx0ZWRfX1BDEH4QRUbD2
 qLsDOkHoieelIrPB3m2E5iGskzzJUhMiNsREW1kNDBx6Zn93m1blOsaiB4eidw9eIsjgKaEWZ1P
 dX44MoQ08LeRO0DxyH6iGvvBGw/+iEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120126

Add basic code for the new arm64 on s390 KVM implementation.
Add kernel module boilerplate code and trivial functions.
Add tracing scaffolding.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c   | 157 ++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/arm.h   |   7 ++
 arch/s390/kvm/arm64/guest.c |  92 +++++++++++++++++++++
 arch/s390/kvm/arm64/trace.h |  18 +++++
 4 files changed, 274 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/arm.c
 create mode 100644 arch/s390/kvm/arm64/arm.h
 create mode 100644 arch/s390/kvm/arm64/guest.c
 create mode 100644 arch/s390/kvm/arm64/trace.h

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
new file mode 100644
index 000000000000..8e17b7eef813
--- /dev/null
+++ b/arch/s390/kvm/arm64/arm.c
@@ -0,0 +1,157 @@
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
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
+static unsigned long system_supported_vcpu_features(void);
+
+#define __INCL_GEN_ARM_FILE
+#include "generated/arm.inc"
+#undef __INCL_GEN_ARM_FILE
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
+	case KVM_CAP_IOEVENTFD:
+		ret = 1;
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
+int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static unsigned long system_supported_vcpu_features(void)
+{
+	unsigned long features = KVM_S390_ARM64_IMPL_FEATURES;
+
+	return features;
+}
+
+bool kvm_arch_irqchip_in_kernel(struct kvm *kvm)
+{
+	return false;
+}
+
+int kvm_set_msi(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
+		int irq_source_id, int level, bool line_status)
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
+static int __init kvm_s390_arm64_init(void)
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
index 000000000000..fd6442d9e4f4
--- /dev/null
+++ b/arch/s390/kvm/arm64/guest.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kvm_host.h>
+#include <linux/kvm.h>
+
+#include <arm64/kvm_emulate.h>
+#include <arm64/kvm_nested.h>
+
+#include "guest.h"
+
+#define __INCL_GEN_ARM_FILE
+#include "generated/guest.inc"
+#undef __INCL_GEN_ARM_FILE
+
+const struct kvm_stats_desc kvm_vm_stats_desc[] = {
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
+const struct kvm_stats_desc kvm_vcpu_stats_desc[] = {
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
diff --git a/arch/s390/kvm/arm64/trace.h b/arch/s390/kvm/arm64/trace.h
new file mode 100644
index 000000000000..3a5dcd039c13
--- /dev/null
+++ b/arch/s390/kvm/arm64/trace.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(KVM_ARM64_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define KVM_ARM64_TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+
+#endif /* KVM_ARM64_TRACE_KVM_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.53.0

