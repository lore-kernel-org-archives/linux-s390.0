From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/3] KVM: s390: drop useless newline in debugging data
Date: Thu, 29 Oct 2015 16:08:28 +0100
Message-ID: <1446131309-176770-3-git-send-email-borntraeger@de.ibm.com>
References: <1446131309-176770-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1446131309-176770-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

the s390 debug feature does not need newlines. In fact it will
result in empty lines. Get rid of 4 leftovers.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 3559617..07a6aa8 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -514,7 +514,7 @@ static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 
 	if (gtod_high != 0)
 		return -EINVAL;
-	VM_EVENT(kvm, 3, "SET: TOD extension: 0x%x\n", gtod_high);
+	VM_EVENT(kvm, 3, "SET: TOD extension: 0x%x", gtod_high);
 
 	return 0;
 }
@@ -527,7 +527,7 @@ static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 		return -EFAULT;
 
 	kvm_s390_set_tod_clock(kvm, gtod);
-	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx\n", gtod);
+	VM_EVENT(kvm, 3, "SET: TOD base: 0x%llx", gtod);
 	return 0;
 }
 
@@ -559,7 +559,7 @@ static int kvm_s390_get_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 	if (copy_to_user((void __user *)attr->addr, &gtod_high,
 					 sizeof(gtod_high)))
 		return -EFAULT;
-	VM_EVENT(kvm, 3, "QUERY: TOD extension: 0x%x\n", gtod_high);
+	VM_EVENT(kvm, 3, "QUERY: TOD extension: 0x%x", gtod_high);
 
 	return 0;
 }
@@ -571,7 +571,7 @@ static int kvm_s390_get_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 	gtod = kvm_s390_get_tod_clock_fast(kvm);
 	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
 		return -EFAULT;
-	VM_EVENT(kvm, 3, "QUERY: TOD base: 0x%llx\n", gtod);
+	VM_EVENT(kvm, 3, "QUERY: TOD base: 0x%llx", gtod);
 
 	return 0;
 }
-- 
2.4.3
