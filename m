Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2BC0018A
	for <linux-s390@archiver.kernel.org>; Fri,  3 Nov 2023 09:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347114AbjKCJaE (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Nov 2023 05:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347126AbjKCJaD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Nov 2023 05:30:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD58D42;
        Fri,  3 Nov 2023 02:30:00 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A39PMUO009665;
        Fri, 3 Nov 2023 09:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wnl6iD9bSf0uKQwYkELioAByLOaNTG2Yumo76+DBMeI=;
 b=LUFWXI41e0GeGsQBwiIGYcAKgEPeJBDlXJoh35gFhAYOMjnmfwavnKOse5zN7pLecqzh
 wbRqj/Dj4ihlshzxKfASEeaPIrT2mywtwiquFAz0gh1gb/+3jupN/yOh9mX0hkAaK9Ua
 QzimpWGh7mHJkk2iiy5YDjA3f/8xLPH9WEg+wlaHdWn1HdYMa1SFG5IidxvrQqWZ8sh0
 0ny0yH5xIR2404Om1/dfS1gqEYRFJGKY+SYE2HCSy9MzmKrdFwYAvBoqgUxpxZpnzXoV
 CoIHHkSOrSJUTE2juvikeoECQLGkCiLUAs266ISBA2oCvaBteYzqMG5mGsDpxvtXeIFP hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4x7703ca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:29:59 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A39QKe2011696;
        Fri, 3 Nov 2023 09:29:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u4x7703c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:29:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A39PA3M011544;
        Fri, 3 Nov 2023 09:29:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1e4mcsse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Nov 2023 09:29:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A39TtYi43909460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 09:29:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CA1B20040;
        Fri,  3 Nov 2023 09:29:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF2C12004E;
        Fri,  3 Nov 2023 09:29:54 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  3 Nov 2023 09:29:54 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v7 2/8] s390x: add function to set DAT mode for all interrupts
Date:   Fri,  3 Nov 2023 10:29:31 +0100
Message-ID: <20231103092954.238491-3-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231103092954.238491-1-nrb@linux.ibm.com>
References: <20231103092954.238491-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rd38R_T9J8cBk3Y5NgHOrHP76F2TRFZb
X-Proofpoint-ORIG-GUID: IEgI-UtYWxnJ3JPI_rgqWWlp22OEQ44q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_09,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=459 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030078
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When toggling DAT or switch address space modes, it is likely that
interrupts should be handled in the same DAT or address space mode.

Add a function which toggles DAT and address space mode for all
interruptions, except restart interrupts.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h  | 10 ++++++----
 lib/s390x/asm/interrupt.h |  2 ++
 lib/s390x/interrupt.c     | 35 +++++++++++++++++++++++++++++++++++
 lib/s390x/mmu.c           |  5 +++--
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index f629b6d0a17f..5beaf15b57e7 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -84,10 +84,12 @@ struct cpu {
 	bool in_interrupt_handler;
 };
 
-#define AS_PRIM				0
-#define AS_ACCR				1
-#define AS_SECN				2
-#define AS_HOME				3
+enum address_space {
+	AS_PRIM = 0,
+	AS_ACCR = 1,
+	AS_SECN = 2,
+	AS_HOME = 3
+};
 
 #define PSW_MASK_DAT			0x0400000000000000UL
 #define PSW_MASK_IO			0x0200000000000000UL
diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
index 35c1145f0349..d01f8a89641a 100644
--- a/lib/s390x/asm/interrupt.h
+++ b/lib/s390x/asm/interrupt.h
@@ -83,6 +83,8 @@ void expect_ext_int(void);
 uint16_t clear_pgm_int(void);
 void check_pgm_int_code(uint16_t code);
 
+void irq_set_dat_mode(bool use_dat, enum address_space as);
+
 /* Activate low-address protection */
 static inline void low_prot_enable(void)
 {
diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
index 3f993a363ae2..e0a1713349f6 100644
--- a/lib/s390x/interrupt.c
+++ b/lib/s390x/interrupt.c
@@ -9,6 +9,7 @@
  */
 #include <libcflat.h>
 #include <asm/barrier.h>
+#include <asm/mem.h>
 #include <asm/asm-offsets.h>
 #include <sclp.h>
 #include <interrupt.h>
@@ -104,6 +105,40 @@ void register_ext_cleanup_func(void (*f)(struct stack_frame_int *))
 	THIS_CPU->ext_cleanup_func = f;
 }
 
+/**
+ * irq_set_dat_mode - Set the DAT mode of all interrupt handlers, except for
+ * restart.
+ * This will update the DAT mode and address space mode of all interrupt new
+ * PSWs.
+ *
+ * Since enabling DAT needs initialized CRs and the restart new PSW is often used
+ * to initialize CRs, the restart new PSW is never touched to avoid the chicken
+ * and egg situation.
+ *
+ * @use_dat specifies whether to use DAT or not
+ * @as specifies the address space mode to use. Not set if use_dat is false.
+ */
+void irq_set_dat_mode(bool use_dat, enum address_space as)
+{
+	struct psw* irq_psws[] = {
+		OPAQUE_PTR(GEN_LC_EXT_NEW_PSW),
+		OPAQUE_PTR(GEN_LC_SVC_NEW_PSW),
+		OPAQUE_PTR(GEN_LC_PGM_NEW_PSW),
+		OPAQUE_PTR(GEN_LC_MCCK_NEW_PSW),
+		OPAQUE_PTR(GEN_LC_IO_NEW_PSW),
+	};
+	struct psw *psw;
+
+	assert(as == AS_PRIM || as == AS_ACCR || as == AS_SECN || as == AS_HOME);
+
+	for (size_t i = 0; i < ARRAY_SIZE(irq_psws); i++) {
+		psw = irq_psws[i];
+		psw->dat = use_dat;
+		if (use_dat)
+			psw->as = as;
+	}
+}
+
 static void fixup_pgm_int(struct stack_frame_int *stack)
 {
 	/* If we have an error on SIE we directly move to sie_exit */
diff --git a/lib/s390x/mmu.c b/lib/s390x/mmu.c
index b474d7021d3f..9a179d6b8ec5 100644
--- a/lib/s390x/mmu.c
+++ b/lib/s390x/mmu.c
@@ -12,6 +12,7 @@
 #include <asm/pgtable.h>
 #include <asm/arch_def.h>
 #include <asm/barrier.h>
+#include <asm/interrupt.h>
 #include <vmalloc.h>
 #include "mmu.h"
 
@@ -41,8 +42,8 @@ static void mmu_enable(pgd_t *pgtable)
 	/* enable dat (primary == 0 set as default) */
 	enable_dat();
 
-	/* we can now also use DAT unconditionally in our PGM handler */
-	lowcore.pgm_new_psw.mask |= PSW_MASK_DAT;
+	/* we can now also use DAT in all interrupt handlers */
+	irq_set_dat_mode(true, AS_PRIM);
 }
 
 /*
-- 
2.41.0

