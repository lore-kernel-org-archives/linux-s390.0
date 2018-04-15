From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v4 05/15] KVM: s390: enable/disable AP interpretive execution
Date: Sun, 15 Apr 2018 17:22:15 -0400
Message-ID: <1523827345-11600-6-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523827345-11600-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The VFIO AP device model exploits interpretive execution of AP
instructions (APIE) to provide guests passthrough access to AP
devices. This patch introduces a new interface to enable and
disable APIE.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm-ap.h   |   16 ++++++++++++++++
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-ap.c           |   20 ++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |    9 +++++++++
 4 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/s390/include/asm/kvm-ap.h b/arch/s390/include/asm/kvm-ap.h
index 736e93e..a6c092e 100644
--- a/arch/s390/include/asm/kvm-ap.h
+++ b/arch/s390/include/asm/kvm-ap.h
@@ -35,4 +35,20 @@
  */
 void kvm_ap_build_crycbd(struct kvm *kvm);
 
+/**
+ * kvm_ap_interpret_instructions
+ *
+ * Indicate whether AP instructions shall be interpreted. If they are not
+ * interpreted, all AP instructions will be intercepted and routed back to
+ * userspace.
+ *
+ * @kvm: the virtual machine attributes
+ * @enable: indicates whether AP instructions are to be interpreted (true) or
+ *	    or not (false).
+ *
+ * Returns 0 if completed successfully; otherwise, returns -EOPNOTSUPP
+ * indicating that AP instructions are not installed on the guest.
+ */
+int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable);
+
 #endif /* _ASM_KVM_AP */
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 3162783..5470685 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -715,6 +715,7 @@ struct kvm_s390_crypto {
 	__u32 crycbd;
 	__u8 aes_kw;
 	__u8 dea_kw;
+	__u8 apie;
 };
 
 #define APCB0_MASK_SIZE 1
diff --git a/arch/s390/kvm/kvm-ap.c b/arch/s390/kvm/kvm-ap.c
index 991bae4..55d11b5 100644
--- a/arch/s390/kvm/kvm-ap.c
+++ b/arch/s390/kvm/kvm-ap.c
@@ -58,3 +58,23 @@ void kvm_ap_build_crycbd(struct kvm *kvm)
 	}
 }
 EXPORT_SYMBOL(kvm_ap_build_crycbd);
+
+int kvm_ap_interpret_instructions(struct kvm *kvm, bool enable)
+{
+	int ret = 0;
+
+	mutex_lock(&kvm->lock);
+
+	if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP)) {
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+
+	kvm->arch.crypto.apie = enable;
+	kvm_s390_vcpu_crypto_reset_all(kvm);
+
+done:
+	mutex_unlock(&kvm->lock);
+	return ret;
+}
+EXPORT_SYMBOL(kvm_ap_interpret_instructions);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 55cd897..1dc8566 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1901,6 +1901,9 @@ static void kvm_s390_crypto_init(struct kvm *kvm)
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_ap_build_crycbd(kvm);
 
+	/* Default setting indicating SIE shall interpret AP instructions */
+	kvm->arch.crypto.apie = 1;
+
 	if (!test_kvm_facility(kvm, 76))
 		return;
 
@@ -2434,6 +2437,12 @@ static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
 
+	vcpu->arch.sie_block->eca &= ~ECA_APIE;
+	if (vcpu->kvm->arch.crypto.apie &&
+	    test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
+		vcpu->arch.sie_block->eca |= ECA_APIE;
+
+
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
-- 
1.7.1
