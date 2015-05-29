Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] s390/sclp: pass timeout as HZ independent value
Date: Fri, 29 May 2015 16:50:55 +0200
Message-Id: <1432911055-23219-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-ID: <linux-s390.vger.kernel.org>

schedule_timeout takes a timeout in jiffies but the code currently is
passing in a constant SDIAS_SLEEP_TICKS, as this is otherwise unused
it is replaced by 500ms as recommended by Michael Holzheu
<holzheu@linux.vnet.ibm.com> and converted with msecs_to_jiffies();
As SDIAS_SLEEP_TICKS was only used in this one location it is dropped.

Patch was compile tested with (s390) defconfig + 
CONFIG_MARCH_Z10=y, (implies CONFIG_CRASH_DUMP=y)

Patch is against 4.1-rc5 (localversion-next is -next-20150529)

Link: http://lkml.org/lkml/2015/5/29/235
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

V2: timeout clarified by Heiko Carstens <heiko.carstens@de.ibm.com> and
    set to 500ms (HZ/2). And thanks for the test-config hints.

 drivers/s390/char/sclp_sdias.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/char/sclp_sdias.c b/drivers/s390/char/sclp_sdias.c
index eb7cb07..7cdd13d 100644
--- a/drivers/s390/char/sclp_sdias.c
+++ b/drivers/s390/char/sclp_sdias.c
@@ -21,7 +21,6 @@
 #define TRACE(x...) debug_sprintf_event(sdias_dbf, 1, x)
 
 #define SDIAS_RETRIES 300
-#define SDIAS_SLEEP_TICKS 50
 
 static struct debug_info *sdias_dbf;
 
@@ -68,7 +67,7 @@ static int sdias_sclp_send(struct sclp_req *req)
 			/* not initiated, wait some time and retry */
 			set_current_state(TASK_INTERRUPTIBLE);
 			TRACE("add request failed: rc = %i\n",rc);
-			schedule_timeout(SDIAS_SLEEP_TICKS);
+			schedule_timeout(msecs_to_jiffies(500));
 			continue;
 		}
 		/* initiated, wait for completion of service call */
-- 
1.7.10.4
