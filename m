Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Senna Tschudin <peter.senna@gmail.com>
Subject: [PATCH 1/2] drivers/s390/char/monreader.c: fix error return code
Date: Mon, 17 Sep 2012 10:12:00 +0200
Message-Id: <1347869521-2470-1-git-send-email-peter.senna@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com, linux390@de.ibm.com, peter.senna@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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
---
 drivers/s390/char/monreader.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/char/monreader.c b/drivers/s390/char/monreader.c
index 5b8b859..f4ff515 100644
--- a/drivers/s390/char/monreader.c
+++ b/drivers/s390/char/monreader.c
@@ -571,8 +571,11 @@ static int __init mon_init(void)
 	if (rc)
 		goto out_iucv;
 	monreader_device = kzalloc(sizeof(struct device), GFP_KERNEL);
-	if (!monreader_device)
+	if (!monreader_device) {
+		rc = -ENOMEM;
 		goto out_driver;
+	}
+
 	dev_set_name(monreader_device, "monreader-dev");
 	monreader_device->bus = &iucv_bus;
 	monreader_device->parent = iucv_root;
-- 
1.7.11.4
