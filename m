Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/18] perf annotate s390: Fix perf annotate error -95 (4.10 regression)
Date: Tue, 11 Apr 2017 21:52:06 -0300
Message-Id: <20170412005215.30135-10-acme@kernel.org>
In-Reply-To: <20170412005215.30135-1-acme@kernel.org>
References: <20170412005215.30135-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Peter Zijlstra <peterz@infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, stable@kernel.org, #@infradead.org, v4.10+@infradead.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

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
Cc: stable@kernel.org # v4.10+
Fixes: 786c1b51844 "perf annotate: Start supporting cross arch annotation"
Link: http://lkml.kernel.org/r/1491465112-45819-2-git-send-email-borntraeger@de.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a37032bd137d..bfb2f1d393d5 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -130,6 +130,12 @@ static struct arch architectures[] = {
 		.name = "powerpc",
 		.init = powerpc__annotate_init,
 	},
+	{
+		.name = "s390",
+		.objdump =  {
+			.comment_char = '#',
+		},
+	},
 };
 
 static void ins__delete(struct ins_operands *ops)
-- 
2.9.3
