Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.10 20/69] perf annotate s390: Fix perf annotate error -95 (4.10 regression)
Date: Wed, 19 Apr 2017 16:36:49 +0200
Message-Id: <20170419141555.950398919@linuxfoundation.org>
In-Reply-To: <20170419141555.114738231@linuxfoundation.org>
References: <20170419141555.114738231@linuxfoundation.org>
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

commit 3c1a427954399fd1bda1ee7e1b356f47b61cee74 upstream.

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
