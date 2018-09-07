Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
From: jun qian <hangdianqj@163.com>
Subject: [PATCH] drivers:s390:char:move spin_lock_bh to spin_lock in tasklet
Date: Fri,  7 Sep 2018 08:52:13 -0700
Message-Id: <20180907155213.46439-1-hangdianqj@163.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jun qian <hangdianqj@163.com>, Barry song <21cnbao@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

As you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: jun qian <hangdianqj@163.com>
Cc: Barry song <21cnbao@gmail.com>
---
 drivers/s390/char/tty3270.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 5b8af2782282..fb1bc0db7e68 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -563,7 +563,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
 	char *input;
 	int len;
 
-	spin_lock_bh(&tp->view.lock);
+	spin_lock(&tp->view.lock);
 	/*
 	 * Two AID keys are special: For 0x7d (enter) the input line
 	 * has to be emitted to the tty and for 0x6d the screen
@@ -590,7 +590,7 @@ tty3270_read_tasklet(struct raw3270_request *rrq)
 		tp->update_flags = TTY_UPDATE_ALL;
 		tty3270_set_timer(tp, 1);
 	}
-	spin_unlock_bh(&tp->view.lock);
+	spin_unlock(&tp->view.lock);
 
 	/* Start keyboard reset command. */
 	raw3270_request_reset(tp->kreset);
-- 
2.17.1
