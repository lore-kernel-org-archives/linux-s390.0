Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/18] perf annotate s390: Implement jump types for perf annotate
Date: Tue, 11 Apr 2017 21:52:07 -0300
Message-Id: <20170412005215.30135-11-acme@kernel.org>
In-Reply-To: <20170412005215.30135-1-acme@kernel.org>
References: <20170412005215.30135-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, stable@kernel.org, #@infradead.org, v4.10+@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

Implement simple detection for all kind of jumps and branches.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andreas Krebbel <krebbel@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>
Cc: stable@kernel.org # v4.10+
Link: http://lkml.kernel.org/r/1491465112-45819-3-git-send-email-borntraeger@de.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 30 ++++++++++++++++++++++++++++
 tools/perf/util/annotate.c                   |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100644 tools/perf/arch/s390/annotate/instructions.c

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
new file mode 100644
index 000000000000..745b4b1b8b21
--- /dev/null
+++ b/tools/perf/arch/s390/annotate/instructions.c
@@ -0,0 +1,30 @@
+static struct ins_ops *s390__associate_ins_ops(struct arch *arch, const char *name)
+{
+	struct ins_ops *ops = NULL;
+
+	/* catch all kind of jumps */
+	if (strchr(name, 'j') ||
+	    !strncmp(name, "bct", 3) ||
+	    !strncmp(name, "br", 2))
+		ops = &jump_ops;
+	/* override call/returns */
+	if (!strcmp(name, "bras") ||
+	    !strcmp(name, "brasl") ||
+	    !strcmp(name, "basr"))
+		ops = &call_ops;
+	if (!strcmp(name, "br"))
+		ops = &ret_ops;
+
+	arch__associate_ins_ops(arch, name, ops);
+	return ops;
+}
+
+static int s390__annotate_init(struct arch *arch)
+{
+	if (!arch->initialized) {
+		arch->initialized = true;
+		arch->associate_instruction_ops = s390__associate_ins_ops;
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bfb2f1d393d5..44ed6652b02f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -108,6 +108,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
 #include "arch/arm64/annotate/instructions.c"
 #include "arch/x86/annotate/instructions.c"
 #include "arch/powerpc/annotate/instructions.c"
+#include "arch/s390/annotate/instructions.c"
 
 static struct arch architectures[] = {
 	{
@@ -132,6 +133,7 @@ static struct arch architectures[] = {
 	},
 	{
 		.name = "s390",
+		.init = s390__annotate_init,
 		.objdump =  {
 			.comment_char = '#',
 		},
-- 
2.9.3
