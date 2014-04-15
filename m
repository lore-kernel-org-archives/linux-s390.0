From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 35/47] s390: rename and split lowcore field per_perc_atmid
Date: Tue, 15 Apr 2014 14:00:38 +0200
Message-ID: <1397563250-3089-36-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jens Freimann <jfrei@linux.vnet.ibm.com>

per_perc_atmid is currently a two-byte field that combines two
fields, the PER code and the PER Addressing-and-Translation-Mode
Identification (ATMID)

Let's make them accessible indepently and also rename per_cause to
per_code.

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/lowcore.h | 6 ++++--
 arch/s390/kernel/asm-offsets.c  | 5 +++--
 arch/s390/kernel/entry.S        | 4 ++--
 arch/s390/kernel/entry64.S      | 4 ++--
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index edfa89b..e88cb8c 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -56,7 +56,8 @@ struct _lowcore {
 	__u16	pgm_code;			/* 0x008e */
 	__u32	trans_exc_code;			/* 0x0090 */
 	__u16	mon_class_num;			/* 0x0094 */
-	__u16	per_perc_atmid;			/* 0x0096 */
+	__u8	per_code;			/* 0x0096 */
+	__u8	per_atmid;			/* 0x0097 */
 	__u32	per_address;			/* 0x0098 */
 	__u32	monitor_code;			/* 0x009c */
 	__u8	exc_access_id;			/* 0x00a0 */
@@ -196,7 +197,8 @@ struct _lowcore {
 	__u16	pgm_code;			/* 0x008e */
 	__u32	data_exc_code;			/* 0x0090 */
 	__u16	mon_class_num;			/* 0x0094 */
-	__u16	per_perc_atmid;			/* 0x0096 */
+	__u8	per_code;			/* 0x0096 */
+	__u8	per_atmid;			/* 0x0097 */
 	__u64	per_address;			/* 0x0098 */
 	__u8	exc_access_id;			/* 0x00a0 */
 	__u8	per_access_id;			/* 0x00a1 */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 6a6b93a..32a284d 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -89,9 +89,10 @@ int main(void)
 	DEFINE(__LC_PGM_ILC, offsetof(struct _lowcore, pgm_ilc));
 	DEFINE(__LC_PGM_INT_CODE, offsetof(struct _lowcore, pgm_code));
 	DEFINE(__LC_TRANS_EXC_CODE, offsetof(struct _lowcore, trans_exc_code));
-	DEFINE(__LC_PER_CAUSE, offsetof(struct _lowcore, per_perc_atmid));
+	DEFINE(__LC_PER_CODE, offsetof(struct _lowcore, per_code));
+	DEFINE(__LC_PER_ATMID, offsetof(struct _lowcore, per_atmid));
 	DEFINE(__LC_PER_ADDRESS, offsetof(struct _lowcore, per_address));
-	DEFINE(__LC_PER_PAID, offsetof(struct _lowcore, per_access_id));
+	DEFINE(__LC_PER_ACCESS_ID, offsetof(struct _lowcore, per_access_id));
 	DEFINE(__LC_AR_MODE_ID, offsetof(struct _lowcore, ar_mode_id));
 	DEFINE(__LC_SUBCHANNEL_ID, offsetof(struct _lowcore, subchannel_id));
 	DEFINE(__LC_SUBCHANNEL_NR, offsetof(struct _lowcore, subchannel_nr));
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 526d373..3432098 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -381,8 +381,8 @@ ENTRY(pgm_check_handler)
 	jz	pgm_kprobe
 	oi	__TI_flags+3(%r12),_TIF_PER_TRAP
 	mvc	__THREAD_per_address(4,%r1),__LC_PER_ADDRESS
-	mvc	__THREAD_per_cause(2,%r1),__LC_PER_CAUSE
-	mvc	__THREAD_per_paid(1,%r1),__LC_PER_PAID
+	mvc	__THREAD_per_cause(2,%r1),__LC_PER_CODE
+	mvc	__THREAD_per_paid(1,%r1),__LC_PER_ACCESS_ID
 0:	REENABLE_IRQS
 	xc	__SF_BACKCHAIN(4,%r15),__SF_BACKCHAIN(%r15)
 	l	%r1,BASED(.Ljump_table)
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index e09dbe5..5880b21 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -413,8 +413,8 @@ ENTRY(pgm_check_handler)
 	jz	pgm_kprobe
 	oi	__TI_flags+7(%r12),_TIF_PER_TRAP
 	mvc	__THREAD_per_address(8,%r14),__LC_PER_ADDRESS
-	mvc	__THREAD_per_cause(2,%r14),__LC_PER_CAUSE
-	mvc	__THREAD_per_paid(1,%r14),__LC_PER_PAID
+	mvc	__THREAD_per_cause(2,%r14),__LC_PER_CODE
+	mvc	__THREAD_per_paid(1,%r14),__LC_PER_ACCESS_ID
 0:	REENABLE_IRQS
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	larl	%r1,pgm_check_table
-- 
1.8.4.2
