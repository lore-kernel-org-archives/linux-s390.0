From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 11/47] KVM: s390: add lowcore access functions
Date: Tue, 15 Apr 2014 14:00:14 +0200
Message-ID: <1397563250-3089-12-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

put_guest_lc, read_guest_lc and write_guest_lc are guest access
functions which shall only be used to access the lowcore of a vcpu.
These functions should be used for e.g. interrupt handlers where no
guest memory access protection facilities, like key or low address
protection, are applicable.

At a later point guest vcpu lowcore access should happen via pinned
prefix pages, so that these pages can be accessed directly via the
kernel mapping. All of these *_lc functions can be removed then.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h | 95 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index ae3cb63..917aeaa 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -1,7 +1,7 @@
 /*
  * access guest memory
  *
- * Copyright IBM Corp. 2008, 2009
+ * Copyright IBM Corp. 2008, 2014
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License (version 2 only)
@@ -15,7 +15,8 @@
 
 #include <linux/compiler.h>
 #include <linux/kvm_host.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
+#include <linux/ptrace.h>
 #include "kvm-s390.h"
 
 /* Convert real to absolute address by applying the prefix of the CPU */
@@ -136,4 +137,94 @@ static inline int __copy_guest(struct kvm_vcpu *vcpu, unsigned long to,
 #define copy_from_guest_absolute(vcpu, to, from, size) \
 	__copy_guest(vcpu, (unsigned long)to, from, size, 0, 0)
 
+/*
+ * put_guest_lc, read_guest_lc and write_guest_lc are guest access functions
+ * which shall only be used to access the lowcore of a vcpu.
+ * These functions should be used for e.g. interrupt handlers where no
+ * guest memory access protection facilities, like key or low address
+ * protection, are applicable.
+ * At a later point guest vcpu lowcore access should happen via pinned
+ * prefix pages, so that these pages can be accessed directly via the
+ * kernel mapping. All of these *_lc functions can be removed then.
+ */
+
+/**
+ * put_guest_lc - write a simple variable to a guest vcpu's lowcore
+ * @vcpu: virtual cpu
+ * @x: value to copy to guest
+ * @gra: vcpu's destination guest real address
+ *
+ * Copies a simple value from kernel space to a guest vcpu's lowcore.
+ * The size of the variable may be 1, 2, 4 or 8 bytes. The destination
+ * must be located in the vcpu's lowcore. Otherwise the result is undefined.
+ *
+ * Returns zero on success or -EFAULT on error.
+ *
+ * Note: an error indicates that either the kernel is out of memory or
+ *	 the guest memory mapping is broken. In any case the best solution
+ *	 would be to terminate the guest.
+ *	 It is wrong to inject a guest exception.
+ */
+#define put_guest_lc(vcpu, x, gra)				\
+({								\
+	struct kvm_vcpu *__vcpu = (vcpu);			\
+	__typeof__(*(gra)) __x = (x);				\
+	unsigned long __gpa;					\
+								\
+	__gpa = (unsigned long)(gra);				\
+	__gpa += __vcpu->arch.sie_block->prefix;		\
+	kvm_write_guest(__vcpu->kvm, __gpa, &__x, sizeof(__x));	\
+})
+
+/**
+ * write_guest_lc - copy data from kernel space to guest vcpu's lowcore
+ * @vcpu: virtual cpu
+ * @gra: vcpu's source guest real address
+ * @data: source address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy data from kernel space to guest vcpu's lowcore. The entire range must
+ * be located within the vcpu's lowcore, otherwise the result is undefined.
+ *
+ * Returns zero on success or -EFAULT on error.
+ *
+ * Note: an error indicates that either the kernel is out of memory or
+ *	 the guest memory mapping is broken. In any case the best solution
+ *	 would be to terminate the guest.
+ *	 It is wrong to inject a guest exception.
+ */
+static inline __must_check
+int write_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
+		   unsigned long len)
+{
+	unsigned long gpa = gra + vcpu->arch.sie_block->prefix;
+
+	return kvm_write_guest(vcpu->kvm, gpa, data, len);
+}
+
+/**
+ * read_guest_lc - copy data from guest vcpu's lowcore to kernel space
+ * @vcpu: virtual cpu
+ * @gra: vcpu's source guest real address
+ * @data: destination address in kernel space
+ * @len: number of bytes to copy
+ *
+ * Copy data from guest vcpu's lowcore to kernel space. The entire range must
+ * be located within the vcpu's lowcore, otherwise the result is undefined.
+ *
+ * Returns zero on success or -EFAULT on error.
+ *
+ * Note: an error indicates that either the kernel is out of memory or
+ *	 the guest memory mapping is broken. In any case the best solution
+ *	 would be to terminate the guest.
+ *	 It is wrong to inject a guest exception.
+ */
+static inline __must_check
+int read_guest_lc(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
+		  unsigned long len)
+{
+	unsigned long gpa = gra + vcpu->arch.sie_block->prefix;
+
+	return kvm_read_guest(vcpu->kvm, gpa, data, len);
+}
 #endif /* __KVM_S390_GACCESS_H */
-- 
1.8.4.2
