From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 1/1] KVM: s390: mark irq_state.flags as non-usable
Date: Tue, 21 Nov 2017 20:10:45 +0100
Message-ID: <20171121191045.117029-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Old kernels did not check for zero in the irq_state.flags field and old
QEMUs did not zero the flag/reserved fields when calling
KVM_S390_*_IRQ_STATE.  Let's add comments to prevent future uses of
these fields.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt | 9 +++++++--
 arch/s390/kvm/kvm-s390.c          | 2 ++
 include/uapi/linux/kvm.h          | 4 ++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index f670e4b..e84c1c3 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -2901,14 +2901,19 @@ userspace buffer and its length:
 
 struct kvm_s390_irq_state {
 	__u64 buf;
-	__u32 flags;
+	__u32 flags;		/* will be unused for compatibility reasons */
 	__u32 len;
-	__u32 reserved[4];
+	__u32 reserved[4];	/* will be unused for compatibility reasons */
 };
 
 Userspace passes in the above struct and for each pending interrupt a
 struct kvm_s390_irq is copied to the provided buffer.
 
+The structure contains a flags and a reserved field for future extensions. As
+the kernel never checked for flags == 0 and QEMU never pre-zeroed flags and
+reserved, these fields can not be used in the future without breaking
+compatibility.
+
 If -ENOBUFS is returned the buffer provided was too small and userspace
 may retry with a bigger buffer.
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6a5e02f..2a9cc0f 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3834,6 +3834,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			r = -EINVAL;
 			break;
 		}
+		/* do not use irq_state.flags, it will break old QEMUs */
 		r = kvm_s390_set_irq_state(vcpu,
 					   (void __user *) irq_state.buf,
 					   irq_state.len);
@@ -3849,6 +3850,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 			r = -EINVAL;
 			break;
 		}
+		/* do not use irq_state.flags, it will break old QEMUs */
 		r = kvm_s390_get_irq_state(vcpu,
 					   (__u8 __user *)  irq_state.buf,
 					   irq_state.len);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 282d7613..6f91b41 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -630,9 +630,9 @@ struct kvm_s390_irq {
 
 struct kvm_s390_irq_state {
 	__u64 buf;
-	__u32 flags;
+	__u32 flags;		/* will be unused for compatibility reasons */
 	__u32 len;
-	__u32 reserved[4];
+	__u32 reserved[4];	/* will be unused for compatibility reasons */
 };
 
 /* for KVM_SET_GUEST_DEBUG */
-- 
2.9.4
