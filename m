From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 6/6] s390: scrub registers on kernel entry and KVM exit
Date: Wed, 17 Jan 2018 10:48:39 +0100
Message-ID: <1516182519-10623-7-git-send-email-schwidefsky@de.ibm.com>
References: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516182519-10623-1-git-send-email-schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Clear all user space registers on entry to the kernel and all KVM guest
registers on KVM guest exit if the register does not contain either a
parameter or a result value.

Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/kernel/entry.S | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 2a22c03..47227d3 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -322,6 +322,12 @@ ENTRY(sie64a)
 sie_exit:
 	lg	%r14,__SF_EMPTY+8(%r15)		# load guest register save area
 	stmg	%r0,%r13,0(%r14)		# save guest gprs 0-13
+	xgr	%r0,%r0				# clear guest registers
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
 	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
 	lg	%r2,__SF_EMPTY+16(%r15)		# return exit reason code
 	br	%r14
@@ -358,6 +364,7 @@ ENTRY(system_call)
 	UPDATE_VTIME %r8,%r9,__LC_SYNC_ENTER_TIMER
 	BPENTER __TI_flags(%r12),_TIF_NOBP
 	stmg	%r0,%r7,__PT_R0(%r11)
+	xgr	%r0,%r0
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	mvc	__PT_PSW(16,%r11),__LC_SVC_OLD_PSW
 	mvc	__PT_INT_CODE(4,%r11),__LC_SVC_ILC
@@ -640,6 +647,14 @@ ENTRY(pgm_check_handler)
 4:	lgr	%r13,%r11
 	la	%r11,STACK_FRAME_OVERHEAD(%r15)
 	stmg	%r0,%r7,__PT_R0(%r11)
+	xgr	%r0,%r0			# clear user space registers
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_SYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_INT_CODE(4,%r11),__LC_PGM_ILC
@@ -706,6 +721,15 @@ ENTRY(io_int_handler)
 	lmg	%r8,%r9,__LC_IO_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	xgr	%r0,%r0			# clear user space registers
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	mvc	__PT_INT_CODE(12,%r11),__LC_SUBCHANNEL_ID
@@ -924,6 +948,15 @@ ENTRY(ext_int_handler)
 	lmg	%r8,%r9,__LC_EXT_OLD_PSW
 	SWITCH_ASYNC __LC_SAVE_AREA_ASYNC,__LC_ASYNC_ENTER_TIMER
 	stmg	%r0,%r7,__PT_R0(%r11)
+	xgr	%r0,%r0			# clear user space registers
+	xgr	%r1,%r1
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA_ASYNC
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	lghi	%r1,__LC_EXT_PARAMS2
@@ -1133,6 +1166,14 @@ ENTRY(mcck_int_handler)
 .Lmcck_skip:
 	lghi	%r14,__LC_GPREGS_SAVE_AREA+64
 	stmg	%r0,%r7,__PT_R0(%r11)
+	xgr	%r0,%r0			# clear user space registers
+	xgr	%r2,%r2
+	xgr	%r3,%r3
+	xgr	%r4,%r4
+	xgr	%r5,%r5
+	xgr	%r6,%r6
+	xgr	%r7,%r7
+	xgr	%r10,%r10
 	mvc	__PT_R8(64,%r11),0(%r14)
 	stmg	%r8,%r9,__PT_PSW(%r11)
 	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
-- 
2.7.4
