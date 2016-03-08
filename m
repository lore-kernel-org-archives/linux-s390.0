From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] KVM: s390: correct fprs on SIGP (STOP AND) STORE STATUS
Date: Tue,  8 Mar 2016 12:24:30 +0100
Message-ID: <1457436270-93409-2-git-send-email-borntraeger@de.ibm.com>
References: <1457436270-93409-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1457436270-93409-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

With MACHINE_HAS_VX, we convert the floating point registers from the
vector registeres when storing the status. For other VCPUs, these are
stored to vcpu->run->s.regs.vrs, but we are using current->thread.fpu.vxrs,
which resolves to the currently loaded VCPU.

So kvm_s390_store_status_unloaded() currently writes the wrong floating
point registers (converted from the vector registers) when called from
another VCPU on a z13.

This is only the case for old user space not handling SIGP STORE STATUS and
SIGP STOP AND STORE STATUS, but relying on the kernel implementation. All
other calls come from the loaded VCPU via kvm_s390_store_status().

Fixes: 9abc2a08a7d6 (KVM: s390: fix memory overwrites when vx is disabled)
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org # v4.4+
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4af21c7..03dfe9c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2381,7 +2381,7 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
 
 	/* manually convert vector registers if necessary */
 	if (MACHINE_HAS_VX) {
-		convert_vx_to_fp(fprs, current->thread.fpu.vxrs);
+		convert_vx_to_fp(fprs, (__vector128 *) vcpu->run->s.regs.vrs);
 		rc = write_guest_abs(vcpu, gpa + __LC_FPREGS_SAVE_AREA,
 				     fprs, 128);
 	} else {
-- 
2.3.0
