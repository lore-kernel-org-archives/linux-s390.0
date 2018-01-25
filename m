From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 08/12] KVM: s390: add GISA interrupts to FLIC ioctl interface
Date: Thu, 25 Jan 2018 14:28:44 +0100
Message-ID: <20180125132848.175942-9-borntraeger@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125132848.175942-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
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
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7731c0d..0edf97a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1882,6 +1882,7 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	for (i = 0; i < FIRQ_MAX_COUNT; i++)
 		fi->counters[i] = 0;
 	spin_unlock(&fi->lock);
+	kvm_s390_gisa_clear(kvm);
 };
 
 static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
@@ -1909,6 +1910,22 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
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
@@ -1947,6 +1964,7 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
 
 out:
 	spin_unlock(&fi->lock);
+out_nolock:
 	if (!ret && n > 0) {
 		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
 			ret = -EFAULT;
-- 
2.9.4
