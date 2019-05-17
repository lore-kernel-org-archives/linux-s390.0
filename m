Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] s390: add unreachable() to dump_fault_info() to fix -Wmaybe-uninitialized
Date: Fri, 17 May 2019 15:49:22 +0900
Message-Id: <20190517064922.22743-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Souptick Joarder <jrdr.linux@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Philipp Rudo <prudo@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When CONFIG_OPTIMIZE_INLINING is enabled for s390, I see this warning:

arch/s390/mm/fault.c:127:15: warning: 'asce' may be used uninitialized in this function [-Wmaybe-uninitialized]
  switch (asce & _ASCE_TYPE_MASK) {
arch/s390/mm/fault.c:177:16: note: 'asce' was declared here
  unsigned long asce;
                ^~~~

If get_fault_type() is not inlined, the compiler cannot deduce that
all the possible paths in the 'switch' statement are covered.

Of course, we could mark get_fault_type() as __always_inline to get
back the original behavior, but I do not think it sensible to force
inlining just for the purpose of suppressing the warning. Since this
is just a matter of warning, I want to keep as much room for compiler
optimization as possible.

I added unreachable() to teach the compiler that the 'default' label
is unreachable.

I got rid of the 'inline' marker. Even without the 'inline' hint,
the compiler inlines functions based on its inlining heuristic.

Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/mm/fault.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index c220399ae196..91ce03fd0c84 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -85,7 +85,7 @@ static inline int notify_page_fault(struct pt_regs *regs)
  * Find out which address space caused the exception.
  * Access register mode is impossible, ignore space == 3.
  */
-static inline enum fault_type get_fault_type(struct pt_regs *regs)
+static enum fault_type get_fault_type(struct pt_regs *regs)
 {
 	unsigned long trans_exc_code;
 
@@ -211,6 +211,8 @@ static void dump_fault_info(struct pt_regs *regs)
 		asce = S390_lowcore.kernel_asce;
 		pr_cont("kernel ");
 		break;
+	default:
+		unreachable();
 	}
 	pr_cont("ASCE.\n");
 	dump_pagetable(asce, regs->int_parm_long & __FAIL_ADDR_MASK);
-- 
2.17.1
