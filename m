Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Allen Pais <allen.lkml@gmail.com>
Subject: [PATCH 1/1] drivers:s390: use setup_timer
Date: Thu, 21 Sep 2017 17:50:58 +0530
Message-Id: <1505996458-11714-1-git-send-email-allen.lkml@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: jwi@linux.vnet.ibm.com, ubraun@linux.vnet.ibm.com, linux-s390@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

    Use setup_timer function instead of initializing timer with the
    function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/s390/net/fsm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
index e5dea67..8c14c6c 100644
--- a/drivers/s390/net/fsm.c
+++ b/drivers/s390/net/fsm.c
@@ -170,9 +170,7 @@ fsm_addtimer(fsm_timer *this, int millisec, int event, void *arg)
 	       this->fi->name, this, millisec);
 #endif
 
-	init_timer(&this->tl);
-	this->tl.function = (void *)fsm_expire_timer;
-	this->tl.data = (long)this;
+	setup_timer(&this->tl, (void *)fsm_expire_timer, (long)this);
 	this->expire_event = event;
 	this->event_arg = arg;
 	this->tl.expires = jiffies + (millisec * HZ) / 1000;
@@ -191,9 +189,7 @@ fsm_modtimer(fsm_timer *this, int millisec, int event, void *arg)
 #endif
 
 	del_timer(&this->tl);
-	init_timer(&this->tl);
-	this->tl.function = (void *)fsm_expire_timer;
-	this->tl.data = (long)this;
+	setup_timer(&this->tl, (void *)fsm_expire_timer, (long)this);
 	this->expire_event = event;
 	this->event_arg = arg;
 	this->tl.expires = jiffies + (millisec * HZ) / 1000;
-- 
2.7.4
