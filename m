From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 25/51] KVM: s390: backup the currently enabled gmap when scheduled out
Date: Tue, 21 Jun 2016 15:13:03 +0200
Message-ID: <1466514809-146638-26-git-send-email-borntraeger@de.ibm.com>
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

Nested virtualization will have to enable own gmaps. Current code
would enable the wrong gmap whenever scheduled out and back in,
therefore resulting in the wrong gmap being enabled.

This patch reenables the last enabled gmap, therefore avoiding having to
touch vcpu->arch.gmap when enabling a different gmap.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h     |  1 +
 arch/s390/include/asm/kvm_host.h |  2 ++
 arch/s390/kvm/kvm-s390.c         |  8 +++++---
 arch/s390/mm/gmap.c              | 11 +++++++++++
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index c67fb85..741ddba 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -94,6 +94,7 @@ void gmap_put(struct gmap *gmap);
 
 void gmap_enable(struct gmap *gmap);
 void gmap_disable(struct gmap *gmap);
+struct gmap *gmap_get_enabled(void);
 int gmap_map_segment(struct gmap *gmap, unsigned long from,
 		     unsigned long to, unsigned long len);
 int gmap_unmap_segment(struct gmap *gmap, unsigned long to, unsigned long len);
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 9eed5c1..96bef30 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -551,6 +551,8 @@ struct kvm_vcpu_arch {
 	struct hrtimer    ckc_timer;
 	struct kvm_s390_pgm_info pgm;
 	struct gmap *gmap;
+	/* backup location for the currently enabled gmap when scheduled out */
+	struct gmap *enabled_gmap;
 	struct kvm_guestdbg_info_arch guestdbg;
 	unsigned long pfault_token;
 	unsigned long pfault_select;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 45a8316..a890f7d 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1719,7 +1719,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
-	gmap_enable(vcpu->arch.gmap);
+	gmap_enable(vcpu->arch.enabled_gmap);
 	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
 		__start_cpu_timer_accounting(vcpu);
@@ -1732,7 +1732,8 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
 		__stop_cpu_timer_accounting(vcpu);
 	atomic_andnot(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
-	gmap_disable(vcpu->arch.gmap);
+	vcpu->arch.enabled_gmap = gmap_get_enabled();
+	gmap_disable(vcpu->arch.enabled_gmap);
 
 	/* Save guest register state */
 	save_fpu_regs();
@@ -1781,7 +1782,8 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 		vcpu->arch.gmap = vcpu->kvm->arch.gmap;
 		sca_add_vcpu(vcpu);
 	}
-
+	/* make vcpu_load load the right gmap on the first trigger */
+	vcpu->arch.enabled_gmap = vcpu->arch.gmap;
 }
 
 static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 738d754..af0ae6d 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -270,6 +270,17 @@ void gmap_disable(struct gmap *gmap)
 }
 EXPORT_SYMBOL_GPL(gmap_disable);
 
+/**
+ * gmap_get_enabled - get a pointer to the currently enabled gmap
+ *
+ * Returns a pointer to the currently enabled gmap. 0 if none is enabled.
+ */
+struct gmap *gmap_get_enabled(void)
+{
+	return (struct gmap *) S390_lowcore.gmap;
+}
+EXPORT_SYMBOL_GPL(gmap_get_enabled);
+
 /*
  * gmap_alloc_table is assumed to be called with mmap_sem held
  */
-- 
2.5.5
