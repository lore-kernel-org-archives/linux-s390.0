Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] s390/dasd: Simplify code
Date: Sat,  9 Dec 2017 07:29:26 +0100
Message-Id: <20171209062926.31515-1-christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: sth@linux.vnet.ibm.com, hoeppner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-ID: <linux-s390.vger.kernel.org>

Use 'seq_printf(m, "...%*phN...")' instead of duplicating its
implementation.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/s390/block/dasd_eckd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index a2edf2a7ace9..29397a9dba68 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -5231,7 +5231,7 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 	struct dasd_ckd_path_group_entry *entry;
 	struct dasd_ckd_host_information *info;
 	char sysplex[9] = "";
-	int rc, i, j;
+	int rc, i;
 
 	access = kzalloc(sizeof(*access), GFP_NOIO);
 	if (!access) {
@@ -5251,10 +5251,7 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 		entry = (struct dasd_ckd_path_group_entry *)
 			(info->entry + i * info->entry_size);
 		/* PGID */
-		seq_puts(m, "pgid ");
-		for (j = 0; j < 11; j++)
-			seq_printf(m, "%02x", entry->pgid[j]);
-		seq_putc(m, '\n');
+		seq_printf(m, "pgid %*phN\n", 11, entry->pgid);
 		/* FLAGS */
 		seq_printf(m, "status_flags %02x\n", entry->status_flags);
 		/* SYSPLEX NAME */
-- 
2.14.1
