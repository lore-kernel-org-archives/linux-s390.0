From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 36/47] s390: add fields to lowcore definition
Date: Tue, 15 Apr 2014 14:00:39 +0200
Message-ID: <1397563250-3089-37-git-send-email-borntraeger@de.ibm.com>
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

This patch adds fields which are currently missing but needed for the correct
injection of interrupts.

This is based on a patch by David Hildenbrand

Signed-off-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/asm-offsets.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 32a284d..5e55d2a 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -89,17 +89,22 @@ int main(void)
 	DEFINE(__LC_PGM_ILC, offsetof(struct _lowcore, pgm_ilc));
 	DEFINE(__LC_PGM_INT_CODE, offsetof(struct _lowcore, pgm_code));
 	DEFINE(__LC_TRANS_EXC_CODE, offsetof(struct _lowcore, trans_exc_code));
+	DEFINE(__LC_MON_CLASS_NR, offsetof(struct _lowcore, mon_class_num));
 	DEFINE(__LC_PER_CODE, offsetof(struct _lowcore, per_code));
 	DEFINE(__LC_PER_ATMID, offsetof(struct _lowcore, per_atmid));
 	DEFINE(__LC_PER_ADDRESS, offsetof(struct _lowcore, per_address));
+	DEFINE(__LC_EXC_ACCESS_ID, offsetof(struct _lowcore, exc_access_id));
 	DEFINE(__LC_PER_ACCESS_ID, offsetof(struct _lowcore, per_access_id));
+	DEFINE(__LC_OP_ACCESS_ID, offsetof(struct _lowcore, op_access_id));
 	DEFINE(__LC_AR_MODE_ID, offsetof(struct _lowcore, ar_mode_id));
+	DEFINE(__LC_MON_CODE, offsetof(struct _lowcore, monitor_code));
 	DEFINE(__LC_SUBCHANNEL_ID, offsetof(struct _lowcore, subchannel_id));
 	DEFINE(__LC_SUBCHANNEL_NR, offsetof(struct _lowcore, subchannel_nr));
 	DEFINE(__LC_IO_INT_PARM, offsetof(struct _lowcore, io_int_parm));
 	DEFINE(__LC_IO_INT_WORD, offsetof(struct _lowcore, io_int_word));
 	DEFINE(__LC_STFL_FAC_LIST, offsetof(struct _lowcore, stfl_fac_list));
 	DEFINE(__LC_MCCK_CODE, offsetof(struct _lowcore, mcck_interruption_code));
+	DEFINE(__LC_MCCK_EXT_DAM_CODE, offsetof(struct _lowcore, external_damage_code));
 	DEFINE(__LC_RST_OLD_PSW, offsetof(struct _lowcore, restart_old_psw));
 	DEFINE(__LC_EXT_OLD_PSW, offsetof(struct _lowcore, external_old_psw));
 	DEFINE(__LC_SVC_OLD_PSW, offsetof(struct _lowcore, svc_old_psw));
@@ -156,6 +161,8 @@ int main(void)
 #ifdef CONFIG_32BIT
 	DEFINE(SAVE_AREA_BASE, offsetof(struct _lowcore, extended_save_area_addr));
 #else /* CONFIG_32BIT */
+	DEFINE(__LC_DATA_EXC_CODE, offsetof(struct _lowcore, data_exc_code));
+	DEFINE(__LC_MCCK_FAIL_STOR_ADDR, offsetof(struct _lowcore, failing_storage_address));
 	DEFINE(__LC_EXT_PARAMS2, offsetof(struct _lowcore, ext_params2));
 	DEFINE(SAVE_AREA_BASE, offsetof(struct _lowcore, floating_pt_save_area));
 	DEFINE(__LC_PASTE, offsetof(struct _lowcore, paste));
-- 
1.8.4.2
