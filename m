From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 1/8] KVM: s390: add and extend interrupt information data structs
Date: Thu, 30 Jan 2014 13:53:42 +0100
Message-ID: <1391086429-43935-2-git-send-email-borntraeger@de.ibm.com>
References: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1391086429-43935-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

With the currently available struct kvm_s390_interrupt it is not possible to
inject every kind of interrupt as defined in the z/Architecture. Add
additional interruption parameters to the structures and move it to kvm.h

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 34 +---------------------
 include/uapi/linux/kvm.h         | 63 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 33 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index eef3dd3..3ffc964 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -16,6 +16,7 @@
 #include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/kvm_host.h>
+#include <linux/kvm.h>
 #include <asm/debug.h>
 #include <asm/cpu.h>
 
@@ -168,18 +169,6 @@ struct kvm_vcpu_stat {
 	u32 diagnose_9c;
 };
 
-struct kvm_s390_io_info {
-	__u16        subchannel_id;            /* 0x0b8 */
-	__u16        subchannel_nr;            /* 0x0ba */
-	__u32        io_int_parm;              /* 0x0bc */
-	__u32        io_int_word;              /* 0x0c0 */
-};
-
-struct kvm_s390_ext_info {
-	__u32 ext_params;
-	__u64 ext_params2;
-};
-
 #define PGM_OPERATION            0x01
 #define PGM_PRIVILEGED_OP	 0x02
 #define PGM_EXECUTE              0x03
@@ -188,27 +177,6 @@ struct kvm_s390_ext_info {
 #define PGM_SPECIFICATION        0x06
 #define PGM_DATA                 0x07
 
-struct kvm_s390_pgm_info {
-	__u16 code;
-};
-
-struct kvm_s390_prefix_info {
-	__u32 address;
-};
-
-struct kvm_s390_extcall_info {
-	__u16 code;
-};
-
-struct kvm_s390_emerg_info {
-	__u16 code;
-};
-
-struct kvm_s390_mchk_info {
-	__u64 cr14;
-	__u64 mcic;
-};
-
 struct kvm_s390_interrupt_info {
 	struct list_head list;
 	u64	type;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 932d7f2..86faf47 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -434,6 +434,69 @@ struct kvm_s390_interrupt {
 	__u64 parm64;
 };
 
+struct kvm_s390_io_info {
+	__u16 subchannel_id;
+	__u16 subchannel_nr;
+	__u32 io_int_parm;
+	__u32 io_int_word;
+};
+
+struct kvm_s390_ext_info {
+	__u32 ext_params;
+	__u32 pad;
+	__u64 ext_params2;
+};
+
+struct kvm_s390_pgm_info {
+	__u64 trans_exc_code;
+	__u64 mon_code;
+	__u64 per_address;
+	__u32 data_exc_code;
+	__u16 code;
+	__u16 mon_class_nr;
+	__u8 per_code;
+	__u8 per_atmid;
+	__u8 exc_access_id;
+	__u8 per_access_id;
+	__u8 op_access_id;
+	__u8 pad[3];
+};
+
+struct kvm_s390_prefix_info {
+	__u32 address;
+};
+
+struct kvm_s390_extcall_info {
+	__u16 code;
+};
+
+struct kvm_s390_emerg_info {
+	__u16 code;
+};
+
+struct kvm_s390_mchk_info {
+	__u64 cr14;
+	__u64 mcic;
+	__u64 failing_storage_address;
+	__u32 ext_damage_code;
+	__u32 pad;
+	__u8 fixed_logout[16];
+};
+
+struct kvm_s390_irq {
+	__u64 type;
+	union {
+		struct kvm_s390_io_info io;
+		struct kvm_s390_ext_info ext;
+		struct kvm_s390_pgm_info pgm;
+		struct kvm_s390_emerg_info emerg;
+		struct kvm_s390_extcall_info extcall;
+		struct kvm_s390_prefix_info prefix;
+		struct kvm_s390_mchk_info mchk;
+		char reserved[64];
+	} u;
+};
+
 /* for KVM_SET_GUEST_DEBUG */
 
 #define KVM_GUESTDBG_ENABLE		0x00000001
-- 
1.8.4.2
