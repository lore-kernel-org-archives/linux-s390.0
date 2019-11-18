Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35954 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726460AbfKRLMp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Nov 2019 06:12:45 -0500
From: Hannes Reinecke <hare@suse.de>
Subject: [PATCH] dasd_fba: Display '00000000' for zero page when dumping sense
Date: Mon, 18 Nov 2019 12:12:26 +0100
Message-Id: <20191118111226.56666-1-hare@suse.de>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jan Hoeppner <hoeppner@linux.ibm.com>
Cc: Stefan Haberland <sth@linux.ibm.com>, linux-s390@vger.kernel.org, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>, Sebastian Parschauer <sparschauer@suse.de>

When a discard I/O fails, dasd_fba_dump_sense() will crash as it
tries to print out the CCW, and failing to take into account that
for discard I/O we have only one data pointer, not one per sg.
As the data pointer will always point to the zero page this patch
replaces the data pointer output with '00000000' to avoid the crash.

Signed-off-by: Hannes Reinecke <hare@suse.com>
[sparschauer: replaced "ccw" with "act", "snprintf" with "sprintf"]
[sparschauer v2: added missing curly braces to for loops]
Signed-off-by: Sebastian Parschauer <sparschauer@suse.de>
---
 drivers/s390/block/dasd_fba.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index cbb770824226..4b867bd6b164 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -717,10 +717,15 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 			       " CCW %p: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
-		     count += sizeof(int))
+		     count += sizeof(int)) {
+			if (act->flags & CCW_FLAG_SLI) {
+				len += sprintf(page + len, " 00000000");
+				break;
+			}
 			len += sprintf(page + len, " %08X",
 				       ((int *) (addr_t) act->cda)
 				       [(count>>2)]);
+		}
 		len += sprintf(page + len, "\n");
 		act++;
 	}
@@ -739,10 +744,15 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 			       " CCW %p: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
-		     count += sizeof(int))
+		     count += sizeof(int)) {
+			if (act->flags & CCW_FLAG_SLI) {
+				len += sprintf(page + len, " 00000000");
+				break;
+			}
 			len += sprintf(page + len, " %08X",
 				       ((int *) (addr_t) act->cda)
 				       [(count>>2)]);
+		}
 		len += sprintf(page + len, "\n");
 		act++;
 	}
@@ -757,10 +767,15 @@ dasd_fba_dump_sense(struct dasd_device *device, struct dasd_ccw_req * req,
 			       " CCW %p: %08X %08X DAT:",
 			       act, ((int *) act)[0], ((int *) act)[1]);
 		for (count = 0; count < 32 && count < act->count;
-		     count += sizeof(int))
+		     count += sizeof(int)) {
+			if (act->flags & CCW_FLAG_SLI) {
+				len += sprintf(page + len, " 00000000");
+				break;
+			}
 			len += sprintf(page + len, " %08X",
 				       ((int *) (addr_t) act->cda)
 				       [(count>>2)]);
+		}
 		len += sprintf(page + len, "\n");
 		act++;
 	}
-- 
2.16.4
