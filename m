From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 40/47] KVM: s390: kernel header addition for guest debugging
Date: Tue, 15 Apr 2014 14:00:43 +0200
Message-ID: <1397563250-3089-41-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch adds the structs to the kernel headers needed to pass information
from/to userspace in order to debug a guest on s390 with hardware support.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index e35c798..b8c0f07 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -79,11 +79,31 @@ struct kvm_fpu {
 	__u64 fprs[16];
 };
 
+#define KVM_GUESTDBG_USE_HW_BP		0x00010000
+
+#define KVM_HW_BP			1
+#define KVM_HW_WP_WRITE			2
+#define KVM_SINGLESTEP			4
+
 struct kvm_debug_exit_arch {
+	__u64 addr;
+	__u8 type;
+	__u8 pad[7]; /* Should be set to 0 */
+};
+
+struct kvm_hw_breakpoint {
+	__u64 addr;
+	__u64 phys_addr;
+	__u64 len;
+	__u8 type;
+	__u8 pad[7]; /* Should be set to 0 */
 };
 
 /* for KVM_SET_GUEST_DEBUG */
 struct kvm_guest_debug_arch {
+	__u32 nr_hw_bp;
+	__u32 pad; /* Should be set to 0 */
+	struct kvm_hw_breakpoint __user *hw_bp;
 };
 
 #define KVM_SYNC_PREFIX (1UL << 0)
-- 
1.8.4.2
