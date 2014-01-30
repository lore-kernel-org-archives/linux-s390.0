From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 5/8] KVM: async_pf: Provide additional direct page notification
Date: Thu, 30 Jan 2014 13:53:46 +0100
Message-ID: <1391086429-43935-6-git-send-email-borntraeger@de.ibm.com>
References: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

By setting a Kconfig option, the architecture can control when
guest notifications will be presented by the apf backend.
There is the default batch mechanism, working as before, where the vcpu
thread should pull in this information.
Opposite to this, there is now the direct mechanism, that will push the
information to the guest.
This way s390 can use an already existing architecture interface.

Still the vcpu thread should call check_completion to cleanup leftovers.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/x86/kvm/mmu.c       |  2 +-
 include/linux/kvm_host.h |  2 +-
 virt/kvm/Kconfig         |  4 ++++
 virt/kvm/async_pf.c      | 20 ++++++++++++++++++--
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index e50425d..aaa60f3 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3328,7 +3328,7 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn)
 	arch.direct_map = vcpu->arch.mmu.direct_map;
 	arch.cr3 = vcpu->arch.mmu.get_cr3(vcpu);
 
-	return kvm_setup_async_pf(vcpu, gva, gfn, &arch);
+	return kvm_setup_async_pf(vcpu, gva, gfn_to_hva(vcpu->kvm, gfn), &arch);
 }
 
 static bool can_do_async_pf(struct kvm_vcpu *vcpu)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index c0102ef..f5937b8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -192,7 +192,7 @@ struct kvm_async_pf {
 
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
 void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
-int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
+int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, unsigned long hva,
 		       struct kvm_arch_async_pf *arch);
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index fbe1a48..13f2d19 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -22,6 +22,10 @@ config KVM_MMIO
 config KVM_ASYNC_PF
        bool
 
+# Toggle to switch between direct notification and batch job
+config KVM_ASYNC_PF_SYNC
+       bool
+
 config HAVE_KVM_MSI
        bool
 
diff --git a/virt/kvm/async_pf.c b/virt/kvm/async_pf.c
index 8631d9c..00980ab 100644
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -28,6 +28,21 @@
 #include "async_pf.h"
 #include <trace/events/kvm.h>
 
+static inline void kvm_async_page_present_sync(struct kvm_vcpu *vcpu,
+					       struct kvm_async_pf *work)
+{
+#ifdef CONFIG_KVM_ASYNC_PF_SYNC
+	kvm_arch_async_page_present(vcpu, work);
+#endif
+}
+static inline void kvm_async_page_present_async(struct kvm_vcpu *vcpu,
+						struct kvm_async_pf *work)
+{
+#ifndef CONFIG_KVM_ASYNC_PF_SYNC
+	kvm_arch_async_page_present(vcpu, work);
+#endif
+}
+
 static struct kmem_cache *async_pf_cache;
 
 int kvm_async_pf_init(void)
@@ -69,6 +84,7 @@ static void async_pf_execute(struct work_struct *work)
 	down_read(&mm->mmap_sem);
 	get_user_pages(current, mm, addr, 1, 1, 0, NULL, NULL);
 	up_read(&mm->mmap_sem);
+	kvm_async_page_present_sync(vcpu, apf);
 	unuse_mm(mm);
 
 	spin_lock(&vcpu->async_pf.lock);
@@ -138,7 +154,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 	}
 }
 
-int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
+int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, unsigned long hva,
 		       struct kvm_arch_async_pf *arch)
 {
 	struct kvm_async_pf *work;
@@ -159,7 +175,7 @@ int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
 	work->wakeup_all = false;
 	work->vcpu = vcpu;
 	work->gva = gva;
-	work->addr = gfn_to_hva(vcpu->kvm, gfn);
+	work->addr = hva;
 	work->arch = *arch;
 	work->mm = current->mm;
 	atomic_inc(&work->mm->mm_count);
-- 
1.8.4.2
