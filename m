From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 02/13] s390/drivers: use setup_timer
Date: Wed, 18 Oct 2017 17:40:14 +0200
Message-ID: <20171018154025.73630-3-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Allen Pais <allen.lkml@gmail.com>

Use setup_timer function instead of initializing timer with the
function and data fields.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/fsm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/net/fsm.c b/drivers/s390/net/fsm.c
index e5dea67f902e..8c14c6c3ad3d 100644
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
2.13.5
