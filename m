Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BF7C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 29 Apr 2021 09:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DB36143E
	for <linux-s390@archiver.kernel.org>; Thu, 29 Apr 2021 09:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhD2JQD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Apr 2021 05:16:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236871AbhD2JQB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 29 Apr 2021 05:16:01 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13T94I2u092902;
        Thu, 29 Apr 2021 05:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=BzxzFNxINp+zQtTmgMnSaN4USUAAED0yk5zleYSowbI=;
 b=irYtMlS2C8yLEL19HYNcCw8eokwLFJ6gqobsyxd+YQEi2f5hSWPSyy5gc/0SUEyWCocG
 NE146fWimsILgbaWsZuX95HinO6a7Gfunv41WbBXrmalYDVszVra8g3mVJiUUrzuc2hn
 Nia1iRH8to4N8/QqnObaQtuSUB3RwgdI0QQa/D6SPRXhWw3noXoirlhhPAO6KMGp/lw0
 Pa1+h7vJzHPOKQjTGRZMWXufp4p4UTmH+E6/9BHh8+4gFJPGLSfdsuzE5/KrDPE48ukI
 CVnz1LLabb/V1O5PzBiO3BZQdE9tzELZoucddx56Li8CDUWUrJqapz0FON77rwdsmSe6 4A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 387sca180r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 05:15:09 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13T98Jjd007664;
        Thu, 29 Apr 2021 09:15:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 384ay8jakq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Apr 2021 09:15:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13T9Edae35520920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 09:14:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6139A4060;
        Thu, 29 Apr 2021 09:15:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3646A405C;
        Thu, 29 Apr 2021 09:15:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 29 Apr 2021 09:15:03 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 5612DE03C3; Thu, 29 Apr 2021 11:15:03 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] s390/entry: add support for syscall stack randomization
Date:   Thu, 29 Apr 2021 11:14:51 +0200
Message-Id: <20210429091451.1062594-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QUBzrmEl-oclbW7pe-Jogo6lQ92GFhOW
X-Proofpoint-GUID: QUBzrmEl-oclbW7pe-Jogo6lQ92GFhOW
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-29_05:2021-04-28,2021-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290064
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This adds support for adding a random offset to the stack while handling
syscalls. The patch uses get_tod_clock_fast() as this is considered good
enough and has much less performance penalty compared to using
get_random_int(). The patch also adds randomization in pgm_check_handler()
as the sigreturn/rt_sigreturn system calls might be called from there.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/Kconfig                    |  1 +
 arch/s390/include/asm/entry-common.h | 10 ++++++++++
 arch/s390/kernel/syscall.c           |  1 +
 arch/s390/kernel/traps.c             |  2 ++
 4 files changed, 14 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c1ff874e6c2e..1900428ce557 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -137,6 +137,7 @@ config S390
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN
 	select HAVE_ARCH_KASAN_VMALLOC
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index 9cceb26ed63f..baa8005090c3 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -4,9 +4,11 @@
 
 #include <linux/sched.h>
 #include <linux/audit.h>
+#include <linux/randomize_kstack.h>
 #include <linux/tracehook.h>
 #include <linux/processor.h>
 #include <linux/uaccess.h>
+#include <asm/timex.h>
 #include <asm/fpu/api.h>
 
 #define ARCH_EXIT_TO_USER_MODE_WORK (_TIF_GUARDED_STORAGE | _TIF_PER_TRAP)
@@ -48,6 +50,14 @@ static __always_inline void arch_exit_to_user_mode(void)
 
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
+}
+
+#define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
+
 static inline bool on_thread_stack(void)
 {
 	return !(((unsigned long)(current->stack) ^ current_stack_pointer()) & ~(THREAD_SIZE - 1));
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index bc8e650e377d..4e5cc7d2364e 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -142,6 +142,7 @@ void do_syscall(struct pt_regs *regs)
 
 void noinstr __do_syscall(struct pt_regs *regs, int per_trap)
 {
+	add_random_kstack_offset();
 	enter_from_user_mode(regs);
 
 	memcpy(&regs->gprs[8], S390_lowcore.save_area_sync, 8 * sizeof(unsigned long));
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 63021d484626..8dd23c703718 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -17,6 +17,7 @@
 #include "asm/ptrace.h"
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
+#include <linux/randomize_kstack.h>
 #include <linux/extable.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
@@ -301,6 +302,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	unsigned int trapnr, syscall_redirect = 0;
 	irqentry_state_t state;
 
+	add_random_kstack_offset();
 	regs->int_code = *(u32 *)&S390_lowcore.pgm_ilc;
 	regs->int_parm_long = S390_lowcore.trans_exc_code;
 
-- 
2.25.1

