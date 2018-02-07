From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 6/6] KVM: s390: generalize kvm_s390_get_tod_clock_ext()
Date: Wed,  7 Feb 2018 12:46:47 +0100
Message-ID: <20180207114647.6220-7-david@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180207114647.6220-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Move the Multiple-epoch facility handling into it and rename it to
kvm_s390_get_tod_clock().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/kvm-s390.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0c0eed7d60a8..df452b8b4f26 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -990,8 +990,8 @@ static int kvm_s390_set_tod(struct kvm *kvm, struct kvm_device_attr *attr)
 	return ret;
 }
 
-static void kvm_s390_get_tod_clock_ext(struct kvm *kvm,
-					struct kvm_s390_vm_tod_clock *gtod)
+static void kvm_s390_get_tod_clock(struct kvm *kvm,
+				   struct kvm_s390_vm_tod_clock *gtod)
 {
 	struct kvm_s390_tod_clock_ext htod;
 
@@ -1000,10 +1000,12 @@ static void kvm_s390_get_tod_clock_ext(struct kvm *kvm,
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
@@ -1012,13 +1014,7 @@ static int kvm_s390_get_tod_ext(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_s390_vm_tod_clock gtod;
 
-	memset(&gtod, 0, sizeof(gtod));
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
2.14.3
