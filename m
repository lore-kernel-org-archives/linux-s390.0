From: frank.blaschka@de.ibm.com
Subject: [RFC][patch 3/6] KVM: s390: Add GISA support
Date: Thu, 04 Sep 2014 12:52:26 +0200
Message-ID: <20140904105337.081387456@de.ibm.com>
References: <20140904105223.336503578@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=004-s390_kvm_gisa-3.16.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: aik@ozlabs.ru, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch adds GISA (Guest Interrupt State Area) support
to s390 kvm. GISA can be used for exitless interrupts. The
patch provides a set of functions for GISA related operations
like accessing GISA fields or registering ISCs for alert.
Exploiters of GISA will follow with additional patches.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   72 ++++++++++++++++
 arch/s390/kvm/kvm-s390.c         |  167 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |   28 ++++++
 3 files changed, 265 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -129,11 +129,12 @@ struct kvm_s390_sie_block {
 	__u8	reserved60;		/* 0x0060 */
 	__u8	ecb;			/* 0x0061 */
 	__u8    ecb2;                   /* 0x0062 */
-	__u8    reserved63[1];          /* 0x0063 */
+	__u8    ecb3;			/* 0x0063 */
 	__u32	scaol;			/* 0x0064 */
 	__u8	reserved68[4];		/* 0x0068 */
 	__u32	todpr;			/* 0x006c */
-	__u8	reserved70[32];		/* 0x0070 */
+	__u32   gd;                     /* 0x0070 */
+	__u8    reserved74[28];         /* 0x0074 */
 	psw_t	gpsw;			/* 0x0090 */
 	__u64	gg14;			/* 0x00a0 */
 	__u64	gg15;			/* 0x00a8 */
@@ -300,6 +301,70 @@ struct kvm_s390_interrupt_info {
 #define ACTION_STORE_ON_STOP		(1<<0)
 #define ACTION_STOP_ON_STOP		(1<<1)
 
+#define KVM_S390_GISA_FORMAT_0	0
+#define KVM_S390_GISA_FORMAT_1	1
+
+struct kvm_s390_gisa_f0 {
+	u32 next_alert;
+	u8 ipm;
+	u16 rsv0:14;
+	u16 g:1;
+	u16 c:1;
+	u8 iam;
+	u32 rsv1;
+	u32 count;
+} __packed;
+
+struct kvm_s390_gisa_f1 {
+	u32 next_alert;
+	u8 ipm;
+	u8 simm;
+	u8 nimm;
+	u8 iam;
+	u64 aisma;
+	u32 rsv0:6;
+	u32 g:1;
+	u32 c:1;
+	u32 rsv1:24;
+	u64 rsv2;
+	u32 count;
+} __packed;
+
+union kvm_s390_gisa {
+	struct kvm_s390_gisa_f0 f0;
+	struct kvm_s390_gisa_f1 f1;
+};
+
+struct kvm_s390_gait {
+	u32 gd;
+	u16      : 5;
+	u16 gisc : 3;
+	u16 rpu  : 8;
+	u16        : 10;
+	u16 gaisbo :  6;
+	u64 gaisba;
+} __packed;
+
+struct kvm_s390_aifte {
+	u64 faisba;
+	u64 gaita;
+	u16 simm : 8;
+	u16      : 5;
+	u16 afi  : 3;
+	u16 reserved1;
+	u16 reserved2;
+	u16 faal;
+} __packed;
+
+struct kvm_s390_gib {
+	u32 alo;
+	u32 reserved1;
+	u32      : 5;
+	u32 nisc : 3;
+	u32      : 24;
+	u8 reserverd2[20];
+} __packed;
+
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
 	struct list_head list;
@@ -420,6 +485,9 @@ struct kvm_arch{
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	spinlock_t start_stop_lock;
+	union kvm_s390_gisa *gisa;
+	unsigned long iam;
+	atomic_t in_sie;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -404,6 +404,16 @@ long kvm_arch_vm_ioctl(struct file *filp
 	return r;
 }
 
+static u8 kvm_s390_gisa_get_alert_mask(struct kvm *kvm)
+{
+	return (u8)ACCESS_ONCE(kvm->arch.iam);
+}
+
+static void kvm_s390_gisa_set_alert_mask(struct kvm *kvm, u8 iam)
+{
+	xchg(&kvm->arch.iam, iam);
+}
+
 int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 {
 	int rc;
@@ -461,6 +471,14 @@ int kvm_arch_init_vm(struct kvm *kvm, un
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
 
+	kvm->arch.gisa = (union kvm_s390_gisa *)get_zeroed_page(
+			GFP_KERNEL | GFP_DMA);
+	if (!kvm->arch.gisa)
+		goto out_nogmap;
+	kvm_s390_gisa_set_next_alert(kvm, (u32)(unsigned long)kvm->arch.gisa);
+	kvm_s390_gisa_set_alert_mask(kvm, 0);
+	atomic_set(&kvm->arch.in_sie, 0);
+
 	spin_lock_init(&kvm->arch.start_stop_lock);
 
 	return 0;
@@ -520,6 +538,7 @@ void kvm_arch_sync_events(struct kvm *kv
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
+	free_page((unsigned long)kvm->arch.gisa);
 	kvm_free_vcpus(kvm);
 	free_page((unsigned long)(kvm->arch.sca));
 	debug_unregister(kvm->arch.dbf);
@@ -656,6 +675,19 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu
 	return rc;
 }
 
+u32 kvm_s390_gisa_get_fmt(void)
+{
+	if (test_facility(70) || test_facility(72))
+		return KVM_S390_GISA_FORMAT_1;
+	else
+		return KVM_S390_GISA_FORMAT_0;
+}
+
+static u32 kvm_s390_build_gd(struct kvm *kvm)
+{
+	return (u32)(unsigned long)kvm->arch.gisa | kvm_s390_gisa_get_fmt();
+}
+
 struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 				      unsigned int id)
 {
@@ -699,6 +731,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(st
 	vcpu->arch.local_int.float_int = &kvm->arch.float_int;
 	vcpu->arch.local_int.wq = &vcpu->wq;
 	vcpu->arch.local_int.cpuflags = &vcpu->arch.sie_block->cpuflags;
+	vcpu->arch.sie_block->gd = kvm_s390_build_gd(kvm);
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
 	if (rc)
@@ -749,6 +782,132 @@ void exit_sie_sync(struct kvm_vcpu *vcpu
 	exit_sie(vcpu);
 }
 
+void kvm_s390_gisa_register_alert(struct kvm *kvm, u32 gisc)
+{
+	int bito = BITS_PER_BYTE * 7 + gisc;
+
+	set_bit(bito ^ (BITS_PER_LONG - 1), &kvm->arch.iam);
+}
+
+void kvm_s390_gisa_unregister_alert(struct kvm *kvm, u32 gisc)
+{
+	int bito = BITS_PER_BYTE * 7 + gisc;
+
+	clear_bit(bito ^ (BITS_PER_LONG - 1), &kvm->arch.iam);
+}
+
+u32 __kvm_s390_gisa_get_next_alert(union kvm_s390_gisa *gisa)
+{
+	return ACCESS_ONCE(gisa->f0.next_alert);
+}
+
+u32 kvm_s390_gisa_get_next_alert(struct kvm *kvm)
+{
+	return __kvm_s390_gisa_get_next_alert(
+		(union kvm_s390_gisa *)kvm->arch.gisa);
+}
+
+void __kvm_s390_gisa_set_next_alert(union kvm_s390_gisa *gisa, u32 val)
+{
+	xchg(&gisa->f0.next_alert, val);
+}
+
+void kvm_s390_gisa_set_next_alert(struct kvm *kvm, u32 val)
+{
+	__kvm_s390_gisa_set_next_alert(kvm->arch.gisa, val);
+}
+
+u8 kvm_s390_gisa_get_iam(struct kvm *kvm)
+{
+	return ACCESS_ONCE(kvm->arch.gisa->f0.iam);
+}
+
+void kvm_s390_gisa_set_iam(struct kvm *kvm, u8 iam)
+{
+	xchg(&kvm->arch.gisa->f0.iam, iam);
+}
+
+int kvm_s390_gisa_test_iam_gisc(struct kvm *kvm, u32 gisc)
+{
+	int bito = BITS_PER_BYTE * 7 + gisc;
+	unsigned long *addr = (unsigned long *)kvm->arch.gisa;
+
+	return test_bit(bito ^ (BITS_PER_LONG - 1), addr);
+}
+
+u8 kvm_s390_gisa_get_ipm(struct kvm *kvm)
+{
+	return ACCESS_ONCE(kvm->arch.gisa->f0.ipm);
+}
+
+void kvm_s390_gisa_set_ipm(struct kvm *kvm, u8 ipm)
+{
+	xchg(&kvm->arch.gisa->f0.ipm, ipm);
+}
+
+int kvm_s390_gisa_test_ipm_gisc(struct kvm *kvm, u32 gisc)
+{
+	int bito = BITS_PER_BYTE * 4 + gisc;
+	unsigned long *addr = (unsigned long *)kvm->arch.gisa;
+
+	return test_bit(bito ^ (BITS_PER_LONG - 1), addr);
+}
+
+void kvm_s390_gisa_set_ipm_gisc(struct kvm *kvm, u32 gisc)
+{
+	int bito = gisc + 32;
+	unsigned long *addr = (unsigned long *)kvm->arch.gisa;
+
+	set_bit(bito ^ (BITS_PER_LONG - 1), addr);
+}
+
+u32 kvm_s390_gisa_get_g(struct kvm *kvm)
+{
+	u32 fmt, bito;
+	unsigned long *addr;
+
+	fmt = kvm_s390_gisa_get_fmt();
+	if (fmt == KVM_S390_GISA_FORMAT_0) {
+		addr = (unsigned long *)kvm->arch.gisa;
+		bito = BITS_PER_BYTE * 6 + 6;
+	} else {
+		addr = (unsigned long *)((u8 *)kvm->arch.gisa + 16);
+		bito = 6;
+	}
+
+	return test_bit(bito ^ (BITS_PER_LONG - 1), addr);
+}
+
+u32 kvm_s390_gisa_get_c(struct kvm *kvm)
+{
+	u32 fmt, bito;
+	unsigned long *addr;
+
+	fmt = kvm_s390_gisa_get_fmt();
+	if (fmt == KVM_S390_GISA_FORMAT_0) {
+		addr = (unsigned long *)kvm->arch.gisa;
+		bito = BITS_PER_BYTE * 6 + 7;
+	} else {
+		addr = (unsigned long *)((u8 *)kvm->arch.gisa + 16);
+		bito = 7;
+	}
+
+	return test_bit(bito ^ (BITS_PER_LONG - 1), addr);
+}
+
+u32 kvm_s390_gisa_get_count(struct kvm *kvm)
+{
+	u32 fmt, cnt;
+
+	fmt = kvm_s390_gisa_get_fmt();
+	if (fmt == KVM_S390_GISA_FORMAT_0)
+		cnt = ACCESS_ONCE(kvm->arch.gisa->f0.count);
+	else
+		cnt = ACCESS_ONCE(kvm->arch.gisa->f1.count);
+
+	return cnt;
+}
+
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address)
 {
 	int i;
@@ -1284,8 +1443,16 @@ static int __vcpu_run(struct kvm_vcpu *v
 		preempt_disable();
 		kvm_guest_enter();
 		preempt_enable();
+
+		atomic_inc(&vcpu->kvm->arch.in_sie);
+		kvm_s390_gisa_set_iam(vcpu->kvm, 0);
+
 		exit_reason = sie64a(vcpu->arch.sie_block,
 				     vcpu->run->s.regs.gprs);
+		if (atomic_dec_and_test(&vcpu->kvm->arch.in_sie))
+			kvm_s390_gisa_set_iam(vcpu->kvm,
+				kvm_s390_gisa_get_alert_mask(vcpu->kvm));
+
 		kvm_guest_exit();
 		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -122,6 +122,17 @@ static inline u64 kvm_s390_get_base_disp
 	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) + disp2;
 }
 
+static inline u64 kvm_s390_get_base_disp_rxy(struct kvm_vcpu *vcpu)
+{
+	u32 x2 = (vcpu->arch.sie_block->ipa & 0x000f);
+	u32 base2 = vcpu->arch.sie_block->ipb >> 28;
+	u32 disp2 = ((vcpu->arch.sie_block->ipb & 0x0fff0000) >> 16) +
+		((vcpu->arch.sie_block->ipb & 0xff00) << 4);
+
+	return (base2 ? vcpu->run->s.regs.gprs[base2] : 0) +
+		(x2 ? vcpu->run->s.regs.gprs[x2] : 0) + (u64)disp2;
+}
+
 /* Set the condition code in the guest program status word */
 static inline void kvm_s390_set_psw_cc(struct kvm_vcpu *vcpu, unsigned long cc)
 {
@@ -180,6 +191,23 @@ void exit_sie(struct kvm_vcpu *vcpu);
 void exit_sie_sync(struct kvm_vcpu *vcpu);
 int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu);
+u32 kvm_s390_gisa_get_fmt(void);
+void kvm_s390_gisa_register_alert(struct kvm *kvm, u32 gisc);
+void kvm_s390_gisa_unregister_alert(struct kvm *kvm, u32 gisc);
+u32 __kvm_s390_gisa_get_next_alert(union kvm_s390_gisa *gisa);
+u32 kvm_s390_gisa_get_next_alert(struct kvm *kvm);
+void __kvm_s390_gisa_set_next_alert(union kvm_s390_gisa *gisa, u32 val);
+void kvm_s390_gisa_set_next_alert(struct kvm *kvm, u32 val);
+u8 kvm_s390_gisa_get_iam(struct kvm *kvm);
+void kvm_s390_gisa_set_iam(struct kvm *kvm, u8 value);
+int kvm_s390_gisa_test_iam_gisc(struct kvm *kvm, u32 gisc);
+u8 kvm_s390_gisa_get_ipm(struct kvm *kvm);
+void kvm_s390_gisa_set_ipm(struct kvm *kvm, u8 value);
+int kvm_s390_gisa_test_ipm_gisc(struct kvm *kvm, u32 gisc);
+void kvm_s390_gisa_set_ipm_gisc(struct kvm *kvm, u32 gisc);
+u32 kvm_s390_gisa_get_g(struct kvm *kvm);
+u32 kvm_s390_gisa_get_c(struct kvm *kvm);
+u32 kvm_s390_gisa_get_count(struct kvm *kvm);
 /* is cmma enabled */
 bool kvm_s390_cmma_enabled(struct kvm *kvm);
 int test_vfacility(unsigned long nr);
