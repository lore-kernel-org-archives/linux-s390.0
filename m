Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/2] perf/s390: implement jump types for perf annotate
Date: Thu,  6 Apr 2017 09:51:52 +0200
In-Reply-To: <1491465112-45819-1-git-send-email-borntraeger@de.ibm.com>
References: <1491465112-45819-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1491465112-45819-3-git-send-email-borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: linux-kernel@vger.kernel.org, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Implement simple detection for all kind of jumps and branches.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 tools/perf/arch/s390/annotate/instructions.c | 30 ++++++++++++++++++++++++++++
 tools/perf/util/annotate.c                   |  2 ++
 2 files changed, 32 insertions(+)
 create mode 100644 tools/perf/arch/s390/annotate/instructions.c

diff --git a/tools/perf/arch/s390/annotate/instructions.c b/tools/perf/arch/s390/annotate/instructions.c
new file mode 100644
index 0000000..745b4b1
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
index 7aa5722..2cc02f6 100644
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
2.7.4
