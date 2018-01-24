From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] KVM: s390: add proper locking for CMMA migration bitmap
Date: Wed, 24 Jan 2018 13:41:00 +0100
Message-ID: <20180124124100.15690-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some parts of the cmma migration bitmap is already protected
with the kvm->lock (e.g. the migration start). On the other
hand the read of the cmma bits is not protected against a
concurrent free, neither is the emulation of the ESSA instruction.
Let's extend the locking to all related ioctls by using
the slots lock and wait for the freeing until all unlocked
users have finished (those hold kvm->srcu for read).

Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org # 4.13+
Fixes: 190df4a212a7 (KVM: s390: CMMA tracking, ESSA emulation, migration mode)
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
v1->v2: fix comments in kvm_s390_vm_[start|stop]_migration
 arch/s390/kvm/kvm-s390.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2a5a9f0617f88..e81b748af4553 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -769,7 +769,7 @@ static void kvm_s390_sync_request_broadcast(struct kvm *kvm, int req)
 
 /*
  * Must be called with kvm->srcu held to avoid races on memslots, and with
- * kvm->lock to avoid races with ourselves and kvm_s390_vm_stop_migration.
+ * kvm->slots_lock to avoid races with ourselves and kvm_s390_vm_stop_migration.
  */
 static int kvm_s390_vm_start_migration(struct kvm *kvm)
 {
@@ -824,7 +824,7 @@ static int kvm_s390_vm_start_migration(struct kvm *kvm)
 }
 
 /*
- * Must be called with kvm->lock to avoid races with ourselves and
+ * Must be called with kvm->slots_lock to avoid races with ourselves and
  * kvm_s390_vm_start_migration.
  */
 static int kvm_s390_vm_stop_migration(struct kvm *kvm)
@@ -839,6 +839,8 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 
 	if (kvm->arch.use_cmma) {
 		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
+		/* We have to wait for the essa emulation to finish */
+		synchronize_srcu(&kvm->srcu);
 		vfree(mgs->pgste_bitmap);
 	}
 	kfree(mgs);
@@ -848,14 +850,12 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 static int kvm_s390_vm_set_migration(struct kvm *kvm,
 				     struct kvm_device_attr *attr)
 {
-	int idx, res = -ENXIO;
+	int res = -ENXIO;
 
-	mutex_lock(&kvm->lock);
+	mutex_lock(&kvm->slots_lock);
 	switch (attr->attr) {
 	case KVM_S390_VM_MIGRATION_START:
-		idx = srcu_read_lock(&kvm->srcu);
 		res = kvm_s390_vm_start_migration(kvm);
-		srcu_read_unlock(&kvm->srcu, idx);
 		break;
 	case KVM_S390_VM_MIGRATION_STOP:
 		res = kvm_s390_vm_stop_migration(kvm);
@@ -863,7 +863,7 @@ static int kvm_s390_vm_set_migration(struct kvm *kvm,
 	default:
 		break;
 	}
-	mutex_unlock(&kvm->lock);
+	mutex_unlock(&kvm->slots_lock);
 
 	return res;
 }
@@ -1765,7 +1765,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
+		mutex_lock(&kvm->slots_lock);
 		r = kvm_s390_get_cmma_bits(kvm, &args);
+		mutex_unlock(&kvm->slots_lock);
 		if (!r) {
 			r = copy_to_user(argp, &args, sizeof(args));
 			if (r)
@@ -1779,7 +1781,9 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&args, argp, sizeof(args)))
 			break;
+		mutex_lock(&kvm->slots_lock);
 		r = kvm_s390_set_cmma_bits(kvm, &args);
+		mutex_unlock(&kvm->slots_lock);
 		break;
 	}
 	default:
-- 
2.13.4
