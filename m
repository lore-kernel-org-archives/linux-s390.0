From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/23] KVM: use heuristic for fast VCPU lookup by id
Date: Wed,  2 Dec 2015 12:06:03 +0100
Message-ID: <1449054384-76374-3-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Usually, VCPU ids match the array index. So let's try a fast
lookup first before falling back to the slow iteration.

Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/kvm_host.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2911919..a754fc0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -472,6 +472,11 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 	struct kvm_vcpu *vcpu;
 	int i;
 
+	if (id < 0 || id >= KVM_MAX_VCPUS)
+		return NULL;
+	vcpu = kvm_get_vcpu(kvm, id);
+	if (vcpu && vcpu->vcpu_id == id)
+		return vcpu;
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		if (vcpu->vcpu_id == id)
 			return vcpu;
-- 
2.3.0
