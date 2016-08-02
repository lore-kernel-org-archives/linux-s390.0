Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0882/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:54:59 +0800
Message-Id: <20160802115459.8784-1-baolex.ni@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, dwmw2@infradead.org, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-s390.vger.kernel.org>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/s390/char/vmur.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index 6c30e93a..9235f64 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -344,7 +344,7 @@ static ssize_t ur_attr_reclen_show(struct device *dev,
 	return rc;
 }
 
-static DEVICE_ATTR(reclen, 0444, ur_attr_reclen_show, NULL);
+static DEVICE_ATTR(reclen, S_IRUSR | S_IRGRP | S_IROTH, ur_attr_reclen_show, NULL);
 
 static int ur_create_attributes(struct device *dev)
 {
-- 
2.9.2
