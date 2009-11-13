Return-Path: <linux-kernel-owner+w=401wt.eu-S1756360AbZKMPbT@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: s390: move keyboard compat ioctls into tty3270 driver
Date: Fri, 13 Nov 2009 16:31:17 +0100
References: <20091113150824.351347652@de.ibm.com> <200911131628.22005.arnd@arndb.de>
In-Reply-To: <200911131628.22005.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200911131631.18177.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

All keyboard ioctls are compatible, so we can simply
move the compat handling into the vt and tty3270 drivers.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 3838567..86b2889 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1731,6 +1731,22 @@ tty3270_ioctl(struct tty_struct *tty, struct file *file,
 	return kbd_ioctl(tp->kbd, file, cmd, arg);
 }
 
+#ifdef CONFIG_COMPAT
+static long
+tty3270_compat_ioctl(struct tty_struct *tty, struct file *file,
+	      unsigned int cmd, unsigned long arg)
+{
+	struct tty3270 *tp;
+
+	tp = tty->driver_data;
+	if (!tp)
+		return -ENODEV;
+	if (tty->flags & (1 << TTY_IO_ERROR))
+		return -EIO;
+	return kbd_ioctl(tp->kbd, file, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static const struct tty_operations tty3270_ops = {
 	.open = tty3270_open,
 	.close = tty3270_close,
@@ -1745,6 +1761,9 @@ static const struct tty_operations tty3270_ops = {
 	.hangup = tty3270_hangup,
 	.wait_until_sent = tty3270_wait_until_sent,
 	.ioctl = tty3270_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = tty3270_compat_ioctl,
+#endif
 	.set_termios = tty3270_set_termios
 };
 
