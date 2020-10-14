Return-Path: <netdev-owner@vger.kernel.org>
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 1/3] net/smc: fix use-after-free of delayed events
Date: Wed, 14 Oct 2020 19:43:27 +0200
Message-Id: <20201014174329.35791-2-kgraul@linux.ibm.com>
In-Reply-To: <20201014174329.35791-1-kgraul@linux.ibm.com>
References: <20201014174329.35791-1-kgraul@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

When a delayed event is enqueued then the event worker will send this
event the next time it is running and no other flow is currently
active. The event handler is called for the delayed event, and the
pointer to the event keeps set in lgr->delayed_event. This pointer is
cleared later in the processing by smc_llc_flow_start().
This can lead to a use-after-free condition when the processing does not
reach smc_llc_flow_start(), but frees the event because of an error
situation. Then the delayed_event pointer is still set but the event is
freed.
Fix this by always clearing the delayed event pointer when the event is
provided to the event handler for processing, and remove the code to
clear it in smc_llc_flow_start().

Fixes: 555da9af827d ("net/smc: add event-based llc_flow framework")
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_llc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 2db967f2fb50..39039a82f24f 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -233,8 +233,6 @@ static bool smc_llc_flow_start(struct smc_llc_flow *flow,
 	default:
 		flow->type = SMC_LLC_FLOW_NONE;
 	}
-	if (qentry == lgr->delayed_event)
-		lgr->delayed_event = NULL;
 	smc_llc_flow_qentry_set(flow, qentry);
 	spin_unlock_bh(&lgr->llc_flow_lock);
 	return true;
@@ -1603,13 +1601,12 @@ static void smc_llc_event_work(struct work_struct *work)
 	struct smc_llc_qentry *qentry;
 
 	if (!lgr->llc_flow_lcl.type && lgr->delayed_event) {
-		if (smc_link_usable(lgr->delayed_event->link)) {
-			smc_llc_event_handler(lgr->delayed_event);
-		} else {
-			qentry = lgr->delayed_event;
-			lgr->delayed_event = NULL;
+		qentry = lgr->delayed_event;
+		lgr->delayed_event = NULL;
+		if (smc_link_usable(qentry->link))
+			smc_llc_event_handler(qentry);
+		else
 			kfree(qentry);
-		}
 	}
 
 again:
-- 
2.17.1
