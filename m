From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 6/8] s390/kvm,gaccess: shorten copy_to/from_guest code
Date: Tue,  5 Mar 2013 13:14:45 +0100
Message-ID: <1362485687-2799-7-git-send-email-borntraeger@de.ibm.com>
References: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1362485687-2799-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The code can be significantly shortened. There is no functional change,
except that for large (> PAGE_SIZE) copies the guest translation would
be done more frequently.
However, there is not a single user which does this currently. If one
gets added later on this functionality can be added easily again.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h | 294 +++++++-----------------------------------------
 1 file changed, 41 insertions(+), 253 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 82f450e..8608d7e 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -18,16 +18,19 @@
 #include <asm/uaccess.h>
 #include "kvm-s390.h"
 
-static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr)
+static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr,
+				   int prefixing)
 {
 	unsigned long prefix  = vcpu->arch.sie_block->prefix;
 	unsigned long gaddr = (unsigned long) gptr;
 	unsigned long uaddr;
 
-	if (gaddr < 2 * PAGE_SIZE)
-		gaddr += prefix;
-	else if ((gaddr >= prefix) && (gaddr < prefix + 2 * PAGE_SIZE))
-		gaddr -= prefix;
+	if (prefixing) {
+		if (gaddr < 2 * PAGE_SIZE)
+			gaddr += prefix;
+		else if ((gaddr >= prefix) && (gaddr < prefix + 2 * PAGE_SIZE))
+			gaddr -= prefix;
+	}
 	uaddr = gmap_fault(gaddr, vcpu->arch.gmap);
 	if (IS_ERR_VALUE(uaddr))
 		uaddr = -EFAULT;
@@ -36,7 +39,7 @@ static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr)
 
 #define get_guest(vcpu, x, gptr)				\
 ({								\
-	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr);	\
+	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr, 1);\
 	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
 	int __ret = PTR_RET(__uptr);				\
 								\
@@ -49,7 +52,7 @@ static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr)
 
 #define put_guest(vcpu, x, gptr)				\
 ({								\
-	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr);	\
+	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr, 1);\
 	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
 	int __ret = PTR_RET(__uptr);				\
 								\
@@ -60,255 +63,40 @@ static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr)
 	__ret;							\
 })
 
-static inline int __copy_to_guest_slow(struct kvm_vcpu *vcpu,
-				       unsigned long guestdest,
-				       void *from, unsigned long n)
-{
-	int rc;
-	unsigned long i;
-	u8 *data = from;
-
-	for (i = 0; i < n; i++) {
-		rc = put_guest(vcpu, *(data++), (u8 *)guestdest++);
-		if (rc < 0)
-			return rc;
-	}
-	return 0;
-}
-
-static inline int __copy_to_guest_fast(struct kvm_vcpu *vcpu,
-				       unsigned long guestdest,
-				       void *from, unsigned long n)
-{
-	int r;
-	void __user *uptr;
-	unsigned long size;
-
-	if (guestdest + n < guestdest)
-		return -EFAULT;
-
-	/* simple case: all within one segment table entry? */
-	if ((guestdest & PMD_MASK) == ((guestdest+n) & PMD_MASK)) {
-		uptr = (void __user *) gmap_fault(guestdest, vcpu->arch.gmap);
-
-		if (IS_ERR((void __force *) uptr))
-			return PTR_ERR((void __force *) uptr);
-
-		r = copy_to_user(uptr, from, n);
-
-		if (r)
-			r = -EFAULT;
-
-		goto out;
-	}
-
-	/* copy first segment */
-	uptr = (void __user *)gmap_fault(guestdest, vcpu->arch.gmap);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	size = PMD_SIZE - (guestdest & ~PMD_MASK);
-
-	r = copy_to_user(uptr, from, size);
-
-	if (r) {
-		r = -EFAULT;
-		goto out;
-	}
-	from += size;
-	n -= size;
-	guestdest += size;
-
-	/* copy full segments */
-	while (n >= PMD_SIZE) {
-		uptr = (void __user *)gmap_fault(guestdest, vcpu->arch.gmap);
-
-		if (IS_ERR((void __force *) uptr))
-			return PTR_ERR((void __force *) uptr);
-
-		r = copy_to_user(uptr, from, PMD_SIZE);
-
-		if (r) {
-			r = -EFAULT;
-			goto out;
-		}
-		from += PMD_SIZE;
-		n -= PMD_SIZE;
-		guestdest += PMD_SIZE;
-	}
-
-	/* copy the tail segment */
-	if (n) {
-		uptr = (void __user *)gmap_fault(guestdest, vcpu->arch.gmap);
-
-		if (IS_ERR((void __force *) uptr))
-			return PTR_ERR((void __force *) uptr);
-
-		r = copy_to_user(uptr, from, n);
-
-		if (r)
-			r = -EFAULT;
-	}
-out:
-	return r;
-}
-
-static inline int copy_to_guest_absolute(struct kvm_vcpu *vcpu,
-					 unsigned long guestdest,
-					 void *from, unsigned long n)
-{
-	return __copy_to_guest_fast(vcpu, guestdest, from, n);
-}
-
-static inline int copy_to_guest(struct kvm_vcpu *vcpu, unsigned long guestdest,
-				void *from, unsigned long n)
-{
-	unsigned long prefix  = vcpu->arch.sie_block->prefix;
-
-	if ((guestdest < 2 * PAGE_SIZE) && (guestdest + n > 2 * PAGE_SIZE))
-		goto slowpath;
-
-	if ((guestdest < prefix) && (guestdest + n > prefix))
-		goto slowpath;
-
-	if ((guestdest < prefix + 2 * PAGE_SIZE)
-	    && (guestdest + n > prefix + 2 * PAGE_SIZE))
-		goto slowpath;
-
-	if (guestdest < 2 * PAGE_SIZE)
-		guestdest += prefix;
-	else if ((guestdest >= prefix) && (guestdest < prefix + 2 * PAGE_SIZE))
-		guestdest -= prefix;
-
-	return __copy_to_guest_fast(vcpu, guestdest, from, n);
-slowpath:
-	return __copy_to_guest_slow(vcpu, guestdest, from, n);
-}
-
-static inline int __copy_from_guest_slow(struct kvm_vcpu *vcpu, void *to,
-					 unsigned long guestsrc,
-					 unsigned long n)
+static inline int __copy_guest(struct kvm_vcpu *vcpu, unsigned long to,
+			       unsigned long from, unsigned long len,
+			       int to_guest, int prefixing)
 {
-	int rc;
-	unsigned long i;
-	u8 *data = to;
-
-	for (i = 0; i < n; i++) {
-		rc = get_guest(vcpu, *(data++), (u8 *)guestsrc++);
-		if (rc < 0)
-			return rc;
+	unsigned long _len, rc;
+	void *uptr;
+
+	while (len) {
+		uptr = to_guest ? (void *)to : (void *)from;
+		uptr = __gptr_to_uptr(vcpu, uptr, prefixing);
+		if (IS_ERR(uptr))
+			return -EFAULT;
+		_len = PAGE_SIZE - ((unsigned long)uptr & (PAGE_SIZE - 1));
+		_len = min(_len, len);
+		if (to_guest)
+			rc = copy_to_user(uptr, (void *)from, _len);
+		else
+			rc = copy_from_user((void *)to, uptr, _len);
+		if (rc)
+			return -EFAULT;
+		len -= _len;
+		from += _len;
+		to += _len;
 	}
 	return 0;
 }
 
-static inline int __copy_from_guest_fast(struct kvm_vcpu *vcpu, void *to,
-					 unsigned long guestsrc,
-					 unsigned long n)
-{
-	int r;
-	void __user *uptr;
-	unsigned long size;
-
-	if (guestsrc + n < guestsrc)
-		return -EFAULT;
-
-	/* simple case: all within one segment table entry? */
-	if ((guestsrc & PMD_MASK) == ((guestsrc+n) & PMD_MASK)) {
-		uptr = (void __user *) gmap_fault(guestsrc, vcpu->arch.gmap);
-
-		if (IS_ERR((void __force *) uptr))
-			return PTR_ERR((void __force *) uptr);
-
-		r = copy_from_user(to, uptr, n);
-
-		if (r)
-			r = -EFAULT;
-
-		goto out;
-	}
-
-	/* copy first segment */
-	uptr = (void __user *)gmap_fault(guestsrc, vcpu->arch.gmap);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	size = PMD_SIZE - (guestsrc & ~PMD_MASK);
-
-	r = copy_from_user(to, uptr, size);
-
-	if (r) {
-		r = -EFAULT;
-		goto out;
-	}
-	to += size;
-	n -= size;
-	guestsrc += size;
-
-	/* copy full segments */
-	while (n >= PMD_SIZE) {
-		uptr = (void __user *)gmap_fault(guestsrc, vcpu->arch.gmap);
-
-		if (IS_ERR((void __force *) uptr))
-			return PTR_ERR((void __force *) uptr);
+#define copy_to_guest(vcpu, to, from, size) \
+	__copy_guest(vcpu, to, (unsigned long)from, size, 1, 1)
+#define copy_from_guest(vcpu, to, from, size) \
+	__copy_guest(vcpu, (unsigned long)to, from, size, 0, 1)
+#define copy_to_guest_absolute(vcpu, to, from, size) \
+	__copy_guest(vcpu, to, (unsigned long)from, size, 1, 0)
+#define copy_from_guest_absolute(vcpu, to, from, size) \
+	__copy_guest(vcpu, (unsigned long)to, from, size, 0, 0)
 
-		r = copy_from_user(to, uptr, PMD_SIZE);
-
-		if (r) {
-			r = -EFAULT;
-			goto out;
-		}
-		to += PMD_SIZE;
-		n -= PMD_SIZE;
-		guestsrc += PMD_SIZE;
-	}
-
-	/* copy the tail segment */
-	if (n) {
-		uptr = (void __user *)gmap_fault(guestsrc, vcpu->arch.gmap);
-
-		if (IS_ERR((void __force *) uptr))
-			return PTR_ERR((void __force *) uptr);
-
-		r = copy_from_user(to, uptr, n);
-
-		if (r)
-			r = -EFAULT;
-	}
-out:
-	return r;
-}
-
-static inline int copy_from_guest_absolute(struct kvm_vcpu *vcpu, void *to,
-					   unsigned long guestsrc,
-					   unsigned long n)
-{
-	return __copy_from_guest_fast(vcpu, to, guestsrc, n);
-}
-
-static inline int copy_from_guest(struct kvm_vcpu *vcpu, void *to,
-				  unsigned long guestsrc, unsigned long n)
-{
-	unsigned long prefix  = vcpu->arch.sie_block->prefix;
-
-	if ((guestsrc < 2 * PAGE_SIZE) && (guestsrc + n > 2 * PAGE_SIZE))
-		goto slowpath;
-
-	if ((guestsrc < prefix) && (guestsrc + n > prefix))
-		goto slowpath;
-
-	if ((guestsrc < prefix + 2 * PAGE_SIZE)
-	    && (guestsrc + n > prefix + 2 * PAGE_SIZE))
-		goto slowpath;
-
-	if (guestsrc < 2 * PAGE_SIZE)
-		guestsrc += prefix;
-	else if ((guestsrc >= prefix) && (guestsrc < prefix + 2 * PAGE_SIZE))
-		guestsrc -= prefix;
-
-	return __copy_from_guest_fast(vcpu, to, guestsrc, n);
-slowpath:
-	return __copy_from_guest_slow(vcpu, to, guestsrc, n);
-}
-#endif
+#endif /* __KVM_S390_GACCESS_H */
-- 
1.8.0.1
