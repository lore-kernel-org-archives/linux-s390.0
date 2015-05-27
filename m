Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH RFC] s390/sclp: pass timeout as HZ independent value
Date: Wed, 27 May 2015 19:04:43 +0200
Message-Id: <1432746283-8068-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-ID: <linux-s390.vger.kernel.org>

schedule_timeout takes a timeout in jiffies but the code currently is
passing in a constant SDIAS_SLEEP_TICKS which sounds like it should be
in jiffies but it is actually not and thus makes this timeout HZ
dependent, to fix this it is passed through msecs_to_jiffies().

patch was not even compile tested as s390 toolchain from kernel.org 
failed for me (on a debian wheezy x86_64) with:
cc1: error: unrecognized command line option '-mtune=zEC12'

Patch is against 4.0-rc5 (localversion-next is -next-20150527)

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

As there is no documentation of the intended timeout it might be wrong
to convert it with msecs_to_jiffies() since the effective timeout is 
at least a factor 10 smaller than it is now - so someone that knows this
driver needs to check on the actual value - but in any case it needs to
be passed in a HZ independent way.

 drivers/s390/char/sclp_sdias.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp_sdias.c b/drivers/s390/char/sclp_sdias.c
index eb7cb07..ab92a75 100644
--- a/drivers/s390/char/sclp_sdias.c
+++ b/drivers/s390/char/sclp_sdias.c
@@ -68,7 +68,7 @@ static int sdias_sclp_send(struct sclp_req *req)
 			/* not initiated, wait some time and retry */
 			set_current_state(TASK_INTERRUPTIBLE);
 			TRACE("add request failed: rc = %i\n",rc);
-			schedule_timeout(SDIAS_SLEEP_TICKS);
+			schedule_timeout(msecs_to_jiffies(SDIAS_SLEEP_TICKS));
 			continue;
 		}
 		/* initiated, wait for completion of service call */
-- 
1.7.10.4
