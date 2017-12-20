From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/5] KVM: s390: add debug tracing for cpu features of CPU model
Date: Wed, 20 Dec 2017 16:52:58 +0100
Message-ID: <20171220155300.102321-4-borntraeger@de.ibm.com>
References: <20171220155300.102321-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171220155300.102321-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

The cpu model already traces the cpu facilities, the ibc and
guest CPU ids. We should do the same for the cpu features (on
success only).

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 00ef6f47e466..c85d7c4e8a38 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1084,7 +1084,6 @@ static int kvm_s390_set_processor_feat(struct kvm *kvm,
 				       struct kvm_device_attr *attr)
 {
 	struct kvm_s390_vm_cpu_feat data;
-	int ret = -EBUSY;
 
 	if (copy_from_user(&data, (void __user *)attr->addr, sizeof(data)))
 		return -EFAULT;
@@ -1094,13 +1093,18 @@ static int kvm_s390_set_processor_feat(struct kvm *kvm,
 		return -EINVAL;
 
 	mutex_lock(&kvm->lock);
-	if (!kvm->created_vcpus) {
-		bitmap_copy(kvm->arch.cpu_feat, (unsigned long *) data.feat,
-			    KVM_S390_VM_CPU_FEAT_NR_BITS);
-		ret = 0;
+	if (kvm->created_vcpus) {
+		mutex_unlock(&kvm->lock);
+		return -EBUSY;
 	}
+	bitmap_copy(kvm->arch.cpu_feat, (unsigned long *) data.feat,
+		    KVM_S390_VM_CPU_FEAT_NR_BITS);
 	mutex_unlock(&kvm->lock);
-	return ret;
+	VM_EVENT(kvm, 3, "SET: guest feat: 0x%16.16llx.0x%16.16llx.0x%16.16llx",
+			 data.feat[0],
+			 data.feat[1],
+			 data.feat[2]);
+	return 0;
 }
 
 static int kvm_s390_set_processor_subfunc(struct kvm *kvm,
@@ -1202,6 +1206,10 @@ static int kvm_s390_get_processor_feat(struct kvm *kvm,
 		    KVM_S390_VM_CPU_FEAT_NR_BITS);
 	if (copy_to_user((void __user *)attr->addr, &data, sizeof(data)))
 		return -EFAULT;
+	VM_EVENT(kvm, 3, "GET: guest feat: 0x%16.16llx.0x%16.16llx.0x%16.16llx",
+			 data.feat[0],
+			 data.feat[1],
+			 data.feat[2]);
 	return 0;
 }
 
@@ -1215,6 +1223,10 @@ static int kvm_s390_get_machine_feat(struct kvm *kvm,
 		    KVM_S390_VM_CPU_FEAT_NR_BITS);
 	if (copy_to_user((void __user *)attr->addr, &data, sizeof(data)))
 		return -EFAULT;
+	VM_EVENT(kvm, 3, "GET: host feat:  0x%16.16llx.0x%16.16llx.0x%16.16llx",
+			 data.feat[0],
+			 data.feat[1],
+			 data.feat[2]);
 	return 0;
 }
 
-- 
2.13.4
