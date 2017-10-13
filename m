From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [RFC 02/19] KVM: s390: refactor crypto initialization
Date: Fri, 13 Oct 2017 13:38:47 -0400
Message-ID: <1507916344-3896-3-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507916344-3896-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This patch introduces the following changes to crypto initialization.

* For key management operations support, the crypto control block
  (CRYCB) referenced by the KVM guest's SIE state description is
  formatted only if the Message-Security-Assist (MSA) extension 3
  facility is installed (STFLE.76 is set). Virtualization of AP
  facilities, however; requires that a CRYCB of the appropriate
  format be made available to SIE regardless of the value of STFLE.76.

* The Execution Controls A (ECA) field bit 28 in the SIE block needs
  to be set to enable interpretive execution mode of adjunct processor (AP)
  instructions.

Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |    1 +
 arch/s390/kvm/kvm-s390.c         |   17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 50a6b25..5683f18 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -188,6 +188,7 @@ struct kvm_s390_sie_block {
 #define ECA_MVPGI	0x01000000
 #define ECA_VX		0x00020000
 #define ECA_PROTEXCI	0x00002000
+#define ECA_AP		0x00000008
 #define ECA_SII		0x00000001
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 40d0a1a..e57fc9b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1819,7 +1819,9 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 {
 	kvm->arch.crypto.crycbd = (__u32)(unsigned long) kvm->arch.crypto.crycb;
 
-	if (kvm_s390_apxa_installed())
+	if (!test_kvm_facility(kvm, 76))
+		kvm->arch.crypto.crycbd &= ~(CRYCB_FORMAT2); /* format 0 */
+	else if (kvm_s390_apxa_installed())
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT2;
 	else
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
@@ -1836,12 +1838,12 @@ static u64 kvm_s390_get_initial_cpuid(void)
 
 static void kvm_s390_crypto_init(struct kvm *kvm)
 {
-	if (!test_kvm_facility(kvm, 76))
-		return;
-
 	kvm->arch.crypto.crycb = &kvm->arch.sie_page2->crycb;
 	kvm_s390_set_crycb_format(kvm);
 
+	if (!test_kvm_facility(kvm, 76))
+		return;
+
 	/* Enable AES/DEA protected key functions by default */
 	kvm->arch.crypto.aes_kw = 1;
 	kvm->arch.crypto.dea_kw = 1;
@@ -2366,8 +2368,15 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu->arch.enabled_gmap = vcpu->arch.gmap;
 }
 
+static void kvm_s390_vcpu_set_crypto_exec_mode(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.sie_block->eca |= ECA_AP;
+}
+
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
 {
+	kvm_s390_vcpu_set_crypto_exec_mode(vcpu);
+
 	if (!test_kvm_facility(vcpu->kvm, 76))
 		return;
 
-- 
1.7.1
