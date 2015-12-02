Return-Path: <owner-linux-mm@kvack.org>
From: Yang Shi <yang.shi@linaro.org>
Subject: [PATCH V2 5/7] s390: mm/gup: add gup trace points
Date: Wed,  2 Dec 2015 14:53:31 -0800
Message-Id: <1449096813-22436-6-git-send-email-yang.shi@linaro.org>
In-Reply-To: <1449096813-22436-1-git-send-email-yang.shi@linaro.org>
References: <1449096813-22436-1-git-send-email-yang.shi@linaro.org>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linaro-kernel@lists.linaro.org, yang.shi@linaro.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/s390/mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/s390/mm/gup.c b/arch/s390/mm/gup.c
index 12bbf0e..ac25e28 100644
--- a/arch/s390/mm/gup.c
+++ b/arch/s390/mm/gup.c
@@ -10,6 +10,10 @@
 #include <linux/vmstat.h>
 #include <linux/pagemap.h>
 #include <linux/rwsem.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 #include <asm/pgtable.h>
 
 /*
@@ -188,6 +192,9 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	end = start + len;
 	if ((end <= start) || (end > TASK_SIZE))
 		return 0;
+
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	/*
 	 * local_irq_save() doesn't prevent pagetable teardown, but does
 	 * prevent the pagetables from being freed on s390.
-- 
2.0.2

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
