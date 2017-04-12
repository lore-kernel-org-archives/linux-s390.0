Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 11 Apr 2017 22:37:58 -0700
From: tip-bot for Christian Borntraeger <tipbot@zytor.com>
Message-ID: <tip-e77852b32d6d4430c68c38aaf73efe5650fa25af@git.kernel.org>
Reply-To: linux-s390@vger.kernel.org, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        hpa@zytor.com, borntraeger@de.ibm.com, krebbel@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, brueckner@linux.vnet.ibm.com
In-Reply-To: <1491465112-45819-2-git-send-email-borntraeger@de.ibm.com>
References: <1491465112-45819-2-git-send-email-borntraeger@de.ibm.com>
Subject: [tip:perf/core] perf annotate s390: Fix perf annotate error -95
 (4.10 regression)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: hpa@zytor.com, schwidefsky@de.ibm.com, krebbel@linux.vnet.ibm.com, borntraeger@de.ibm.com, brueckner@linux.vnet.ibm.com, acme@redhat.com, linux-s390@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org
List-ID: <linux-s390.vger.kernel.org>

Commit-ID:  e77852b32d6d4430c68c38aaf73efe5650fa25af
Gitweb:     http://git.kernel.org/tip/e77852b32d6d4430c68c38aaf73efe5650fa25af
Author:     Christian Borntraeger <borntraeger@de.ibm.com>
AuthorDate: Thu, 6 Apr 2017 09:51:51 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 11 Apr 2017 15:23:39 -0300

perf annotate s390: Fix perf annotate error -95 (4.10 regression)

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
index a37032b..bfb2f1d 100644
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
