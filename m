Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/3] tty: Remove ASYNC_CLOSING
Date: Sat, 12 Dec 2015 13:49:36 -0800
Message-Id: <1449956976-4784-4-git-send-email-peter@hurleysoftware.com>
In-Reply-To: <1449956976-4784-1-git-send-email-peter@hurleysoftware.com>
References: <1449956976-4784-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, Samuel Ortiz <samuel@sortiz.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

The tty core no longer provides nor uses ASYNC_CLOSING; remove from
tty_port_close_start() and tty_port_close_end() as well as tty drivers
which open-code these state changes. Unfortunately, even though the
bit is masked from userspace, its inclusion in a uapi header precludes
removing the macro.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel@axis.com
Cc: Samuel Ortiz <samuel@sortiz.org>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/s390/char/con3215.c      | 3 +--
 drivers/tty/rocket.c             | 2 +-
 drivers/tty/serial/68328serial.c | 3 +--
 drivers/tty/serial/crisv10.c     | 3 +--
 drivers/tty/serial/serial_core.c | 1 -
 drivers/tty/tty_port.c           | 3 +--
 net/irda/ircomm/ircomm_tty.c     | 4 ----
 7 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 715251d..057d197 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -643,7 +643,6 @@ static void raw3215_shutdown(struct raw3215_info *raw)
 	if ((raw->flags & RAW3215_WORKING) ||
 	    raw->queued_write != NULL ||
 	    raw->queued_read != NULL) {
-		raw->port.flags |= ASYNC_CLOSING;
 		add_wait_queue(&raw->empty_wait, &wait);
 		set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
@@ -651,7 +650,7 @@ static void raw3215_shutdown(struct raw3215_info *raw)
 		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		remove_wait_queue(&raw->empty_wait, &wait);
 		set_current_state(TASK_RUNNING);
-		raw->port.flags &= ~(ASYNC_INITIALIZED | ASYNC_CLOSING);
+		raw->port.flags &= ~ASYNC_INITIALIZED;
 	}
 	spin_unlock_irqrestore(get_ccwdev_lock(raw->cdev), flags);
 }
diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b575f05..7a3a1b6 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1040,7 +1040,7 @@ static void rp_close(struct tty_struct *tty, struct file *filp)
 		}
 	}
 	spin_lock_irq(&port->lock);
-	info->port.flags &= ~(ASYNC_INITIALIZED | ASYNC_CLOSING | ASYNC_NORMAL_ACTIVE);
+	info->port.flags &= ~(ASYNC_INITIALIZED | ASYNC_NORMAL_ACTIVE);
 	spin_unlock_irq(&port->lock);
 	mutex_unlock(&port->mutex);
 	tty_port_tty_set(port, NULL);
diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
index a190a37..dd1bd3c 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -1030,7 +1030,6 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 		local_irq_restore(flags);
 		return;
 	}
-	port->flags |= ASYNC_CLOSING;
 	/*
 	 * Now we wait for the transmit buffer to clear; and we notify 
 	 * the line discipline to only process XON/XOFF characters.
@@ -1059,7 +1058,7 @@ static void rs_close(struct tty_struct *tty, struct file * filp)
 			msleep_interruptible(jiffies_to_msecs(port->close_delay));
 		wake_up_interruptible(&port->open_wait);
 	}
-	port->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
+	port->flags &= ~ASYNC_NORMAL_ACTIVE;
 	local_irq_restore(flags);
 }
 
diff --git a/drivers/tty/serial/crisv10.c b/drivers/tty/serial/crisv10.c
index 5f2bd78..0b7dd09 100644
--- a/drivers/tty/serial/crisv10.c
+++ b/drivers/tty/serial/crisv10.c
@@ -3613,7 +3613,6 @@ rs_close(struct tty_struct *tty, struct file * filp)
 		local_irq_restore(flags);
 		return;
 	}
-	info->port.flags |= ASYNC_CLOSING;
 	/*
 	 * Now we wait for the transmit buffer to clear; and we notify
 	 * the line discipline to only process XON/XOFF characters.
@@ -3651,7 +3650,7 @@ rs_close(struct tty_struct *tty, struct file * filp)
 			schedule_timeout_interruptible(info->port.close_delay);
 		wake_up_interruptible(&info->port.open_wait);
 	}
-	info->port.flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CLOSING);
+	info->port.flags &= ~ASYNC_NORMAL_ACTIVE;
 	local_irq_restore(flags);
 
 	/* port closed */
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 418587f..cbf36df 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1434,7 +1434,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	 * Wake up anyone trying to open this port.
 	 */
 	clear_bit(ASYNCB_NORMAL_ACTIVE, &port->flags);
-	clear_bit(ASYNCB_CLOSING, &port->flags);
 	spin_unlock_irq(&port->lock);
 	wake_up_interruptible(&port->open_wait);
 
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 1fd07ef..ca5c119 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -476,7 +476,6 @@ int tty_port_close_start(struct tty_port *port,
 		spin_unlock_irqrestore(&port->lock, flags);
 		return 0;
 	}
-	set_bit(ASYNCB_CLOSING, &port->flags);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	tty_ldisc_closing(tty);
@@ -514,7 +513,7 @@ void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 		spin_lock_irqsave(&port->lock, flags);
 		wake_up_interruptible(&port->open_wait);
 	}
-	port->flags &= ~(ASYNC_NORMAL_ACTIVE | ASYNC_CLOSING);
+	port->flags &= ~ASYNC_NORMAL_ACTIVE;
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 EXPORT_SYMBOL(tty_port_close_end);
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
index a423770..db4d38c 100644
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -1268,10 +1268,6 @@ static void ircomm_tty_line_info(struct ircomm_tty_cb *self, struct seq_file *m)
 		seq_printf(m, "%cASYNC_LOW_LATENCY", sep);
 		sep = '|';
 	}
-	if (self->port.flags & ASYNC_CLOSING) {
-		seq_printf(m, "%cASYNC_CLOSING", sep);
-		sep = '|';
-	}
 	if (self->port.flags & ASYNC_NORMAL_ACTIVE) {
 		seq_printf(m, "%cASYNC_NORMAL_ACTIVE", sep);
 		sep = '|';
-- 
2.6.3
