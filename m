From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [BUILD_FAILURE] next-20091013 s390x - build breaks SCLP VT220
 terminal driver
Date: Wed, 14 Oct 2009 12:45:53 +0200
Message-ID: <20091014124553.596e7f5a@mschwide.boeblingen.de.ibm.com>
References: <20091013162312.8b93998b.sfr@canb.auug.org.au>
 <20091013162809.GA27977@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932862AbZJNKqd@vger.kernel.org>
In-Reply-To: <20091013162809.GA27977@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-next/>
List-Post: <mailto:linux-next@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Peter.Oberparleiter@de.ibm.com, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 13 Oct 2009 21:58:09 +0530
Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> 	next-20091013 randconfig build on s390x build breaks with
> 
> drivers/s390/built-in.o:(.data+0x3354): undefined reference to `sclp_vt220_pm_event_fn'

Michael pointed out a problem with my fix: suspend/resume of a vt220 console with
SCLP_VT220_CONSOLE=n doesn't work any more. V2 of the patch:

--
Subject: [PATCH] sclp_vt220 build fix

From: Michael Holzheu <michael.holzheu@linux.vnet.ibm.com>

Fix this build error:

	next-20091013 randconfig build on s390x build breaks with

drivers/s390/built-in.o:(.data+0x3354): undefined reference to `sclp_vt220_pm_event_fn'

Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <michael.holzheu@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_vt220.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff -urpN linux-2.6/drivers/s390/char/sclp_vt220.c linux-2.6-patched/drivers/s390/char/sclp_vt220.c
--- linux-2.6/drivers/s390/char/sclp_vt220.c	2009-09-10 00:13:59.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp_vt220.c	2009-10-14 12:41:48.000000000 +0200
@@ -705,21 +705,6 @@ out_driver:
 }
 __initcall(sclp_vt220_tty_init);
 
-#ifdef CONFIG_SCLP_VT220_CONSOLE
-
-static void
-sclp_vt220_con_write(struct console *con, const char *buf, unsigned int count)
-{
-	__sclp_vt220_write((const unsigned char *) buf, count, 1, 1, 0);
-}
-
-static struct tty_driver *
-sclp_vt220_con_device(struct console *c, int *index)
-{
-	*index = 0;
-	return sclp_vt220_driver;
-}
-
 static void __sclp_vt220_flush_buffer(void)
 {
 	unsigned long flags;
@@ -776,6 +761,21 @@ static void sclp_vt220_pm_event_fn(struc
 	}
 }
 
+#ifdef CONFIG_SCLP_VT220_CONSOLE
+
+static void
+sclp_vt220_con_write(struct console *con, const char *buf, unsigned int count)
+{
+	__sclp_vt220_write((const unsigned char *) buf, count, 1, 1, 0);
+}
+
+static struct tty_driver *
+sclp_vt220_con_device(struct console *c, int *index)
+{
+	*index = 0;
+	return sclp_vt220_driver;
+}
+
 static int
 sclp_vt220_notify(struct notifier_block *self,
 			  unsigned long event, void *data)
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
