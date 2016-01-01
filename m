Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] s390: fix normalization bug in exception table sorting
Date: Fri,  1 Jan 2016 13:39:22 +0100
Message-Id: <1451651962-4180-1-git-send-email-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-ID: <linux-s390.vger.kernel.org>

The normalization pass in the sorting routine of the relative exception
table serves two purposes:
- it ensures that the address fields of the exception table entries are
  fully ordered, so that no ambiguities arise between entries with
  identical instruction offsets (i.e., when two instructions that are
  exactly 8 bytes apart each have an exception table entry associated with
  them)
- it ensures that the offsets of both the instruction and the fixup fields
  of each entry are relative to their final location after sorting.

Commit eb608fb366de ("s390/exceptions: switch to relative exception table
entries") ported the relative exception table format from x86, but modified
the sorting routine to only normalize the instruction offset field and not
the fixup offset field. The result is that the fixup offset of each entry
will be relative to the original location of the entry before sorting,
likely leading to crashes when those entries are dereferenced.

Fixes: eb608fb366de ("s390/exceptions: switch to relative exception table entries")
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/s390/mm/extable.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
index 4d1ee88864e8..18c8b819b0aa 100644
--- a/arch/s390/mm/extable.c
+++ b/arch/s390/mm/extable.c
@@ -52,12 +52,16 @@ void sort_extable(struct exception_table_entry *start,
 	int i;
 
 	/* Normalize entries to being relative to the start of the section */
-	for (p = start, i = 0; p < finish; p++, i += 8)
+	for (p = start, i = 0; p < finish; p++, i += 8) {
 		p->insn += i;
+		p->fixup += i + 4;
+	}
 	sort(start, finish - start, sizeof(*start), cmp_ex, NULL);
 	/* Denormalize all entries */
-	for (p = start, i = 0; p < finish; p++, i += 8)
+	for (p = start, i = 0; p < finish; p++, i += 8) {
 		p->insn -= i;
+		p->fixup -= i + 4;
+	}
 }
 
 #ifdef CONFIG_MODULES
-- 
1.9.1
