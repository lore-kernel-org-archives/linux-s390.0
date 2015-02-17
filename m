From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [RFC PATCH v2 08/15] cpu-model/s390: Update linux-headers/asm-s390/kvm.h
Date: Tue, 17 Feb 2015 15:24:06 +0100
Message-ID: <1424183053-4310-9-git-send-email-mimu@linux.vnet.ibm.com>
References: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424183053-4310-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 linux-headers/asm-s390/kvm.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.h
index d36b2fa..e38c942 100644
--- a/linux-headers/asm-s390/kvm.h
+++ b/linux-headers/asm-s390/kvm.h
@@ -57,11 +57,31 @@ struct kvm_s390_io_adapter_req {
 
 /* kvm attr_group  on vm fd */
 #define KVM_S390_VM_MEM_CTRL		0
+#define KVM_S390_VM_CPU_MODEL		3
 
 /* kvm attributes for mem_ctrl */
 #define KVM_S390_VM_MEM_ENABLE_CMMA	0
 #define KVM_S390_VM_MEM_CLR_CMMA	1
 
+/* kvm S390 processor related attributes are r/w */
+#define KVM_S390_VM_CPU_PROCESSOR	0
+struct kvm_s390_vm_cpu_processor {
+	__u64 cpuid;
+	__u16 ibc;
+	__u8  pad[6];
+	__u64 fac_list[256];
+};
+
+/* kvm S390 machine related attributes are r/o */
+#define KVM_S390_VM_CPU_MACHINE		1
+struct kvm_s390_vm_cpu_machine {
+	__u64 cpuid;
+	__u32 ibc_range;
+	__u8  pad[4];
+	__u64 fac_mask[256];
+	__u64 fac_list[256];
+};
+
 /* for KVM_GET_REGS and KVM_SET_REGS */
 struct kvm_regs {
 	/* general purpose regs for s390 */
-- 
1.8.3.1
