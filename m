From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 1/3] kvm: Introduction of kvm_arch_vcpu_dont_yield()
Date: Tue, 11 Feb 2014 12:45:30 +0100
Message-ID: <1392119132-50182-2-git-send-email-borntraeger@de.ibm.com>
References: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

The function kvm_arch_vcpu_dont_yield() allows the platform dependant
extension of the heuristic being used to identify unsuitable virtual cpus
during undirected yield processing.

The default implementation used the existing waitqueue check.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 include/linux/kvm_host.h | 9 +++++++++
 virt/kvm/Kconfig         | 3 +++
 virt/kvm/kvm_main.c      | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index f5937b8..3e979a2 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -686,6 +686,15 @@ static inline wait_queue_head_t *kvm_arch_vcpu_wq(struct kvm_vcpu *vcpu)
 #endif
 }
 
+#ifndef CONFIG_HAVE_KVM_ARCH_VCPU_DONT_YIELD
+static inline bool kvm_arch_vcpu_dont_yield(struct kvm_vcpu *vcpu)
+{
+	return waitqueue_active(kvm_arch_vcpu_wq(vcpu));
+}
+#else
+bool kvm_arch_vcpu_dont_yield(struct kvm_vcpu *vcpu);
+#endif
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type);
 void kvm_arch_destroy_vm(struct kvm *kvm);
 void kvm_arch_sync_events(struct kvm *kvm);
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 13f2d19..e1e46a8 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -34,3 +34,6 @@ config HAVE_KVM_CPU_RELAX_INTERCEPT
 
 config KVM_VFIO
        bool
+
+config HAVE_KVM_ARCH_VCPU_DONT_YIELD
+       bool
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index a9e999a..6829e6f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1804,7 +1804,7 @@ void kvm_vcpu_on_spin(struct kvm_vcpu *me)
 				continue;
 			if (vcpu == me)
 				continue;
-			if (waitqueue_active(&vcpu->wq))
+			if (kvm_arch_vcpu_dont_yield(vcpu))
 				continue;
 			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
 				continue;
-- 
1.8.4.2
