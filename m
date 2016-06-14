From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:57:21 +0000
Subject: [GIT PULL 44/52] KVM: s390: storage keys fit into a char
Message-Id: <201606141857.u5EIs1hn090457@mx0a-001b2d01.pphosted.com>
In-Reply-To: <201606141857.u5EIs0in141840@mx0a-001b2d01.pphosted.com>
References: <201606141857.u5EIs0in141840@mx0a-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

No need to convert the storage key into an unsigned long, the target
function expects a char as argument.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ad166c6..49c6039 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1120,8 +1120,7 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 			break;
 		}
 
-		r = set_guest_storage_key(current->mm, hva,
-					  (unsigned long)keys[i], 0);
+		r = set_guest_storage_key(current->mm, hva, keys[i], 0);
 		if (r)
 			break;
 	}
-- 
2.5.5
