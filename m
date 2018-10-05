From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 1/2] KVM: s390: Tracing APCB changes
Date: Fri,  5 Oct 2018 10:31:09 +0200
Message-ID: <1538728270-10340-2-git-send-email-pmorel@linux.ibm.com>
References: <7d147350-4284-8e01-d1fa-0795d2da85c1@de.ibm.com>
 <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538728270-10340-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: david@redhat.com, linux-kernel@vger.kernel.org, cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

kvm_arch_crypto_set_masks is a new function to centralize
the setup the APCB masks inside the CRYCB SIE satelite.

To trace APCB mask changes, we add KVM_EVENT() tracing to
both kvm_arch_crypto_set_masks and kvm_arch_crypto_clear_masks.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/kvm-s390.c         | 41 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 36d3531..22aa4da 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -861,6 +861,8 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 				 struct kvm_async_pf *work);
 
 void kvm_arch_crypto_clear_masks(struct kvm *kvm);
+void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
+			       unsigned long *aqm, unsigned long *adm);
 
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d3ea721..e871e5a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2057,6 +2057,46 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 		kvm->arch.crypto.crycbd |= CRYCB_FORMAT1;
 }
 
+void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
+			       unsigned long *aqm, unsigned long *adm)
+{
+	struct kvm_s390_crypto_cb *crycb = kvm->arch.crypto.crycb;
+
+	mutex_lock(&kvm->lock);
+	kvm_s390_vcpu_block_all(kvm);
+
+	switch (kvm->arch.crypto.crycbd & CRYCB_FORMAT_MASK) {
+	case CRYCB_FORMAT2: /* APCB1 use 256 bits */
+		memcpy(crycb->apcb1.apm, apm, 32);
+		VM_EVENT(kvm, 3, "SET CRYCB: apm %016lx %016lx %016lx %016lx",
+			 apm[0], apm[1], apm[2], apm[3]);
+		memcpy(crycb->apcb1.aqm, aqm, 32);
+		VM_EVENT(kvm, 3, "SET CRYCB: aqm %016lx %016lx %016lx %016lx",
+			 aqm[0], aqm[1], aqm[2], aqm[3]);
+		memcpy(crycb->apcb1.adm, adm, 32);
+		VM_EVENT(kvm, 3, "SET CRYCB: adm %016lx %016lx %016lx %016lx",
+			 adm[0], adm[1], adm[2], adm[3]);
+		break;
+	case CRYCB_FORMAT1:
+	case CRYCB_FORMAT0: /* Fall through both use APCB0 */
+		memcpy(crycb->apcb0.apm, apm, 8);
+		memcpy(crycb->apcb0.aqm, aqm, 2);
+		memcpy(crycb->apcb0.adm, adm, 2);
+		VM_EVENT(kvm, 3, "SET CRYCB: apm %016lx aqm %04x adm %04x",
+			 apm[0], *((unsigned short *)aqm),
+			 *((unsigned short *)adm));
+		break;
+	default:	/* Can not happen */
+		break;
+	}
+
+	/* recreate the shadow crycb for each vcpu */
+	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
+	kvm_s390_vcpu_unblock_all(kvm);
+	mutex_unlock(&kvm->lock);
+}
+EXPORT_SYMBOL_GPL(kvm_arch_crypto_set_masks);
+
 void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 {
 	mutex_lock(&kvm->lock);
@@ -2067,6 +2107,7 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 	memset(&kvm->arch.crypto.crycb->apcb1, 0,
 	       sizeof(kvm->arch.crypto.crycb->apcb1));
 
+	VM_EVENT(kvm, 3, "%s", "CLR CRYCB:");
 	/* recreate the shadow crycb for each vcpu */
 	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
 	kvm_s390_vcpu_unblock_all(kvm);
-- 
2.7.4
