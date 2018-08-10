Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Ursula Braun <ubraun@linux.ibm.com>
Subject: [PATCH net-next 1/1] net/smc: send response to test link signal
Date: Fri, 10 Aug 2018 17:45:11 +0200
Message-Id: <20180810154511.71106-1-ubraun@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

With SMC-D z/OS sends a test link signal every 10 seconds. Linux is
supposed to answer, otherwise the SMC-D connection breaks.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_ism.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index cfade7fdcc6d..e36f21ce7252 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -184,6 +184,37 @@ struct smc_ism_event_work {
 	struct smcd_event event;
 };
 
+#define ISM_EVENT_REQUEST		0x0001
+#define ISM_EVENT_RESPONSE		0x0002
+#define ISM_EVENT_REQUEST_IR		0x00000001
+#define ISM_EVENT_CODE_TESTLINK		0x83
+
+static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
+{
+	union {
+		u64	info;
+		struct {
+			u32		uid;
+			unsigned short	vlanid;
+			u16		code;
+		};
+	} ev_info;
+
+	switch (wrk->event.code) {
+	case ISM_EVENT_CODE_TESTLINK:	/* Activity timer */
+		ev_info.info = wrk->event.info;
+		if (ev_info.code == ISM_EVENT_REQUEST) {
+			ev_info.code = ISM_EVENT_RESPONSE;
+			wrk->smcd->ops->signal_event(wrk->smcd,
+						     wrk->event.tok,
+						     ISM_EVENT_REQUEST_IR,
+						     ISM_EVENT_CODE_TESTLINK,
+						     ev_info.info);
+			}
+		break;
+	}
+}
+
 /* worker for SMC-D events */
 static void smc_ism_event_work(struct work_struct *work)
 {
@@ -196,6 +227,9 @@ static void smc_ism_event_work(struct work_struct *work)
 		break;
 	case ISM_EVENT_DMB:
 		break;
+	case ISM_EVENT_SWR:	/* Software defined event */
+		smcd_handle_sw_event(wrk);
+		break;
 	}
 	kfree(wrk);
 }
-- 
2.16.4
