From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/2] KVM: s390: use cookies for ioeventfd
Date: Wed,  3 Jul 2013 10:56:20 +0200
Message-ID: <1372841780-29645-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1372841780-29645-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1372841780-29645-1-git-send-email-cornelia.huck@de.ibm.com>
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
 arch/s390/kvm/diag.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3074475..2a467bf 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -108,22 +108,33 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 {
 	int ret, idx;
+	long cookie;
 
 	/* No virtio-ccw notification? Get out quickly. */
 	if (!vcpu->kvm->arch.css_support ||
 	    (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
 		return -EOPNOTSUPP;
 
+	cookie = vcpu->run->s.regs.gprs[4];
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	/*
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
+				      &cookie);
 	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+
+	/*
+	 * Return cookie in gpr 2, but don't overwrite the register if the
+	 * diagnose will be handled by userspace.
+	 */
+	if (ret != -EOPNOTSUPP)
+		vcpu->run->s.regs.gprs[2] = cookie;
 	/* kvm_io_bus_write returns -EOPNOTSUPP if it found no match. */
 	return ret < 0 ? ret : 0;
 }
-- 
1.8.2.2
