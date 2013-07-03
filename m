From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v4 2/2] KVM: s390: use cookies for ioeventfd
Date: Wed,  3 Jul 2013 16:30:54 +0200
Message-ID: <1372861854-23043-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1372861854-23043-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Make use of cookies for the virtio ccw notification hypercall to speed up
lookup of devices on the io bus.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/diag.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3074475..e88c76e 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -119,11 +119,20 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 	 * The layout is as follows:
 	 * - gpr 2 contains the subchannel id (passed as addr)
 	 * - gpr 3 contains the virtqueue index (passed as datamatch)
+	 * - gpr 4 contains the index on the bus (optionally)
 	 */
-	ret = kvm_io_bus_write(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
-				vcpu->run->s.regs.gprs[2],
-				8, &vcpu->run->s.regs.gprs[3]);
+	ret = kvm_io_bus_write_cookie(vcpu->kvm, KVM_VIRTIO_CCW_NOTIFY_BUS,
+				      vcpu->run->s.regs.gprs[2],
+				      8, &vcpu->run->s.regs.gprs[3],
+				      vcpu->run->s.regs.gprs[4]);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	/*
+	 * Return cookie in gpr 2, but don't overwrite the register if the
+	 * diagnose will be handled by userspace.
+	 */
+	if (ret != -EOPNOTSUPP)
+		vcpu->run->s.regs.gprs[2] = ret;
 	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
 	return ret < 0 ? ret : 0;
 }
-- 
1.8.2.2
