Return-Path: <linux-kernel-owner+w=401wt.eu-S1756405AbZDNN4H@vger.kernel.org>
Message-Id: <20090414135347.799599997@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:33 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 06/14] appldata: Use new mod_virt_timer_periodic() function.
Content-Disposition: inline; filename=006-appldata-vtimer.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

mod_virt_timer() was used to modify/add cpu timers for cpus that were
set online. This resulted in a one-shot timer for every cpu that was
newly added or previously set offline, instead of an interval timer,
which broke the appldata vtime interval setup.

To fix this, the new mod_virt_timer_periodic() function is used, which
adds interval timers instead of one-shot timers.

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/appldata/appldata_base.c
===================================================================
--- quilt-2.6.orig/arch/s390/appldata/appldata_base.c
+++ quilt-2.6/arch/s390/appldata/appldata_base.c
@@ -176,7 +176,7 @@ static void __appldata_mod_vtimer_wrap(v
 		struct vtimer_list *timer;
 		u64    expires;
 	} *args = p;
-	mod_virt_timer(args->timer, args->expires);
+	mod_virt_timer_periodic(args->timer, args->expires);
 }
 
 #define APPLDATA_ADD_TIMER	0

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
