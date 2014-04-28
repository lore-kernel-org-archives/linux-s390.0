From: frank.blaschka@de.ibm.com
Subject: [patch 6/7] claw: replace PTR_RET with PTR_ERR_OR_ZERO
Date: Mon, 28 Apr 2014 10:05:10 +0200
Message-ID: <20140428080533.442277178@de.ibm.com>
References: <20140428080504.925649066@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=claw-ptr-ret.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

PTR_RET is deprecated. Do not recommend its usage anymore.
Use PTR_ERR_OR_ZERO instead.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/s390/net/claw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -3348,7 +3348,7 @@ static int __init claw_init(void)
 	}
 	CLAW_DBF_TEXT(2, setup, "init_mod");
 	claw_root_dev = root_device_register("claw");
-	ret = PTR_RET(claw_root_dev);
+	ret = PTR_ERR_OR_ZERO(claw_root_dev);
 	if (ret)
 		goto register_err;
 	ret = ccw_driver_register(&claw_ccw_driver);
