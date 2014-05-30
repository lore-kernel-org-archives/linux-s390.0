From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/6] KVM: s390: Intercept the tprot instruction
Date: Fri, 30 May 2014 11:00:12 +0200
Message-ID: <1401440412-20472-7-git-send-email-borntraeger@de.ibm.com>
References: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Nick Wang <jfwang@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Based on original patch from Jeng-fang (Nick) Wang

When standby memory is specified for a guest Linux, but no virtual memory has
been allocated on the Qemu host backing that guest, the guest memory detection
process encounters a memory access exception which is not thrown from the KVM
handle_tprot() instruction-handler function. The access exception comes from
sie64a returning EFAULT, which then passes an addressing exception to the guest.
Unfortunately this does not the proper PSW fixup (nullifying vs.
suppressing) so the guest will get a fault for the wrong address.

Let's just intercept the tprot instruction all the time to do the right thing
and not go the page fault handler path for standby memory. tprot is only used
by Linux during startup so some exits should be ok.
Without this patch, standby memory cannot be used with KVM.

Signed-off-by: Nick Wang <jfwang@us.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/kvm-s390.c         | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index a27f500..4181d7b 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -110,6 +110,7 @@ struct kvm_s390_sie_block {
 #define ICTL_ISKE	0x00004000
 #define ICTL_SSKE	0x00002000
 #define ICTL_RRBE	0x00001000
+#define ICTL_TPROT	0x00000200
 	__u32	ictl;			/* 0x0048 */
 	__u32	eca;			/* 0x004c */
 #define ICPT_INST	0x04
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 06d1888..43e191b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -637,7 +637,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	if (sclp_has_siif())
 		vcpu->arch.sie_block->eca |= 1;
 	vcpu->arch.sie_block->fac   = (int) (long) vfacilities;
-	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
+	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE |
+				      ICTL_TPROT;
+
 	if (kvm_s390_cmma_enabled(vcpu->kvm)) {
 		rc = kvm_s390_vcpu_setup_cmma(vcpu);
 		if (rc)
-- 
1.8.4.2
