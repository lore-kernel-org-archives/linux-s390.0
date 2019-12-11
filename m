Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 126/134] s390/unwind: filter out unreliable bogus %r14
Date: Wed, 11 Dec 2019 10:11:42 -0500
Message-Id: <20191211151150.19073-126-sashal@kernel.org>
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit bf018ee644897d7982e1b8dd8b15e97db6e1a4da ]

Currently unwinder unconditionally returns %r14 from the first frame
pointed by %r15 from pt_regs. A task could be interrupted when a function
already allocated this frame (if it needs it) for its callees or to
store local variables. In that case this frame would contain random
values from stack or values stored there by a callee. As we are only
interested in %r14 to get potential return address, skip bogus return
addresses which doesn't belong to kernel text.

This helps to avoid duplicating filtering logic in unwider users, most
of which use unwind_get_return_address() and would choke on bogus 0
address returned by it otherwise.

Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/unwind_bc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/kernel/unwind_bc.c b/arch/s390/kernel/unwind_bc.c
index a8204f952315d..6e609b13c0cec 100644
--- a/arch/s390/kernel/unwind_bc.c
+++ b/arch/s390/kernel/unwind_bc.c
@@ -60,6 +60,11 @@ bool unwind_next_frame(struct unwind_state *state)
 		ip = READ_ONCE_NOCHECK(sf->gprs[8]);
 		reliable = false;
 		regs = NULL;
+		if (!__kernel_text_address(ip)) {
+			/* skip bogus %r14 */
+			state->regs = NULL;
+			return unwind_next_frame(state);
+		}
 	} else {
 		sf = (struct stack_frame *) state->sp;
 		sp = READ_ONCE_NOCHECK(sf->back_chain);
-- 
2.20.1
