From: frank.blaschka@de.ibm.com
Subject: [patch 5/5] [PATCH] ctcm: fix error return code
Date: Mon, 24 Sep 2012 16:24:27 +0200
Message-ID: <20120924142501.449097699@de.ibm.com>
References: <20120924142422.001953152@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=604-ctcm-return-code.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Senna Tschudin <peter.senna@gmail.com>

Convert a nonnegative error return code to a negative one, as returned
elsewhere in the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
(
if@p1 (\(ret < 0\|ret != 0\))
 { ... return ret; }
|
ret@p1 = 0
)
... when != ret = e1
    when != &ret
*if(...)
{
  ... when != ret = e2
      when forall
 return ret;
}
// </smpl>

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/ctcm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 5227e57..98ea9cc 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1454,7 +1454,7 @@ static int add_channel(struct ccw_device *cdev, enum ctcm_channel_types type,
 				ch_fsm_len, GFP_KERNEL);
 	}
 	if (ch->fsm == NULL)
-				goto free_return;
+				goto nomem_return;
 
 	fsm_newstate(ch->fsm, CTC_STATE_IDLE);
 
-- 
1.7.11.7
