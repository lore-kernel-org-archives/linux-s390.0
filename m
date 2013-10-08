From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [Patchv5 4/7] KVM: async_pf: Provide additional direct page notification
Date: Tue,  8 Oct 2013 16:54:57 +0200
Message-ID: <1381244100-59056-5-git-send-email-borntraeger@de.ibm.com>
References: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1381244100-59056-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

By setting a Kconfig option, the architecture can control when
guest notifications will be presented by the apf backend.
So there is the default batch mechanism, working as before, where the vcpu thread
should pull in this information. On the other hand there is now the direct
mechanism, this will directly push the information to the guest.
This way s390 can use an already existing architecture interface.

Still the vcpu thread should call check_completion to cleanup leftovers,
that leaves most of the common code untouched.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/x86/kvm/mmu.c       |  2 +-
 include/linux/kvm_host.h |  2 +-
 virt/kvm/Kconfig         |  4 ++++
 virt/kvm/async_pf.c      | 22 +++++++++++++++++++---
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index cf95cfe..9862e36 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3324,7 +3324,7 @@ static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn)
 	arch.direct_map = vcpu->arch.mmu.direct_map;
 	arch.cr3 = vcpu->arch.mmu.get_cr3(vcpu);
 
-	return kvm_setup_async_pf(vcpu, gva, gfn, &arch);
+	return kvm_setup_async_pf(vcpu, gva, gfn_to_hva(vcpu->kvm, gfn), &arch);
 }
 
 static bool can_do_async_pf(struct kvm_vcpu *vcpu)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 2077dd0..b4e8666 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -194,7 +194,7 @@ struct kvm_async_pf {
 
 void kvm_clear_async_pf_completion_queue(struct kvm_vcpu *vcpu);
 void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu);
-int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
+int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, unsigned long hva,
 		       struct kvm_arch_async_pf *arch);
 int kvm_async_pf_wakeup_all(struct kvm_vcpu *vcpu);
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 779262f..0774495 100644
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
index b197950..8f57d63 100644
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
@@ -70,6 +85,7 @@ static void async_pf_execute(struct work_struct *work)
 	down_read(&mm->mmap_sem);
 	get_user_pages(current, mm, addr, 1, 1, 0, &page, NULL);
 	up_read(&mm->mmap_sem);
+	kvm_async_page_present_sync(vcpu, apf);
 	unuse_mm(mm);
 
 	spin_lock(&vcpu->async_pf.lock);
@@ -135,7 +151,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 
 		if (work->page)
 			kvm_arch_async_page_ready(vcpu, work);
-		kvm_arch_async_page_present(vcpu, work);
+		kvm_async_page_present_async(vcpu, work);
 
 		list_del(&work->queue);
 		vcpu->async_pf.queued--;
@@ -145,7 +161,7 @@ void kvm_check_async_pf_completion(struct kvm_vcpu *vcpu)
 	}
 }
 
-int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
+int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, unsigned long hva,
 		       struct kvm_arch_async_pf *arch)
 {
 	struct kvm_async_pf *work;
@@ -166,7 +182,7 @@ int kvm_setup_async_pf(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
 	work->page = NULL;
 	work->vcpu = vcpu;
 	work->gva = gva;
-	work->addr = gfn_to_hva(vcpu->kvm, gfn);
+	work->addr = hva;
 	work->arch = *arch;
 	work->mm = current->mm;
 	atomic_inc(&work->mm->mm_count);
-- 
1.8.3.1
