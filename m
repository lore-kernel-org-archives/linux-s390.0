From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v4 07/15] target-s390x: Update
	linux-headers/asm-s390/kvm.h
Date: Mon, 30 Mar 2015 16:28:20 +0200
Message-ID: <1427725708-52100-8-git-send-email-mimu@linux.vnet.ibm.com>
References: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1427725708-52100-1-git-send-email-mimu@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Daniel Hansel <daniel.hansel@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Andreas Faerber <afaerber@suse.de>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index c5a93eb..bfe6925 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -70,8 +70,14 @@ struct kvm_s390_io_adapter_req {
 #define KVM_S390_VM_TOD_LOW		0
 #define KVM_S390_VM_TOD_HIGH		1
 
+/* kvm attributes for crypto */
+#define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
+#define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
+#define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
+#define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
+
 /* kvm attributes for KVM_S390_VM_CPU_MODEL */
-/* processor related attributes are r/w */
+/* kvm S390 processor related attributes are r/w */
 #define KVM_S390_VM_CPU_PROCESSOR	0
 struct kvm_s390_vm_cpu_processor {
 	__u64 cpuid;
@@ -80,22 +86,16 @@ struct kvm_s390_vm_cpu_processor {
 	__u64 fac_list[256];
 };
 
-/* machine related attributes are r/o */
+/* kvm S390 machine related attributes are r/o */
 #define KVM_S390_VM_CPU_MACHINE		1
 struct kvm_s390_vm_cpu_machine {
 	__u64 cpuid;
-	__u32 ibc;
+	__u32 ibc_range;
 	__u8  pad[4];
 	__u64 fac_mask[256];
 	__u64 fac_list[256];
 };
 
-/* kvm attributes for crypto */
-#define KVM_S390_VM_CRYPTO_ENABLE_AES_KW	0
-#define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
-#define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
-#define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
-
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
-- 
1.8.3.1
