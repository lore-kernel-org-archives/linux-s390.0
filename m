Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:43260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbgIUNKv (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:51 -0400
From: Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] s390/3215: simplify the return expression of tty3215_open()
Date: Mon, 21 Sep 2020 21:11:01 +0800
Message-ID: <20200921131101.93037-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Qinglang Miao <miaoqinglang@huawei.com>

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/char/con3215.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 92757f9bd..d8acabbb1 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -978,7 +978,6 @@ static int tty3215_install(struct tty_driver *driver, struct tty_struct *tty)
 static int tty3215_open(struct tty_struct *tty, struct file * filp)
 {
 	struct raw3215_info *raw = tty->driver_data;
-	int retval;
 
 	tty_port_tty_set(&raw->port, tty);
 
@@ -986,11 +985,7 @@ static int tty3215_open(struct tty_struct *tty, struct file * filp)
 	/*
 	 * Start up 3215 device
 	 */
-	retval = raw3215_startup(raw);
-	if (retval)
-		return retval;
-
-	return 0;
+	return raw3215_startup(raw);
 }
 
 /*
-- 
2.23.0
