Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 1/3] s390/dasd: Adjust buffer output in dasd_hosts_print()
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
Message-ID: <deb83447-9b77-d297-135c-a8af8055b3af@users.sourceforge.net>
Date: Wed, 10 May 2017 20:01:17 +0200
MIME-Version: 1.0
In-Reply-To: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 May 2017 18:52:28 +0200

* Use a special format string specification for the desired output of the
  array "pgid" into a sequence.

  This issue was detected by using the Coccinelle software.

* Delete the local variable "j" and a call of the function "seq_puts"
  wich became unnecessary with this refactoring.

Fixes: 5a3b7b112884f80ff19b18028fabeb4f9c035518 ("s390/dasd: add query host access to volume support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/block/dasd_eckd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 122456e4db89..b3709d3cba54 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -5288,7 +5288,7 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 	struct dasd_ckd_path_group_entry *entry;
 	struct dasd_ckd_host_information *info;
 	char sysplex[9] = "";
-	int rc, i, j;
+	int rc, i;
 
 	access = kzalloc(sizeof(*access), GFP_NOIO);
 	if (!access) {
@@ -5308,10 +5308,8 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 		entry = (struct dasd_ckd_path_group_entry *)
 			(info->entry + i * info->entry_size);
 		/* PGID */
-		seq_puts(m, "pgid ");
-		for (j = 0; j < 11; j++)
-			seq_printf(m, "%02x", entry->pgid[j]);
-		seq_putc(m, '\n');
+		seq_printf(m, "pgid %*phN\n",
+			   ARRAY_SIZE(entry->pgid), entry->pgid);
 		/* FLAGS */
 		seq_printf(m, "status_flags %02x\n", entry->status_flags);
 		/* SYSPLEX NAME */
-- 
2.12.3
