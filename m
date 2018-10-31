From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 3/7] vfio: ap: AP Queue Interrupt structures definitions
Date: Wed, 31 Oct 2018 19:12:53 +0100
Message-ID: <1541009577-29656-4-git-send-email-pmorel@linux.ibm.com>
References: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541009577-29656-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: borntraeger@de.ibm.com
Cc: alex.williamson@redhat.com, cohuck@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

We define all the structures we need to let GISA handle
the AP Queues Interrupt.

This patch defines the inline assembler for AP Queue Interrupt
Control instruction with GISA, some utilities to manipulate
the data in the registers used by this instruction.

We also define new ap_matrix components to handle interruptions
and adapter mapping.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_private.h | 77 +++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 5675492233c7..45103865bd7f 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -74,15 +74,92 @@ struct ap_matrix {
  * @group_notifier: notifier block used for specifying callback function for
  *		    handling the VFIO_GROUP_NOTIFY_SET_KVM event
  * @kvm:	the struct holding guest's state
+ * @map:	the adapter information for QEMU mapping
+ * @gisc:	the Guest ISC
  */
 struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
 	struct kvm *kvm;
+	struct s390_map_info *map;
+	unsigned char gisc;
 };
 
 extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
+/* AP Queue Interrupt Control associated structures and functions */
+struct aqic_gisa {
+	uint8_t  rzone;
+	uint8_t  izone;
+	unsigned	ir:1;
+	unsigned	reserved1:4;
+	unsigned	gisc:3;
+	unsigned	reserved2:6;
+	unsigned	f:2;
+	unsigned	reserved3:1;
+	unsigned	gisao:27;
+	unsigned	t:1;
+	unsigned	isc:3;
+}  __packed __aligned(8);
+
+struct ap_status {
+	unsigned	e:1;
+	unsigned	r:1;
+	unsigned	f:1;
+	unsigned	reserved:4;
+	unsigned	i:1;
+	unsigned	rc:8;
+	unsigned	pad:16;
+}  __packed __aligned(4);
+
+static inline uint32_t status2reg(struct ap_status a)
+{
+	return *(uint32_t *)(&a);
+}
+
+static inline struct ap_status reg2status(uint32_t r)
+{
+	return *(struct ap_status *)(&r);
+}
+
+static inline struct aqic_gisa reg2aqic(uint64_t r)
+{
+	return *((struct aqic_gisa *)&r);
+}
+
+static inline uint64_t aqic2reg(struct aqic_gisa a)
+{
+	return *((uint64_t *)&a);
+}
+
+/**
+ * ap_host_aqic - Issue the host AQIC instruction.
+ * @apqn is the AP queue number
+ * @gr1  the caller must have setup the register
+ *       with GISA address and format, with interrupt
+ *       request, ISC and guest ISC
+ * @gr2  the caller must have setup the register
+ *       to the guest NIB physical address
+ *
+ * issue the AQIC PQAP instruction and return the AP status
+ * word
+ */
+static inline uint32_t ap_host_aqic(uint64_t apqn, uint64_t gr1,
+				    uint64_t gr2)
+{
+	register unsigned long reg0 asm ("0") = apqn | (3UL << 24);
+	register unsigned long reg1_in asm ("1") = gr1;
+	register uint32_t reg1_out asm ("1");
+	register unsigned long reg2 asm ("2") = gr2;
+
+	asm volatile(
+		".long 0xb2af0000"	  /* PQAP(AQIC) */
+		: "+d" (reg0), "+d" (reg1_in), "=d" (reg1_out), "+d" (reg2)
+		:
+		: "cc");
+	return reg1_out;
+}
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.17.0
