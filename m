Return-Path: <brueckner@linux.vnet.ibm.com>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 1/2] tty/hvc_console: Add DTR/RTS callback to handle HUPCL
 control
Date: Tue,  2 Jul 2013 17:07:14 +0200
Message-Id: <1372777635-10423-2-git-send-email-brueckner@linux.vnet.ibm.com>
In-Reply-To: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1372777635-10423-1-git-send-email-brueckner@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: benh@kernel.crashing.org, jslaby@suse.cz, gregkh@linuxfoundation.org
Cc: linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, brueckner@linux.vnet.com, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

Introduce a new callback to explicitly handle the HUPCL termios control flag.
This prepares for a follow-up commit for the hvc_iucv device driver to
improve handling when to drop an established network connection.

The callback naming is based on the recently added tty_port interface to
facilitate a potential refactoring of the hvc_console to use tty_port
functions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 drivers/tty/hvc/hvc_console.c |   11 ++++++++++-
 drivers/tty/hvc/hvc_console.h |    3 +++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index eb255e8..9eba119 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -361,7 +361,12 @@ static int hvc_open(struct tty_struct *tty, struct file * filp)
 		tty->driver_data = NULL;
 		tty_port_put(&hp->port);
 		printk(KERN_ERR "hvc_open: request_irq failed with rc %d.\n", rc);
-	}
+	} else
+		/* We are ready... raise DTR/RTS */
+		if (C_BAUD(tty))
+			if (hp->ops->dtr_rts)
+				hp->ops->dtr_rts(hp, 1);
+
 	/* Force wakeup of the polling thread */
 	hvc_kick();
 
@@ -393,6 +398,10 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 		/* We are done with the tty pointer now. */
 		tty_port_tty_set(&hp->port, NULL);
 
+		if (C_HUPCL(tty))
+			if (hp->ops->dtr_rts)
+				hp->ops->dtr_rts(hp, 0);
+
 		if (hp->ops->notifier_del)
 			hp->ops->notifier_del(hp, hp->data);
 
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 674d23c..9131019 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -75,6 +75,9 @@ struct hv_ops {
 	/* tiocmget/set implementation */
 	int (*tiocmget)(struct hvc_struct *hp);
 	int (*tiocmset)(struct hvc_struct *hp, unsigned int set, unsigned int clear);
+
+	/* Callbacks to handle tty ports */
+	void (*dtr_rts)(struct hvc_struct *hp, int raise);
 };
 
 /* Register a vterm and a slot index for use as a console (console_init) */
-- 
1.7.5.4
