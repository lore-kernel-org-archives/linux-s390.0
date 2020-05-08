Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:4306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgEHOHy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 8 May 2020 10:07:54 -0400
From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] s390: Remove two unused inline functions
Date: Fri, 8 May 2020 22:07:24 +0800
Message-ID: <20200508140724.11324-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: rostedt@goodmis.org, mingo@redhat.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>

commit 657480d9c015 ("s390: support KPROBES_ON_FTRACE")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/s390/kernel/ftrace.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 4cd9b1ada834..44e01dd1e624 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -72,22 +72,6 @@ static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
 #endif
 }
 
-static inline void ftrace_generate_kprobe_nop_insn(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_KPROBES
-	insn->opc = BREAKPOINT_INSTRUCTION;
-	insn->disp = KPROBE_ON_FTRACE_NOP;
-#endif
-}
-
-static inline void ftrace_generate_kprobe_call_insn(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_KPROBES
-	insn->opc = BREAKPOINT_INSTRUCTION;
-	insn->disp = KPROBE_ON_FTRACE_CALL;
-#endif
-}
-
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
-- 
2.17.1
