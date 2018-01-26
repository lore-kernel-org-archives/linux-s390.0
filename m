From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 18/22] KVM: s390: add GISA interrupts to FLIC ioctl interface
Date: Fri, 26 Jan 2018 16:53:30 +0100
Message-ID: <20180126155334.52956-19-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

Pending interrupts marked in the GISA IPM are required to
become part of the answer of ioctl KVM_DEV_FLIC_GET_ALL_IRQS.

The ioctl KVM_DEV_FLIC_ENQUEUE is already capable to enqueue
adapter interrupts when a GISA is present.

With ioctl KVM_DEV_FLIC_CLEAR_IRQS the GISA IPM wil be cleared
now as well.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a0ded3a23a5e0..dd4c50b82a532 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1879,6 +1879,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	for (i = 0; i < FIRQ_MAX_COUNT; i++)
 		fi->counters[i] = 0;
 	spin_unlock(&fi->lock);
+	kvm_s390_gisa_clear(kvm);
 };
 
 static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
@@ -1906,6 +1907,22 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 	max_irqs = len / sizeof(struct kvm_s390_irq);
 
+	if (kvm->arch.gisa &&
+	    kvm_s390_gisa_get_ipm(kvm->arch.gisa)) {
+		for (i = 0; i <= MAX_ISC; i++) {
+			if (n == max_irqs) {
+				/* signal userspace to try again */
+				ret = -ENOMEM;
+				goto out_nolock;
+			}
+			if (kvm_s390_gisa_tac_ipm_gisc(kvm->arch.gisa, i)) {
+				irq = (struct kvm_s390_irq *) &buf[n];
+				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
+				irq->u.io.io_int_word = isc_to_int_word(i);
+				n++;
+			}
+		}
+	}
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
 	for (i = 0; i < FIRQ_LIST_COUNT; i++) {
@@ -1944,6 +1961,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 out:
 	spin_unlock(&fi->lock);
+out_nolock:
 	if (!ret && n > 0) {
 		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
 			ret = -EFAULT;
-- 
2.13.4
