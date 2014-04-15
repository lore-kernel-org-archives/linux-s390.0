From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 34/47] s390: fix name of lowcore field at offset 0xa3
Date: Tue, 15 Apr 2014 14:00:37 +0200
Message-ID: <1397563250-3089-35-git-send-email-borntraeger@de.ibm.com>
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

According to the Principles of Operation, at offset 0xA3
in the lowcore we have the "Architectural-Mode identification",
not an "access identification".

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/lowcore.h | 4 ++--
 arch/s390/kernel/asm-offsets.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index bbf8141..edfa89b 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -62,7 +62,7 @@ struct _lowcore {
 	__u8	exc_access_id;			/* 0x00a0 */
 	__u8	per_access_id;			/* 0x00a1 */
 	__u8	op_access_id;			/* 0x00a2 */
-	__u8	ar_access_id;			/* 0x00a3 */
+	__u8	ar_mode_id;			/* 0x00a3 */
 	__u8	pad_0x00a4[0x00b8-0x00a4];	/* 0x00a4 */
 	__u16	subchannel_id;			/* 0x00b8 */
 	__u16	subchannel_nr;			/* 0x00ba */
@@ -201,7 +201,7 @@ struct _lowcore {
 	__u8	exc_access_id;			/* 0x00a0 */
 	__u8	per_access_id;			/* 0x00a1 */
 	__u8	op_access_id;			/* 0x00a2 */
-	__u8	ar_access_id;			/* 0x00a3 */
+	__u8	ar_mode_id;			/* 0x00a3 */
 	__u8	pad_0x00a4[0x00a8-0x00a4];	/* 0x00a4 */
 	__u64	trans_exc_code;			/* 0x00a8 */
 	__u64	monitor_code;			/* 0x00b0 */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index e4c99a1..6a6b93a 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -92,7 +92,7 @@ int main(void)
 	DEFINE(__LC_PER_CAUSE, offsetof(struct _lowcore, per_perc_atmid));
 	DEFINE(__LC_PER_ADDRESS, offsetof(struct _lowcore, per_address));
 	DEFINE(__LC_PER_PAID, offsetof(struct _lowcore, per_access_id));
-	DEFINE(__LC_AR_MODE_ID, offsetof(struct _lowcore, ar_access_id));
+	DEFINE(__LC_AR_MODE_ID, offsetof(struct _lowcore, ar_mode_id));
 	DEFINE(__LC_SUBCHANNEL_ID, offsetof(struct _lowcore, subchannel_id));
 	DEFINE(__LC_SUBCHANNEL_NR, offsetof(struct _lowcore, subchannel_nr));
 	DEFINE(__LC_IO_INT_PARM, offsetof(struct _lowcore, io_int_parm));
-- 
1.8.4.2
