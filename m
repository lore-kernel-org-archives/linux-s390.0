From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 1/5] update linux headers with with cpustate changes
Date: Thu, 10 Jul 2014 15:10:35 +0200
Message-ID: <1404997839-29038-2-git-send-email-borntraeger@de.ibm.com>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Will do a proper headers sync when ready

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 linux-headers/linux/kvm.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index f5d2c38..9b584da 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -399,13 +399,18 @@ struct kvm_vapic_addr {
 	__u64 vapic_addr;
 };
 
-/* for KVM_SET_MPSTATE */
+/* for KVM_SET_MP_STATE */
 
+/* not all states are valid on all architectures */
 #define KVM_MP_STATE_RUNNABLE          0
 #define KVM_MP_STATE_UNINITIALIZED     1
 #define KVM_MP_STATE_INIT_RECEIVED     2
 #define KVM_MP_STATE_HALTED            3
 #define KVM_MP_STATE_SIPI_RECEIVED     4
+#define KVM_MP_STATE_STOPPED           5
+#define KVM_MP_STATE_CHECK_STOP        6
+#define KVM_MP_STATE_OPERATING         7
+#define KVM_MP_STATE_LOAD              8
 
 struct kvm_mp_state {
 	__u32 mp_state;
-- 
1.8.4.2
