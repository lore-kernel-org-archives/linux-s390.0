From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 7/8] KVM: async_pf: Async page fault support on s390
Date: Thu, 30 Jan 2014 13:53:48 +0100
Message-ID: <1391086429-43935-8-git-send-email-borntraeger@de.ibm.com>
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

This patch enables async page faults for s390 kvm guests.
It provides the userspace API to enable and disable_wait this feature.
The disable_wait will enforce that the feature is off by waiting on it.
Also it includes the diagnose code, called by the guest to enable async page faults.

The async page faults will use an already existing guest interface for this
purpose, as described in "CP Programming Services (SC24-6084)".

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/devices/s390_flic.txt | 10 +++
 arch/s390/include/asm/kvm_host.h                | 22 ++++++
 arch/s390/include/uapi/asm/kvm.h                |  2 +
 arch/s390/kvm/Kconfig                           |  2 +
 arch/s390/kvm/Makefile                          |  2 +-
 arch/s390/kvm/diag.c                            | 84 +++++++++++++++++++++++
 arch/s390/kvm/interrupt.c                       | 65 ++++++++++++++++--
 arch/s390/kvm/kvm-s390.c                        | 89 ++++++++++++++++++++++++-
 arch/s390/kvm/kvm-s390.h                        |  4 ++
 arch/s390/kvm/sigp.c                            |  7 ++
 arch/s390/kvm/trace.h                           | 46 +++++++++++++
 include/uapi/linux/kvm.h                        |  2 +
 12 files changed, 326 insertions(+), 9 deletions(-)

diff --git a/Documentation/virtual/kvm/devices/s390_flic.txt b/Documentation/virtual/kvm/devices/s390_flic.txt
index 6b55795..410fa67 100644
--- a/Documentation/virtual/kvm/devices/s390_flic.txt
+++ b/Documentation/virtual/kvm/devices/s390_flic.txt
@@ -11,6 +11,7 @@ FLIC provides support to
 - add interrupts (KVM_DEV_FLIC_ENQUEUE)
 - inspect currently pending interrupts (KVM_FLIC_GET_ALL_IRQS)
 - purge all pending floating interrupts (KVM_DEV_FLIC_CLEAR_IRQS)
+- enable/disable for the guest transparent async page faults
 
 Groups:
   KVM_DEV_FLIC_ENQUEUE
@@ -34,3 +35,12 @@ Groups:
   KVM_DEV_FLIC_CLEAR_IRQS
     Simply deletes all elements from the list of currently pending floating
     interrupts.  No interrupts are injected into the guest.
+
+  KVM_DEV_FLIC_APF_ENABLE
+    Enables async page faults for the guest. So in case of a major page fault
+    the host is allowed to handle this async and continues the guest.
+
+  KVM_DEV_FLIC_APF_DISABLE_WAIT
+    Disables async page faults for the guest and waits until already pending
+    async page faults are done. This is necessary to trigger a completion interrupt
+    for every init interrupt before migrating the interrupt list.
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index c3c5e10..2c69ba2 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -231,6 +231,10 @@ struct kvm_vcpu_arch {
 		u64		stidp_data;
 	};
 	struct gmap *gmap;
+#define KVM_S390_PFAULT_TOKEN_INVALID	(-1UL)
+	unsigned long pfault_token;
+	unsigned long pfault_select;
+	unsigned long pfault_compare;
 };
 
 struct kvm_vm_stat {
@@ -257,6 +261,24 @@ static inline bool kvm_is_error_hva(unsigned long addr)
 	return IS_ERR_VALUE(addr);
 }
 
+#define ASYNC_PF_PER_VCPU	64
+struct kvm_vcpu;
+struct kvm_async_pf;
+struct kvm_arch_async_pf {
+	unsigned long pfault_token;
+};
+
+bool kvm_arch_can_inject_async_page_present(struct kvm_vcpu *vcpu);
+
+void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
+			       struct kvm_async_pf *work);
+
+void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
+				     struct kvm_async_pf *work);
+
+void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
+				 struct kvm_async_pf *work);
+
 extern int sie64a(struct kvm_s390_sie_block *, u64 *);
 extern char sie_exit;
 #endif
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 058b178..ccfd0b1 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -20,6 +20,8 @@
 #define KVM_DEV_FLIC_GET_ALL_IRQS	1
 #define KVM_DEV_FLIC_ENQUEUE		2
 #define KVM_DEV_FLIC_CLEAR_IRQS		3
+#define KVM_DEV_FLIC_APF_ENABLE		4
+#define KVM_DEV_FLIC_APF_DISABLE_WAIT	5
 /*
  * We can have up to 4*64k pending subchannels + 8 adapter interrupts,
  * as well as up  to ASYNC_PF_PER_VCPU*KVM_MAX_VCPUS pfault done interrupts.
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 70b46ea..c8bacbc 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -23,6 +23,8 @@ config KVM
 	select ANON_INODES
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_EVENTFD
+	select KVM_ASYNC_PF
+	select KVM_ASYNC_PF_SYNC
 	---help---
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 40b4c64..a47d2c3 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -7,7 +7,7 @@
 # as published by the Free Software Foundation.
 
 KVM := ../../../virt/kvm
-common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o
+common-objs = $(KVM)/kvm_main.o $(KVM)/eventfd.o  $(KVM)/async_pf.o
 
 ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
 
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 8216c0e..bf9ed34 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -17,6 +17,7 @@
 #include "kvm-s390.h"
 #include "trace.h"
 #include "trace-s390.h"
+#include "gaccess.h"
 
 static int diag_release_pages(struct kvm_vcpu *vcpu)
 {
@@ -46,6 +47,87 @@ static int diag_release_pages(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static int __diag_page_ref_service(struct kvm_vcpu *vcpu)
+{
+	struct prs_parm {
+		u16 code;
+		u16 subcode;
+		u16 parm_len;
+		u16 parm_version;
+		u64 token_addr;
+		u64 select_mask;
+		u64 compare_mask;
+		u64 zarch;
+	};
+	struct prs_parm parm;
+	int rc;
+	u16 rx = (vcpu->arch.sie_block->ipa & 0xf0) >> 4;
+	u16 ry = (vcpu->arch.sie_block->ipa & 0x0f);
+	unsigned long hva_token = KVM_HVA_ERR_BAD;
+
+	if (vcpu->run->s.regs.gprs[rx] & 7)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	if (copy_from_guest(vcpu, &parm, vcpu->run->s.regs.gprs[rx], sizeof(parm)))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	if (parm.parm_version != 2 || parm.parm_len < 5 || parm.code != 0x258)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+	switch (parm.subcode) {
+	case 0: /* TOKEN */
+		if (vcpu->arch.pfault_token != KVM_S390_PFAULT_TOKEN_INVALID) {
+			/*
+			 * If the pagefault handshake is already activated,
+			 * the token must not be changed.  We have to return
+			 * decimal 8 instead, as mandated in SC24-6084.
+			 */
+			vcpu->run->s.regs.gprs[ry] = 8;
+			return 0;
+		}
+
+		if ((parm.compare_mask & parm.select_mask) != parm.compare_mask ||
+		    parm.token_addr & 7 || parm.zarch != 0x8000000000000000ULL)
+			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+		hva_token = gfn_to_hva(vcpu->kvm, gpa_to_gfn(parm.token_addr));
+		if (kvm_is_error_hva(hva_token))
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+
+		vcpu->arch.pfault_token = parm.token_addr;
+		vcpu->arch.pfault_select = parm.select_mask;
+		vcpu->arch.pfault_compare = parm.compare_mask;
+		vcpu->run->s.regs.gprs[ry] = 0;
+		rc = 0;
+		break;
+	case 1: /*
+		 * CANCEL
+		 * Specification allows to let already pending tokens survive
+		 * the cancel, therefore to reduce code complexity, we assume
+		 * all outstanding tokens are already pending.
+		 */
+		if (parm.token_addr || parm.select_mask ||
+		    parm.compare_mask || parm.zarch)
+			return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+
+		vcpu->run->s.regs.gprs[ry] = 0;
+		/*
+		 * If the pfault handling was not established or is already
+		 * canceled SC24-6084 requests to return decimal 4.
+		 */
+		if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
+			vcpu->run->s.regs.gprs[ry] = 4;
+		else
+			vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
+
+		rc = 0;
+		break;
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
 static int __diag_time_slice_end(struct kvm_vcpu *vcpu)
 {
 	VCPU_EVENT(vcpu, 5, "%s", "diag time slice end");
@@ -150,6 +232,8 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
 		return __diag_time_slice_end(vcpu);
 	case 0x9c:
 		return __diag_time_slice_end_directed(vcpu);
+	case 0x258:
+		return __diag_page_ref_service(vcpu);
 	case 0x308:
 		return __diag_ipl_functions(vcpu);
 	case 0x500:
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9c9192b..1848080 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -31,7 +31,7 @@ static int is_ioint(u64 type)
 	return ((type & 0xfffe0000u) != 0xfffe0000u);
 }
 
-static int psw_extint_disabled(struct kvm_vcpu *vcpu)
+int psw_extint_disabled(struct kvm_vcpu *vcpu)
 {
 	return !(vcpu->arch.sie_block->gpsw.mask & PSW_MASK_EXT);
 }
@@ -78,11 +78,8 @@ static int __interrupt_is_deliverable(struct kvm_vcpu *vcpu,
 			return 1;
 		return 0;
 	case KVM_S390_INT_SERVICE:
-		if (psw_extint_disabled(vcpu))
-			return 0;
-		if (vcpu->arch.sie_block->gcr[0] & 0x200ul)
-			return 1;
-		return 0;
+	case KVM_S390_INT_PFAULT_INIT:
+	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
 		if (psw_extint_disabled(vcpu))
 			return 0;
@@ -150,6 +147,8 @@ static void __set_intercept_indicator(struct kvm_vcpu *vcpu,
 	case KVM_S390_INT_EXTERNAL_CALL:
 	case KVM_S390_INT_EMERGENCY:
 	case KVM_S390_INT_SERVICE:
+	case KVM_S390_INT_PFAULT_INIT:
+	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
 		if (psw_extint_disabled(vcpu))
 			__set_cpuflag(vcpu, CPUSTAT_EXT_INT);
@@ -223,6 +222,30 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		rc |= put_guest(vcpu, inti->ext.ext_params,
 				(u32 __user *)__LC_EXT_PARAMS);
 		break;
+	case KVM_S390_INT_PFAULT_INIT:
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
+						 inti->ext.ext_params2);
+		rc  = put_guest(vcpu, 0x2603, (u16 __user *) __LC_EXT_INT_CODE);
+		rc |= put_guest(vcpu, 0x0600, (u16 __user *) __LC_EXT_CPU_ADDR);
+		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_EXT_NEW_PSW, sizeof(psw_t));
+		rc |= put_guest(vcpu, inti->ext.ext_params2,
+				(u64 __user *) __LC_EXT_PARAMS2);
+		break;
+	case KVM_S390_INT_PFAULT_DONE:
+		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type, 0,
+						 inti->ext.ext_params2);
+		rc  = put_guest(vcpu, 0x2603, (u16 __user *) __LC_EXT_INT_CODE);
+		rc |= put_guest(vcpu, 0x0680, (u16 __user *) __LC_EXT_CPU_ADDR);
+		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
+				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
+				      __LC_EXT_NEW_PSW, sizeof(psw_t));
+		rc |= put_guest(vcpu, inti->ext.ext_params2,
+				(u64 __user *) __LC_EXT_PARAMS2);
+		break;
 	case KVM_S390_INT_VIRTIO:
 		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
 			   inti->ext.ext_params, inti->ext.ext_params2);
@@ -357,7 +380,7 @@ static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
-static int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
+int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_float_interrupt *fi = vcpu->arch.local_int.float_int;
@@ -737,6 +760,10 @@ int kvm_s390_inject_vm(struct kvm *kvm,
 		VM_EVENT(kvm, 5, "inject: sclp parm:%x", s390int->parm);
 		inti->ext.ext_params = s390int->parm;
 		break;
+	case KVM_S390_INT_PFAULT_DONE:
+		inti->type = s390int->type;
+		inti->ext.ext_params2 = s390int->parm64;
+		break;
 	case KVM_S390_MCHK:
 		VM_EVENT(kvm, 5, "inject: machine check parm64:%llx",
 			 s390int->parm64);
@@ -823,6 +850,10 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 		inti->type = s390int->type;
 		inti->mchk.mcic = s390int->parm64;
 		break;
+	case KVM_S390_INT_PFAULT_INIT:
+		inti->type = s390int->type;
+		inti->ext.ext_params2 = s390int->parm64;
+		break;
 	case KVM_S390_INT_VIRTIO:
 	case KVM_S390_INT_SERVICE:
 	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
@@ -877,6 +908,8 @@ static inline int copy_irq_to_user(struct kvm_s390_interrupt_info *inti,
 
 	irq.type = inti->type;
 	switch (inti->type) {
+	case KVM_S390_INT_PFAULT_INIT:
+	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
 	case KVM_S390_INT_SERVICE:
 		irq.u.ext = inti->ext;
@@ -956,6 +989,8 @@ static inline int copy_irq_from_user(struct kvm_s390_interrupt_info *inti,
 		return -EFAULT;
 
 	switch (inti->type) {
+	case KVM_S390_INT_PFAULT_INIT:
+	case KVM_S390_INT_PFAULT_DONE:
 	case KVM_S390_INT_VIRTIO:
 	case KVM_S390_INT_SERVICE:
 		target = (void *) &inti->ext;
@@ -1019,6 +1054,8 @@ static int enqueue_floating_irq(struct kvm_device *dev,
 static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 {
 	int r = 0;
+	unsigned int i;
+	struct kvm_vcpu *vcpu;
 
 	switch (attr->group) {
 	case KVM_DEV_FLIC_ENQUEUE:
@@ -1028,6 +1065,20 @@ static int flic_set_attr(struct kvm_device *dev, struct kvm_device_attr *attr)
 		r = 0;
 		clear_floating_interrupts(dev->kvm);
 		break;
+	case KVM_DEV_FLIC_APF_ENABLE:
+		dev->kvm->arch.gmap->pfault_enabled = 1;
+		break;
+	case KVM_DEV_FLIC_APF_DISABLE_WAIT:
+		dev->kvm->arch.gmap->pfault_enabled = 0;
+		/*
+		 * Make sure no async faults are in transition when
+		 * clearing the queues. So we don't need to worry
+		 * about late coming workers.
+		 */
+		synchronize_srcu(&dev->kvm->srcu);
+		kvm_for_each_vcpu(i, vcpu, dev->kvm)
+			kvm_clear_async_pf_completion_queue(vcpu);
+		break;
 	default:
 		r = -EINVAL;
 	}
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9eec794..d8e9f04 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -152,6 +152,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 #ifdef CONFIG_KVM_S390_UCONTROL
 	case KVM_CAP_S390_UCONTROL:
 #endif
+	case KVM_CAP_ASYNC_PF:
 	case KVM_CAP_SYNC_REGS:
 	case KVM_CAP_ONE_REG:
 	case KVM_CAP_ENABLE_CAP:
@@ -273,6 +274,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 {
 	VCPU_EVENT(vcpu, 3, "%s", "free cpu");
 	trace_kvm_s390_destroy_vcpu(vcpu->vcpu_id);
+	kvm_clear_async_pf_completion_queue(vcpu);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
 		clear_bit(63 - vcpu->vcpu_id,
 			  (unsigned long *) &vcpu->kvm->arch.sca->mcn);
@@ -322,6 +324,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 /* Section: vcpu related */
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
+	kvm_clear_async_pf_completion_queue(vcpu);
 	if (kvm_is_ucontrol(vcpu->kvm)) {
 		vcpu->arch.gmap = gmap_alloc(current->mm);
 		if (!vcpu->arch.gmap)
@@ -382,6 +386,8 @@ static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_fpregs.fpc = 0;
 	asm volatile("lfpc %0" : : "Q" (vcpu->arch.guest_fpregs.fpc));
 	vcpu->arch.sie_block->gbea = 1;
+	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
+	kvm_clear_async_pf_completion_queue(vcpu);
 	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
 }
 
@@ -713,10 +719,89 @@ static long kvm_arch_fault_in_sync(struct kvm_vcpu *vcpu)
 	return rc;
 }
 
+static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
+				      unsigned long token)
+{
+	struct kvm_s390_interrupt inti;
+	inti.parm64 = token;
+
+	if (start_token) {
+		inti.type = KVM_S390_INT_PFAULT_INIT;
+		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &inti));
+	} else {
+		inti.type = KVM_S390_INT_PFAULT_DONE;
+		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
+	}
+}
+
+void kvm_arch_async_page_not_present(struct kvm_vcpu *vcpu,
+				     struct kvm_async_pf *work)
+{
+	trace_kvm_s390_pfault_init(vcpu, work->arch.pfault_token);
+	__kvm_inject_pfault_token(vcpu, true, work->arch.pfault_token);
+}
+
+void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
+				 struct kvm_async_pf *work)
+{
+	trace_kvm_s390_pfault_done(vcpu, work->arch.pfault_token);
+	__kvm_inject_pfault_token(vcpu, false, work->arch.pfault_token);
+}
+
+void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu,
+			       struct kvm_async_pf *work)
+{
+	/* s390 will always inject the page directly */
+}
+
+bool kvm_arch_can_inject_async_page_present(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * s390 will always inject the page directly,
+	 * but we still want check_async_completion to cleanup
+	 */
+	return true;
+}
+
+static int kvm_arch_setup_async_pf(struct kvm_vcpu *vcpu)
+{
+	hva_t hva;
+	struct kvm_arch_async_pf arch;
+	int rc;
+
+	if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
+		return 0;
+	if ((vcpu->arch.sie_block->gpsw.mask & vcpu->arch.pfault_select) !=
+	    vcpu->arch.pfault_compare)
+		return 0;
+	if (psw_extint_disabled(vcpu))
+		return 0;
+	if (kvm_cpu_has_interrupt(vcpu))
+		return 0;
+	if (!(vcpu->arch.sie_block->gcr[0] & 0x200ul))
+		return 0;
+	if (!vcpu->arch.gmap->pfault_enabled)
+		return 0;
+
+	hva = gmap_fault(current->thread.gmap_addr, vcpu->arch.gmap);
+	if (copy_from_guest(vcpu, &arch.pfault_token, vcpu->arch.pfault_token, 8))
+		return 0;
+
+	rc = kvm_setup_async_pf(vcpu, current->thread.gmap_addr, hva, &arch);
+	return rc;
+}
+
 static int vcpu_pre_run(struct kvm_vcpu *vcpu)
 {
 	int rc, cpuflags;
 
+	/*
+	 * On s390 notifications for arriving pages will be delivered directly
+	 * to the guest but the house keeping for completed pfaults is
+	 * handled outside the worker.
+	 */
+	kvm_check_async_pf_completion(vcpu);
+
 	memcpy(&vcpu->arch.sie_block->gg14, &vcpu->run->s.regs.gprs[14], 16);
 
 	if (need_resched())
@@ -758,8 +843,10 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 		rc = -EREMOTE;
 
 	} else if (current->thread.gmap_pfault) {
+		trace_kvm_s390_major_guest_pfault(vcpu);
 		current->thread.gmap_pfault = 0;
-		if (kvm_arch_fault_in_sync(vcpu) >= 0)
+		if (kvm_arch_setup_async_pf(vcpu) ||
+		    (kvm_arch_fault_in_sync(vcpu) >= 0))
 			rc = 0;
 	}
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index f9559b0..ed4750a 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -159,4 +159,8 @@ void exit_sie_sync(struct kvm_vcpu *vcpu);
 /* implemented in diag.c */
 int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 
+/* implemented in interrupt.c */
+int kvm_cpu_has_interrupt(struct kvm_vcpu *vcpu);
+int psw_extint_disabled(struct kvm_vcpu *vcpu);
+
 #endif
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 87c2b3a..fe9442d 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -224,6 +224,8 @@ unlock:
 static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 {
 	int rc;
+	unsigned int i;
+	struct kvm_vcpu *v;
 
 	switch (parameter & 0xff) {
 	case 0:
@@ -231,6 +233,11 @@ static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 		break;
 	case 1:
 	case 2:
+		kvm_for_each_vcpu(i, v, vcpu->kvm) {
+			v->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
+			kvm_clear_async_pf_completion_queue(v);
+		}
+
 		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 		break;
 	default:
diff --git a/arch/s390/kvm/trace.h b/arch/s390/kvm/trace.h
index 3db76b2..e8e7213 100644
--- a/arch/s390/kvm/trace.h
+++ b/arch/s390/kvm/trace.h
@@ -30,6 +30,52 @@
 	TP_printk("%02d[%016lx-%016lx]: " p_str, __entry->id,		\
 		  __entry->pswmask, __entry->pswaddr, p_args)
 
+TRACE_EVENT(kvm_s390_major_guest_pfault,
+	    TP_PROTO(VCPU_PROTO_COMMON),
+	    TP_ARGS(VCPU_ARGS_COMMON),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    ),
+	    VCPU_TP_PRINTK("%s", "major fault, maybe applicable for pfault")
+	);
+
+TRACE_EVENT(kvm_s390_pfault_init,
+	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
+	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(long, pfault_token)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->pfault_token = pfault_token;
+		    ),
+	    VCPU_TP_PRINTK("init pfault token %ld", __entry->pfault_token)
+	);
+
+TRACE_EVENT(kvm_s390_pfault_done,
+	    TP_PROTO(VCPU_PROTO_COMMON, long pfault_token),
+	    TP_ARGS(VCPU_ARGS_COMMON, pfault_token),
+
+	    TP_STRUCT__entry(
+		    VCPU_FIELD_COMMON
+		    __field(long, pfault_token)
+		    ),
+
+	    TP_fast_assign(
+		    VCPU_ASSIGN_COMMON
+		    __entry->pfault_token = pfault_token;
+		    ),
+	    VCPU_TP_PRINTK("done pfault token %ld", __entry->pfault_token)
+	);
+
 /*
  * Tracepoints for SIE entry and exit.
  */
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 19f717b..7d76401 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -413,6 +413,8 @@ struct kvm_s390_psw {
 #define KVM_S390_PROGRAM_INT		0xfffe0001u
 #define KVM_S390_SIGP_SET_PREFIX	0xfffe0002u
 #define KVM_S390_RESTART		0xfffe0003u
+#define KVM_S390_INT_PFAULT_INIT	0xfffe0004u
+#define KVM_S390_INT_PFAULT_DONE	0xfffe0005u
 #define KVM_S390_MCHK			0xfffe1000u
 #define KVM_S390_INT_VIRTIO		0xffff2603u
 #define KVM_S390_INT_SERVICE		0xffff2401u
-- 
1.8.4.2
