From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 31 May 2018 21:07:58 +0000
Subject: [GIT PULL 5/7] KVM: s390: generalize kvm_s390_get_tod_clock_ext()
Message-Id: <20180531210800.137347-6-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

Move the Multiple-epoch facility handling into it and rename it to
kvm_s390_get_tod_clock().

This leaves us with:
- kvm_s390_set_tod_clock()
- kvm_s390_get_tod_clock()
- kvm_s390_get_tod_clock_fast()

So all Multiple-epoch facility is hidden in these functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index fd7ce3ab45eb..e521f7699032 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1040,8 +1040,8 @@ static int kvm_s390_set_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
-static void kvm_s390_get_tod_clock_ext(struct kvm *kvm,
-					struct kvm_s390_vm_tod_clock *gtod)
+static void kvm_s390_get_tod_clock(struct kvm *kvm,
+				   struct kvm_s390_vm_tod_clock *gtod)
 {
 	struct kvm_s390_tod_clock_ext htod;
 
@@ -1050,10 +1050,12 @@ static void kvm_s390_get_tod_clock_ext(struct kvm *kvm,
 	get_tod_clock_ext((char *)&htod);
 
 	gtod->tod = htod.tod + kvm->arch.epoch;
-	gtod->epoch_idx = htod.epoch_idx + kvm->arch.epdx;
-
-	if (gtod->tod < htod.tod)
-		gtod->epoch_idx += 1;
+	gtod->epoch_idx = 0;
+	if (test_kvm_facility(kvm, 139)) {
+		gtod->epoch_idx = htod.epoch_idx + kvm->arch.epdx;
+		if (gtod->tod < htod.tod)
+			gtod->epoch_idx += 1;
+	}
 
 	preempt_enable();
 }
@@ -1063,12 +1065,7 @@ static int kvm_s390_get_tod_ext(struct kvm *kvm, struct kvm_device_attr *attr)
 	struct kvm_s390_vm_tod_clock gtod;
 
 	memset(&gtod, 0, sizeof(gtod));
-
-	if (test_kvm_facility(kvm, 139))
-		kvm_s390_get_tod_clock_ext(kvm, &gtod);
-	else
-		gtod.tod = kvm_s390_get_tod_clock_fast(kvm);
-
+	kvm_s390_get_tod_clock(kvm, &gtod);
 	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
 		return -EFAULT;
 
-- 
2.14.2
