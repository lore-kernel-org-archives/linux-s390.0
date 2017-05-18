Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.10 51/93] perf annotate s390: Implement jump types for perf annotate
Date: Thu, 18 May 2017 12:47:20 +0200
Message-Id: <20170518104745.202740967@linuxfoundation.org>
In-Reply-To: <20170518104743.163522815@linuxfoundation.org>
References: <20170518104743.163522815@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

4.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit d9f8dfa9baf9b6ae1f2f84f887176558ecde5268 upstream.

Implement simple detection for all kind of jumps and branches.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andreas Krebbel <krebbel@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>
Link: http://lkml.kernel.org/r/1491465112-45819-3-git-send-email-borntraeger@de.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/arch/s390/annotate/instructions.c |   30 +++++++++++++++++++++++++++
 tools/perf/util/annotate.c                   |    2 +
 2 files changed, 32 insertions(+)

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
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -108,6 +108,7 @@ static int arch__associate_ins_ops(struc
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
