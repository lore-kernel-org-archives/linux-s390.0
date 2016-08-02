Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0898/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:56:15 +0800
Message-Id: <20160802115615.9841-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: ubraun@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/s390/net/smsgiucv_app.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/smsgiucv_app.c b/drivers/s390/net/smsgiucv_app.c
index 32515a2..15d4075 100644
--- a/drivers/s390/net/smsgiucv_app.c
+++ b/drivers/s390/net/smsgiucv_app.c
@@ -40,7 +40,7 @@
  * If the value is undefined or empty (""), special messages are
  * accepted from any z/VM user ID. */
 static char *sender;
-module_param(sender, charp, 0400);
+module_param(sender, charp, S_IRUSR);
 MODULE_PARM_DESC(sender, "z/VM user ID from which CP SMSGs are accepted");
 
 /* SMSG device representation */
-- 
2.9.2
