Return-Path: <linux-kernel-owner+w=401wt.eu-S1755353AbYK0Khi@vger.kernel.org>
Message-Id: <20081127103132.813255499@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:30:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 18/60] dasd: improve dasd statistics proc interface
Content-Disposition: inline; filename=117-dasd-stats.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Haberland <stefan.haberland@de.ibm.com>

For a large number of I/O requests the values were shifted binary.
The shift was not transparent for the user because the shift value 
was not displayed. To make this interface more human readable the 
values are shifted decimal and the scale factor is displayed.

Signed-off-by: Stefan Haberland <stefan.haberland@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd_proc.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/block/dasd_proc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_proc.c
+++ quilt-2.6/drivers/s390/block/dasd_proc.c
@@ -180,12 +180,12 @@ dasd_calc_metrics(char *page, char **sta
 
 #ifdef CONFIG_DASD_PROFILE
 static char *
-dasd_statistics_array(char *str, unsigned int *array, int shift)
+dasd_statistics_array(char *str, unsigned int *array, int factor)
 {
 	int i;
 
 	for (i = 0; i < 32; i++) {
-		str += sprintf(str, "%7d ", array[i] >> shift);
+		str += sprintf(str, "%7d ", array[i] / factor);
 		if (i == 15)
 			str += sprintf(str, "\n");
 	}
@@ -202,7 +202,7 @@ dasd_statistics_read(char *page, char **
 #ifdef CONFIG_DASD_PROFILE
 	struct dasd_profile_info_t *prof;
 	char *str;
-	int shift;
+	int factor;
 
 	/* check for active profiling */
 	if (dasd_profile_level == DASD_PROFILE_OFF) {
@@ -214,12 +214,14 @@ dasd_statistics_read(char *page, char **
 
 	prof = &dasd_global_profile;
 	/* prevent couter 'overflow' on output */
-	for (shift = 0; (prof->dasd_io_reqs >> shift) > 9999999; shift++);
+	for (factor = 1; (prof->dasd_io_reqs / factor) > 9999999;
+	     factor *= 10);
 
 	str = page;
 	str += sprintf(str, "%d dasd I/O requests\n", prof->dasd_io_reqs);
-	str += sprintf(str, "with %d sectors(512B each)\n",
+	str += sprintf(str, "with %u sectors(512B each)\n",
 		       prof->dasd_io_sects);
+	str += sprintf(str, "Scale Factor is  %d\n", factor);
 	str += sprintf(str,
 		       "   __<4	   ___8	   __16	   __32	   __64	   _128	"
 		       "   _256	   _512	   __1k	   __2k	   __4k	   __8k	"
@@ -230,22 +232,22 @@ dasd_statistics_read(char *page, char **
 		       "   __1G	   __2G	   __4G " "   _>4G\n");
 
 	str += sprintf(str, "Histogram of sizes (512B secs)\n");
-	str = dasd_statistics_array(str, prof->dasd_io_secs, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_secs, factor);
 	str += sprintf(str, "Histogram of I/O times (microseconds)\n");
-	str = dasd_statistics_array(str, prof->dasd_io_times, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_times, factor);
 	str += sprintf(str, "Histogram of I/O times per sector\n");
-	str = dasd_statistics_array(str, prof->dasd_io_timps, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_timps, factor);
 	str += sprintf(str, "Histogram of I/O time till ssch\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time1, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_time1, factor);
 	str += sprintf(str, "Histogram of I/O time between ssch and irq\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time2, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_time2, factor);
 	str += sprintf(str, "Histogram of I/O time between ssch "
 			    "and irq per sector\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time2ps, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_time2ps, factor);
 	str += sprintf(str, "Histogram of I/O time between irq and end\n");
-	str = dasd_statistics_array(str, prof->dasd_io_time3, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_time3, factor);
 	str += sprintf(str, "# of req in chanq at enqueuing (1..32) \n");
-	str = dasd_statistics_array(str, prof->dasd_io_nr_req, shift);
+	str = dasd_statistics_array(str, prof->dasd_io_nr_req, factor);
 	len = str - page;
 #else
 	len = sprintf(page, "Statistics are not activated in this kernel\n");

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
