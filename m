From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH 2/2] KVM: remove garbage arg to *hardware_{en,dis}able
Date: Thu, 28 Aug 2014 15:13:03 +0200
Message-ID: <1409231583-7048-3-git-send-email-rkrcmar@redhat.com>
References: <1409231583-7048-1-git-send-email-rkrcmar@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409231583-7048-1-git-send-email-rkrcmar@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, kvm-ia64@vger.kernel.org, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu, Paolo Bonzini <pbonzini@redhat.com>, Gleb Natapov <gleb@kernel.org>, Christoffer Dall <christoffer.dall@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

In the beggining was on_each_cpu(), which required an unused argument t=
o
kvm_arch_ops.hardware_{en,dis}able, but this was soon forgotten.

Remove unnecessary arguments that stem from this.

Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
---
 arch/arm/include/asm/kvm_host.h     |  2 +-
 arch/arm/kvm/arm.c                  |  2 +-
 arch/arm64/include/asm/kvm_host.h   |  2 +-
 arch/ia64/kvm/kvm-ia64.c            |  4 ++--
 arch/mips/include/asm/kvm_host.h    |  2 +-
 arch/mips/kvm/mips.c                |  2 +-
 arch/powerpc/include/asm/kvm_host.h |  2 +-
 arch/powerpc/kvm/powerpc.c          |  2 +-
 arch/s390/include/asm/kvm_host.h    |  2 +-
 arch/s390/kvm/kvm-s390.c            |  2 +-
 arch/x86/include/asm/kvm_host.h     |  4 ++--
 arch/x86/kvm/svm.c                  |  4 ++--
 arch/x86/kvm/vmx.c                  |  4 ++--
 arch/x86/kvm/x86.c                  | 12 ++++++------
 include/linux/kvm_host.h            |  4 ++--
 virt/kvm/kvm_main.c                 |  4 ++--
 16 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm=
_host.h
index 84291fe..278ecfa 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -233,7 +233,7 @@ static inline void vgic_arch_setup(const struct vgi=
c_params *vgic)
 int kvm_perf_init(void);
 int kvm_perf_teardown(void);
=20
-static inline void kvm_arch_hardware_disable(void *garbage) {}
+static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 132bb0d..005a7b5 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -87,7 +87,7 @@ struct kvm_vcpu __percpu **kvm_get_running_vcpus(void=
)
 	return &kvm_arm_running_vcpu;
 }
=20
-int kvm_arch_hardware_enable(void *garbage)
+int kvm_arch_hardware_enable(void)
 {
 	return 0;
 }
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm=
/kvm_host.h
index 94d8a3c..3816c52 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -244,7 +244,7 @@ static inline void vgic_arch_setup(const struct vgi=
c_params *vgic)
 	}
 }
=20
-static inline void kvm_arch_hardware_disable(void *garbage) {}
+static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_vcpu_uninit(struct kvm_vcpu *vcpu) {}
diff --git a/arch/ia64/kvm/kvm-ia64.c b/arch/ia64/kvm/kvm-ia64.c
index 5e14dca..ec6b9ac 100644
--- a/arch/ia64/kvm/kvm-ia64.c
+++ b/arch/ia64/kvm/kvm-ia64.c
@@ -125,7 +125,7 @@ long ia64_pal_vp_create(u64 *vpd, u64 *host_iva, u6=
4 *opt_handler)
=20
 static  DEFINE_SPINLOCK(vp_lock);
=20
-int kvm_arch_hardware_enable(void *garbage)
+int kvm_arch_hardware_enable(void)
 {
 	long  status;
 	long  tmp_base;
@@ -160,7 +160,7 @@ int kvm_arch_hardware_enable(void *garbage)
 	return 0;
 }
=20
-void kvm_arch_hardware_disable(void *garbage)
+void kvm_arch_hardware_disable(void)
 {
=20
 	long status;
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/k=
vm_host.h
index b4d900a..2f63ca2 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -767,7 +767,7 @@ extern int kvm_mips_trans_mtc0(uint32_t inst, uint3=
2_t *opc,
 extern void kvm_mips_dump_stats(struct kvm_vcpu *vcpu);
 extern unsigned long kvm_mips_get_ramsize(struct kvm *kvm);
=20
-static inline void kvm_arch_hardware_disable(void *garbage) {}
+static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 0ec7490..e3b21e5 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -77,7 +77,7 @@ int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 	return 1;
 }
=20
-int kvm_arch_hardware_enable(void *garbage)
+int kvm_arch_hardware_enable(void)
 {
 	return 0;
 }
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include=
/asm/kvm_host.h
index 0e646c1..b00113b 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -687,7 +687,7 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
=20
-static inline void kvm_arch_hardware_disable(void *garbage) {}
+static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_memslots_updated(struct kvm *kvm) {}
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 72c3fc0..da50523 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -384,7 +384,7 @@ int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, =
int size, void *ptr,
 }
 EXPORT_SYMBOL_GPL(kvmppc_ld);
=20
-int kvm_arch_hardware_enable(void *garbage)
+int kvm_arch_hardware_enable(void)
 {
 	return 0;
 }
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/k=
vm_host.h
index cee2be9..5626241 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -451,7 +451,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *v=
cpu,
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
=20
-static inline void kvm_arch_hardware_disable(void *garbage) {}
+static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_check_processor_compat(void *rtn) {}
 static inline void kvm_arch_exit(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 043c58b..c942d61 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -100,7 +100,7 @@ int test_vfacility(unsigned long nr)
 }
=20
 /* Section: not file related */
-int kvm_arch_hardware_enable(void *garbage)
+int kvm_arch_hardware_enable(void)
 {
 	/* every s390 is virtualization enabled ;-) */
 	return 0;
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm=
_host.h
index ac0f90e..031e1dc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -665,8 +665,8 @@ struct msr_data {
 struct kvm_x86_ops {
 	int (*cpu_has_kvm_support)(void);          /* __init */
 	int (*disabled_by_bios)(void);             /* __init */
-	int (*hardware_enable)(void *dummy);
-	void (*hardware_disable)(void *dummy);
+	int (*hardware_enable)(void);
+	void (*hardware_disable)(void);
 	void (*check_processor_compatibility)(void *rtn);
 	int (*hardware_setup)(void);               /* __init */
 	void (*hardware_unsetup)(void);            /* __exit */
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index a981227..75e903b 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -622,7 +622,7 @@ static int has_svm(void)
 	return 1;
 }
=20
-static void svm_hardware_disable(void *garbage)
+static void svm_hardware_disable(void)
 {
 	/* Make sure we clean up behind us */
 	if (static_cpu_has(X86_FEATURE_TSCRATEMSR))
@@ -633,7 +633,7 @@ static void svm_hardware_disable(void *garbage)
 	amd_pmu_disable_virt();
 }
=20
-static int svm_hardware_enable(void *garbage)
+static int svm_hardware_enable(void)
 {
=20
 	struct svm_cpu_data *sd;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 85457aa..2d8c143 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2726,7 +2726,7 @@ static void kvm_cpu_vmxon(u64 addr)
 			: "memory", "cc");
 }
=20
-static int hardware_enable(void *garbage)
+static int hardware_enable(void)
 {
 	int cpu =3D raw_smp_processor_id();
 	u64 phys_addr =3D __pa(per_cpu(vmxarea, cpu));
@@ -2790,7 +2790,7 @@ static void kvm_cpu_vmxoff(void)
 	asm volatile (__ex(ASM_VMX_VMXOFF) : : : "cc");
 }
=20
-static void hardware_disable(void *garbage)
+static void hardware_disable(void)
 {
 	if (vmm_exclusive) {
 		vmclear_local_loaded_vmcss();
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6b20a3c..2ec0050 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -246,7 +246,7 @@ void kvm_set_shared_msr(unsigned slot, u64 value, u=
64 mask)
 }
 EXPORT_SYMBOL_GPL(kvm_set_shared_msr);
=20
-static void drop_user_return_notifiers(void *ignore)
+static void drop_user_return_notifiers(void)
 {
 	unsigned int cpu =3D smp_processor_id();
 	struct kvm_shared_msrs *smsr =3D per_cpu_ptr(shared_msrs, cpu);
@@ -6959,7 +6959,7 @@ void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu=
 *vcpu, unsigned int vector)
 	kvm_rip_write(vcpu, 0);
 }
=20
-int kvm_arch_hardware_enable(void *garbage)
+int kvm_arch_hardware_enable(void)
 {
 	struct kvm *kvm;
 	struct kvm_vcpu *vcpu;
@@ -6970,7 +6970,7 @@ int kvm_arch_hardware_enable(void *garbage)
 	bool stable, backwards_tsc =3D false;
=20
 	kvm_shared_msr_cpu_online();
-	ret =3D kvm_x86_ops->hardware_enable(garbage);
+	ret =3D kvm_x86_ops->hardware_enable();
 	if (ret !=3D 0)
 		return ret;
=20
@@ -7051,10 +7051,10 @@ int kvm_arch_hardware_enable(void *garbage)
 	return 0;
 }
=20
-void kvm_arch_hardware_disable(void *garbage)
+void kvm_arch_hardware_disable(void)
 {
-	kvm_x86_ops->hardware_disable(garbage);
-	drop_user_return_notifiers(garbage);
+	kvm_x86_ops->hardware_disable();
+	drop_user_return_notifiers();
 }
=20
 int kvm_arch_hardware_setup(void)
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index ebd7236..33d8d0a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -634,8 +634,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu);
 int kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu);
=20
-int kvm_arch_hardware_enable(void *garbage);
-void kvm_arch_hardware_disable(void *garbage);
+int kvm_arch_hardware_enable(void);
+void kvm_arch_hardware_disable(void);
 int kvm_arch_hardware_setup(void);
 void kvm_arch_hardware_unsetup(void);
 void kvm_arch_check_processor_compat(void *rtn);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5a0817e..967dbd9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2669,7 +2669,7 @@ static void hardware_enable_nolock(void *junk)
=20
 	cpumask_set_cpu(cpu, cpus_hardware_enabled);
=20
-	r =3D kvm_arch_hardware_enable(NULL);
+	r =3D kvm_arch_hardware_enable();
=20
 	if (r) {
 		cpumask_clear_cpu(cpu, cpus_hardware_enabled);
@@ -2694,7 +2694,7 @@ static void hardware_disable_nolock(void *junk)
 	if (!cpumask_test_cpu(cpu, cpus_hardware_enabled))
 		return;
 	cpumask_clear_cpu(cpu, cpus_hardware_enabled);
-	kvm_arch_hardware_disable(NULL);
+	kvm_arch_hardware_disable();
 }
=20
 static void hardware_disable(void)
--=20
2.1.0
