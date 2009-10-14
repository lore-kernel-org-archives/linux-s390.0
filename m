From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [BUILD_FAILURE] next-20091013 s390x - build breaks SCLP VT220
 terminal driver
Date: Wed, 14 Oct 2009 11:02:46 +0200
Message-ID: <20091014110246.3c76f93f@mschwide.boeblingen.de.ibm.com>
References: <20091013162312.8b93998b.sfr@canb.auug.org.au>
	<20091013162809.GA27977@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758219AbZJNJD1@vger.kernel.org>
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

This patch should take care of it:

--
Subject: [PATCH] sclp_vt220 build fix

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix this build error:

	next-20091013 randconfig build on s390x build breaks with

drivers/s390/built-in.o:(.data+0x3354): undefined reference to `sclp_vt220_pm_event_fn'

Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_vt220.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -urpN linux-2.6/drivers/s390/char/sclp_vt220.c linux-2.6-patched/drivers/s390/char/sclp_vt220.c
--- linux-2.6/drivers/s390/char/sclp_vt220.c	2009-09-10 00:13:59.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp_vt220.c	2009-10-14 11:00:22.000000000 +0200
@@ -93,8 +93,10 @@ static int __initdata sclp_vt220_init_co
 static int sclp_vt220_flush_later;
 
 static void sclp_vt220_receiver_fn(struct evbuf_header *evbuf);
+#ifdef CONFIG_SCLP_VT220_CONSOLE
 static void sclp_vt220_pm_event_fn(struct sclp_register *reg,
 				   enum sclp_pm_event sclp_pm_event);
+#endif
 static int __sclp_vt220_emit(struct sclp_vt220_request *request);
 static void sclp_vt220_emit_current(void);
 
@@ -104,7 +106,9 @@ static struct sclp_register sclp_vt220_r
 	.receive_mask		= EVTYP_VT220MSG_MASK,
 	.state_change_fn	= NULL,
 	.receiver_fn		= sclp_vt220_receiver_fn,
+#ifdef CONFIG_SCLP_VT220_CONSOLE
 	.pm_event_fn		= sclp_vt220_pm_event_fn,
+#endif
 };
 
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
