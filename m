From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/8] KVM: s390: fix get_all_floating_irqs
Date: Tue, 31 Mar 2015 15:01:58 +0200
Message-ID: <1427806923-21910-4-git-send-email-borntraeger@de.ibm.com>
References: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1427806923-21910-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

This fixes a bug introduced with commit c05c4186bbe4 ("KVM: s390:
add floating irq controller").

get_all_floating_irqs() does copy_to_user() while holding
a spin lock. Let's fix this by filling a temporary buffer
first and copy it to userspace after giving up the lock.

Cc: <stable@vger.kernel.org> # 3.18+: 69a8d4562638 KVM: s390: no need to hold...

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt |  3 ++
 arch/s390/kvm/interrupt.c                       | 60 ++++++++++++++-----------
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index 4ceef53..d1ad9d5 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -27,6 +27,9 @@ Groups:
     Copies all floating interrupts into a buffer provided by userspace.
     When the buffer is too small it returns -ENOMEM, which is the indication
     for userspace to try again with a bigger buffer.
+    -ENOBUFS is returned when the allocation of a kernelspace buffer has
+    failed.
+    -EFAULT is returned when copying data to userspace failed.
     All interrupts remain pending, i.e. are not deleted from the list of
     currently pending interrupts.
     attr->addr contains the userspace address of the buffer into which all
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2361b8e..65b4eee 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -17,6 +17,7 @@
 #include <linux/signal.h>
 #include <linux/slab.h>
 #include <linux/bitmap.h>
+#include <linux/vmalloc.h>
 #include <asm/asm-offsets.h>
 #include <asm/dis.h>
 #include <asm/uaccess.h>
@@ -1477,61 +1478,68 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
 	spin_unlock(&fi->lock);
 }
 
-static inline int copy_irq_to_user(struct kvm_s390_interrupt_info *inti,
-				   u8 *addr)
+static void inti_to_irq(struct kvm_s390_interrupt_info *inti,
+		       struct kvm_s390_irq *irq)
 {
-	struct kvm_s390_irq __user *uptr = (struct kvm_s390_irq __user *) addr;
-	struct kvm_s390_irq irq = {0};
-
-	irq.type = inti->type;
+	irq->type = inti->type;
 	switch (inti->type) {
 	case KVM_S390_INT_PFAULT_INIT:
 	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
 	case KVM_S390_INT_SERVICE:
-		irq.u.ext = inti->ext;
+		irq->u.ext = inti->ext;
 		break;
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		irq.u.io = inti->io;
+		irq->u.io = inti->io;
 		break;
 	case KVM_S390_MCHK:
-		irq.u.mchk = inti->mchk;
+		irq->u.mchk = inti->mchk;
 		break;
-	default:
-		return -EINVAL;
 	}
-
-	if (copy_to_user(uptr, &irq, sizeof(irq)))
-		return -EFAULT;
-
-	return 0;
 }
 
-static int get_all_floating_irqs(struct kvm *kvm, __u8 *buf, __u64 len)
+static int get_all_floating_irqs(struct kvm *kvm, __user u8 *usrbuf, u64 len)
 {
 	struct kvm_s390_interrupt_info *inti;
 	struct kvm_s390_float_interrupt *fi;
+	struct kvm_s390_irq *buf;
+	int max_irqs;
 	int ret = 0;
 	int n = 0;
 
+	if (len > KVM_S390_FLIC_MAX_BUFFER || len == 0)
+		return -EINVAL;
+
+	/*
+	 * We are already using -ENOMEM to signal
+	 * userspace it may retry with a bigger buffer,
+	 * so we need to use something else for this case
+	 */
+	buf = vzalloc(len);
+	if (!buf)
+		return -ENOBUFS;
+
+	max_irqs = len / sizeof(struct kvm_s390_irq);
+
 	fi = &kvm->arch.float_int;
 	spin_lock(&fi->lock);
-
 	list_for_each_entry(inti, &fi->list, list) {
-		if (len < sizeof(struct kvm_s390_irq)) {
+		if (n == max_irqs) {
 			/* signal userspace to try again */
 			ret = -ENOMEM;
 			break;
 		}
-		ret = copy_irq_to_user(inti, buf);
-		if (ret)
-			break;
-		buf += sizeof(struct kvm_s390_irq);
-		len -= sizeof(struct kvm_s390_irq);
+		inti_to_irq(inti, &buf[n]);
 		n++;
 	}
-
 	spin_unlock(&fi->lock);
+	if (!ret && n > 0) {
+		if (copy_to_user((void __user *) usrbuf,
+				 (void *) buf,
+				 sizeof(struct kvm_s390_irq) * n))
+			ret = -EFAULT;
+	}
+	vfree(buf);
 
 	return ret < 0 ? ret : n;
 }
@@ -1542,7 +1550,7 @@ static int flic_get_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 
 	switch (attr->group) {
 	case KVM_DEV_FLIC_GET_ALL_IRQS:
-		r = get_all_floating_irqs(dev->kvm, (u8 *) attr->addr,
+		r = get_all_floating_irqs(dev->kvm, (__user u8 *) attr->addr,
 					  attr->attr);
 		break;
 	default:
-- 
2.3.0
