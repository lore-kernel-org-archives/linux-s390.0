Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51385F79.7000106@huawei.com>
Date: Thu, 7 Mar 2013 17:35:53 +0800
From: Li Zefan <lizefan@huawei.com>
MIME-Version: 1.0
Subject: [PATCH][RESEND] s390: Fix a build error
References: <5137EB66.9050509@huawei.com>
In-Reply-To: <5137EB66.9050509@huawei.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Commit 877c685607925238e302cd3aa38788dca6c1b226
("perf: Remove include of cgroup.h from perf_event.h") caused this:

   In file included from arch/s390/include/asm/perf_event.h:9:0,
                    from include/linux/perf_event.h:24,
                    from kernel/events/ring_buffer.c:12:
   arch/s390/include/asm/cpu_mf.h: In function 'qctri':
   arch/s390/include/asm/cpu_mf.h:61:12: error: 'EINVAL' undeclared
   (first use in this function)

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Tested-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Li Zefan <lizefan@huawei.com>
---

CC LKML, and add tested-by tag.

---
 arch/s390/include/asm/cpu_mf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index f1eddd1..c879fad 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -12,6 +12,7 @@
 #ifndef _ASM_S390_CPU_MF_H
 #define _ASM_S390_CPU_MF_H
 
+#include <linux/errno.h>
 #include <asm/facility.h>
 
 #define CPU_MF_INT_SF_IAE	(1 << 31)	/* invalid entry address */
-- 
1.8.0.2
