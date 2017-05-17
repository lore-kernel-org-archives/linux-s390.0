Return-Path: <stable-owner@vger.kernel.org>
Subject: Patch "perf annotate s390: Implement jump types for perf annotate" has been added to the 4.11-stable tree
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 May 2017 17:56:09 +0200
Message-ID: <149503656921911@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/stable/>
List-Post: <mailto:stable@vger.kernel.org>
To: borntraeger@de.ibm.com, acme@redhat.com, brueckner@linux.vnet.ibm.com, gregkh@linuxfoundation.org, krebbel@linux.vnet.ibm.com, linux-s390@vger.kernel.org, peterz@infradead.org, schwidefsky@de.ibm.com
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


This is a note to let you know that I've just added the patch titled

    perf annotate s390: Implement jump types for perf annotate

to the 4.11-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     perf-annotate-s390-implement-jump-types-for-perf-annotate.patch
and it can be found in the queue-4.11 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From d9f8dfa9baf9b6ae1f2f84f887176558ecde5268 Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 6 Apr 2017 09:51:52 +0200
Subject: perf annotate s390: Implement jump types for perf annotate

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


Patches currently in stable-queue which might be from borntraeger@de.ibm.com are

queue-4.11/perf-annotate-s390-implement-jump-types-for-perf-annotate.patch
queue-4.11/perf-annotate-s390-fix-perf-annotate-error-95-4.10-regression.patch
