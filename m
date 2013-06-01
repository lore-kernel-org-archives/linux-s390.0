Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1370080643.29224.32.camel@localhost.localdomain>
Subject: [PATCH] qeth: Cocci spatch "ptr_ret.spatch"
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 01 Jun 2013 11:57:23 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -3348,7 +3348,7 @@ static int __init claw_init(void)
 	}
 	CLAW_DBF_TEXT(2, setup, "init_mod");
 	claw_root_dev = root_device_register("claw");
-	ret = IS_ERR(claw_root_dev) ? PTR_ERR(claw_root_dev) : 0;
+	ret = PTR_RET(claw_root_dev);
 	if (ret)
 		goto register_err;
 	ret = ccw_driver_register(&claw_ccw_driver);
diff -u -p a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1837,7 +1837,7 @@ static int __init ctcm_init(void)
 	if (ret)
 		goto out_err;
 	ctcm_root_dev = root_device_register("ctcm");
-	ret = IS_ERR(ctcm_root_dev) ? PTR_ERR(ctcm_root_dev) : 0;
+	ret = PTR_RET(ctcm_root_dev);
 	if (ret)
 		goto register_err;
 	ret = ccw_driver_register(&ctcm_ccw_driver);
diff -u -p a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -2441,7 +2441,7 @@ __init lcs_init_module(void)
 	if (rc)
 		goto out_err;
 	lcs_root_dev = root_device_register("lcs");
-	rc = IS_ERR(lcs_root_dev) ? PTR_ERR(lcs_root_dev) : 0;
+	rc = PTR_RET(lcs_root_dev);
 	if (rc)
 		goto register_err;
 	rc = ccw_driver_register(&lcs_ccw_driver);
diff -u -p a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5705,7 +5705,7 @@ static int __init qeth_core_init(void)
 	if (rc)
 		goto out_err;
 	qeth_core_root_dev = root_device_register("qeth");
-	rc = IS_ERR(qeth_core_root_dev) ? PTR_ERR(qeth_core_root_dev) : 0;
+	rc = PTR_RET(qeth_core_root_dev);
 	if (rc)
 		goto register_err;
 	qeth_core_header_cache = kmem_cache_create("qeth_hdr",
