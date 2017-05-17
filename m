Return-Path: <stable-owner@vger.kernel.org>
Subject: Patch "perf annotate s390: Fix perf annotate error -95 (4.10 regression)" has been added to the 4.11-stable tree
From: <gregkh@linuxfoundation.org>
Date: Wed, 17 May 2017 17:56:09 +0200
Message-ID: <1495036569193236@kroah.com>
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

    perf annotate s390: Fix perf annotate error -95 (4.10 regression)

to the 4.11-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     perf-annotate-s390-fix-perf-annotate-error-95-4.10-regression.patch
and it can be found in the queue-4.11 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From e77852b32d6d4430c68c38aaf73efe5650fa25af Mon Sep 17 00:00:00 2001
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 6 Apr 2017 09:51:51 +0200
Subject: perf annotate s390: Fix perf annotate error -95 (4.10 regression)

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit e77852b32d6d4430c68c38aaf73efe5650fa25af upstream.

since 4.10 perf annotate exits on s390 with an "unknown error -95".
Turns out that commit 786c1b51844d ("perf annotate: Start supporting
cross arch annotation") added a hard requirement for architecture
support when objdump is used but only provided x86 and arm support.
Meanwhile power was added so lets add s390 as well.

While at it make sure to implement the branch and jump types.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andreas Krebbel <krebbel@linux.vnet.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>
Fixes: 786c1b51844 "perf annotate: Start supporting cross arch annotation"
Link: http://lkml.kernel.org/r/1491465112-45819-2-git-send-email-borntraeger@de.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/annotate.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -136,6 +136,12 @@ static struct arch architectures[] = {
 			.comment_char = '#',
 		},
 	},
+	{
+		.name = "s390",
+		.objdump =  {
+			.comment_char = '#',
+		},
+	},
 };
 
 static void ins__delete(struct ins_operands *ops)


Patches currently in stable-queue which might be from borntraeger@de.ibm.com are

queue-4.11/perf-annotate-s390-implement-jump-types-for-perf-annotate.patch
queue-4.11/perf-annotate-s390-fix-perf-annotate-error-95-4.10-regression.patch
