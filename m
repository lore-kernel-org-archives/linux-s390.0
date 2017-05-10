Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 3/3] s390/dasd: Adjust six checks for null pointers
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
Message-ID: <1395faca-9953-5873-0892-3d2eedbef2b6@users.sourceforge.net>
Date: Wed, 10 May 2017 20:03:08 +0200
MIME-Version: 1.0
In-Reply-To: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 May 2017 19:29:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/block/dasd_eckd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index e78601d97a67..d02f3bbbd552 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1080,7 +1080,7 @@ static int dasd_eckd_read_conf(struct dasd_device *device)
 					"error %d", rc);
 			return rc;
 		}
-		if (conf_data == NULL) {
+		if (!conf_data) {
 			DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
 					"No configuration data "
 					"retrieved");
@@ -2049,7 +2049,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 				 "Track 0 has no records following the VTOC\n");
 	}
 
-	if (count_area != NULL && count_area->kl == 0) {
+	if (count_area && count_area->kl == 0) {
 		/* we found notthing violating our disk layout */
 		if (dasd_check_blocksize(count_area->dl) == 0)
 			block->bp_block = count_area->dl;
@@ -2649,10 +2649,10 @@ static int dasd_eckd_format_process_data(struct dasd_device *base,
 	old_start = fdata->start_unit;
 	old_stop = fdata->stop_unit;
 
-	if (!tpm && fmt_buffer != NULL) {
+	if (!tpm && fmt_buffer) {
 		/* Command Mode / Format Check */
 		format_step = 1;
-	} else if (tpm && fmt_buffer != NULL) {
+	} else if (tpm && fmt_buffer) {
 		/* Transport Mode / Format Check */
 		format_step = DASD_CQR_MAX_CCW / rpt;
 	} else {
@@ -4681,7 +4681,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 	int len, sl, sct;
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
-	if (page == NULL) {
+	if (!page) {
 		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
 			      "No memory to dump sense data\n");
 		return;
@@ -4785,7 +4785,7 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 	u8 *sense, *rcq;
 
 	page = (char *) get_zeroed_page(GFP_ATOMIC);
-	if (page == NULL) {
+	if (!page) {
 		DBF_DEV_EVENT(DBF_WARNING, device, " %s",
 			    "No memory to dump sense data");
 		return;
-- 
2.12.3
