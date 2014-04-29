From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/6] KVM: s390: enable IBS for single running VCPUs
Date: Tue, 29 Apr 2014 15:36:48 +0200
Message-ID: <1398778608-3887-7-git-send-email-borntraeger@de.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch enables the IBS facility when a single VCPU is running.
The facility is dynamically turned on/off as soon as other VCPUs
enter/leave the stopped state.

When this facility is operating, some instructions can be executed
faster for single-cpu guests.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |   2 +
 arch/s390/kvm/kvm-s390.c         | 123 ++++++++++++++++++++++++++++++++++++++-
 arch/s390/kvm/trace-s390.h       |  22 +++++++
 include/linux/kvm_host.h         |   2 +
 4 files changed, 147 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 0d45f6f..f0a1dc5 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -72,6 +72,7 @@ struct sca_block {
 #define CPUSTAT_ZARCH      0x00000800
 #define CPUSTAT_MCDS       0x00000100
 #define CPUSTAT_SM         0x00000080
+#define CPUSTAT_IBS        0x00000040
 #define CPUSTAT_G          0x00000008
 #define CPUSTAT_GED        0x00000004
 #define CPUSTAT_J          0x00000002
@@ -411,6 +412,7 @@ struct kvm_arch{
 	int use_cmma;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
+	spinlock_t start_stop_lock;
 };
 
 #define KVM_HVA_ERR_BAD		(-1UL)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6c972d2..0a01744 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -458,6 +458,8 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.css_support = 0;
 	kvm->arch.use_irqchip = 0;
 
+	spin_lock_init(&kvm->arch.start_stop_lock);
+
 	return 0;
 out_nogmap:
 	debug_unregister(kvm->arch.dbf);
@@ -996,8 +998,15 @@ bool kvm_s390_cmma_enabled(struct kvm *kvm)
 	return true;
 }
 
+static bool ibs_enabled(struct kvm_vcpu *vcpu)
+{
+	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_IBS;
+}
+
 static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 {
+retry:
+	s390_vcpu_unblock(vcpu);
 	/*
 	 * We use MMU_RELOAD just to re-arm the ipte notifier for the
 	 * guest prefix page. gmap_ipte_notify will wait on the ptl lock.
@@ -1005,15 +1014,34 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	 * already finished. We might race against a second unmapper that
 	 * wants to set the blocking bit. Lets just retry the request loop.
 	 */
-	while (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu)) {
+	if (kvm_check_request(KVM_REQ_MMU_RELOAD, vcpu)) {
 		int rc;
 		rc = gmap_ipte_notify(vcpu->arch.gmap,
 				      vcpu->arch.sie_block->prefix,
 				      PAGE_SIZE * 2);
 		if (rc)
 			return rc;
-		s390_vcpu_unblock(vcpu);
+		goto retry;
+	}
+
+	if (kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu)) {
+		if (!ibs_enabled(vcpu)) {
+			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 1);
+			atomic_set_mask(CPUSTAT_IBS,
+					&vcpu->arch.sie_block->cpuflags);
+		}
+		goto retry;
 	}
+
+	if (kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu)) {
+		if (ibs_enabled(vcpu)) {
+			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 0);
+			atomic_clear_mask(CPUSTAT_IBS,
+					  &vcpu->arch.sie_block->cpuflags);
+		}
+		goto retry;
+	}
+
 	return 0;
 }
 
@@ -1362,16 +1390,107 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 	return kvm_s390_store_status_unloaded(vcpu, addr);
 }
 
+static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
+{
+	return atomic_read(&(vcpu)->arch.sie_block->cpuflags) & CPUSTAT_STOPPED;
+}
+
+static void __disable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
+{
+	kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu);
+	kvm_make_request(KVM_REQ_DISABLE_IBS, vcpu);
+	exit_sie_sync(vcpu);
+}
+
+static void __disable_ibs_on_all_vcpus(struct kvm *kvm)
+{
+	unsigned int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm) {
+		__disable_ibs_on_vcpu(vcpu);
+	}
+}
+
+static void __enable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
+{
+	kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu);
+	kvm_make_request(KVM_REQ_ENABLE_IBS, vcpu);
+	exit_sie_sync(vcpu);
+}
+
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 {
+	int i, online_vcpus, started_vcpus = 0;
+
+	if (!is_vcpu_stopped(vcpu))
+		return;
+
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 1);
+	/* Only one cpu at a time may enter/leave the STOPPED state. */
+	spin_lock_bh(&vcpu->kvm->arch.start_stop_lock);
+	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
+
+	for (i = 0; i < online_vcpus; i++) {
+		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i]))
+			started_vcpus++;
+	}
+
+	if (started_vcpus == 0) {
+		/* we're the only active VCPU -> speed it up */
+		__enable_ibs_on_vcpu(vcpu);
+	} else if (started_vcpus == 1) {
+		/*
+		 * As we are starting a second VCPU, we have to disable
+		 * the IBS facility on all VCPUs to remove potentially
+		 * oustanding ENABLE requests.
+		 */
+		__disable_ibs_on_all_vcpus(vcpu->kvm);
+	}
+
 	atomic_clear_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	/*
+	 * Another VCPU might have used IBS while we were offline.
+	 * Let's play safe and flush the VCPU at startup.
+	 */
+	vcpu->arch.sie_block->ihcpu  = 0xffff;
+	spin_unlock_bh(&vcpu->kvm->arch.start_stop_lock);
+	return;
 }
 
 void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu)
 {
+	int i, online_vcpus, started_vcpus = 0;
+	struct kvm_vcpu *started_vcpu = NULL;
+
+	if (is_vcpu_stopped(vcpu))
+		return;
+
 	trace_kvm_s390_vcpu_start_stop(vcpu->vcpu_id, 0);
+	/* Only one cpu at a time may enter/leave the STOPPED state. */
+	spin_lock_bh(&vcpu->kvm->arch.start_stop_lock);
+	online_vcpus = atomic_read(&vcpu->kvm->online_vcpus);
+
 	atomic_set_mask(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	__disable_ibs_on_vcpu(vcpu);
+
+	for (i = 0; i < online_vcpus; i++) {
+		if (!is_vcpu_stopped(vcpu->kvm->vcpus[i])) {
+			started_vcpus++;
+			started_vcpu = vcpu->kvm->vcpus[i];
+		}
+	}
+
+	if (started_vcpus == 1) {
+		/*
+		 * As we only have one VCPU left, we want to enable the
+		 * IBS facility for that VCPU to speed it up.
+		 */
+		__enable_ibs_on_vcpu(started_vcpu);
+	}
+
+	spin_unlock_bh(&vcpu->kvm->arch.start_stop_lock);
+	return;
 }
 
 static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
diff --git a/arch/s390/kvm/trace-s390.h b/arch/s390/kvm/trace-s390.h
index 34d4f8a..647e9d6 100644
--- a/arch/s390/kvm/trace-s390.h
+++ b/arch/s390/kvm/trace-s390.h
@@ -244,6 +244,28 @@ TRACE_EVENT(kvm_s390_enable_css,
 		      __entry->kvm)
 	);
 
+/*
+ * Trace point for enabling and disabling interlocking-and-broadcasting
+ * suppression.
+ */
+TRACE_EVENT(kvm_s390_enable_disable_ibs,
+	    TP_PROTO(unsigned int id, int state),
+	    TP_ARGS(id, state),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int, id)
+		    __field(int, state)
+		    ),
+
+	    TP_fast_assign(
+		    __entry->id = id;
+		    __entry->state = state;
+		    ),
+
+	    TP_printk("%s ibs on cpu %d",
+		      __entry->state ? "enabling" : "disabling", __entry->id)
+	);
+
 
 #endif /* _TRACE_KVMS390_H */
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 820fc2e..1e125b0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -134,6 +134,8 @@ static inline bool is_error_page(struct page *page)
 #define KVM_REQ_EPR_EXIT          20
 #define KVM_REQ_SCAN_IOAPIC       21
 #define KVM_REQ_GLOBAL_CLOCK_UPDATE 22
+#define KVM_REQ_ENABLE_IBS        23
+#define KVM_REQ_DISABLE_IBS       24
 
 #define KVM_USERSPACE_IRQ_SOURCE_ID		0
 #define KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID	1
-- 
1.8.4.2
