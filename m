From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/11] KVM: s390: allow 255 VCPUs when sca entries aren't used
Date: Thu,  8 Sep 2016 14:00:21 +0200
Message-ID: <1473336023-15522-10-git-send-email-borntraeger@de.ibm.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

If the SCA entries aren't used by the hardware (no SIGPIF), we
can simply not set the entries, stick to the basic sca and allow more
than 64 VCPUs.

To hinder any other facility from using these entries, let's properly
provoke intercepts by not setting the MCN and keeping the entries
unset.

This effectively allows when running KVM under KVM (vSIE) or under z/VM to
provide more than 64 VCPUs to a guest. Let's limit it to 255 for now, to
not run into problems if the CPU numbers are limited somewhere else.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 +-
 arch/s390/kvm/interrupt.c        |  4 ++++
 arch/s390/kvm/kvm-s390.c         | 18 +++++++++++++++++-
 arch/s390/kvm/kvm-s390.h         | 10 ++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 8e5daf7..876173c 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -28,7 +28,7 @@
 
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
-#define KVM_MAX_VCPUS KVM_S390_ESCA_CPU_SLOTS
+#define KVM_MAX_VCPUS 255
 #define KVM_USER_MEM_SLOTS 32
 
 /*
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 353e0b7..be4db07 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -42,6 +42,7 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 	if (!(atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_ECALL_PEND))
 		return 0;
 
+	BUG_ON(!kvm_s390_use_sca_entries());
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
@@ -70,6 +71,7 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 {
 	int expect, rc;
 
+	BUG_ON(!kvm_s390_use_sca_entries());
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
@@ -111,6 +113,8 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	int rc, expect;
 
+	if (!kvm_s390_use_sca_entries())
+		return;
 	atomic_andnot(CPUSTAT_ECALL_PEND, li->cpuflags);
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 892abf4..3a628eb 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -376,7 +376,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_NR_VCPUS:
 	case KVM_CAP_MAX_VCPUS:
 		r = KVM_S390_BSCA_CPU_SLOTS;
-		if (sclp.has_esca && sclp.has_64bscao)
+		if (!kvm_s390_use_sca_entries())
+			r = KVM_MAX_VCPUS;
+		else if (sclp.has_esca && sclp.has_64bscao)
 			r = KVM_S390_ESCA_CPU_SLOTS;
 		break;
 	case KVM_CAP_NR_MEMSLOTS:
@@ -1553,6 +1555,8 @@ static int __kvm_ucontrol_vcpu_init(struct kvm_vcpu *vcpu)
 
 static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 {
+	if (!kvm_s390_use_sca_entries())
+		return;
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
@@ -1570,6 +1574,13 @@ static void sca_del_vcpu(struct kvm_vcpu *vcpu)
 
 static void sca_add_vcpu(struct kvm_vcpu *vcpu)
 {
+	if (!kvm_s390_use_sca_entries()) {
+		struct bsca_block *sca = vcpu->kvm->arch.sca;
+
+		/* we still need the basic sca for the ipte control */
+		vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
+		vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
+	}
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
@@ -1650,6 +1661,11 @@ static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
 {
 	int rc;
 
+	if (!kvm_s390_use_sca_entries()) {
+		if (id < KVM_MAX_VCPUS)
+			return true;
+		return false;
+	}
 	if (id < KVM_S390_BSCA_CPU_SLOTS)
 		return true;
 	if (!sclp.has_esca || !sclp.has_64bscao)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 9995cab..3a4e97f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -20,6 +20,7 @@
 #include <linux/kvm_host.h>
 #include <asm/facility.h>
 #include <asm/processor.h>
+#include <asm/sclp.h>
 
 typedef int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
 
@@ -387,4 +388,13 @@ static inline union ipte_control *kvm_s390_get_ipte_control(struct kvm *kvm)
 
 	return &sca->ipte_control;
 }
+static inline int kvm_s390_use_sca_entries(void)
+{
+	/*
+	 * Without SIGP interpretation, only SRS interpretation (if available)
+	 * might use the entries. By not setting the entries and keeping them
+	 * invalid, hardware will not access them but intercept.
+	 */
+	return sclp.has_sigpif;
+}
 #endif
-- 
2.5.5
