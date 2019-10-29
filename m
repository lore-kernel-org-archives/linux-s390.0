Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389024AbfJ2OjI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Oct 2019 10:39:08 -0400
From: Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 1/3] s390/unwind: drop unnecessary code around calling ftrace_graph_ret_addr()
Date: Tue, 29 Oct 2019 15:39:02 +0100
Message-Id: <20191029143904.24051-2-mbenes@suse.cz>
In-Reply-To: <20191029143904.24051-1-mbenes@suse.cz>
References: <20191029143904.24051-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, jpoimboe@redhat.com, joe.lawrence@redhat.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>

The current code around calling ftrace_graph_ret_addr() is ifdeffed and
also tests if ftrace redirection is present on stack.
ftrace_graph_ret_addr() however performs the test internally and there
is a version for !CONFIG_FUNCTION_GRAPH_TRACER as well. The unnecessary
code can thus be dropped.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/s390/kernel/unwind_bc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.c
index 8fc9daae47a2..b407b5531f11 100644
--- a/arch/s390/kernel/unwind_bc.c
+++ b/arch/s390/kernel/unwind_bc.c
@@ -80,12 +80,8 @@ bool unwind_next_frame(struct unwind_state *state)
 		}
 	}
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	/* Decode any ftrace redirection */
-	if (ip == (unsigned long) return_to_handler)
-		ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
-					   ip, (void *) sp);
-#endif
+	ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+				   ip, (void *) sp);
 
 	/* Update unwind state */
 	state->sp = sp;
@@ -140,12 +136,8 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
 		reliable = false;
 	}
 
-#ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	/* Decode any ftrace redirection */
-	if (ip == (unsigned long) return_to_handler)
-		ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
-					   ip, NULL);
-#endif
+	ip = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+				   ip, NULL);
 
 	/* Update unwind state */
 	state->sp = sp;
-- 
2.23.0
