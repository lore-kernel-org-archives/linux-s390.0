From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 8/8] s390/kvm,gaccess: add address space annotations
Date: Tue,  5 Mar 2013 13:14:47 +0100
Message-ID: <1362485687-2799-9-git-send-email-borntraeger@de.ibm.com>
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

Add missing address space annotations to all put_guest()/get_guest() callers.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.h   | 21 +++++++++++----------
 arch/s390/kvm/intercept.c |  4 ++--
 arch/s390/kvm/interrupt.c | 36 ++++++++++++++++++------------------
 arch/s390/kvm/priv.c      | 22 +++++++++++-----------
 4 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 8608d7e..302e0e5 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -18,8 +18,9 @@
 #include <asm/uaccess.h>
 #include "kvm-s390.h"
 
-static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr,
-				   int prefixing)
+static inline void __user *__gptr_to_uptr(struct kvm_vcpu *vcpu,
+					  void __user *gptr,
+					  int prefixing)
 {
 	unsigned long prefix  = vcpu->arch.sie_block->prefix;
 	unsigned long gaddr = (unsigned long) gptr;
@@ -34,14 +35,14 @@ static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr,
 	uaddr = gmap_fault(gaddr, vcpu->arch.gmap);
 	if (IS_ERR_VALUE(uaddr))
 		uaddr = -EFAULT;
-	return (void *)uaddr;
+	return (void __user *)uaddr;
 }
 
 #define get_guest(vcpu, x, gptr)				\
 ({								\
 	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr, 1);\
 	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
-	int __ret = PTR_RET(__uptr);				\
+	int __ret = PTR_RET((void __force *)__uptr);		\
 								\
 	if (!__ret) {						\
 		BUG_ON((unsigned long)__uptr & __mask);		\
@@ -54,7 +55,7 @@ static inline void *__gptr_to_uptr(struct kvm_vcpu *vcpu, void *gptr,
 ({								\
 	__typeof__(gptr) __uptr = __gptr_to_uptr(vcpu, gptr, 1);\
 	int __mask = sizeof(__typeof__(*(gptr))) - 1;		\
-	int __ret = PTR_RET(__uptr);				\
+	int __ret = PTR_RET((void __force *)__uptr);		\
 								\
 	if (!__ret) {						\
 		BUG_ON((unsigned long)__uptr & __mask);		\
@@ -68,19 +69,19 @@ static inline int __copy_guest(struct kvm_vcpu *vcpu, unsigned long to,
 			       int to_guest, int prefixing)
 {
 	unsigned long _len, rc;
-	void *uptr;
+	void __user *uptr;
 
 	while (len) {
-		uptr = to_guest ? (void *)to : (void *)from;
+		uptr = to_guest ? (void __user *)to : (void __user *)from;
 		uptr = __gptr_to_uptr(vcpu, uptr, prefixing);
-		if (IS_ERR(uptr))
+		if (IS_ERR((void __force *)uptr))
 			return -EFAULT;
 		_len = PAGE_SIZE - ((unsigned long)uptr & (PAGE_SIZE - 1));
 		_len = min(_len, len);
 		if (to_guest)
-			rc = copy_to_user(uptr, (void *)from, _len);
+			rc = copy_to_user((void __user *) uptr, (void *)from, _len);
 		else
-			rc = copy_from_user((void *)to, uptr, _len);
+			rc = copy_from_user((void *)to, (void __user *)uptr, _len);
 		if (rc)
 			return -EFAULT;
 		len -= _len;
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 6474400..c6ba4df 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -44,7 +44,7 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 
 	do {
 		rc = get_guest(vcpu, vcpu->arch.sie_block->gcr[reg],
-			       (u64 *) useraddr);
+			       (u64 __user *) useraddr);
 		if (rc) {
 			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 			break;
@@ -78,7 +78,7 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 
 	reg = reg1;
 	do {
-		rc = get_guest(vcpu, val, (u32 *) useraddr);
+		rc = get_guest(vcpu, val, (u32 __user *) useraddr);
 		if (rc) {
 			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 			break;
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index d78824b..5c94817 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -188,9 +188,9 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_emergency_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->emerg.code, 0);
-		rc  = put_guest(vcpu, 0x1201, (u16 *)__LC_EXT_INT_CODE);
+		rc  = put_guest(vcpu, 0x1201, (u16 __user *)__LC_EXT_INT_CODE);
 		rc |= put_guest(vcpu, inti->emerg.code,
-				(u16 *)__LC_EXT_CPU_ADDR);
+				(u16 __user *)__LC_EXT_CPU_ADDR);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -201,9 +201,9 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_external_call++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->extcall.code, 0);
-		rc  = put_guest(vcpu, 0x1202, (u16 *)__LC_EXT_INT_CODE);
+		rc  = put_guest(vcpu, 0x1202, (u16 __user *)__LC_EXT_INT_CODE);
 		rc |= put_guest(vcpu, inti->extcall.code,
-				(u16 *)__LC_EXT_CPU_ADDR);
+				(u16 __user *)__LC_EXT_CPU_ADDR);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -215,13 +215,13 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_service_signal++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params, 0);
-		rc  = put_guest(vcpu, 0x2401, (u16 *)__LC_EXT_INT_CODE);
+		rc  = put_guest(vcpu, 0x2401, (u16 __user *)__LC_EXT_INT_CODE);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
 				      __LC_EXT_NEW_PSW, sizeof(psw_t));
 		rc |= put_guest(vcpu, inti->ext.ext_params,
-				(u32 *)__LC_EXT_PARAMS);
+				(u32 __user *)__LC_EXT_PARAMS);
 		break;
 	case KVM_S390_INT_VIRTIO:
 		VCPU_EVENT(vcpu, 4, "interrupt: virtio parm:%x,parm64:%llx",
@@ -230,16 +230,16 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->ext.ext_params,
 						 inti->ext.ext_params2);
-		rc  = put_guest(vcpu, 0x2603, (u16 *)__LC_EXT_INT_CODE);
-		rc |= put_guest(vcpu, 0x0d00, (u16 *)__LC_EXT_CPU_ADDR);
+		rc  = put_guest(vcpu, 0x2603, (u16 __user *)__LC_EXT_INT_CODE);
+		rc |= put_guest(vcpu, 0x0d00, (u16 __user *)__LC_EXT_CPU_ADDR);
 		rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
 				      __LC_EXT_NEW_PSW, sizeof(psw_t));
 		rc |= put_guest(vcpu, inti->ext.ext_params,
-				(u32 *)__LC_EXT_PARAMS);
+				(u32 __user *)__LC_EXT_PARAMS);
 		rc |= put_guest(vcpu, inti->ext.ext_params2,
-				(u64 *)__LC_EXT_PARAMS2);
+				(u64 __user *)__LC_EXT_PARAMS2);
 		break;
 	case KVM_S390_SIGP_STOP:
 		VCPU_EVENT(vcpu, 4, "%s", "interrupt: cpu stop");
@@ -278,9 +278,9 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		vcpu->stat.deliver_program_int++;
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 inti->pgm.code, 0);
-		rc  = put_guest(vcpu, inti->pgm.code, (u16 *)__LC_PGM_INT_CODE);
+		rc  = put_guest(vcpu, inti->pgm.code, (u16 __user *)__LC_PGM_INT_CODE);
 		rc |= put_guest(vcpu, table[vcpu->arch.sie_block->ipa >> 14],
-				(u16 *)__LC_PGM_ILC);
+				(u16 __user *)__LC_PGM_ILC);
 		rc |= copy_to_guest(vcpu, __LC_PGM_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -295,7 +295,7 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 						 inti->mchk.mcic);
 		rc  = kvm_s390_vcpu_store_status(vcpu,
 						 KVM_S390_STORE_STATUS_PREFIXED);
-		rc |= put_guest(vcpu, inti->mchk.mcic, (u64 *) __LC_MCCK_CODE);
+		rc |= put_guest(vcpu, inti->mchk.mcic, (u64 __user *) __LC_MCCK_CODE);
 		rc |= copy_to_guest(vcpu, __LC_MCK_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -313,13 +313,13 @@ static void __do_deliver_interrupt(struct kvm_vcpu *vcpu,
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id, inti->type,
 						 param0, param1);
 		rc  = put_guest(vcpu, inti->io.subchannel_id,
-				(u16 *) __LC_SUBCHANNEL_ID);
+				(u16 __user *) __LC_SUBCHANNEL_ID);
 		rc |= put_guest(vcpu, inti->io.subchannel_nr,
-				(u16 *) __LC_SUBCHANNEL_NR);
+				(u16 __user *) __LC_SUBCHANNEL_NR);
 		rc |= put_guest(vcpu, inti->io.io_int_parm,
-				(u32 *) __LC_IO_INT_PARM);
+				(u32 __user *) __LC_IO_INT_PARM);
 		rc |= put_guest(vcpu, inti->io.io_int_word,
-				(u32 *) __LC_IO_INT_WORD);
+				(u32 __user *) __LC_IO_INT_WORD);
 		rc |= copy_to_guest(vcpu, __LC_IO_OLD_PSW,
 				    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 		rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
@@ -344,7 +344,7 @@ static int __try_deliver_ckc_interrupt(struct kvm_vcpu *vcpu)
 		return 0;
 	if (!(vcpu->arch.sie_block->gcr[0] & 0x800ul))
 		return 0;
-	rc  = put_guest(vcpu, 0x1004, (u16 *)__LC_EXT_INT_CODE);
+	rc  = put_guest(vcpu, 0x1004, (u16 __user *)__LC_EXT_INT_CODE);
 	rc |= copy_to_guest(vcpu, __LC_EXT_OLD_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= copy_from_guest(vcpu, &vcpu->arch.sie_block->gpsw,
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index d64382c..7db2ad0 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -42,7 +42,7 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	}
 
 	/* get the value */
-	if (get_guest(vcpu, address, (u32 *) operand2)) {
+	if (get_guest(vcpu, address, (u32 __user *) operand2)) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
 	}
@@ -83,7 +83,7 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	address = address & 0x7fffe000u;
 
 	/* get the value */
-	if (put_guest(vcpu, address, (u32 *)operand2)) {
+	if (put_guest(vcpu, address, (u32 __user *)operand2)) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
 	}
@@ -108,7 +108,7 @@ static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	rc = put_guest(vcpu, vcpu->vcpu_id, (u16 *)useraddr);
+	rc = put_guest(vcpu, vcpu->vcpu_id, (u16 __user *)useraddr);
 	if (rc) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
@@ -149,18 +149,18 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 		 * Store the two-word I/O interruption code into the
 		 * provided area.
 		 */
-		put_guest(vcpu, inti->io.subchannel_id, (u16 *) addr);
-		put_guest(vcpu, inti->io.subchannel_nr, (u16 *) (addr + 2));
-		put_guest(vcpu, inti->io.io_int_parm, (u32 *) (addr + 4));
+		put_guest(vcpu, inti->io.subchannel_id, (u16 __user *) addr);
+		put_guest(vcpu, inti->io.subchannel_nr, (u16 __user *) (addr + 2));
+		put_guest(vcpu, inti->io.io_int_parm, (u32 __user *) (addr + 4));
 	} else {
 		/*
 		 * Store the three-word I/O interruption code into
 		 * the appropriate lowcore area.
 		 */
-		put_guest(vcpu, inti->io.subchannel_id, (u16 *) __LC_SUBCHANNEL_ID);
-		put_guest(vcpu, inti->io.subchannel_nr, (u16 *) __LC_SUBCHANNEL_NR);
-		put_guest(vcpu, inti->io.io_int_parm, (u32 *) __LC_IO_INT_PARM);
-		put_guest(vcpu, inti->io.io_int_word, (u32 *) __LC_IO_INT_WORD);
+		put_guest(vcpu, inti->io.subchannel_id, (u16 __user *) __LC_SUBCHANNEL_ID);
+		put_guest(vcpu, inti->io.subchannel_nr, (u16 __user *) __LC_SUBCHANNEL_NR);
+		put_guest(vcpu, inti->io.io_int_parm, (u32 __user *) __LC_IO_INT_PARM);
+		put_guest(vcpu, inti->io.io_int_word, (u32 __user *) __LC_IO_INT_WORD);
 	}
 	kfree(inti);
 no_interrupt:
@@ -353,7 +353,7 @@ static int handle_stidp(struct kvm_vcpu *vcpu)
 		goto out;
 	}
 
-	rc = put_guest(vcpu, vcpu->arch.stidp_data, (u64 *)operand2);
+	rc = put_guest(vcpu, vcpu->arch.stidp_data, (u64 __user *)operand2);
 	if (rc) {
 		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out;
-- 
1.8.0.1
