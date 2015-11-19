From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 3/5] KVM: Provide function for VCPU lookup by id
Date: Thu, 19 Nov 2015 15:09:24 +0100
Message-ID: <1447942166-66514-4-git-send-email-borntraeger@de.ibm.com>
References: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's provide a function to lookup a VCPU by id.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split patch from refactoring patch]
---
 include/linux/kvm_host.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5706a21..c923350 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -460,6 +460,17 @@ static inline struct kvm_vcpu *kvm_get_vcpu(struct kvm *kvm, int i)
 	     (vcpup = kvm_get_vcpu(kvm, idx)) != NULL; \
 	     idx++)
 
+static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
+{
+	struct kvm_vcpu *vcpu;
+	int i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		if (vcpu->vcpu_id == id)
+			return vcpu;
+	return NULL;
+}
+
 #define kvm_for_each_memslot(memslot, slots)	\
 	for (memslot = &slots->memslots[0];	\
 	      memslot < slots->memslots + KVM_MEM_SLOTS_NUM && memslot->npages;\
-- 
2.3.0
