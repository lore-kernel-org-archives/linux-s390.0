From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: introduce KMSG_COMPONENT for kvm-s390
Date: Tue,  2 Jun 2015 10:14:10 +0200
Message-ID: <1433232850-9578-3-git-send-email-borntraeger@de.ibm.com>
References: <1433232850-9578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1433232850-9578-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's remove "kvm-s390" from our printk messages and make use
of pr_fmt instead.

Also replace one printk() occurrence by a equivalent pr_warn
on the way.

Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f37557b..9cb6cfaa 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -36,6 +36,10 @@
 #include "kvm-s390.h"
 #include "gaccess.h"
 
+#define KMSG_COMPONENT "kvm-s390"
+#undef pr_fmt
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #define CREATE_TRACE_POINTS
 #include "trace.h"
 #include "trace-s390.h"
@@ -2086,7 +2090,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (!kvm_s390_user_cpu_state_ctrl(vcpu->kvm)) {
 		kvm_s390_vcpu_start(vcpu);
 	} else if (is_vcpu_stopped(vcpu)) {
-		pr_err_ratelimited("kvm-s390: can't run stopped vcpu %d\n",
+		pr_err_ratelimited("can't run stopped vcpu %d\n",
 				   vcpu->vcpu_id);
 		return -EINVAL;
 	}
@@ -2617,7 +2621,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 	rc = gmap_map_segment(kvm->arch.gmap, mem->userspace_addr,
 		mem->guest_phys_addr, mem->memory_size);
 	if (rc)
-		printk(KERN_WARNING "kvm-s390: failed to commit memory region\n");
+		pr_warn("failed to commit memory region\n");
 	return;
 }
 
-- 
2.3.0
