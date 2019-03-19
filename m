Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Jeff Xie <chongguiguzi@gmail.com>
Subject: [PATCH] s390:tty3270:move spin_lock_bh to spin_lock in tasklet
Date: Wed, 20 Mar 2019 00:12:36 +0800
Message-Id: <1553011956-28747-1-git-send-email-chongguiguzi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: chwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc: rppt@linux.vnet.ibm.com, akpm@linux-foundation.org, mhocko@suse.com, keescook@chromium.org, chongguiguzi@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

It is unnecessary to call spin_lock_bh in a tasklet.

Signed-off-by: Jeff Xie <chongguiguzi@gmail.com>
---
 drivers/s390/char/tty3270.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 2b0c36c2..2963396 100644
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
2.7.4
