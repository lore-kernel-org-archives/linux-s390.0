From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/11] KVM: s390: add bitmap for handling cpu-local interrupts
Date: Fri, 28 Nov 2014 14:25:37 +0100
Message-ID: <1417181139-25623-10-git-send-email-borntraeger@de.ibm.com>
References: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

Adds a bitmap to the vcpu structure which is used to keep track
of local pending interrupts. Also add enum with all interrupt
types sorted in order of priority (highest to lowest)

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index ac7b074..624a821 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -295,6 +295,79 @@ struct kvm_vcpu_stat {
 #define PGM_PER				0x80
 #define PGM_CRYPTO_OPERATION		0x119
 
+/* irq types in order of priority */
+enum irq_types {
+	IRQ_PEND_MCHK_EX = 0,
+	IRQ_PEND_SVC,
+	IRQ_PEND_PROG,
+	IRQ_PEND_MCHK_REP,
+	IRQ_PEND_EXT_IRQ_KEY,
+	IRQ_PEND_EXT_MALFUNC,
+	IRQ_PEND_EXT_EMERGENCY,
+	IRQ_PEND_EXT_EXTERNAL,
+	IRQ_PEND_EXT_CLOCK_COMP,
+	IRQ_PEND_EXT_CPU_TIMER,
+	IRQ_PEND_EXT_TIMING,
+	IRQ_PEND_EXT_SERVICE,
+	IRQ_PEND_EXT_HOST,
+	IRQ_PEND_PFAULT_INIT,
+	IRQ_PEND_PFAULT_DONE,
+	IRQ_PEND_VIRTIO,
+	IRQ_PEND_IO_ISC_0,
+	IRQ_PEND_IO_ISC_1,
+	IRQ_PEND_IO_ISC_2,
+	IRQ_PEND_IO_ISC_3,
+	IRQ_PEND_IO_ISC_4,
+	IRQ_PEND_IO_ISC_5,
+	IRQ_PEND_IO_ISC_6,
+	IRQ_PEND_IO_ISC_7,
+	IRQ_PEND_SIGP_STOP,
+	IRQ_PEND_RESTART,
+	IRQ_PEND_SET_PREFIX,
+	IRQ_PEND_COUNT
+};
+
+/*
+ * Repressible (non-floating) machine check interrupts
+ * subclass bits in MCIC
+ */
+#define MCHK_EXTD_BIT 58
+#define MCHK_DEGR_BIT 56
+#define MCHK_WARN_BIT 55
+#define MCHK_REP_MASK ((1UL << MCHK_DEGR_BIT) | \
+		       (1UL << MCHK_EXTD_BIT) | \
+		       (1UL << MCHK_WARN_BIT))
+
+/* Exigent machine check interrupts subclass bits in MCIC */
+#define MCHK_SD_BIT 63
+#define MCHK_PD_BIT 62
+#define MCHK_EX_MASK ((1UL << MCHK_SD_BIT) | (1UL << MCHK_PD_BIT))
+
+#define IRQ_PEND_EXT_MASK ((1UL << IRQ_PEND_EXT_IRQ_KEY)    | \
+			   (1UL << IRQ_PEND_EXT_CLOCK_COMP) | \
+			   (1UL << IRQ_PEND_EXT_CPU_TIMER)  | \
+			   (1UL << IRQ_PEND_EXT_MALFUNC)    | \
+			   (1UL << IRQ_PEND_EXT_EMERGENCY)  | \
+			   (1UL << IRQ_PEND_EXT_EXTERNAL)   | \
+			   (1UL << IRQ_PEND_EXT_TIMING)     | \
+			   (1UL << IRQ_PEND_EXT_HOST)       | \
+			   (1UL << IRQ_PEND_EXT_SERVICE)    | \
+			   (1UL << IRQ_PEND_VIRTIO)         | \
+			   (1UL << IRQ_PEND_PFAULT_INIT)    | \
+			   (1UL << IRQ_PEND_PFAULT_DONE))
+
+#define IRQ_PEND_IO_MASK ((1UL << IRQ_PEND_IO_ISC_0) | \
+			  (1UL << IRQ_PEND_IO_ISC_1) | \
+			  (1UL << IRQ_PEND_IO_ISC_2) | \
+			  (1UL << IRQ_PEND_IO_ISC_3) | \
+			  (1UL << IRQ_PEND_IO_ISC_4) | \
+			  (1UL << IRQ_PEND_IO_ISC_5) | \
+			  (1UL << IRQ_PEND_IO_ISC_6) | \
+			  (1UL << IRQ_PEND_IO_ISC_7))
+
+#define IRQ_PEND_MCHK_MASK ((1UL << IRQ_PEND_MCHK_REP) | \
+			    (1UL << IRQ_PEND_MCHK_EX))
+
 struct kvm_s390_interrupt_info {
 	struct list_head list;
 	u64	type;
@@ -313,6 +386,16 @@ struct kvm_s390_interrupt_info {
 #define ACTION_STORE_ON_STOP		(1<<0)
 #define ACTION_STOP_ON_STOP		(1<<1)
 
+struct kvm_s390_irq_payload {
+	struct kvm_s390_io_info io;
+	struct kvm_s390_ext_info ext;
+	struct kvm_s390_pgm_info pgm;
+	struct kvm_s390_emerg_info emerg;
+	struct kvm_s390_extcall_info extcall;
+	struct kvm_s390_prefix_info prefix;
+	struct kvm_s390_mchk_info mchk;
+};
+
 struct kvm_s390_local_interrupt {
 	spinlock_t lock;
 	struct list_head list;
@@ -321,6 +404,9 @@ struct kvm_s390_local_interrupt {
 	wait_queue_head_t *wq;
 	atomic_t *cpuflags;
 	unsigned int action_bits;
+	DECLARE_BITMAP(sigp_emerg_pending, KVM_MAX_VCPUS);
+	struct kvm_s390_irq_payload irq;
+	unsigned long pending_irqs;
 };
 
 struct kvm_s390_float_interrupt {
-- 
1.9.3
