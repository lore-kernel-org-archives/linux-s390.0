From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 5/8] s390/kvm,gaccess: shorten put/get_guest code
Date: Tue,  5 Mar 2013 13:14:44 +0100
Message-ID: <1362485687-2799-6-git-send-email-borntraeger@de.ibm.com>
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

The put_guest_u*/get_guest_u* are nothing but wrappers for the regular
put_user/get_user uaccess functions. The only difference is that before
accessing user space the guest address must be translated to a user space
address.
Change the order of arguments for the guest access functions so they
match their uaccess parts. Also remove the u* suffix, so we simply
have put_guest/get_guest which will automatically use the right size
dependent on pointer type of the destination/source that now must be
correct.
In result the same behaviour as put_user/get_user except that accesses
must be aligned.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h   | 153 ++++++++++++----------------------------------
 arch/s390/kvm/intercept.c |   6 +-
 arch/s390/kvm/interrupt.c |  52 ++++++++--------
 arch/s390/kvm/priv.c      |  22 +++----
 4 files changed, 81 insertions(+), 152 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 84d01dd..82f450e 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -18,122 +18,47 @@
 #include <asm/uaccess.h>
 #include "kvm-s390.h"
 
-static inline void __user *__guestaddr_to_user(struct kvm_vcpu *vcpu,
-					       unsigned long guestaddr)
+static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr)
 {
 	unsigned long prefix  = vcpu->arch.sie_block->prefix;
-	unsigned long uaddress;
-
-	if (guestaddr < 2 * PAGE_SIZE)
-		guestaddr += prefix;
-	else if ((guestaddr >= prefix) && (guestaddr < prefix + 2 * PAGE_SIZE))
-		guestaddr -= prefix;
-	uaddress = gmap_fault(guestaddr, vcpu->arch.gmap);
-	if (IS_ERR_VALUE(uaddress))
-		uaddress = -EFAULT;
-	return (void __user *)uaddress;
-}
-
-static inline int get_guest_u64(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-				u64 *result)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	BUG_ON(guestaddr & 7);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	return get_user(*result, (unsigned long __user *) uptr);
-}
-
-static inline int get_guest_u32(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-				u32 *result)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	BUG_ON(guestaddr & 3);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	return get_user(*result, (u32 __user *) uptr);
-}
-
-static inline int get_guest_u16(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-				u16 *result)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	BUG_ON(guestaddr & 1);
-
-	if (IS_ERR(uptr))
-		return PTR_ERR(uptr);
-
-	return get_user(*result, (u16 __user *) uptr);
-}
-
-static inline int get_guest_u8(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-			       u8 *result)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	return get_user(*result, (u8 __user *) uptr);
-}
-
-static inline int put_guest_u64(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-				u64 value)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	BUG_ON(guestaddr & 7);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	return put_user(value, (u64 __user *) uptr);
-}
-
-static inline int put_guest_u32(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-				u32 value)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	BUG_ON(guestaddr & 3);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	return put_user(value, (u32 __user *) uptr);
-}
-
-static inline int put_guest_u16(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-				u16 value)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	BUG_ON(guestaddr & 1);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	return put_user(value, (u16 __user *) uptr);
-}
-
-static inline int put_guest_u8(struct kvm_vcpu *vcpu, unsigned long guestaddr,
-			       u8 value)
-{
-	void __user *uptr = __guestaddr_to_user(vcpu, guestaddr);
-
-	if (IS_ERR((void __force *) uptr))
-		return PTR_ERR((void __force *) uptr);
-
-	return put_user(value, (u8 __user *) uptr);
+	unsigned long gaddr = (unsigned long) gptr;
+	unsigned long uaddr;
+
+	if (gaddr < 2 * PAGE_SIZE)
+		gaddr += prefix;
+	else if ((gaddr >= prefix) && (gaddr < prefix + 2 * PAGE_SIZE))
+		gaddr -= prefix;
+	uaddr = gmap_fault(gaddr, vcpu->arch.gmap);
+	if (IS_ERR_VALUE(uaddr))
+		uaddr = -EFAULT;
+	return (void *)uaddr;
 }
 
+#define get_guest(vcpu, x, gptr)				\
+({								\
+	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr);	\
+	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
+	int __ret = PTR_RET(__uptr);				\
+								\
+	if (!__ret) {						\
+		BUG_ON((unsigned long)__uptr & __mask);		\
+		__ret = get_user(x, __uptr);			\
+	}							\
+	__ret;							\
+})
+
+#define put_guest(vcpu, x, gptr)				\
+({								\
+	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr);	\
+	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
+	int __ret = PTR_RET(__uptr);				\
+								\
+	if (!__ret) {						\
+		BUG_ON((unsigned long)__uptr & __mask);		\
+		__ret = put_user(x, __uptr);			\
+	}							\
+	__ret;							\
+})
 
 static inline int __copy_to_guest_slow(struct kvm_vcpu *vcpu,
 				       unsigned long guestdest,
@@ -144,7 +69,7 @@ static inline int __copy_to_guest_slow(struct kvm_vcpu *vcpu,
 	u8 *data = from;
 
 	for (i = 0; i < n; i++) {
-		rc = put_guest_u8(vcpu, guestdest++, *(data++));
+		rc = put_guest(vcpu, *(data++), (u8 *)guestdest++);
 		if (rc < 0)
 			return rc;
 	}
@@ -270,7 +195,7 @@ static inline int __copy_from_guest_slow(struct kvm_vcpu *vcpu, void *to,
 	u8 *data = to;
 
 	for (i = 0; i < n; i++) {
-		rc = get_guest_u8(vcpu, guestsrc++, data++);
+		rc = get_guest(vcpu, *(data++), (u8 *)guestsrc++);
 		if (rc < 0)
 			return rc;
 	}
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 9b22047..6474400 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -43,8 +43,8 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	trace_kvm_s390_handle_lctl(vcpu, 1, reg1, reg3, useraddr);
 
 	do {
-		rc = get_guest_u64(vcpu, useraddr,
-				   &vcpu->arch.sie_block->gcr[reg]);
+		rc = get_guest(vcpu, vcpu->arch.sie_block->gcr[reg],
+			       (u64 *) useraddr);
 		if (rc) {
 			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 			break;
@@ -78,7 +78,7 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 
 	reg = reg1;
 	do {
-		rc = get_guest_u32(vcpu, useraddr, &val);
+		rc = get_guest(vcpu, val, (u32 *) useraddr);
 		if (rc) {
 			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 			break;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5afa931..d78824b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -188,8 +188,9 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_emergency_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->emerg.code, 0);
-		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1201);
-		rc |= put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, inti->emerg.code);
+		rc  = put_guest(vcpu, 0x1201, (u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest(vcpu, inti->emerg.code,
+				(u16 *)__LC_EXT_CPU_ADDR);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -200,8 +201,9 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_external_call++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->extcall.code, 0);
-		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1202);
-		rc |= put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, inti->extcall.code);
+		rc  = put_guest(vcpu, 0x1202, (u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest(vcpu, inti->extcall.code,
+				(u16 *)__LC_EXT_CPU_ADDR);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -213,12 +215,13 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_service_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params, 0);
-		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x2401);
+		rc  = put_guest(vcpu, 0x2401, (u16 *)__LC_EXT_INT_CODE);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
 				      __LC_EXT_NEW_PSW, sizeof(psw_t));
-		rc |= put_guest_u32(vcpu, __LC_EXT_PARAMS, inti->ext.ext_params);
+		rc |= put_guest(vcpu, inti->ext.ext_params,
+				(u32 *)__LC_EXT_PARAMS);
 		break;
 	case KVM_S390_INT_VIRTIO:
 		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
@@ -227,15 +230,16 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params,
 						 inti->ext.ext_params2);
-		rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x2603);
-		rc |= put_guest_u16(vcpu, __LC_EXT_CPU_ADDR, 0x0d00);
+		rc  = put_guest(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
+		rc |= put_guest(vcpu, 0x0d00, (u16 *)__LC_EXT_CPU_ADDR);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
 				      __LC_EXT_NEW_PSW, sizeof(psw_t));
-		rc |= put_guest_u32(vcpu, __LC_EXT_PARAMS, inti->ext.ext_params);
-		rc |= put_guest_u64(vcpu, __LC_EXT_PARAMS2,
-				    inti->ext.ext_params2);
+		rc |= put_guest(vcpu, inti->ext.ext_params,
+				(u32 *)__LC_EXT_PARAMS);
+		rc |= put_guest(vcpu, inti->ext.ext_params2,
+				(u64 *)__LC_EXT_PARAMS2);
 		break;
 	case KVM_S390_SIGP_STOP:
 		VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
@@ -274,9 +278,9 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_program_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->pgm.code, 0);
-		rc  = put_guest_u16(vcpu, __LC_PGM_INT_CODE, inti->pgm.code);
-		rc |= put_guest_u16(vcpu, __LC_PGM_ILC,
-				    table[vcpu->arch.sie_block->ipa >> 14]);
+		rc  = put_guest(vcpu, inti->pgm.code, (u16 *)__LC_PGM_INT_CODE);
+		rc |= put_guest(vcpu, table[vcpu->arch.sie_block->ipa >> 14],
+				(u16 *)__LC_PGM_ILC);
 		rc |= copy_to_guest(vcpu, __LC_PGM_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -291,7 +295,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 						 inti->mchk.mcic);
 		rc  = kvm_s390_vcpu_store_status(vcpu,
 						 KVM_S390_STORE_STATUS_PREFIXED);
-		rc |= put_guest_u64(vcpu, __LC_MCCK_CODE, inti->mchk.mcic);
+		rc |= put_guest(vcpu, inti->mchk.mcic, (u64 *) __LC_MCCK_CODE);
 		rc |= copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -308,14 +312,14 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_io_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 param0, param1);
-		rc  = put_guest_u16(vcpu, __LC_SUBCHANNEL_ID,
-				    inti->io.subchannel_id);
-		rc |= put_guest_u16(vcpu, __LC_SUBCHANNEL_NR,
-				    inti->io.subchannel_nr);
-		rc |= put_guest_u32(vcpu, __LC_IO_INT_PARM,
-				    inti->io.io_int_parm);
-		rc |= put_guest_u32(vcpu, __LC_IO_INT_WORD,
-				    inti->io.io_int_word);
+		rc  = put_guest(vcpu, inti->io.subchannel_id,
+				(u16 *) __LC_SUBCHANNEL_ID);
+		rc |= put_guest(vcpu, inti->io.subchannel_nr,
+				(u16 *) __LC_SUBCHANNEL_NR);
+		rc |= put_guest(vcpu, inti->io.io_int_parm,
+				(u32 *) __LC_IO_INT_PARM);
+		rc |= put_guest(vcpu, inti->io.io_int_word,
+				(u32 *) __LC_IO_INT_WORD);
 		rc |= copy_to_guest(vcpu, __LC_IO_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -340,7 +344,7 @@ static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 		return 0;
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))
 		return 0;
-	rc  = put_guest_u16(vcpu, __LC_EXT_INT_CODE, 0x1004);
+	rc  = put_guest(vcpu, 0x1004, (u16 *)__LC_EXT_INT_CODE);
 	rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 34b42dc..cb07147 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -41,7 +41,7 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	}
 
 	/* get the value */
-	if (get_guest_u32(vcpu, operand2, &address)) {
+	if (get_guest(vcpu, address, (u32 *) operand2)) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
 	}
@@ -82,7 +82,7 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	address = address & 0x7fffe000u;
 
 	/* get the value */
-	if (put_guest_u32(vcpu, operand2, address)) {
+	if (put_guest(vcpu, address, (u32 *)operand2)) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
 	}
@@ -107,7 +107,7 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	rc = put_guest_u16(vcpu, useraddr, vcpu->vcpu_id);
+	rc = put_guest(vcpu, vcpu->vcpu_id, (u16 *)useraddr);
 	if (rc) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
@@ -142,18 +142,18 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 			 * Store the two-word I/O interruption code into the
 			 * provided area.
 			 */
-			put_guest_u16(vcpu, addr, inti->io.subchannel_id);
-			put_guest_u16(vcpu, addr + 2, inti->io.subchannel_nr);
-			put_guest_u32(vcpu, addr + 4, inti->io.io_int_parm);
+			put_guest(vcpu, inti->io.subchannel_id, (u16 *) addr);
+			put_guest(vcpu, inti->io.subchannel_nr, (u16 *) (addr + 2));
+			put_guest(vcpu, inti->io.io_int_parm, (u32 *) (addr + 4));
 		} else {
 			/*
 			 * Store the three-word I/O interruption code into
 			 * the appropriate lowcore area.
 			 */
-			put_guest_u16(vcpu, 184, inti->io.subchannel_id);
-			put_guest_u16(vcpu, 186, inti->io.subchannel_nr);
-			put_guest_u32(vcpu, 188, inti->io.io_int_parm);
-			put_guest_u32(vcpu, 192, inti->io.io_int_word);
+			put_guest(vcpu, inti->io.subchannel_id, (u16 *) 184);
+			put_guest(vcpu, inti->io.subchannel_nr, (u16 *) 186);
+			put_guest(vcpu, inti->io.io_int_parm, (u32 *) 188);
+			put_guest(vcpu, inti->io.io_int_word, (u32 *) 192);
 		}
 		cc = 1;
 	} else
@@ -347,7 +347,7 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	rc = put_guest_u64(vcpu, operand2, vcpu->arch.stidp_data);
+	rc = put_guest(vcpu, vcpu->arch.stidp_data, (u64 *)operand2);
 	if (rc) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
-- 
1.8.0.1
