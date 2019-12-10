Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 183/350] s390: add error handling to perf_callchain_kernel
Date: Tue, 10 Dec 2019 16:04:48 -0500
Message-Id: <20191210210735.9077-144-sashal@kernel.org>
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Ilya Leoshkevich <iii@linux.ibm.com>

[ Upstream commit effb83ccc83a97dbbe5214f4c443522719f05f3a ]

perf_callchain_kernel stops neither when it encounters a garbage
address, nor when it runs out of space. Fix both issues using x86
version as an inspiration.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_event.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index fcb6c2e92b071..1e75cc9835468 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -224,9 +224,13 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 			   struct pt_regs *regs)
 {
 	struct unwind_state state;
+	unsigned long addr;
 
-	unwind_for_each_frame(&state, current, regs, 0)
-		perf_callchain_store(entry, state.ip);
+	unwind_for_each_frame(&state, current, regs, 0) {
+		addr = unwind_get_return_address(&state);
+		if (!addr || perf_callchain_store(entry, addr))
+			return;
+	}
 }
 
 /* Perf definitions for PMU event attributes in sysfs */
-- 
2.20.1
