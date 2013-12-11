From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 6/6] KVM: s390: ioeventfd: ignore leftmost bits
Date: Wed, 11 Dec 2013 19:57:49 +0100
Message-ID: <1386788269-20249-7-git-send-email-cornelia.huck@de.ibm.com>
References: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Dominik Dingel <dingel@linux.vnet.ibm.com>, stable@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

The diagnose 500 subcode 3 contains the 32 bit subchannel id in bits 32-63
(counting from the left). As for other I/O instructions, bits 0-31 should be
ignored and thus not be passed to kvm_io_bus_write_cookie().

This fixes a bug where the guest passed non-zero bits 0-31 which the
host tried to interpret, leading to ioeventfd notification failures.

Cc: stable@vger.kernel.org
Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/diag.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 5ff29be..8216c0e 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -121,7 +121,7 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 	 * - gpr 4 contains the index on the bus (optionally)
 	 */
 	ret = kvm_io_bus_write_cookie(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
-				      vcpu->run->s.regs.gprs[2],
+				      vcpu->run->s.regs.gprs[2] & 0xffffffff,
 				      8, &vcpu->run->s.regs.gprs[3],
 				      vcpu->run->s.regs.gprs[4]);
 
-- 
1.7.9.5
