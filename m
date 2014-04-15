From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 32/47] KVM: s390: remove old guest access functions
Date: Tue, 15 Apr 2014 14:00:35 +0200
Message-ID: <1397563250-3089-33-git-send-email-borntraeger@de.ibm.com>
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

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h | 81 -------------------------------------------------
 1 file changed, 81 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index f46e764..ed4749e 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -56,87 +56,6 @@ static inline unsigned long kvm_s390_logical_to_effective(struct kvm_vcpu *vcpu,
 	return ga & ((1UL << 24) - 1);
 }
 
-static inline void __user *__gptr_to_uptr(struct kvm_vcpu *vcpu,
-					  void __user *gptr,
-					  int prefixing)
-{
-	unsigned long gaddr = (unsigned long) gptr;
-	unsigned long uaddr;
-
-	if (prefixing)
-		gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
-	uaddr = gmap_fault(gaddr, vcpu->arch.gmap);
-	if (IS_ERR_VALUE(uaddr))
-		uaddr = -EFAULT;
-	return (void __user *)uaddr;
-}
-
-#define get_guest(vcpu, x, gptr)				\
-({								\
-	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr, 1);\
-	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
-	int __ret;						\
-								\
-	if (IS_ERR((void __force *)__uptr)) {			\
-		__ret = PTR_ERR((void __force *)__uptr);	\
-	} else {						\
-		BUG_ON((unsigned long)__uptr & __mask);		\
-		__ret = get_user(x, __uptr);			\
-	}							\
-	__ret;							\
-})
-
-#define put_guest(vcpu, x, gptr)				\
-({								\
-	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr, 1);\
-	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
-	int __ret;						\
-								\
-	if (IS_ERR((void __force *)__uptr)) {			\
-		__ret = PTR_ERR((void __force *)__uptr);	\
-	} else {						\
-		BUG_ON((unsigned long)__uptr & __mask);		\
-		__ret = put_user(x, __uptr);			\
-	}							\
-	__ret;							\
-})
-
-static inline int __copy_guest(struct kvm_vcpu *vcpu, unsigned long to,
-			       unsigned long from, unsigned long len,
-			       int to_guest, int prefixing)
-{
-	unsigned long _len, rc;
-	void __user *uptr;
-
-	while (len) {
-		uptr = to_guest ? (void __user *)to : (void __user *)from;
-		uptr = __gptr_to_uptr(vcpu, uptr, prefixing);
-		if (IS_ERR((void __force *)uptr))
-			return -EFAULT;
-		_len = PAGE_SIZE - ((unsigned long)uptr & (PAGE_SIZE - 1));
-		_len = min(_len, len);
-		if (to_guest)
-			rc = copy_to_user((void __user *) uptr, (void *)from, _len);
-		else
-			rc = copy_from_user((void *)to, (void __user *)uptr, _len);
-		if (rc)
-			return -EFAULT;
-		len -= _len;
-		from += _len;
-		to += _len;
-	}
-	return 0;
-}
-
-#define copy_to_guest(vcpu, to, from, size) \
-	__copy_guest(vcpu, to, (unsigned long)from, size, 1, 1)
-#define copy_from_guest(vcpu, to, from, size) \
-	__copy_guest(vcpu, (unsigned long)to, from, size, 0, 1)
-#define copy_to_guest_absolute(vcpu, to, from, size) \
-	__copy_guest(vcpu, to, (unsigned long)from, size, 1, 0)
-#define copy_from_guest_absolute(vcpu, to, from, size) \
-	__copy_guest(vcpu, (unsigned long)to, from, size, 0, 0)
-
 /*
  * put_guest_lc, read_guest_lc and write_guest_lc are guest access functions
  * which shall only be used to access the lowcore of a vcpu.
-- 
1.8.4.2
