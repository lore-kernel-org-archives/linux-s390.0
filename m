From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 46/51] KVM: s390: vsie: speed up VCPU irq delivery when handling vsie
Date: Tue, 21 Jun 2016 15:13:24 +0200
Message-ID: <1466514809-146638-47-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Whenever we want to wake up a VCPU (e.g. when injecting an IRQ), we
have to kick it out of vsie, so the request will be handled faster.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/interrupt.c        |  5 +++++
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/vsie.c             | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 190ad63..946fc86 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -549,6 +549,8 @@ struct kvm_guestdbg_info_arch {
 
 struct kvm_vcpu_arch {
 	struct kvm_s390_sie_block *sie_block;
+	/* if vsie is active, currently executed shadow sie control block */
+	struct kvm_s390_sie_block *vsie_block;
 	unsigned int      host_acrs[NUM_ACRS];
 	struct fpu	  host_fpregs;
 	struct kvm_s390_local_interrupt local_int;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d72c4a8..ca19627 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -995,6 +995,11 @@ void kvm_s390_vcpu_wakeup(struct kvm_vcpu *vcpu)
 		swake_up(&vcpu->wq);
 		vcpu->stat.halt_wakeup++;
 	}
+	/*
+	 * The VCPU might not be sleeping but is executing the VSIE. Let's
+	 * kick it, so it leaves the SIE to process the request.
+	 */
+	kvm_s390_vsie_kick(vcpu);
 }
 
 enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index b137fba..ffbbdd28 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -254,6 +254,7 @@ int kvm_s390_handle_eb(struct kvm_vcpu *vcpu);
 
 /* implemented in vsie.c */
 int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu);
+void kvm_s390_vsie_kick(struct kvm_vcpu *vcpu);
 void kvm_s390_vsie_gmap_notifier(struct gmap *gmap, unsigned long start,
 				 unsigned long end);
 void kvm_s390_vsie_init(struct kvm *kvm);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 7482488..c8c8763 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -838,6 +838,23 @@ static int acquire_gmap_shadow(struct kvm_vcpu *vcpu,
 }
 
 /*
+ * Register the shadow scb at the VCPU, e.g. for kicking out of vsie.
+ */
+static void register_shadow_scb(struct kvm_vcpu *vcpu,
+				struct vsie_page *vsie_page)
+{
+	WRITE_ONCE(vcpu->arch.vsie_block, &vsie_page->scb_s);
+}
+
+/*
+ * Unregister a shadow scb from a VCPU.
+ */
+static void unregister_shadow_scb(struct kvm_vcpu *vcpu)
+{
+	WRITE_ONCE(vcpu->arch.vsie_block, NULL);
+}
+
+/*
  * Run the vsie on a shadowed scb, managing the gmap shadow, handling
  * prefix pages and faults.
  *
@@ -860,6 +877,7 @@ static int vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			rc = do_vsie_run(vcpu, vsie_page);
 			gmap_enable(vcpu->arch.gmap);
 		}
+		atomic_andnot(PROG_BLOCK_SIE, &scb_s->prog20);
 
 		if (rc == -EAGAIN)
 			rc = 0;
@@ -1000,7 +1018,9 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	rc = pin_blocks(vcpu, vsie_page);
 	if (rc)
 		goto out_unshadow;
+	register_shadow_scb(vcpu, vsie_page);
 	rc = vsie_run(vcpu, vsie_page);
+	unregister_shadow_scb(vcpu);
 	unpin_blocks(vcpu, vsie_page);
 out_unshadow:
 	unshadow_scb(vcpu, vsie_page);
@@ -1039,3 +1059,18 @@ void kvm_s390_vsie_destroy(struct kvm *kvm)
 	kvm->arch.vsie.page_count = 0;
 	mutex_unlock(&kvm->arch.vsie.mutex);
 }
+
+void kvm_s390_vsie_kick(struct kvm_vcpu *vcpu)
+{
+	struct kvm_s390_sie_block *scb = READ_ONCE(vcpu->arch.vsie_block);
+
+	/*
+	 * Even if the VCPU lets go of the shadow sie block reference, it is
+	 * still valid in the cache. So we can safely kick it.
+	 */
+	if (scb) {
+		atomic_or(PROG_BLOCK_SIE, &scb->prog20);
+		if (scb->prog0c & PROG_IN_SIE)
+			atomic_or(CPUSTAT_STOP_INT, &scb->cpuflags);
+	}
+}
-- 
2.5.5
