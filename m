From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: linux-next: Tree for September 30
Date: Wed, 30 Sep 2009 14:16:41 +0200
Message-ID: <20090930141641.3652fc99@mschwide.boeblingen.de.ibm.com>
References: <20090930133745.36a6beea.sfr@canb.auug.org.au>
	<20090930095254.GB5416@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090930095254.GB5416@linux.vnet.ibm.com>
Sender: linux-next-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 30 Sep 2009 15:22:54 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> 	next-20090930 randconfig build breaks, character driver
> 
> ERROR: "ccw_device_force_console" [drivers/s390/char/raw3270.ko] undefined!
> make[1]: *** [__modpost] Error 1

This patch should fix the build breakage:
--
Subject: [PATCH] 3270 console build fix

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Fix this build failure:
drivers/s390/built-in.o: In function `raw3270_pm_unfreeze':
(.text+0x3ac04): undefined reference to `ccw_device_force_console'
with:
CONFIG_TN3270=y
CONFIG_TN3270_CONSOLE=n
CONFIG_TN3215_CONSOLE=n

Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/raw3270.c |    2 ++
 1 file changed, 2 insertions(+)

diff -urpN linux-2.6/drivers/s390/char/raw3270.c linux-2.6-patched/drivers/s390/char/raw3270.c
--- linux-2.6/drivers/s390/char/raw3270.c	2009-09-10 00:13:59.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/raw3270.c	2009-09-30 14:14:44.000000000 +0200
@@ -1361,11 +1361,13 @@ static int raw3270_pm_start(struct ccw_d
 
 void raw3270_pm_unfreeze(struct raw3270_view *view)
 {
+#ifdef CONFIG_TN3270_CONSOLE
 	struct raw3270 *rp;
 
 	rp = view->dev;
 	if (rp && test_bit(RAW3270_FLAGS_FROZEN, &rp->flags))
 		ccw_device_force_console();
+#endif
 }
 
 static struct ccw_device_id raw3270_id[] = {
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
