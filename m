Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Apr 2017 22:38:33 -0700
From: tip-bot for Christian Borntraeger <tipbot@zytor.com>
Message-ID: <tip-d9f8dfa9baf9b6ae1f2f84f887176558ecde5268@git.kernel.org>
Reply-To: mingo@kernel.org, borntraeger@de.ibm.com, tglx@linutronix.de,
        brueckner@linux.vnet.ibm.com, krebbel@linux.vnet.ibm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, hpa@zytor.com,
        acme@redhat.com
In-Reply-To: <1491465112-45819-3-git-send-email-borntraeger@de.ibm.com>
References: <1491465112-45819-3-git-send-email-borntraeger@de.ibm.com>
Subject: [tip:perf/core] perf annotate s390: Implement jump types for perf
 annotate
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: linux-s390@vger.kernel.org, krebbel@linux.vnet.ibm.com, peterz@infradead.org, linux-kernel@vger.kernel.org, acme@redhat.com, schwidefsky@de.ibm.com, hpa@zytor.com, borntraeger@de.ibm.com, mingo@kernel.org, tglx@linutronix.de, brueckner@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Commit-ID:  d9f8dfa9baf9b6ae1f2f84f887176558ecde5268
Gitweb:     http://git.kernel.org/tip/d9f8dfa9baf9b6ae1f2f84f887176558ecde5268
Author:     Christian Borntraeger <borntraeger@de.ibm.com>
AuthorDate: Thu, 6 Apr 2017 09:51:52 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Apr 2017 15:23:40 -0300

perf annotate s390: Implement jump types for perf annotate

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
index bfb2f1d..44ed665 100644
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
