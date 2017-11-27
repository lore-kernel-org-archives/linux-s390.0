Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] s390/dasd: remove 'struct timespec' usage
Date: Mon, 27 Nov 2017 12:46:57 +0100
Message-Id: <20171127114715.2731901-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Sebastian Ott <sebott@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

getnstimeofday() and timespec are deprecated since they can
overflow on 32-bit architectures. This simply changes to the
explicitly typed timespec64 version that doesn't have that
problem.

It would be nice to also convert to monotonic timestamps
and call ktime_get_ts64() rather than ktime_get_real_ts64(),
but that would be a user-visible change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/block/dasd.c     | 10 +++++-----
 drivers/s390/block/dasd_int.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 0f1ff0813493..f48b3d5082cf 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -758,7 +758,7 @@ static void dasd_profile_end_add_data(struct dasd_profile_info *data,
 	/* in case of an overflow, reset the whole profile */
 	if (data->dasd_io_reqs == UINT_MAX) {
 			memset(data, 0, sizeof(*data));
-			getnstimeofday(&data->starttod);
+			ktime_get_real_ts64(&data->starttod);
 	}
 	data->dasd_io_reqs++;
 	data->dasd_io_sects += sectors;
@@ -893,7 +893,7 @@ void dasd_profile_reset(struct dasd_profile *profile)
 		return;
 	}
 	memset(data, 0, sizeof(*data));
-	getnstimeofday(&data->starttod);
+	ktime_get_real_ts64(&data->starttod);
 	spin_unlock_bh(&profile->lock);
 }
 
@@ -910,7 +910,7 @@ int dasd_profile_on(struct dasd_profile *profile)
 		kfree(data);
 		return 0;
 	}
-	getnstimeofday(&data->starttod);
+	ktime_get_real_ts64(&data->starttod);
 	profile->data = data;
 	spin_unlock_bh(&profile->lock);
 	return 0;
@@ -994,8 +994,8 @@ static void dasd_stats_array(struct seq_file *m, unsigned int *array)
 static void dasd_stats_seq_print(struct seq_file *m,
 				 struct dasd_profile_info *data)
 {
-	seq_printf(m, "start_time %ld.%09ld\n",
-		   data->starttod.tv_sec, data->starttod.tv_nsec);
+	seq_printf(m, "start_time %lld.%09ld\n",
+		   (s64)data->starttod.tv_sec, data->starttod.tv_nsec);
 	seq_printf(m, "total_requests %u\n", data->dasd_io_reqs);
 	seq_printf(m, "total_sectors %u\n", data->dasd_io_sects);
 	seq_printf(m, "total_pav %u\n", data->dasd_io_alias);
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index b095a23bcc0c..96709b1a7bf8 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -441,7 +441,7 @@ struct dasd_profile_info {
 	unsigned int dasd_io_nr_req[32]; /* hist. of # of requests in chanq */
 
 	/* new data */
-	struct timespec starttod;	   /* time of start or last reset */
+	struct timespec64 starttod;	   /* time of start or last reset */
 	unsigned int dasd_io_alias;	   /* requests using an alias */
 	unsigned int dasd_io_tpm;	   /* requests using transport mode */
 	unsigned int dasd_read_reqs;	   /* total number of read  requests */
-- 
2.9.0
