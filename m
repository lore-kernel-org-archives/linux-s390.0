Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbfK2HmF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 29 Nov 2019 02:42:05 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAT7g3hl089725
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 02:42:04 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wjp2edygf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 29 Nov 2019 02:42:03 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gor@linux.ibm.com>;
        Fri, 29 Nov 2019 07:41:54 -0000
Date: Fri, 29 Nov 2019 08:41:48 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v4 1/2] s390/unwind: add stack pointer alignment sanity checks
References: <20191106095601.29986-5-mbenes@suse.cz>
 <cover.thread-a0061f.your-ad-here.call-01575012971-ext-9115@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-a0061f.your-ad-here.call-01575012971-ext-9115@work.hours>
Message-Id: <patch-1.thread-a0061f.git-617139935cc4.your-ad-here.call-01575012971-ext-9115@work.hours>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

ABI requires SP to be aligned 8 bytes, report unwinding error otherwise.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/kernel/dumpstack.c | 4 ++++
 arch/s390/kernel/unwind_bc.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index d74e21a23703..d306fe04489a 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -94,6 +94,10 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	if (!sp)
 		goto unknown;
 
+	/* Sanity check: ABI requires SP to be aligned 8 bytes. */
+	if (sp & 0x7)
+		goto unknown;
+
 	/* Check per-task stack */
 	if (in_task_stack(sp, task, info))
 		goto recursion_check;
diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.c
index ef42d5f77ce7..da2d4d4c5b0e 100644
--- a/arch/s390/kernel/unwind_bc.c
+++ b/arch/s390/kernel/unwind_bc.c
@@ -92,6 +92,10 @@ bool unwind_next_frame(struct unwind_state *state)
 		}
 	}
 
+	/* Sanity check: ABI requires SP to be aligned 8 bytes. */
+	if (sp & 0x7)
+		goto out_err;
+
 	ip = ftrace_graph_ret_addr(state->task, &state->graph_idx, ip, (void *) sp);
 
 	/* Update unwind state */
-- 
2.21.0
