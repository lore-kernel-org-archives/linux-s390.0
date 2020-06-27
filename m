Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:52029 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgF0MzI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 27 Jun 2020 08:55:08 -0400
From: Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH] drivers/s390/char/tty3270: Remove function callback casts
Date: Sat, 27 Jun 2020 14:54:17 +0200
Message-Id: <20200627125417.18887-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kernel-hardening@lists.openwall.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, remove all the function callback
casts.

To do this modify the function prototypes accordingly.

Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/s390/char/tty3270.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 98d7fc152e32..aec996de44d9 100644
=2D-- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -556,8 +556,9 @@ tty3270_scroll_backward(struct kbd_data *kbd)
  * Pass input line to tty.
  */
 static void
-tty3270_read_tasklet(struct raw3270_request *rrq)
+tty3270_read_tasklet(unsigned long data)
 {
+	struct raw3270_request *rrq =3D (struct raw3270_request *)data;
 	static char kreset_data =3D TW_KR;
 	struct tty3270 *tp =3D container_of(rrq->view, struct tty3270, view);
 	char *input;
@@ -652,8 +653,9 @@ tty3270_issue_read(struct tty3270 *tp, int lock)
  * Hang up the tty
  */
 static void
-tty3270_hangup_tasklet(struct tty3270 *tp)
+tty3270_hangup_tasklet(unsigned long data)
 {
+	struct tty3270 *tp =3D (struct tty3270 *)data;
 	tty_port_tty_hangup(&tp->port, true);
 	raw3270_put_view(&tp->view);
 }
@@ -752,11 +754,9 @@ tty3270_alloc_view(void)

 	tty_port_init(&tp->port);
 	timer_setup(&tp->timer, tty3270_update, 0);
-	tasklet_init(&tp->readlet,
-		     (void (*)(unsigned long)) tty3270_read_tasklet,
+	tasklet_init(&tp->readlet, tty3270_read_tasklet,
 		     (unsigned long) tp->read);
-	tasklet_init(&tp->hanglet,
-		     (void (*)(unsigned long)) tty3270_hangup_tasklet,
+	tasklet_init(&tp->hanglet, tty3270_hangup_tasklet,
 		     (unsigned long) tp);
 	INIT_WORK(&tp->resize_work, tty3270_resize_work);

=2D-
2.20.1
