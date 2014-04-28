From: frank.blaschka@de.ibm.com
Subject: [patch 7/7] ctc: replace PTR_RET with PTR_ERR_OR_ZERO
Date: Mon, 28 Apr 2014 10:05:11 +0200
Message-ID: <20140428080533.562193862@de.ibm.com>
References: <20140428080504.925649066@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=ctc-ptr-ret.diff
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
 drivers/s390/net/ctcm_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1837,7 +1837,7 @@ static int __init ctcm_init(void)
 	if (ret)
 		goto out_err;
 	ctcm_root_dev = root_device_register("ctcm");
-	ret = PTR_RET(ctcm_root_dev);
+	ret = PTR_ERR_OR_ZERO(ctcm_root_dev);
 	if (ret)
 		goto register_err;
 	ret = ccw_driver_register(&ctcm_ccw_driver);
