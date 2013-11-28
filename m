From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 6/9] KVM: s390: Fix clock comparator field for STORE STATUS
Date: Thu, 28 Nov 2013 15:06:55 +0100
Message-ID: <1385647618-15541-7-git-send-email-cornelia.huck@de.ibm.com>
References: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1385647618-15541-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Only the most 7 significant bytes of the clock comparator must be
saved to the status area, and the byte at offset 304 has to be zero.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 55eb8de..1bb1dda 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -877,6 +877,7 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr)
 {
 	unsigned char archmode = 1;
 	int prefix;
+	u64 clkcomp;
 
 	if (addr == KVM_S390_STORE_STATUS_NOADDR) {
 		if (copy_to_guest_absolute(vcpu, 163ul, &archmode, 1))
@@ -920,8 +921,9 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr)
 			&vcpu->arch.sie_block->cputm, 8, prefix))
 		return -EFAULT;
 
+	clkcomp = vcpu->arch.sie_block->ckc >> 8;
 	if (__guestcopy(vcpu, addr + offsetof(struct save_area, clk_cmp),
-			&vcpu->arch.sie_block->ckc, 8, prefix))
+			&clkcomp, 8, prefix))
 		return -EFAULT;
 
 	if (__guestcopy(vcpu, addr + offsetof(struct save_area, acc_regs),
-- 
1.7.9.5
